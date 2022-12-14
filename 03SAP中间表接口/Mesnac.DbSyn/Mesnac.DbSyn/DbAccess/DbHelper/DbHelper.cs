using System;
using System.Collections.Generic;
using System.Data;
using System.IO;
using System.Reflection;
using System.Xml;
using MyBatis.Common.Configuration;
using MyBatis.DataMapper;
using MyBatis.DataMapper.Configuration;
using MyBatis.DataMapper.Configuration.Interpreters.Config;
using MyBatis.DataMapper.Configuration.Interpreters.Config.Xml;
using MyBatis.DataMapper.MappedStatements;
using MyBatis.DataMapper.Scope;
using MyBatis.DataMapper.Session;
using MyBatis.DataMapper.Model.Sql.External;
using System.Runtime.Remoting.Messaging;

namespace Mesnac.DbAccess
{
    public delegate string KeyConvert(string key);
    /// <summary>
    /// 数据访问辅助类
    /// </summary>
    public class DbHelper : ScriptBase
    {
        #region 系统日志  log
        private LogAgent.ILog log = LogAgent.Log.Instance;
        #endregion
        
        #region  Attributes
        /// <summary>
        /// MyBatis 配置类
        /// </summary>
        private ConfigurationSetting _configurationSetting = null;
        /// <summary>
        /// MyBatis 配置引擎
        /// </summary>
        private IConfigurationEngine _engine = null;
        /// <summary>
        /// MyBatis 会话工厂
        /// </summary>
        private ISessionFactory _sessionFactory = null;
        /// <summary>
        /// MyBatis 会话仓库
        /// </summary>
        private ISessionStore _sessionStore = null;
        /// <summary>
        /// MyBatis 映射器工厂
        /// </summary>
        private IMapperFactory _mapperFactory = null;
        /// <summary>
        /// MyBatis 当前映射器
        /// </summary>
        private IDataMapper _dataMapper = null;
        /// <summary>
        /// 命名格式化事件
        /// </summary>
        private KeyConvert ConvertKey = null;

        #endregion

        #region 构造函数
        #region 通过Xml获取Mapper.xml列表
        /// <summary>
        /// 获取XmlNode属性值
        /// </summary>
        /// <param name="node"></param>
        /// <param name="attribute">属性名</param>
        /// <param name="throwException">是否提示异常</param>
        /// <param name="value">属性值</param>
        /// <returns></returns>
        private bool getNodeAttributeValue(XmlNode node, string attribute, bool throwException, out string value)
        {
            value = string.Empty;
            try
            {
                XmlAttribute a = node.Attributes[attribute.ToLower()];
                if (a != null && a.Value != null)
                {
                    value = a.Value.ToString().Trim();
                }
            }
            catch (Exception ex)
            {
                if (throwException)
                {
                    throw (ex);
                }
                return false;
            }
            return true;
        }
        /// <summary>
        /// 通过Xml获取Mapper.xml列表
        /// 格式为<sqlMaps><sqlMap uri=filepath></sqlMap></sqlMaps>
        /// </summary>
        /// <param name="fi"></param>
        /// <returns></returns>
        private List<string> getSqlMap(FileInfo fi)
        {
            List<string> result = new List<string>();
            XmlDocument xmlDoc = new XmlDocument();
            xmlDoc.Load(fi.FullName);
            foreach (XmlNode node in xmlDoc.ChildNodes)
            {
                if (node.Name.Equals("sqlMaps", StringComparison.CurrentCultureIgnoreCase))
                {
                    foreach (XmlNode dsNode in node.ChildNodes)
                    {
                        if (dsNode.Name.Equals("sqlMap", StringComparison.CurrentCultureIgnoreCase))
                        {
                            string uri = string.Empty;
                            getNodeAttributeValue(dsNode, "uri", false, out uri);
                            if (!string.IsNullOrWhiteSpace(uri))
                            {
                                result.Add(uri);
                            }
                        }
                    }
                }
            }
            return result;
        }
        /// <summary>
        /// 通过Xml获取Mapper.xml列表
        /// </summary>
        /// <param name="codeConfig"></param>
        /// <param name="sqlMap"></param>
        private void AddSqlMaps(CodeConfigurationInterpreter codeConfig, string sqlMap)
        {
            DirectoryInfo dir = new DirectoryInfo(AppDomain.CurrentDomain.BaseDirectory + sqlMap);
            if (!dir.Exists)
            {
                return;
            }
            foreach (FileInfo fi in dir.GetFiles())
            {
                if (fi.Extension.ToLower() == ".xml")
                {
                    foreach (string ss in getSqlMap(fi))
                    {
                        log.Debug("Mapper.xml add " + ss);
                        codeConfig.AddSqlMap(ss, false);
                    }
                }
            }
        }
        #endregion

