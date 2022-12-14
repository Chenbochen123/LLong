using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Reflection;
using System.Text;
using System.Xml;
using Mesnac.Utility.Xml;

namespace Mesnac.DbSyn
{
    /// <summary>
    /// 配置文件读取
    /// </summary>
    public class McSynXml
    {
        #region 系统日志  log
       private LogAgent.ILog log = LogAgent.Log.Instance;
        #endregion

        #region McSyn
        /// <summary>
        /// 配置文件读取
        /// </summary>
        /// <param name="fi"></param>
        /// <returns></returns>
        public McSyn GetMcSyn(FileInfo fi)
        {
            McSyn result = getMcSyn(fi);
            if (string.IsNullOrWhiteSpace(result.Name))
            {
                return null;
            }
            return result;
        }
        /// <summary>
        /// 通过文件名获取名称
        /// </summary>
        /// <param name="fi"></param>
        /// <returns></returns>
        public string GetName(FileInfo fi)
        {
            string name = fi.Name.Substring(0, fi.Name.Length - fi.Extension.Length);
            return name;
        }
        #endregion

        #region 通过XML初始化 getMcSyn
        #region McSyn
        /// <summary>
        /// 配置文件获取 McSyn
        /// </summary>
        /// <param name="fi"></param>
        /// <returns></returns>
        private McSyn getMcSyn(FileInfo fi)
        {
            #region 初始化数据
            McSyn result = new McSyn();
            XReader reader = new XReader();
            reader.XmlFile = fi.FullName;
            reader.TRename = "SynConfig";
            List<XTarget<string>> xmlHelpers = new XHelper<string>().DeserializeToTargets(reader);
            XTarget<string> xmlHelper = xmlHelpers.FirstOrDefault();
            if (xmlHelper == null)
            {
                return result;
            }
            #endregion
            #region 获取基础信息
            var tables = getTableInfos(xmlHelper.Node);
            var synDatas = getSynDatas(xmlHelper.Node, tables);
            #endregion

            #region 整理基础信息
            #endregion
            result.Tables = tables;
            result.SynTables = synDatas;
            result.Name = GetName(fi);
            return result;
        }
        #endregion

        #region TableInfo
        /// <summary>
        /// 配置文件获取 TableInfo
        /// </summary>
        /// <param name="node"></param>
        /// <returns></returns>
        private List<TableInfo> getTableInfos(XmlNode node)
        {
            var result = new List<TableInfo>();
            XReader reader = new XReader()
            {
                Node = node,
                TRename = "Tables\\Table"
            };
            var xmlHelper = new XHelper<TableInfo>();
            var targets = xmlHelper.DeserializeToTargets(reader);
            if (targets == null || targets.Count == 0)
            {
                return result;
            }
            foreach (var target in targets)
            {
                var table = target.Instance;
                var tNode = target.Node;
                table.Primarykey = getPrimarykey(tNode);
                table.Uniques = getUniques(tNode);
                table.SeqFields = getSeqFields(tNode);
                table.FieldInfos = getFieldInfos(tNode);
                result.Add(table);
            }
            return result;
        }
        /// <summary>
        /// 配置文件获取 TableInfo.Primarykey
        /// </summary>
        /// <param name="node"></param>
        /// <returns></returns>
        private Primarykey getPrimarykey(XmlNode node)
        {
            var result = new Primarykey();
            XReader reader = new XReader()
            {
                Node = node
            };
            var xmlHelper = new XHelper<Primarykey>();
            var targets = xmlHelper.DeserializeToTargets(reader);
            if (targets == null || targets.Count == 0)
            {
                return result;
            }
            result = targets.FirstOrDefault().Instance;
            return result;
        }
        /// <summary>
        /// 配置文件获取 TableInfo.Uniques
        /// </summary>
        /// <param name="node"></param>
        /// <returns></returns>
        private List<Unique> getUniques(XmlNode node)
        {
            XReader reader = new XReader()
            {
                Node = node
            };
            var result = new List<Unique>();
            var xmlHelper = new XHelper<Unique>();
            result = xmlHelper.DeserializeToInstances(reader);
            return result;
        }
        /// <summary>
        /// 配置文件获取 TableInfo.SeqFields
        /// </summary>
        /// <param name="node"></param>
        /// <returns></returns>
        private List<SeqField> getSeqFields(XmlNode node)
        {
            XReader reader = new XReader()
            {
                Node = node
            };
            var result = new List<SeqField>();
            var xmlHelper = new XHelper<SeqField>();
            result = xmlHelper.DeserializeToInstances(reader);
            return result;
        }
        /// <summary>
        /// 配置文件获取 TableInfo.FieldInfos
        /// </summary>
        /// <param name="node"></param>
        /// <returns></returns>
        private List<FieldInfo> getFieldInfos(XmlNode node)
        {
            XReader reader = new XReader()
            {
                Node = node,
                TRename = "FieldInfos\\FieldInfo"
            };
            var result = new List<FieldInfo>();
            var xmlHelper = new XHelper<FieldInfo>();
            result = xmlHelper.DeserializeToInstances(reader);
            return result;
        }
        #endregion

