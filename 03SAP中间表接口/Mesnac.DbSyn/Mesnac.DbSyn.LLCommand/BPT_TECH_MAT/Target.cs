using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using Mesnac.DbAccess;
using Mesnac.DbSyn.Business.Implements;

namespace Mesnac.DbSyn.LLERP.BPT_TECH_MAT
{
    /// <summary>
    /// 目标 命令
    /// </summary>
    public class Target : TableSyn.BaseTarget
    {
        #region 基础信息
        private DbSqlHelper getNewDbSqlHelper(DbSynResult dbSyn)
        {
            var dbInfo = new DbInfo();
            dbInfo.DbName = dbSyn.SynTable.Target.TableInfo.DbSourceName;
            dbInfo.SynName = dbSyn.SynTable.Name;
            return DbSqlHelperFactory.Instance.NewDbSqlHelper(dbInfo);
        }
        private DateTime getDate(string date8)
        {
            var date = date8.Substring(0, 4) + "-" + date8.Substring(4, 2) + "-" + date8.Substring(6, 2);
            var result = DateTime.MinValue;
            if (DateTime.TryParse(date, out result))
            {
                return result;
            }
            return DateTime.MinValue;
        }
        private DateTime getDate(DataRow row, string fieldName)
        {
            var result = DateTime.MinValue;
            var date8 = row[fieldName];
            if (date8 != null
                && date8 != DBNull.Value
                && (!string.IsNullOrWhiteSpace(date8.ToString()))
                && (date8.ToString().Trim().Length == 8))
            {
                result = getDate(date8.ToString());
            }
            return result;
        }
        private string getRowString(DataRow row, string fieldName)
        {
            var result = row[fieldName];
            if (result != null
                && result != DBNull.Value
                && (!string.IsNullOrWhiteSpace(result.ToString())))
            {
                return result.ToString();
            }
            return string.Empty;
        }
        #endregion

        #region ExcuteRowSyn 执行同步
        #region 检验数据是否已经存在 checkData
        private void getWhere(DataRow row, KVSQL kvsql)
        {
            kvsql.Add("MATERIAL_ID", row["MATERIAL_ID"]);
            kvsql.Add("PDM_VERSION", row["PDM_VERSION"]);
        }
        private void getTypeWhere(DataRow row, KVSQL kvsql)
        {
            const string parm_value_field = "parm_type_id";
            var value = 0;
            if (int.TryParse(getRowString(row, parm_value_field), out value))
            {
                if (value <= 2)
                {
                    kvsql.Add("PARM_TYPE", value);
                }
            }
        }
        /// <summary>
        /// 检验数据是否已经存在
        /// </summary>
        /// <param name="dbSyn"></param>
        /// <returns>
        /// 0：不存在此条数据
        /// 1：
        /// </returns>
        private int checkData(DbSynResult dbSyn)
        {
            #region 基础数据
            var dbHelper = getDbSqlHelper(dbSyn);
            var table = dbSyn.SynTable.Target.TableInfo;
            var row = dbSyn.Target.CurrentRow.DataRow;
            var keyValues = dbSyn.SynTable.Target.ExcuteRowSyn;
            var kvsql = new KVSQL();
            #endregion

            #region 整理 sql 语句
            StringBuilder sqlsb = new StringBuilder();
            sqlsb.Append("select OBJID from BPT_MOLDING_TECH where 1=1 ");
            getWhere(row, kvsql);
            kvsql.ToWhere(dbHelper, sqlsb);
            dbHelper.CommandText = sqlsb.ToString();
            #endregion
            var dt = dbHelper.ToDataTable();
            return dt.Rows.Count;
        }
        #endregion

        #region 更新数据 updateData