        #region 通过dll反射获取 Mapper.xml列表
        /// <summary>
        /// 获取Mapper.dlll列表
        /// </summary>
        /// <param name="dir"></param>
        /// <param name="fsMapper"></param>
        private void GetMapperFile(DirectoryInfo dir, DbInfo dbInfo, ref List<FileInfo> fsMapper)
        {
            string beginName = "Mesnac";
            string endName = ".Mapper.dll";
            foreach (FileInfo fi in dir.GetFiles())
            {
                if (fi.Name.ToLower().EndsWith(endName.ToLower())
                    && MapperIsDbInfo("." + fi.Name, beginName, dbInfo))
                {
                    fsMapper.Add(fi);
                }
            }
            foreach (DirectoryInfo d in dir.GetDirectories())
            {
                GetMapperFile(d, dbInfo, ref fsMapper);
            }
        }
        private bool MapperIsDbInfo(string ss, string beginName, DbInfo dbInfo)
        {
            var dbMapperList = DbVersion.Instance.GetDbMapperByDbName(dbInfo.DbName);
            foreach (var dbMapper in dbMapperList)
            {
                string tmp = "." + beginName + "." + dbMapper.PluginName + ".";
                if (ss.ToLower().StartsWith(tmp.ToLower()))
                {
                    return true;
                }
            }
            return false;
        }
        /// <summary>
        /// 通过反射添加所有Mapper文件
        /// </summary>
        /// <param name="codeConfig"></param>
        private void AddSqlMapsFromMesnacMapper(CodeConfigurationInterpreter codeConfig, DbInfo dbInfo)
        {
            var fsMapper = new List<FileInfo>();
            GetMapperFile(new DirectoryInfo(AppDomain.CurrentDomain.BaseDirectory), dbInfo, ref fsMapper);
            //FileInfo fi = new FileInfo(AppDomain.CurrentDomain.BaseDirectory + "bin\\" + assName + ".dll");

            foreach (FileInfo fi in fsMapper)
            {
                Assembly ass = Assembly.LoadFrom(fi.FullName);
                string[] ss = ass.GetManifestResourceNames();
                foreach (string str in ss)
                {
                    string assName = fi.Name;
                    assName = assName.Substring(0, assName.Length - fi.Extension.Length);
                    if (str.ToLower().EndsWith(".xml"))
                    {
                        //Mesnac.Mapper.BasicMapper.PptMoldPlanDetail.xml
                        //assembly://Mesnac.Mapper/Mesnac.Mapper.BusinessMapper/PptMoldPlanDetail.xml
                        string path = str.Substring(0, str.LastIndexOf("."));
                        path = "assembly://" + assName + "/"
                            + path.Substring(0, path.LastIndexOf(".")) + "/"
                            + path.Substring(path.LastIndexOf(".") + 1) + ".xml";

                        log.Debug("Mapper add " + path);
                        codeConfig.AddSqlMap(path, false);
                    }
                }
            }
        }
        #endregion

