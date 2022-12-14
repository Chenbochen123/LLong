using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using Mesnac.DbAccess;
using Mesnac.DbSyn.Business.Implements;

namespace Mesnac.DbSyn.LLERP.CPT_TECH_DATA
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
        #region 数据获取
        private string[,] parmName_fieldName = 
        {
            {"装胎高度","LOADER_HEIGHT"},
            {"定型高度","SHAPING_HEIGHT"},
            {"二次定型压力(0-100次)","SECOND_SHAPING_PRESS_1"},
            {"二次定型压力(100-200次)","SECOND_SHAPING_PRESS_2"},
            {"二次定型压力(200次以上)","SECOND_SHAPING_PRESS_3"},
            {"一次定型压力(0-100次)","FIRST_SHAPING_PRESS_1"},
            {"一次定型压力(100-200次)","FIRST_SHAPING_PRESS_2"},
            {"一次定型压力(200次以上)","FIRST_SHAPING_PRESS_3"},
            {"合模力","CLAMPING_PRESS"},
            {"拉伸高度","BLADDER_TENSILE_HEIGHT"},
            {"上限次数","TOP_LIMIT_AMOUNT"},
            {"胶囊型号","BLADDER_SIZE"},
            {"胶囊ERP品号","BLADDER_CODE"},
            {"硫化总时间","ALL_CURING_TIME"},
            {"模温低限","MODEL_TEMP_LOW"},
            {"模温高限","MODEL_TEMP_HIGH"},
            {"模温设定","MODEL_TEMP_SET"},
            {"热环设定","HOT_RING_SET"},
            {"板温设定","PLATE_TEMP_SET"},
            {"板温高限","PLATE_TEMP_HIGH"},
            {"板温低限","PLATE_TEMP_LOW"},
            {"步1时间设定","CURING_TIME_01"},
            {"步2时间设定","CURING_TIME_02"},
            {"步3时间设定","CURING_TIME_03"},
            {"步4时间设定","CURING_TIME_04"},
            {"步5时间设定","CURING_TIME_05"},
            {"步6时间设定","CURING_TIME_06"},
            {"步7时间设定","CURING_TIME_07"},
            {"步8时间设定","CURING_TIME_08"},
            {"步9时间设定","CURING_TIME_09"},
            {"步10时间设定","CURING_TIME_10"},
            {"步11时间设定","CURING_TIME_11"},
            {"步12时间设定","CURING_TIME_12"},
            {"步13时间设定","CURING_TIME_13"},
            {"步14时间设定","CURING_TIME_14"},
            {"步15时间设定","CURING_TIME_15"},
            {"步16时间设定","CURING_TIME_16"},
            {"步17时间设定","CURING_TIME_17"},
            {"步18时间设定","CURING_TIME_18"},
            {"步19时间设定","CURING_TIME_19"},
            {"步20时间设定","CURING_TIME_20"},
            {"步21时间设定","CURING_TIME_21"},
            {"步22时间设定","CURING_TIME_22"},
            {"步23时间设定","CURING_TIME_23"},
            {"步24时间设定","CURING_TIME_24"},
            {"步25时间设定","CURING_TIME_25"},
            {"步26时间设定","CURING_TIME_26"},
            {"步27时间设定","CURING_TIME_27"},
            {"步28时间设定","CURING_TIME_28"},
            {"步29时间设定","CURING_TIME_29"},
            {"步30时间设定","CURING_TIME_30"},
            {"上色标1","SIZE_MARK_LINE_U1"},
            {"上色标2","SIZE_MARK_LINE_U2"},
            {"上色标3","SIZE_MARK_LINE_U3"},
            {"上色标4","SIZE_MARK_LINE_U4"},
            {"上色标5","SIZE_MARK_LINE_U5"},
            {"下色标1","SIZE_MARK_LINE_D1"},
            {"下色标2","SIZE_MARK_LINE_D2"},
            {"下色标3","SIZE_MARK_LINE_D3"},
            {"下色标4","SIZE_MARK_LINE_D4"},
            {"下色标5","SIZE_MARK_LINE_D5"},
            {"拉伸高度上限","BLADDER_TENSILE_HEIGHT_MAX"},
        };
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
            kvsql.Add("RECORD_USER_ID", row["RECORD_USER_ID"]);
            kvsql.Add("RECORD_TIME", row["RECORD_TIME"]);
            kvsql.Add("DELETE_FLAG", row["DELETE_FLAG"]);
            kvsql.Add("LASTMODIFIER", row["LASTMODIFIER"]);
            kvsql.Add("LASTMODIFY_DATE", row["LASTMODIFY_DATE"]);
            kvsql.Add("EFFECT_DATE", row["EFFECT_DATE"]);
            kvsql.Add("LOSE_EFFECT_DATE", row["LOSE_EFFECT_DATE"]);
            kvsql.Add("MATERIAL_ID", row["MATERIAL_ID"]);
            kvsql.Add("PDM_VERSION", row["PDM_VERSION"]);
            kvsql.Add("TECH_TYPE", row["TECH_TYPE"]);
            #endregion
            #region parm_name
            const string parm_name_field = "parm_name";
            const string parm_value_field = "valueid";
            var parmName = getRowString(row, parm_name_field).Trim().ToLower();
            var fieldName = string.Empty;

            for (int i = 0; i < parmName_fieldName.Length / 2; i++)
            {
                var pName = parmName_fieldName[i, 0].Trim().ToLower();
                if (pName == parmName)
                {
                    fieldName = parmName_fieldName[i, 1];
                    var value = 0;
                    if (int.TryParse(getRowString(row, parm_value_field), out value))
                    {
                        kvsql.Add(fieldName, value);
                    }
                    return 0;
                }
            }
            #endregion
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
                string tfieldName = tfield.TargetFieldName.Trim();
                string sfieldName = tfield.SourceFieldName.Trim();
                if (row.IsNull(sfieldName))
                {
                    continue;
                }
                object value = row[sfieldName];
                kvsql.Add(tfieldName, value);
            }
            var result = 0;
            return result;
        }
        #endregion

        #region 更新数据 updateData
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
            sqlsb.Append("update CPT_CURING_TECH set ");
            int n = getDefaultTargetData(dbSyn, kvsql, true);
            n = getSourceToTargetData(dbSyn, kvsql);
            kvsql.ToUpdate(dbHelper, sqlsb);
            kvsql.RemoveLastChar(sqlsb).Append(" where 1=1 ");
            #endregion
            #region  整理 sql 语句 where
            getWhere(row, kvsql);
            getTypeWhere(row, kvsql);
            kvsql.ToWhere(dbHelper, sqlsb);
            dbHelper.CommandText = sqlsb.ToString();
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
            result = updateData(dbSyn);
            return result;
        }
        #endregion
        #endregion
    }
}
