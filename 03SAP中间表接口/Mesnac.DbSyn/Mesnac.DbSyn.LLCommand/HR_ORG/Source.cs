using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using Mesnac.DbAccess;
using Mesnac.DbSyn.Business.Implements;

namespace Mesnac.DbSyn.LLERP.HR_ORG
{
    /// <summary>
    /// 目标 命令
    /// </summary>
    public class Source : TableSyn.Source
    {
        #region SelectData 查询数据
        private void SelectData(DbSynResult dbSyn, DataTable dbTable, DataTable result)
        {
            #region 基础数据
            var dbHelper = getDbSqlHelper(dbSyn);
            var table = dbSyn.SynTable.Source.TableInfo;
            var keyValues = dbSyn.SynTable.Source.SelectData;
            var kvsql = new KVSQL();
            #endregion
            var lstTable = new DataTable();
            foreach (DataRow row in dbTable.Rows)
            {
                var org_id = row["ORG_ID"].ToString();
                var sqlsb = new StringBuilder();
                sqlsb.Append("select * from ").Append(table.TableName).Append(" where 1=1");
                kvsql.Add("PARENT_ID",org_id);
                kvsql.ToWhere(dbHelper, sqlsb);
                dbHelper.CommandText = sqlsb.ToString();
                lstTable = dbHelper.ToDataTable();
                foreach (DataRow lstRow in lstTable.Rows)
                {
                    var resultRow = result.NewRow();
                    foreach (DataColumn dc in result.Columns)
                    {
                        resultRow[dc.ColumnName] = lstRow[dc.ColumnName];
                    }
                    result.Rows.Add(resultRow);
                }
                SelectData(dbSyn, lstTable, result);
            }
        }

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
            #region 第一级目录
            {
                #region 整理 sql 语句
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
            }
            #endregion
            #region 其他目录
            {
                SelectData(dbSyn, lstTable, result);
            }
            return result;
            #endregion
        }
        #endregion
    }
}