        #region 添加当前目录下的所有*.Mapper.xml文件
        /// <summary>
        /// 添加当前目录下的所有*.Mapper.xml文件
        /// </summary>
        /// <param name="codeConfig"></param>
        /// <param name="dir"></param>
        private void AddSqlMapsFromMapperFileXml(CodeConfigurationInterpreter codeConfig, DirectoryInfo dir, DbInfo dbInfo)
        {
            foreach (FileInfo fi in dir.GetFiles())
            {
                string fileName = fi.FullName;
                string pluginName = fileName.Substring(AppDomain.CurrentDomain.BaseDirectory.Length);
                pluginName = pluginName.Replace("\\", ".").Replace("/", ".");
                if (pluginName.ToLower().EndsWith(".Mapper.xml".ToLower())
                    && MapperIsDbInfo("." + pluginName, "Plugins", dbInfo))
                {
                    fileName = fileName.Substring(AppDomain.CurrentDomain.BaseDirectory.Length);
                    fileName = fileName.Replace("\\", "/");
                    fileName = "file://" + fileName;
                    log.Debug("Mapper and " + fileName);
                    codeConfig.AddSqlMap(fileName, false);
                }
            }

            foreach (DirectoryInfo _dir in dir.GetDirectories())
            {
                AddSqlMapsFromMapperFileXml(codeConfig, _dir, dbInfo);
            }
        }
        /// <summary>
        /// 添加当前目录下的所有*.Mapper.xml文件
        /// </summary>
        /// <param name="codeConfig"></param>
        /// <param name="dir"></param>
        private void AddSqlMapsFromMapperFileXml(CodeConfigurationInterpreter codeConfig, DbInfo dbInfo)
        {
            DirectoryInfo dir = new DirectoryInfo(AppDomain.CurrentDomain.BaseDirectory);
            AddSqlMapsFromMapperFileXml(codeConfig, dir, dbInfo);
        }
        #endregion

        private void Ini(DbInfo dbInfo)
        {
            #region 获取配置文件
            string sqlmapconfig = AppDomain.CurrentDomain.BaseDirectory + "config\\" + dbInfo.MapperName;
            FileInfo sqlmapfi = new FileInfo(sqlmapconfig);
            if (!sqlmapfi.Exists)
            {
                sqlmapconfig = sqlmapconfig + "\\SqlMap.config";
                sqlmapfi = new FileInfo(sqlmapconfig);
            }
            #endregion
            #region 初始化MyBatis配置
            _configurationSetting = new ConfigurationSetting();
            _configurationSetting.Properties.Add("nullableInt", "int?");

            _engine = new DefaultConfigurationEngine(_configurationSetting);
            XmlConfigurationInterpreter config = new XmlConfigurationInterpreter(sqlmapfi.FullName);
            _engine.RegisterInterpreter(config);

            //更新是否使用命名空间  参数不好用
            _engine.ConfigurationStore.AddSettingConfiguration(
                            new MutableConfiguration(
                                   ConfigConstants.ELEMENT_SETTING,
                                   ConfigConstants.ATTRIBUTE_USE_STATEMENT_NAMESPACES,
                                   true.ToString()));
            #endregion
            #region 添加配置文件
            DirectoryInfo dir = new DirectoryInfo(AppDomain.CurrentDomain.BaseDirectory + dbInfo.MapperName);
            if (!dir.Exists)
            {
                AddSqlMapsFromMesnacMapper(new CodeConfigurationInterpreter(_engine.ConfigurationStore), dbInfo);
                AddSqlMapsFromMapperFileXml(new CodeConfigurationInterpreter(_engine.ConfigurationStore), dbInfo);
            }
            else
            {
                AddSqlMaps(new CodeConfigurationInterpreter(_engine.ConfigurationStore), dbInfo.MapperName);
            }
            #endregion
            #region 创建相关实例
            _mapperFactory = _engine.BuildMapperFactory();
            _sessionFactory = _engine.ModelStore.SessionFactory;
            _dataMapper = ((IDataMapperAccessor)_mapperFactory).DataMapper;
            _sessionStore = ((IModelStoreAccessor)_dataMapper).ModelStore.SessionStore;
            #endregion

            #region 字段名格式化
            if (_sessionFactory.DataSource.DbProvider.Id.ToLower().IndexOf("PostgreSql".ToLower()) >= 0)
            {
                ConvertKey = new KeyConvert(Lower);
            }
            else if (_sessionFactory.DataSource.DbProvider.Id.ToLower().IndexOf("oracle".ToLower()) >= 0)
            {
                ConvertKey = new KeyConvert(Upper);
            }
            else
            {
                ConvertKey = new KeyConvert(Normal);
            }
            #endregion
        }

