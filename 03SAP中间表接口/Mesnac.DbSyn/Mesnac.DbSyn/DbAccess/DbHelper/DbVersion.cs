/************************************************************************************
 *      All contents © copyright MESNAC. All rights reserved
 *      File:
 *				DBHelper.cs
 *      Description:
 *				 SQL数据访问辅助类
 *      Author:
 *				孙本强
 *				SunBQ@MESNAC.COM
 *				HTTP://WWWW.MESNAC.COM
 *      Finish DateTime:
 *				2013年11月13日
 *      History:
 *      
 ***********************************************************************************/
using System;
using System.Collections.Generic;
using System.IO;
using System.Xml;
using Mesnac.Utility.Xml;

namespace Mesnac.DbAccess
{
    public class DbVersion
    {
        #region 单例实现
        private DbVersion()
        {
        }
        private static DbVersion _instance = null;
        public static DbVersion Instance
        {
            get
            {
                if (_instance == null)
                {
                    lock (typeof(DbVersion))
                    {
                        if (_instance == null)        //double-check
                        {
                            _instance = new DbVersion();
                        }
                    }
                }
                return _instance;
            }
        }
        #endregion
        #region 获取路径
        public DirectoryInfo AppDirectory()
        {
            var result = string.Empty;
            if (true)//如果是网站
            {
                try
                {
                    result = System.Web.HttpContext.Current.Request.PhysicalApplicationPath;
                }
                catch
                {
                }
            }
            if (string.IsNullOrWhiteSpace(result))
            {
                try
                {
                    result = System.Environment.CurrentDirectory;
                }
                catch
                {
                }
            }
            return new DirectoryInfo(result);
        }
        #endregion

        private string getXmlPath()
        {
            string result = "dbVersion.config";
            try
            {
                result = System.IO.Path.Combine(
                    AppDirectory().FullName,
                    "config",
                    result);
            }
            catch { }
            return result;
        }
        #region 版本对应配置
        private Dictionary<string, DbSource> DbSourceDic = new Dictionary<string, DbSource>(StringComparer.OrdinalIgnoreCase);
        private void IniDbSource()
        {
            if (DbSourceDic.Count > 0)
            {
                return;
            }
            XReader reader = new XReader();
            reader.XmlFile = getXmlPath();
            List<XTarget<DbSource>> xmlDbSourceHelpers = new XHelper<DbSource>().DeserializeToTargets(reader);
            foreach (var xmlDbSource in xmlDbSourceHelpers)
            {
                DbSource dbsource = xmlDbSource.Instance;
                dbsource.DbInfoList = new List<DbInfo>();
                reader = new XReader()
                {
                    Node = xmlDbSource.Node
                };
                List<XTarget<DbInfo>> xmlDbInfoHelpers = new XHelper<DbInfo>().DeserializeToTargets(reader);
                foreach (var xmlDbInfo in xmlDbInfoHelpers)
                {
                    dbsource.DbInfoList.Add(xmlDbInfo.Instance);
                }
                if (!DbSourceDic.ContainsKey(dbsource.Version))
                {
                    DbSourceDic.Add(dbsource.Version, dbsource);
                }
            }
        }

        /// <summary>
        /// 获取当前数据库版本列表
        /// </summary>
        /// <returns></returns>
        public Dictionary<string, string> GetDatasourceVersions()
        {
            IniDbSource();
            Dictionary<string, string> result = new Dictionary<string, string>(StringComparer.OrdinalIgnoreCase);
            foreach (var keyvalue in DbSourceDic)
            {
                result.Add(keyvalue.Value.Version, keyvalue.Value.Remark);
            }
            return result;
        }
        public DbSource GetDbSourceByVersion(string name)
        {
            IniDbSource();
            foreach (var keyvalue in DbSourceDic)
            {
                if (keyvalue.Key.ToLower().Trim() == name.ToLower().Trim())
                {
                    return keyvalue.Value;
                }
            }
            return new DbSource();
        }
        public DbInfo GetDbInfo(string version,string dbName)
        {
            IniDbSource();
            if (string.IsNullOrWhiteSpace(dbName))
            {
                dbName = "Default";
            }
            if (string.IsNullOrWhiteSpace(version))
            {
                version = "Default";
            }
            foreach (var keyvalue in DbSourceDic)
            {
                if (keyvalue.Key.ToLower().Trim() == version.ToLower().Trim())
                {
                    foreach (var dbInfo in keyvalue.Value.DbInfoList)
                    {
                        if (dbInfo.DbName.ToLower().Trim() == dbName.ToLower().Trim())
                        {
                            return dbInfo;
                        }
                    }
                }
            }
            return new DbInfo();
        }
        #endregion

        #region 插件对应数据库
        private Dictionary<string, DbMapper> DbMapperDic = new Dictionary<string, DbMapper>(StringComparer.OrdinalIgnoreCase);
        private void IniDbMapper()
        {
            if (DbMapperDic.Count > 0)
            {
                return;
            }
            XReader reader = new XReader();
            reader.XmlFile = getXmlPath();
            List<DbMapper> xmlHelpers = new XHelper<DbMapper>().DeserializeToInstances(reader);
            foreach (var dbMapper in xmlHelpers)
            {
                if (!DbMapperDic.ContainsKey(dbMapper.PluginName))
                {
                    DbMapperDic.Add(dbMapper.PluginName, dbMapper);
                }
            }
        }
        public List<DbMapper> GetDbMapperByDbName(string name)
        {
            IniDbMapper();
            var result = new List<DbMapper>();
            foreach (var keyvalue in DbMapperDic)
            {
                if (keyvalue.Value.DbName.ToLower().Trim() == name.ToLower().Trim())
                {
                    result.Add(keyvalue.Value);
                }
            }
            return result;
        }
        public DbMapper GetDbMapperByPluginName(string name)
        {
            IniDbMapper();
            foreach (var keyvalue in DbMapperDic)
            {
                if (keyvalue.Key.ToLower().Trim() == name.ToLower().Trim())
                {
                    return keyvalue.Value;
                }
            }
            return new DbMapper();
        }
        #endregion
    }


    /// <summary>
    /// 插件对应数据库
    /// </summary>
    public class DbMapper
    {
        /// <summary>
        /// 插件名
        /// </summary>
        public string PluginName { get; set; }
        /// <summary>
        /// 数据库名
        /// </summary>
        public string DbName { get; set; }
    }

    /// <summary>
    /// 数据库配置对应
    /// </summary>
    public class DbInfo
    {
        /// <summary>
        /// 数据库名称
        /// </summary>
        public string DbName { get; set; }
        /// <summary>
        /// 配置文档名
        /// </summary>
        public string MapperName { get; set; }
    }
    /// <summary>
    /// 数据源配置
    /// </summary>
    public class DbSource
    {
        /// <summary>
        /// 版本信息
        /// </summary>
        public string Version { get; set; }
        /// <summary>
        /// 说明信息
        /// </summary>
        public string Remark { get; set; }
        /// <summary>
        /// 数据库列表
        /// </summary>
        public List<DbInfo> DbInfoList { get; set; }
    }
}
