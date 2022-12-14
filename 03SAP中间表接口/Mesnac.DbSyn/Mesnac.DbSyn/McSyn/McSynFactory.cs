using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Reflection;
using System.Text;

namespace Mesnac.DbSyn
{
    /// <summary>
    /// 同步信息 工厂
    /// </summary>
    public class McSynFactory
    {
        #region 系统日志  log
        private LogAgent.ILog log = LogAgent.Log.Instance;
        #endregion

        #region 单例实现
        private static McSynFactory _instance = null;
        public static McSynFactory Instance
        {
            get
            {
                if (_instance == null)
                {
                    lock (typeof(McSynFactory))
                    {
                        if (_instance == null)
                        {
                            _instance = new McSynFactory();
                        }
                    }
                }
                return _instance;
            }
        }
        private McSynFactory()
        {
            IniMcSynInfo();
        }
        public static void SetInstanceNull()
        {
            _instance = null;
        }
        #endregion

        #region 数据字典 GetMcSyn
        private Dictionary<string, McSyn> mcSyns = new Dictionary<string, McSyn>();
        /// <summary>
        /// 同步数据信息字段
        /// </summary>
        public McSyn GetMcSyn(string key)
        {
            McSyn result = null;
            foreach (var kv in mcSyns)
            {
                if (kv.Key.Equals(key, StringComparison.CurrentCultureIgnoreCase))
                {
                    return kv.Value;
                }
            }
            return result;
        }
        #endregion

        #region 初始化信息
        /// <summary>
        /// 初始化信息
        /// </summary>
        private void IniMcSynInfo()
        {
            var files = getXmlFiles();
            foreach (var fi in files)
            {
                IniMcSynInfo(mcSyns, fi);
            }
        }
        /// <summary>
        /// 获取 SynTableXml 目录下所有XML
        /// </summary>
        /// <returns></returns>
        private List<FileInfo> getXmlFiles()
        {
            var result = new List<FileInfo>();
            string fileName = Assembly.GetAssembly(this.GetType()).CodeBase;
            var uri = new Uri(fileName);
            var dir = new FileInfo(uri.LocalPath).Directory;
            foreach (var cdir in dir.GetDirectories())
            {
                if (!cdir.Name.Equals("McSynXml", StringComparison.CurrentCultureIgnoreCase))
                {
                    continue;
                }
                foreach (var fi in cdir.GetFiles())
                {
                    if (fi.Extension.Equals(".xml", StringComparison.CurrentCultureIgnoreCase))
                    {
                        result.Add(fi);
                    }
                }
            }
            return result;
        }
        /// <summary>
        /// 初始化 同步信息
        /// </summary>
        /// <param name="dic"></param>
        /// <param name="fi"></param>
        private void IniMcSynInfo(Dictionary<string, McSyn> dic, FileInfo fi)
        {
            var xml = new McSynXml();
            string key = xml.GetName(fi);
            if (dic.ContainsKey(key))
            {
                return;
            }
            var table = xml.GetMcSyn(fi);
            if (table != null)
            {
                table.Name = key;
                dic.Add(key, table);
            }
        }
        #endregion
    }
}