        /// <summary>
        /// 构造函数
        /// </summary>
        /// <param name="sqlMap">sql名称</param>
        private DbHelper(DbInfo dbInfo)
        {
            try
            {
                Ini(dbInfo);
            }
            catch (Exception ex)
            {
                log.Error("DbHelper 构造错误", ex);
                throw;
            }
        }
        #endregion

        #region 获取 DbHelper
        private static Dictionary<string, DbHelper> dbHelperStore = new Dictionary<string, DbHelper>(StringComparer.OrdinalIgnoreCase);
        /// <summary>
        /// 获取数据访问辅助类
        /// </summary>
        /// <param name="sqlMapConfig">配置文件</param>
        /// <returns></returns>
        public static DbHelper GetInstance(DbInfo dbInfo)
        {
            lock (dbHelperStore)
            {
                DbHelper dbHelper = null;
                if (dbInfo != null
                    && !string.IsNullOrWhiteSpace(dbInfo.MapperName)
                    && !dbHelperStore.TryGetValue(dbInfo.MapperName, out dbHelper))
                {
                    dbHelper = new DbHelper(dbInfo);
                    if (dbHelper != null)
                    {
                        dbHelperStore.Add(dbInfo.MapperName, dbHelper);
                    }
                }
                return dbHelper;
            }
        }
        /// <summary>
        /// 缓存清空
        /// </summary>
        public static void ClearCache()
        {
            dbHelperStore.Clear();
        }
        #endregion

        #region Properties
        /// <summary>
        /// 数据库配置信息
        /// </summary>
        public ConfigurationSetting ConfigurationSetting
        {
            get
            {
                return this._configurationSetting;
            }
        }

        /// <summary>
        /// MyBatis 配置引擎
        /// </summary>
        public IConfigurationEngine Engine
        {
            get
            {
                return this._engine;
            }
        }
        /// <summary>
        /// MyBatis 会话工厂
        /// </summary>
        public ISessionFactory SessionFactory
        {
            get
            {
                return this._sessionFactory;
            }
        }
        /// <summary>
        /// MyBatis 会话仓库
        /// </summary>
        public ISessionStore SessionStore
        {
            get
            {
                return this._sessionStore;
            }
        }
        /// <summary>
        /// MyBatis 当前会话
        /// </summary>
        public ISession CurrentSession
        {
            get
            {
                return this._sessionStore.CurrentSession;
            }
        }
        /// <summary>
        /// MyBatis 数据映射器
        /// </summary>
        public IDataMapper DataMapper
        {
            get
            {
                return this._dataMapper;
            }
        }
        #endregion

        #region 辅助方法
        private static string Normal(string key)
        {
            return key;
        }

        private static string Upper(string key)
        {
            return key.ToUpper();
        }

        private static string Lower(string key)
        {
            return key.ToLower();
        }
        #endregion

        #region 扩展方法
        /// <summary>
        /// 得到运行时ibatis.net动态生成的SQL
        /// </summary>
        /// <param name="sqlMapper"></param>
        /// <param name="statementName"></param>
        /// <param name="paramObject"></param>
        /// <returns></returns>
        public virtual string GetRuntimeSql(string statementName, object paramObject)
        {
            string result = string.Empty;
            try
            {
                IMappedStatement statement = this.Engine.ModelStore.GetMappedStatement(statementName);
                if (null == this.Engine.ModelStore.SessionStore.CurrentSession)
                {
                    this.Engine.ModelStore.SessionFactory.OpenSession();
                }
                RequestScope scope = statement.Statement.Sql.GetRequestScope(statement, paramObject, this.Engine.ModelStore.SessionStore.CurrentSession);
                result = scope.PreparedStatement.PreparedSql;

                log.Info("Sql=" + result);

                foreach (IDbDataParameter para in scope.PreparedStatement.DbParameters)
                {
                    log.InfoFormat("{0} = {1}", para.ParameterName, para.Value);
                }
                log.Debug("Sql End");
            }
            catch (Exception ex)
            {
                result = "获取SQL语句出现异常:" + ex.Message;
                log.Info(result);
            }
            return result;
        }
        #endregion
    }

}