using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using Mesnac.DbAccess;
using Mesnac.DbSyn.Business.Implements;

namespace Mesnac.DbSyn.LLERP.BPT_TECH_DATA
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
            {"32000001","PAR32000001"},//主鼓灯标胎侧外定位：（MM）
            {"32000002","PAR32000002"},//主鼓灯标胎侧内定位：（MM）
            {"32000003","PAR32000003"},//主鼓灯标内衬定位：（MM）
            {"32000004","PAR32000004"},//主鼓灯标胎体帘布定位：（MM）
            {"32000005","PAR32000005"},//主鼓灯标1#钢丝包布内定位：（MM）
            {"32000006","PAR32000006"},//主鼓灯标1#钢丝包布外定位：（MM）
            {"32000007","PAR32000007"},//主鼓灯标2#钢丝包布内定位：（MM）
            {"32000008","PAR32000008"},//主鼓灯标2#钢丝包布外定位：（MM）
            {"32000009","PAR32000009"},//主鼓灯标1#尼龙包布内定位：（MM）
            {"32000010","PAR32000010"},//主鼓灯标1#尼龙包布外定位：（MM）
            {"32000011","PAR32000011"},//主鼓灯标2#尼龙包布内定位：（MM）
            {"32000012","PAR32000012"},//主鼓灯标2#尼龙包布外定位：（MM）
            {"32000013","PAR32000013"},//主鼓灯标型胶内定位：（MM）
            {"32000014","PAR32000014"},//灯标垫胶内定位：（MM）
            {"32000015","PAR32000015"},//辅鼓灯标1#带束层定位：：（MM）
            {"32000016","PAR32000016"},//辅鼓灯标2#带束层定位：：（MM）
            {"32000017","PAR32000017"},//辅鼓灯标3#带束层定位：：（MM）
            {"32000018","PAR32000018"},//辅鼓灯标4#带束层定位：：（MM）
            {"32000019","PAR32000019"},//辅鼓周长
            {"32000020","PAR32000020"},//平宽(钢丝圈内定位)
            {"32000021","PAR32000021"},//平宽(钢丝圈外定位)
            {"32000022","PAR32000022"},//机头宽度
            {"32000023","PAR32000023"},//预定型机头宽度
            {"32000024","PAR32000024"},//定型机头宽度
            {"32000025","PAR32000025"},//内衬层复合件裁断长度：MM
            {"32000026","PAR32000026"},//辅鼓灯标0°带束层定位：（MM）
            {"32001068","PAR32001010"},//下色标5
            {"32001067","PAR32001009"},//下色标4
            {"32001066","PAR32001008"},//下色标3
            {"32001065","PAR32001007"},//下色标2
            {"32001064","PAR32001006"},//下色标1
            {"32001063","PAR32001005"},//上色标5
            {"32001062","PAR32001004"},//上色标4
            {"32001061","PAR32001003"},//上色标3
            {"32001060","PAR32001002"},//上色标2
            {"32001059","PAR32001001"},//上色标1

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
            const string parm_name_field = "pdm_code";
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
            sqlsb.Append("update BPT_MOLDING_TECH set ");
            int n = getDefaultTargetData(dbSyn, kvsql, true);
            n = getSourceToTargetData(dbSyn, kvsql);
            getTypeWhere(row, kvsql);
            kvsql.ToUpdate(dbHelper, sqlsb);
            kvsql.RemoveLastChar(sqlsb).Append(" where 1=1 ");
            #endregion
            #region  整理 sql 语句 where
            getWhere(row, kvsql);
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
