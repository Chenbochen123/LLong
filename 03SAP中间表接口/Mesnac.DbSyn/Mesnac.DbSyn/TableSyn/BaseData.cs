using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using Mesnac.DbAccess;
using Mesnac.DbSyn.Business.Implements;

namespace Mesnac.DbSyn.TableSyn
{
    /// <summary>
    /// 基础数据类
    /// </summary>
    public abstract class BaseData
    {
        #region 系统日志  log
        protected LogAgent.ILog log = LogAgent.Log.Instance;
        protected DbSqlHelperFactory sqlHelpers = DbSqlHelperFactory.Instance;
        #endregion

        #region 保留字
        protected const string k_sql = "sql";
        protected const string k_where = "where";
        protected const string k_update = "update";
        protected const string k_count = "count";
        protected const string k_where_and = "where_and";
        protected string[] reserved_Words = new string[] { k_sql, k_where, k_update, k_count, k_where_and };
        #endregion

        #region 构造函数
        public BaseData()
        {
        }
        #endregion

        #region 获取序列值
        public int getSequenceNextVal(DbSqlHelper dbHelper, string seqName)
        {
            var result = 0;
            var sqlsb = new StringBuilder();
            sqlsb.Append("select ").Append(seqName).Append(".nextval from dual");
            dbHelper.CommandText = sqlsb.ToString();
            result = Convert.ToInt32(dbHelper.ToScalar().ToString());
            return result;
        }
        #endregion
    }
}
