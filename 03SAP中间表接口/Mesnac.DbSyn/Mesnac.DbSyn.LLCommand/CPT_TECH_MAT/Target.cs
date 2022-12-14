using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using Mesnac.DbAccess;
using Mesnac.DbSyn.Business.Implements;

namespace Mesnac.DbSyn.LLERP.CPT_TECH_MAT
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
            sqlsb.Append("select OBJID from CPT_CURING_TECH where 1=1 ");
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
            sqlsb.Append(@"update CPT_CURING_TECH set 
                LOADER_HEIGHT=null,
                SHAPING_HEIGHT=null,
                SECOND_SHAPING_PRESS_1=null,
                SECOND_SHAPING_PRESS_2=null,
                SECOND_SHAPING_PRESS_3=null,
                FIRST_SHAPING_PRESS_1=null,
                FIRST_SHAPING_PRESS_2=null,
                FIRST_SHAPING_PRESS_3=null,
                CLAMPING_PRESS=null,
                BLADDER_TENSILE_HEIGHT=null,
                TOP_LIMIT_AMOUNT=null,
                BLADDER_SIZE=null,
                BLADDER_CODE=null,
                ALL_CURING_TIME=null,
                MODEL_TEMP_LOW=null,
                MODEL_TEMP_HIGH=null,
                MODEL_TEMP_SET=null,
                HOT_RING_SET=null,
                PLATE_TEMP_SET=null,
                PLATE_TEMP_HIGH=null,
                PLATE_TEMP_LOW=null,
                CURING_TIME_01=null,
                CURING_TIME_02=null,
                CURING_TIME_03=null,
                CURING_TIME_04=null,
                CURING_TIME_05=null,
                CURING_TIME_06=null,
                CURING_TIME_07=null,
                CURING_TIME_08=null,
                CURING_TIME_09=null,
                CURING_TIME_10=null,
                CURING_TIME_11=null,
                CURING_TIME_12=null,
                CURING_TIME_13=null,
                CURING_TIME_14=null,
                CURING_TIME_15=null,
                CURING_TIME_16=null,
                CURING_TIME_17=null,
                CURING_TIME_18=null,
                CURING_TIME_19=null,
                CURING_TIME_20=null,
                CURING_TIME_21=null,
                CURING_TIME_22=null,
                CURING_TIME_23=null,
                CURING_TIME_24=null,
                CURING_TIME_25=null,
                CURING_TIME_26=null,
                CURING_TIME_27=null,
                CURING_TIME_28=null,
                CURING_TIME_29=null,
                CURING_TIME_30=null,
                RECORD_USER_ID=null,
                RECORD_TIME=null,
                LASTMODIFIER=null,
                LASTMODIFY_DATE=null,
                EFFECT_DATE=null,
                LOSE_EFFECT_DATE=null,
                TECH_TYPE=null,
                SIZE_MARK_LINE_U1=null,
                SIZE_MARK_LINE_U2=null,
                SIZE_MARK_LINE_U3=null,
                SIZE_MARK_LINE_U4=null,
                SIZE_MARK_LINE_U5=null,
                SIZE_MARK_LINE_D1=null,
                SIZE_MARK_LINE_D2=null,
                SIZE_MARK_LINE_D3=null,
                SIZE_MARK_LINE_D4=null,
                SIZE_MARK_LINE_D5=null,
                BLADDER_TENSILE_HEIGHT_MAX=null,
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
            for (int i = 1; i < 3; i++)
            {
                #region 整理 sql 语句
                var sqlsb_fields = new StringBuilder();
                var sqlsb_values = new StringBuilder();
                sqlsb_fields.Append("insert into CPT_CURING_TECH (OBJID,IS_NEW_ROW,DELETE_FLAG,");
                #region PARM_TYPE
                kvsql.Add("PARM_TYPE", i);
                #endregion
                getDefaultTargetData(dbSyn, kvsql, false);
                kvsql.ToInsert(dbHelper, sqlsb_fields, sqlsb_values);
                kvsql.RemoveLastChar(sqlsb_fields);
                kvsql.RemoveLastChar(sqlsb_values);
                dbHelper.CommandText = sqlsb_fields.Append(") values (SEQ_CPT_CURING_TECH.nextval,1,0,").Append(sqlsb_values).Append(")").ToString();
                #endregion
                result += dbHelper.ExecuteNonQuery();
            }
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
            dbHelper.CommandText = "UPDATE CPT_CURING_TECH set DELETE_FLAG=1 where IS_NEW_ROW=0";
            dbHelper.ExecuteNonQuery();
            dbHelper.CommandText = "UPDATE CPT_CURING_TECH set IS_NEW_ROW=0";
            dbHelper.ExecuteNonQuery();
            #endregion

            var result = 0;
            return result;
        }
        #endregion

        #endregion
    }
}
