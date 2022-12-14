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
    /// 目标 命令
    /// </summary>
    public class Target : BaseTarget
    {
        #region ExcuteRowSyn 执行同步
        #region 数据获取
        /// <summary>
        /// 获取插入数据的基础信息
        /// </summary>
        /// <param name="dbSyn"></param>
        /// <param name="dbHelper"></param>
        /// <param name="sqlsb_fields"></param>
        /// <param name="sqlsb_values"></param>
        protected virtual int getDefaultTargetData(DbSynResult dbSyn, KVSQL kvsql, bool isUpdate)
        {
            var result = 0;
            return result;
        }

        /// <summary>
        /// 获取插入数据的源数据
        /// </summary>
        /// <param name="dbSyn"></param>
        /// <param name="dbHelper"></param>
        /// <param name="sqlsb_fields"></param>
        /// <param name="sqlsb_values"></param>
        private int getSourceToTargetData(DbSynResult dbSyn, KVSQL kvsql)
        {
            #region 基础数据
            var row = dbSyn.Target.CurrentRow.DataRow;
            #endregion
            foreach (var tfield in dbSyn.SynTable.Fields)
            {
                string tfieldName = string.Empty;
                if (!string.IsNullOrWhiteSpace(tfield.TargetFieldName))
                {
                    tfieldName = tfield.TargetFieldName.Trim();
                }
                string sfieldName = string.Empty;
                if (!string.IsNullOrWhiteSpace(tfield.SourceFieldName))
                {
                    sfieldName = tfield.SourceFieldName.Trim();
                }
                string sfieldValue = string.Empty;
                if (!string.IsNullOrWhiteSpace(tfield.SourceValue))
                {
                    sfieldValue = tfield.SourceValue.Trim();
                }
                if (!string.IsNullOrWhiteSpace(sfieldValue))
                {
                    kvsql.Add(tfieldName, sfieldValue);
                    continue;
                }
                if (!row.Table.Columns.Contains(sfieldName))
                {
                    continue;
                }
                if (row.IsNull(sfieldName))
                {
                    kvsql.Add(tfieldName, DBNull.Value);
                }
                else
                {
                    object value = row[sfieldName];
                    kvsql.Add(tfieldName, value);
                }
            }
            var result = 0;
            return result;
        }
        #endregion

        #region 检验数据是否已经存在 checkData
        /// <summary>
        /// 获取where语句
        /// </summary>
        /// <param name="dbSyn"></param>
        /// <param name="dbHelper"></param>
        private void getWhere(DbSynResult dbSyn,
                DbSqlHelper dbHelper,
                StringBuilder sqlsb)
        {
            #region 基础数据
            var table = dbSyn.SynTable.Target.TableInfo;
            var row = dbSyn.Target.CurrentRow.DataRow;
            var keyValues = dbSyn.SynTable.Target.ExcuteRowSyn;
            var kvsql = new KVSQL();
            #endregion
            #region 整理 sql 语句
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
                foreach (var tfield in dbSyn.SynTable.Fields)
                {
                    string tfieldName = tfield.TargetFieldName.Trim();
                    if (tfieldName.ToLower() != value.ToLower())
                    {
                        continue;
                    }
                    string sfieldName = tfield.SourceFieldName;
                    if (row.IsNull(sfieldName))
                    {
                        continue;
                    }
                    object where_value = row[sfieldName];
                    kvsql.Add(tfield.TargetFieldName, where_value);
                }
            }
            kvsql.ToWhere(dbHelper, sqlsb);
            #endregion
        }
        /// <summary>
        /// 检验数据是否已经存在
        /// </summary>
        /// <param name="dbSyn"></param>
        /// <returns></returns>
        private int checkData(DbSynResult dbSyn)
        {
            var result = 0;
            #region 基础数据
            var dbHelper = getDbSqlHelper(dbSyn);
            var table = dbSyn.SynTable.Target.TableInfo;
            var row = dbSyn.Target.CurrentRow.DataRow;
            var keyValues = dbSyn.SynTable.Target.ExcuteRowSyn;
            #endregion

            #region 整理 sql 语句
            var sqlwhere = new StringBuilder();
            getWhere(dbSyn, dbHelper, sqlwhere);
            if (string.IsNullOrWhiteSpace(sqlwhere.ToString()))
                return 0;
            var sqlsb = new StringBuilder();
            sqlsb.Append("select 1 from ").Append(table.TableName).Append(" where 1=1 ").Append(sqlwhere);
            dbHelper.CommandText = sqlsb.ToString();
            #endregion
            result = dbHelper.ToDataTable().Rows.Count;
            return result;
        }
        #endregion

        #region 更新数据 updateData
        /// <summary>
        /// 更新数据
        /// </summary>
        /// <param name="dbSyn"></param>
        /// <returns></returns>
        private int updateData(DbSynResult dbSyn)
        {
            var result = 0;
            #region 基础数据
            var dbHelper = getDbSqlHelper(dbSyn);
            var table = dbSyn.SynTable.Target.TableInfo;
            var row = dbSyn.Target.CurrentRow.DataRow;
            var kvsql = new KVSQL();
            #endregion
            #region 整理 sql 语句 update
            StringBuilder sqlsb = new StringBuilder();
            sqlsb.Append("update ").Append(table.TableName).Append(" set ");
            int n = getDefaultTargetData(dbSyn, kvsql, true);
            if (n < 0)
            {
                dbHelper.Dispose();
                return 1;
            }
            n = getSourceToTargetData(dbSyn, kvsql);
            if (n < 0)
            {
                dbHelper.Dispose();
                return 1;
            }
            kvsql.ToUpdate(dbHelper, sqlsb);
            kvsql.RemoveLastChar(sqlsb).Append(" where 1=1 ");
            #endregion
            #region  整理 sql 语句 where
            getWhere(dbSyn, dbHelper, sqlsb);
            dbHelper.CommandText = sqlsb.ToString();
            #endregion
            result = dbHelper.ExecuteNonQuery();
            return result;
        }
        #endregion

        #region 数据插入 InsertData
        /// <summary>
        /// 插入数据
        /// </summary>
        /// <param name="dbSyn"></param>
        /// <returns></returns>
        private int insertData(DbSynResult dbSyn)
        {
            var result = 0;
            #region 基础数据
            var table = dbSyn.SynTable.Target.TableInfo;
            var dbHelper = getDbSqlHelper(dbSyn);
            var kvsql = new KVSQL();
            #endregion
            #region 整理 sql 语句
            StringBuilder sqlsb_fields = new StringBuilder();
            StringBuilder sqlsb_values = new StringBuilder();
            sqlsb_fields.Append("insert into ").Append(table.TableName).Append(" (");
            #region 主键
            if (table.Primarykey != null
                && (!string.IsNullOrWhiteSpace(table.Primarykey.FieldName))
                && (!table.Primarykey.Identity))
            {
                foreach (var seqfield in table.SeqFields)
                {
                    if (string.Equals(table.Primarykey.FieldName, seqfield.FieldName,
                                      StringComparison.CurrentCultureIgnoreCase))
                    {
                        string tfieldName = table.Primarykey.FieldName;
                        sqlsb_fields.Append(tfieldName).Append(",");
                        sqlsb_values.Append(seqfield.SeqName).Append(".nextval").Append(",");
                        break;
                    }
                }
            }
            #endregion
            int n = getDefaultTargetData(dbSyn, kvsql, false);
            if (n < 0)
            {
                dbHelper.Dispose();
                return n;
            }
            n = getSourceToTargetData(dbSyn, kvsql);
            if (n < 0)
            {
                dbHelper.Dispose();
                return n;
            }
            kvsql.ToInsert(dbHelper, sqlsb_fields, sqlsb_values);
            kvsql.RemoveLastChar(sqlsb_fields);
            kvsql.RemoveLastChar(sqlsb_values);
            dbHelper.CommandText = sqlsb_fields.Append(") values (").Append(sqlsb_values).Append(")").ToString();
            #endregion
            result = dbHelper.ExecuteNonQuery();
            return result;
        }
        #endregion

        #region 执行同步 ExcuteRowSyn
        /// <summary>
        /// 执行同步
        /// </summary>
        /// <param name="dbSyn"></param>
        /// <returns></returns>
        public override int ExcuteRowSyn(DbSynResult dbSyn)
        {
            var result = 0;
            result = checkData(dbSyn);
            if (result == 0)
            {
                result = insertData(dbSyn);
            }
            else
            {
                result = updateData(dbSyn);
            }
            return result;
        }
        #endregion

        #endregion
    }
}