        #region SynDatas
        /// <summary>
        /// 配置文件获取 同步数据
        /// </summary>
        /// <param name="node"></param>
        /// <param name="tables"></param>
        /// <returns></returns>
        private List<SynData> getSynDatas(XmlNode node, List<TableInfo> tables)
        {
            XReader reader = new XReader()
            {
                Node = node,
                TRename = "SynDatas\\SynData"
            };
            var result = new List<SynData>();
            var xmlHelper = new XHelper<SynData>();
            var targets = xmlHelper.DeserializeToTargets(reader);
            foreach (var target in targets)
            {
                var t = target.Instance;
                t.Fields = getSourceTargetFields(target.Node);
                #region Source
                t.Source = getSynInfo(new XReader()
                {
                    Node = target.Node,
                    TRename = "SourceTable"
                });
                t.Source.SynData = t;
                t.Source.TableInfo = getTableInfoByKey(t.Source.TableName, tables);
                #endregion
                #region Target
                t.Target = getSynInfo(new XReader()
                {
                    Node = target.Node,
                    TRename = "TargetTable"
                });
                t.Target.SynData = t;
                t.Target.TableInfo = getTableInfoByKey(t.Target.TableName, tables);
                #endregion
                result.Add(t);
            }
            return result;
        }
        #region SynInfo
        /// <summary>
        /// 配置文件获取 同步表数据
        /// </summary>
        /// <param name="reader"></param>
        /// <returns></returns>
        private SynInfo getSynInfo(XReader reader)
        {
            var result = new List<SynInfo>();
            var xmlHelper = new XHelper<SynInfo>();
            var targets = xmlHelper.DeserializeToTargets(reader);
            foreach (var target in targets)
            {
                var t = target.Instance;
                t.Command = getCommand(new XReader()
                {
                    Node = target.Node,
                    TRename = "Command"
                });
                if (t.Command != null)
                {
                    t.Command.ClassType = CommandInfo2Type(t.Command);
                }
                t.BeginSyn = getKeyValues(new XReader()
                {
                    Node = target.Node,
                    TRename = "BeginSyn\\add"
                });
                t.SelectData = getKeyValues(new XReader()
                {
                    Node = target.Node,
                    TRename = "SelectData\\add"
                });
                t.VerifyRow = getKeyValues(new XReader()
                {
                    Node = target.Node,
                    TRename = "VerifyRow\\add"
                });
                t.PKValue = getKeyValues(new XReader()
                {
                    Node = target.Node,
                    TRename = "PKValue\\add"
                });
                t.ExcuteRowSyn = getKeyValues(new XReader()
                {
                    Node = target.Node,
                    TRename = "ExcuteRowSyn\\add"
                });
                t.FinishRowSyn = getKeyValues(new XReader()
                {
                    Node = target.Node,
                    TRename = "FinishRowSyn\\add"
                });
                t.FinishSyn = getKeyValues(new XReader()
                {
                    Node = target.Node,
                    TRename = "FinishSyn\\add"
                });
                result.Add(t);
                break;
            }
            return result.FirstOrDefault();
        }
        /// <summary>
        /// 配置文件获取 同步表命令
        /// </summary>
        /// <param name="reader"></param>
        /// <returns></returns>
        private CommandInfo getCommand(XReader reader)
        {
            var result = new List<CommandInfo>();
            var xmlHelper = new XHelper<CommandInfo>();
            var targets = xmlHelper.DeserializeToTargets(reader);
            foreach (var target in targets)
            {
                var t = target.Instance;
                result.Add(t);
                break;
            }
            return result.FirstOrDefault();
        }
        /// <summary>
        /// 配置文件获取 同步表键值参数
        /// </summary>
        /// <param name="reader"></param>
        /// <returns></returns>
        private List<KeyValue> getKeyValues(XReader reader)
        {
            var result = new List<KeyValue>();
            var xmlHelper = new XHelper<KeyValue>();
            var targets = xmlHelper.DeserializeToTargets(reader);
            foreach (var target in targets)
            {
                var t = target.Instance;
                if (string.IsNullOrWhiteSpace(t.Key))
                {
                    continue;
                }
                if (string.IsNullOrWhiteSpace(t.Value))
                {
                    t.Value = string.Empty;
                }
                t.Key = t.Key.Trim();
                t.Value = t.Value.Trim();
                result.Add(t);
            }
            return result;
        }
        #endregion
        #region SourceTargetField
        /// <summary>
        /// 配置文件获取 同步字段对应
        /// </summary>
        /// <param name="node"></param>
        /// <returns></returns>
        private List<SourceTargetField> getSourceTargetFields(XmlNode node)
        {
            XReader reader = new XReader()
            {
                Node = node
            };
            var result = new List<SourceTargetField>();
            var xmlHelper = new XHelper<SourceTargetField>();
            var targets = xmlHelper.DeserializeToTargets(reader);
            foreach (var target in targets)
            {
                var t = target.Instance;
                result.Add(t);
            }
            return result;
        }
        #endregion
        #endregion
        #region CommandInfo2Type
        private FileInfo getCommandFile(CommandInfo command)
        {
            string fileName = command.FileName;
            var result = new FileInfo(fileName);
            if (result.Exists)
            {
                return result;
            }
            fileName = new Uri(Assembly.GetExecutingAssembly().CodeBase).LocalPath;
            result = new FileInfo(fileName);
            fileName = Path.Combine(result.Directory.FullName, command.FileName);
            result = new FileInfo(fileName);
            if (result.Exists)
            {
                return result;
            }
            log.Debug("文件不存在：" + result.FullName);
            return null;
        }
        private Type CommandInfo2Type(CommandInfo command)
        {
            Type result = null;
            if (command == null)
            {
                return result;
            }
            var fileInfo = getCommandFile(command);
            if (fileInfo != null)
            {
                var ass = Assembly.LoadFile(fileInfo.FullName);
                if (ass != null)
                {
                    var type = ass.GetType(command.ClassName);
                    if (type != null)
                    {
                        result = (Type)type;
                    }
                }
            }
            return result;
        }
        #endregion
        #region 根据名称绑定
        /// <summary>
        /// 通过名称查找表
        /// </summary>
        /// <param name="key"></param>
        /// <param name="tables"></param>
        /// <returns></returns>
        private TableInfo getTableInfoByKey(string key, List<TableInfo> tables)
        {
            foreach (var table in tables)
            {
                if (table.Name.Equals(key, StringComparison.CurrentCultureIgnoreCase))
                {
                    return table;
                }
            }
            return null;
        }
        /// <summary>
        /// 通过名称查找字段
        /// </summary>
        /// <param name="key"></param>
        /// <param name="fieldInfos"></param>
        /// <returns></returns>
        private FieldInfo getFieldInfoByKey(string key, List<FieldInfo> fieldInfos)
        {
            foreach (var field in fieldInfos)
            {
                if (field.FieldName.Equals(key, StringComparison.CurrentCultureIgnoreCase))
                {
                    return field;
                }
            }
            return null;
        }
        #endregion
        #endregion
    }
}