        /// <summary>
        /// 检验数据是否已经存在
        /// </summary>
        /// <param name="dbSyn"></param>
        /// <returns>
        /// 0：不存在此条数据
        /// 1：
        /// </returns>
        private int updateDataNull(DbSynResult dbSyn)
        {
            #region 基础数据
            var dbHelper = getDbSqlHelper(dbSyn);
            var table = dbSyn.SynTable.Target.TableInfo;
            var row = dbSyn.Target.CurrentRow.DataRow;
            var keyValues = dbSyn.SynTable.Target.ExcuteRowSyn;
            var kvsql = new KVSQL();
            #endregion
            var sqlsb = new StringBuilder();
            sqlsb.Append(@"update BPT_MOLDING_TECH set 
                PAR32000001=null,
                PAR32000002=null,
                PAR32000003=null,
                PAR32000004=null,
                PAR32000005=null,
                PAR32000006=null,
                PAR32000007=null,
                PAR32000008=null,
                PAR32000009=null,
                PAR32000010=null,
                PAR32000011=null,
                PAR32000012=null,
                PAR32000013=null,
                PAR32000014=null,
                PAR32000015=null,
                PAR32000016=null,
                PAR32000017=null,
                PAR32000018=null,
                PAR32000019=null,
                PAR32000020=null,
                PAR32000021=null,
                PAR32000022=null,
                PAR32000023=null,
                PAR32000024=null,
                PAR32000025=null,
                PAR32001010=null,
                PAR32001009=null,
                PAR32001008=null,
                PAR32001007=null,
                PAR32001006=null,
                PAR32001005=null,
                PAR32001004=null,
                PAR32001003=null,
                PAR32001002=null,
                PAR32001001=null,
                DELETE_FLAG=0,
                IS_NEW_ROW=2 where 1=1 ");
            getWhere(row, kvsql);
            kvsql.ToWhere(dbHelper, sqlsb);
            dbHelper.CommandText = sqlsb.ToString();
            dbHelper.ExecuteNonQuery();
            return 2;
        }
        #endregion

        #region 数据插入 InsertData

        /// <summary>
        /// 获取插入数据的源数据
        /// </summary>
        /// <param name="dbSyn"></param>
        /// <param name="dbHelper"></param>
        /// <param name="sqlsb_fields"></param>
        /// <param name="sqlsb_values"></param>
        private int getDefaultTargetData(DbSynResult dbSyn, KVSQL kvsql, bool isUpdate)
        {
            #region 基础数据
            var row = dbSyn.Target.CurrentRow.DataRow;
            #endregion
            #region 基础数据
            kvsql.Add("MATERIAL_ID", row["MATERIAL_ID"]);
            kvsql.Add("PDM_VERSION", row["PDM_VERSION"]);
            #endregion
            var result = 0;
            return result;
        }
        /// <summary>
        /// 插入数据
        /// </summary>
        /// <param name="dbSyn"></param>
        /// <returns></returns>
        private int insertDataNull(DbSynResult dbSyn)
        {
            #region 基础数据
            var table = dbSyn.SynTable.Target.TableInfo;
            var dbHelper = getDbSqlHelper(dbSyn);
            var kvsql = new KVSQL();
            #endregion
            var result = 0;
            #region 整理 sql 语句
            var sqlsb_fields = new StringBuilder();
            var sqlsb_values = new StringBuilder();
            sqlsb_fields.Append("insert into BPT_MOLDING_TECH (OBJID,IS_NEW_ROW,DELETE_FLAG,");
            getDefaultTargetData(dbSyn, kvsql, false);
            kvsql.ToInsert(dbHelper, sqlsb_fields, sqlsb_values);
            kvsql.RemoveLastChar(sqlsb_fields);
            kvsql.RemoveLastChar(sqlsb_values);
            dbHelper.CommandText = sqlsb_fields.Append(") values (SEQ_BPT_MOLDING_TECH.nextval,1,0,").Append(sqlsb_values).Append(")").ToString();
            #endregion
            result += dbHelper.ExecuteNonQuery();
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
                result = insertDataNull(dbSyn);
            }
            else
            {
                updateDataNull(dbSyn);
            }
            return result;
        }
        #endregion

        #region 执行同步 FinishSyn
        /// <summary>
        /// 执行同步
        /// </summary>
        /// <param name="dbSyn"></param>
        /// <returns></returns>
        public override int FinishSyn(DbSynResult dbSyn)
        {
            #region 基础数据
            var dbHelper = getDbSqlHelper(dbSyn);
            var table = dbSyn.SynTable.Target.TableInfo;
            var keyValues = dbSyn.SynTable.Target.ExcuteRowSyn;
            var kvsql = new KVSQL();
            #endregion

            #region 整理 sql 语句
            dbHelper.CommandText = "UPDATE BPT_MOLDING_TECH set DELETE_FLAG=1 where IS_NEW_ROW=0";
            dbHelper.ExecuteNonQuery();
            dbHelper.CommandText = "UPDATE BPT_MOLDING_TECH set IS_NEW_ROW=0";
            dbHelper.ExecuteNonQuery();
            #endregion

            var result = 0;
            return result;
        }
        #endregion

        #endregion
    }
}
