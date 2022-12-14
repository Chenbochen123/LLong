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
    /// 源数据 命令
    /// </summary>
    public class Source : BaseSource
    {
        #region SelectData 查询数据
        /// <summary>
        /// 查询数据
        /// </summary>
        /// <param name="dbSyn"></param>
        /// <returns></returns>
        public override DataTable SelectData(DbSynResult dbSyn)
        {
            #region 基础数据
            var dbHelper = getDbSqlHelper(dbSyn);
            var table = dbSyn.SynTable.Source.TableInfo;
            var keyValues = dbSyn.SynTable.Source.SelectData;
            var kvsql = new KVSQL();
            #endregion
            #region 整理 sql 语句
            StringBuilder sqlsb = new StringBuilder();
            sqlsb.Append("select * from ").Append(table.TableName).Append(" where 1=1 ");
            foreach (var kv in keyValues)
            {
                string key = kv.Key.ToLower();
                string value = kv.Value;
                if (string.IsNullOrWhiteSpace(value))
                {
                    continue;
                }
                if (key == k_sql)
                {
                    sqlsb = new StringBuilder();
                    sqlsb.Append(value);
                    break;
                }
                if (key == k_where)
                {
                    sqlsb.Append(" and (").Append(value).Append(")");
                }
                if (reserved_Words.Contains(key))
                {
                    continue;
                }
                kvsql.Add(key, kv.Value);
            }
            kvsql.ToWhere(dbHelper, sqlsb);
            dbHelper.CommandText = sqlsb.ToString();
            #endregion

            #region 取DataTable条数
            var count = 0;
            foreach (var kv in keyValues)
            {
                string key = kv.Key.ToLower();
                string value = kv.Value;
                if (key == k_count)
                {
                    int.TryParse(value, out count);
                }
            }
            #endregion
            return dbHelper.ToDataTable(count);
        }
        #endregion

        #region FinishRowSyn 单条执行完成
        /// <summary>
        /// 单条执行完成
        /// </summary>
        /// <param name="dbSyn"></param>
        /// <returns></returns>
        public override int FinishRowSyn(DbSynResult dbSyn)
        {
            var result = 0;
            if (dbSyn.Target.CurrentRow.ExcuteRowSyn < 1)
            {
                return result;
            }
            #region 基础数据
            var dbHelper = getDbSqlHelper(dbSyn);
            var table = dbSyn.SynTable.Source.TableInfo;
            var row = dbSyn.Source.CurrentRow.DataRow;
            var keyValues = dbSyn.SynTable.Source.FinishRowSyn;
            var kvsql = new KVSQL();
            #endregion
            #region 整理 sql 语句 update
            StringBuilder sqlsb = new StringBuilder();
            sqlsb.Append("update ").Append(table.TableName).Append(" set ");
            bool isExist = false;
            foreach (var kv in keyValues)
            {
                string key = kv.Key.ToLower();
                string value = kv.Value;
                if (string.IsNullOrWhiteSpace(value))
                {
                    continue;
                }
                if (key == k_sql)
                {
                    sqlsb = new StringBuilder();
                    sqlsb.Append(value);
                    isExist = true;
                    break;
                }
                if (key == k_update)
                {
                    isExist = true;
                    sqlsb.Append(value).Append(",");
                }
                if (reserved_Words.Contains(key))
                {
                    continue;
                }
                isExist = true;
                kvsql.Add(key, kv.Value);
            }
            if (!isExist)
            {
                return result;
            }
            kvsql.ToUpdate(dbHelper, sqlsb);
            kvsql.RemoveLastChar(sqlsb).Append(" where 1=1 ");
            #endregion
            #region 整理 sql 语句 where
            foreach (var kv in keyValues)
            {
                string key = kv.Key.ToLower();
                string value = kv.Value;
                if (key != k_where)
                {
                    continue;
                }
                if (string.IsNullOrWhiteSpace(value))
                {
                    continue;
                }
                object where_value = row[value];
                kvsql.Add(value, where_value);
            }
            kvsql.ToWhere(dbHelper, sqlsb);

            #region 整理 sql 语句 where_and
             foreach (var kv in keyValues)
            {
                string key = kv.Key.ToLower();
                string value = kv.Value;
                if (key != k_where_and)
                {
                    continue;
                }
                if (string.IsNullOrWhiteSpace(value))
                {
                    continue;
                }
                sqlsb.Append(" and " + value);
            }
          
            #endregion
            dbHelper.CommandText = sqlsb.ToString();
            #endregion
            result = dbHelper.ExecuteNonQuery();
            return result;
        }
        #endregion
    }
}
