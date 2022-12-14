using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using Mesnac.DbAccess;
using Mesnac.DbSyn.Business.Implements;

namespace Mesnac.DbSyn.LLERP.Materials
{
    /// <summary>
    /// 源数据 命令
    /// </summary>
    public class Source : TableSyn.BaseSource
    {
        #region SelectData 查询数据
        private string getDateTime()
        {
            string date = McConfig.Instance.LastUpDate;
            string time = McConfig.Instance.LastUpTime;
            var sqlsb = new StringBuilder();
            if (!string.IsNullOrWhiteSpace(date))
            {
                sqlsb.Append(" and (((Udate>'").Append(date).Append("') or (Udate='").Append(date).Append("' and UTIME>'").Append(time).Append("')) ");
                sqlsb.Append("  or  ((Cdate>'").Append(date).Append("') or (Cdate='").Append(date).Append("' and CTIME>'").Append(time).Append("'))) ");
            }
            return sqlsb.ToString();
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
            dbHelper.CommandText = sqlsb.ToString() + getDateTime();
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
        private string getString(DataRow row, string fieldName)
        {
            var result = string.Empty;
            if (row[fieldName] != null
                && row[fieldName] != DBNull.Value)
            {
                result = row[fieldName].ToString();
            }
            return result;
        }
        private string getString(DataRow row, string fieldName1, string fieldName2)
        {
            var result = string.Empty;
            result = getString(row, fieldName1);
            if (string.IsNullOrWhiteSpace(result))
            {
                result = getString(row, fieldName2);
            }
            return result;
        }
        private DateTime getDateTime(string date, string time)
        {
            var result= DateTime.MinValue;
            if (DateTime.TryParse(date+" "+time,out result))
            {
                return result;
            }
            return DateTime.MinValue;
        }
        private void updateMcConfig(string date, string time)
        {
            if (getDateTime(McConfig.Instance.LastUpDate, McConfig.Instance.LastUpTime) <= getDateTime(date, time))
            {
                McConfig.Instance.LastUpDate = date;
                McConfig.Instance.LastUpTime = time;
            }

        }
        /// <summary>
        /// 单条执行完成
        /// </summary>
        /// <param name="dbSyn"></param>
        /// <returns></returns>
        public override int FinishRowSyn(DbSynResult dbSyn)
        {
            var row = dbSyn.Source.CurrentRow.DataRow;
            string date = getString(row, "Udate", "Cdate");
            string time = getString(row, "UTIME", "CTIME");
            updateMcConfig(date, time);
            var result = 0;
            return result;
        }
        #endregion
        #region FinishSyn 全部执行完成
        private void saveDateTime()
        {
            McConfig.Instance.Save();
        }
        /// <summary>
        /// 单条执行完成
        /// </summary>
        /// <param name="dbSyn"></param>
        /// <returns></returns>
        public override int FinishSyn(DbSynResult dbSyn)
        {
            log.Debug("Materials FinishSyn" + McConfig.Instance.LastUpDate + " " + McConfig.Instance.LastUpTime);
            saveDateTime();
            var result = 0;
            return result;
        }
        #endregion
    }
}
