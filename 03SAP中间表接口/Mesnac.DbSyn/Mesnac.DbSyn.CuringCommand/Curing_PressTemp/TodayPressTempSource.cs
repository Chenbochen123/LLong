using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Data;

namespace Mesnac.DbSyn.CuringCommand
{
    public class TodayPressTempSource : TableSyn.Source
    {
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
            var result = new DataTable();
            var lstTable = new DataTable();
            string tableSuf = DateTime.Now.ToString("yyyyMMdd");

            #region 整理 sql 语句
            table.TableName = "tb_PP_PressTemp" + tableSuf;
            var sqlsb = new StringBuilder();
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
                kvsql.ToWhere(dbHelper, sqlsb);
            }
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
            lstTable = dbHelper.ToDataTable(count);
            result = lstTable.Copy();
            result.TableName = System.Guid.NewGuid().ToString("D");

            return result;
        }

        /// <summary>
        /// 单条执行完成
        /// </summary>
        /// <param name="dbSyn"></param>
        /// <returns></returns>
        //public override int FinishRowSyn(DbSynResult dbSyn)
        //{
        //    var dbHelper = getDbSqlHelper(dbSyn);
        //    var row = dbSyn.Source.CurrentRow.DataRow;
        //    var table = dbSyn.SynTable.Source.TableInfo;
        //    var keyValues = dbSyn.SynTable.Source.FinishRowSyn;
        //    var kvsql = new KVSQL();
        //    string tableSuf = DateTime.Now.ToString("yyyyMMdd");
        //    string objid = ((DataRow)row)["objid"].ToString();

        //    #region 整理 sql 语句
        //    var sqlsb = new StringBuilder();
        //    var sqlwhere = new StringBuilder();
        //    sqlsb.Append("update ").Append(table.TableName + tableSuf).Append(" set ");

        //    foreach (var kv in keyValues)
        //    {
        //        string key = kv.Key.ToLower();
        //        string value = kv.Value;
        //        if (string.IsNullOrWhiteSpace(value))
        //        {
        //            continue;
        //        }
        //        if (key == k_update)
        //        {
        //            sqlsb.Append(value);
        //        }
        //        if (key == k_where)
        //        {
        //            sqlwhere.Append(" and (").Append(value).Append("='"+updateValue(value,row)+"')");
        //        }
        //        if (reserved_Words.Contains(key))
        //        {
        //            continue;
        //        }

        //        kvsql.Add(key, kv.Value);
        //    }
        //    kvsql.ToWhere(dbHelper, sqlsb.Append(" where 1=1 ").Append(sqlwhere));
        //    dbHelper.CommandText = sqlsb.ToString();
        //    dbHelper.ExecuteNonQuery();
        //    #endregion
        //    return 1;
        //}

        private string updateValue(string value,DataRow dr)
        {
            string returnstr = string.Empty;
            if (dr.Table.Columns.Contains(value))
            {
                returnstr = dr[value].ToString();
            }
            return returnstr;
        }
    }
}
