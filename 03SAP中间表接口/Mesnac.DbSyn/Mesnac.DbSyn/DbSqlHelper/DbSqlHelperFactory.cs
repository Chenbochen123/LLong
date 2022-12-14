using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using Mesnac.DbAccess;
using Mesnac.DbSyn.Business.Implements;

namespace Mesnac.DbSyn
{
    /// <summary>
    /// 数据连接
    /// </summary>
    public class DbInfo
    {
        /// <summary>
        /// 表同步名称
        /// </summary>
        public string SynName { get; set; }
        /// <summary>
        /// 数据连接名称
        /// </summary>
        public string DbName { get; set; }

        public string ToString()
        {
            var result = string.Empty;
            result = this.SynName + "|" + this.DbName;
            return result;
        }
    }
    /// <summary>
    /// 数据库操作类 工厂
    /// </summary>
    public class DbSqlHelperFactory
    {
        #region 系统日志  log
       private LogAgent.ILog log = LogAgent.Log.Instance;
        #endregion

        #region 单例实现
        private static DbSqlHelperFactory _instance = null;
        /// <summary>
        /// 单例
        /// </summary>
        public static DbSqlHelperFactory Instance
        {
            get
            {
                if (_instance == null)
                {
                    lock (typeof(DbSqlHelperFactory))
                    {
                        if (_instance == null)
                        {
                            _instance = new DbSqlHelperFactory();
                        }
                    }
                }
                return _instance;
            }
        }
        private DbSqlHelperFactory()
        {
        }
        #endregion

        #region 初始化参数
        #region DbSqlHelper
        private Dictionary<string, McSynTableManager> managerDic = new Dictionary<string, McSynTableManager>();
        private Dictionary<string, DbSqlHelper> dbSqlHelperDic = new Dictionary<string, DbSqlHelper>();
        /// <summary>
        /// 获取MyBatis业务类
        /// </summary>
        /// <param name="key"></param>
        /// <returns></returns>
        public McSynTableManager GetManager(DbInfo dbInfo)
        {
            string key = dbInfo.ToString();
            key = key.ToLower();
            McSynTableManager result = null;
            if (managerDic.TryGetValue(key, out result))
            {
                return result;
            }
            result = new McSynTableManager(dbInfo.DbName);
            managerDic.Add(key, result);
            return result;
        }
        public DbSqlHelper GetDbSqlHelper(DbInfo dbInfo)
        {
            string key = dbInfo.ToString();
            bool isExist = false;
            key = key.ToLower();
            DbSqlHelper result = null;
            if (dbSqlHelperDic.TryGetValue(key, out result))
            {
                if ((result != null)
                    && (result.DbSession != null)
                    && (result.DbSession.Connection != null)
                    && (!string.IsNullOrWhiteSpace(result.DbSession.Connection.ConnectionString)))
                {
                    if (result.DbSession.Connection.State != ConnectionState.Open)
                    {
                        try
                        {
                            result.DbSession.Connection.Open();
                        }
                        catch
                        {
                        }
                    }
                    if (result.DbSession.Connection.State == ConnectionState.Open)
                    {
                        isExist = true;
                    }
                    else
                    {
                        result.DbSession.Connection.Close();
                    }
                }
                if (!isExist)
                {
                    dbSqlHelperDic.Remove(key);
                }
            }
            if (!isExist)
            {
                result = NewDbSqlHelper(dbInfo);
                dbSqlHelperDic.Add(key, result);
            }
            return result;
        }
        /// <summary>
        /// 获取新的DbSqlHelper
        /// </summary>
        /// <param name="key"></param>
        /// <returns></returns>
        public DbSqlHelper NewDbSqlHelper(DbInfo dbInfo)
        {
            string key = dbInfo.ToString();
            key = key.ToLower();
            DbSqlHelper result = null;
            var manager = GetManager(dbInfo);
            var dbHelper = manager.DbHelper;
            var dbSqlSession = new DbSqlSession(dbHelper);
            result = new DbSqlHelper(dbSqlSession);
            return result;
        }
        #endregion
        #endregion
    }
}
