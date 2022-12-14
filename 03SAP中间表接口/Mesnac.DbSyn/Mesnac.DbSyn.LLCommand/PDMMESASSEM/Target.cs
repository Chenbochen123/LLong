using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using Mesnac.DbAccess;
using Mesnac.DbSyn.Business.Implements;

namespace Mesnac.DbSyn.LLERP.PDMMESASSEM
{
    /// <summary>
    /// 目标 命令
    /// </summary>
    public class Target : TableSyn.Target
    {
        #region 获取插入数据的基础信息
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
        private DateTime getDate(DataRow row, string fieldName,string fieldName2)
        {
            var result = getDate(row, fieldName);
            if (result == DateTime.MinValue)
            {
                result = getDate(row, fieldName2);
            }
            return result;
        }
        private string getString(DataRow row, string fieldName)
        {
            var result = string.Empty;
            var ss = row[fieldName];
            if (ss != null
                && ss != DBNull.Value
                && (!string.IsNullOrWhiteSpace(ss.ToString())))
            {
                result = ss.ToString();
            }
            return result;
        }
        private int getInt(DataRow row, string fieldName)
        {
            var result = 0;
            var ss = row[fieldName];
            if (ss != null
                && ss != DBNull.Value
                && (!string.IsNullOrWhiteSpace(ss.ToString())))
            {
                result =Convert.ToInt32(ss);
            }
            return result;
        }
        private string getERPId(DataRow row)
        {
            var result = row["indx"];
            if (result != null
                && result != DBNull.Value
                && (!string.IsNullOrWhiteSpace(result.ToString())))
            {
                return result.ToString();
            }
            return string.Empty;

        }
        private string getERPMaterialId(DataRow row, string fieldName)
        {
            var result = row[fieldName];
            if (result != null
                && result != DBNull.Value
                && (!string.IsNullOrWhiteSpace(result.ToString()))
                && (result.ToString().Length >= 9))
            {
                return result.ToString().Substring(0, 9);
            }
            return string.Empty;
        }
        /// <summary>
        /// 获取插入数据的基础信息
        /// </summary>
        /// <param name="dbSyn"></param>
        /// <param name="dbHelper"></param>
        /// <param name="sqlsb_fields"></param>
        /// <param name="sqlsb_values"></param>
        protected override int getDefaultTargetData(DbSynResult dbSyn, KVSQL kvsql, bool isUpdate)
        {
            #region 基础数据
            var table = dbSyn.SynTable.Target.TableInfo;
            var row = dbSyn.Target.CurrentRow.DataRow;
            var thisDbHelper = getNewDbSqlHelper(dbSyn);
            var thisKVSql = new KVSQL();
            #endregion
            #region RECORD_USER_ID
            kvsql.Add("RECORD_USER_ID", 0);
            #endregion
            #region RECORD_TIME
            {
                var value = getDate(row, "CREATEDATE");
                if (value > (DateTime.MinValue))
                {
                    kvsql.Add("RECORD_TIME", value);
                }
            }
            #endregion
            #region LASTMODIFY_DATE
            {
                var value = getDate(row, "MODIFIDATE", "CREATEDATE");
                if (value > (DateTime.MinValue))
                {
                    kvsql.Add("LASTMODIFY_DATE", value);
                }
                else
                {
                    kvsql.Add("LASTMODIFY_DATE", DateTime.Today);
                }
            }
            #endregion

            #region DELETE_FLAG
            {
                var value = getInt(row, "MD012");
                if (value>0)
                {
                    kvsql.Add("DELETE_FLAG", 1);
                }
                else
                {
                    kvsql.Add("DELETE_FLAG", 0);
                }
            }
            #endregion
            #region EFFECT_DATE
            {
                var value = getDate(row, "PD001");
                if (value > (DateTime.MinValue))
                {
                    kvsql.Add("EFFECT_DATE", value);
                }
            }
            #endregion
            #region LOSE_EFFECT_DATE
            {
                kvsql.Add("LOSE_EFFECT_DATE", DateTime.MaxValue);
            }
            #endregion
            #region MATERIAL_PARENT_ID
            {
                var value = 0;
                var sap_code = getERPMaterialId(row, "MD007");
                if (!string.IsNullOrWhiteSpace(sap_code.ToString()))
                {
                    var sqlsb = new StringBuilder();
                    sqlsb.Append("select OBJID,MAJOR_TYPE_ID,MINOR_TYPE_ID from SBM_MATERIAL where 1=1");
                    thisKVSql.Add("SAP_CODE", sap_code);
                    thisKVSql.ToWhere(thisDbHelper, sqlsb);
                    thisDbHelper.CommandText = sqlsb.ToString();
                    var dt = thisDbHelper.ToDataTable();
                    if (dt.Rows.Count > 0)
                    {
                        var dbValue = dt.Rows[0]["OBJID"];
                        if (dbValue != null
                            && dbValue != DBNull.Value
                            && (!string.IsNullOrWhiteSpace(dbValue.ToString())))
                        {
                            value = Convert.ToInt32(dbValue.ToString());
                            kvsql.Add("MATERIAL_PARENT_ID", value);
                        }
                    }
                }
            }
            #endregion
            #region MATERIAL_ID
            {
                var value = 0;
                var sap_code = getERPMaterialId(row, "MD001");
                if (!string.IsNullOrWhiteSpace(sap_code.ToString()))
                {
                    var sqlsb = new StringBuilder();
                    sqlsb.Append("select OBJID,MAJOR_TYPE_ID,MINOR_TYPE_ID from SBM_MATERIAL where 1=1");
                    thisKVSql.Add("SAP_CODE", sap_code);
                    thisKVSql.ToWhere(thisDbHelper, sqlsb);
                    thisDbHelper.CommandText = sqlsb.ToString();
                    var dt = thisDbHelper.ToDataTable();
                    if (dt.Rows.Count > 0)
                    {
                        var dbValue = dt.Rows[0]["OBJID"];
                        if (dbValue != null
                            && dbValue != DBNull.Value
                            && (!string.IsNullOrWhiteSpace(dbValue.ToString())))
                        {
                            value = Convert.ToInt32(dbValue.ToString());
                            kvsql.Add("MATERIAL_ID", value);
                        }
                    }
                }
            }
            #endregion
            #region GREENTYRE_MATERIAL_ID
            //{
            //    var value = 0;
            //    var sap_code = getERPMaterialId(row, "MD013");
            //    if (!string.IsNullOrWhiteSpace(sap_code.ToString()))
            //    {
            //        var sqlsb = new StringBuilder();
            //        sqlsb.Append("select OBJID from SBM_MATERIAL where 1=1");
            //        thisKVSql.Add("SAP_CODE", sap_code);
            //        thisKVSql.ToWhere(thisDbHelper, sqlsb);
            //        thisDbHelper.CommandText = sqlsb.ToString();
            //        var dbObjid = thisDbHelper.ToScalar();
            //        if (dbObjid != null
            //            && dbObjid != DBNull.Value
            //            && (!string.IsNullOrWhiteSpace(dbObjid.ToString())))
            //        {
            //            value = Convert.ToInt32(dbObjid.ToString());
            //        }
            //    }
            //    if (value > 0)
            //    {
            //        kvsql.Add("GREENTYRE_MATERIAL_ID", value);
            //    }
            //}
            #endregion
            #region BOM_TYPE
//            {
//                var stepName = row["MD014"];
//                if ((stepName != null)
//                    && (stepName != DBNull.Value)
//                    && (!string.IsNullOrWhiteSpace(stepName.ToString())))
//                {
//                    var value = 0;
//                    var sqlsb = new StringBuilder();

//                    sqlsb.Append("select objid from SBM_BOM_TYPE where 1=1");
//                    thisKVSql.Add("TYPE_NAME", stepName);
//                    thisKVSql.ToWhere(thisDbHelper, sqlsb);
//                    thisDbHelper.CommandText = sqlsb.ToString();
//                    var scalar = thisDbHelper.ToScalar();
//                    if ((scalar != null)
//                        && (scalar != DBNull.Value)
//                        && (!string.IsNullOrWhiteSpace(scalar.ToString())))
//                    {
//                        value = Convert.ToInt32(scalar.ToString());
//                    }
//                    else
//                    {
//                        sqlsb = new StringBuilder();
//                        sqlsb.Append("select SEQ_SBM_BOM_TYPE.nextval from dual");
//                        thisDbHelper.CommandText = sqlsb.ToString();
//                        value = Convert.ToInt32(thisDbHelper.ToScalar().ToString());

//                        sqlsb = new StringBuilder();
//                        sqlsb.Append(@"insert into SBM_BOM_TYPE
//                          (objid, TYPE_NAME,DELETE_FLAG)
//                        values (");
//                        sqlsb.Append(value.ToString()).Append(",");

//                        thisKVSql.Add("TYPE_NAME", stepName);
//                        thisKVSql.ToInsert(thisDbHelper, new StringBuilder(), sqlsb);
//                        thisKVSql.RemoveLastChar(sqlsb).Append(",0)");
//                        thisDbHelper.CommandText = sqlsb.ToString();
//                        thisDbHelper.ExecuteNonQuery();
//                    }

//                    string key = "BOM_TYPE";
//                    kvsql.Add(key, value);
//                }
//            }
            #endregion
            #region UNIT_ID
            {
                var stepName = row["MD004"];
                if ((stepName != null)
                    && (stepName != DBNull.Value)
                    && (!string.IsNullOrWhiteSpace(stepName.ToString())))
                {
                    var value = 0;
                    var sqlsb = new StringBuilder();

                    sqlsb.Append("select objid from SSB_UNIT where 1=1");
                    thisKVSql.Add("UNIT_NAME", stepName);
                    thisKVSql.ToWhere(thisDbHelper, sqlsb);
                    thisDbHelper.CommandText = sqlsb.ToString();
                    var scalar = thisDbHelper.ToScalar();
                    if ((scalar != null)
                        && (scalar != DBNull.Value)
                        && (!string.IsNullOrWhiteSpace(scalar.ToString())))
                    {
                        value = Convert.ToInt32(scalar.ToString());
                    }
                    else
                    {
                        sqlsb = new StringBuilder();
                        sqlsb.Append("select SEQ_SSB_UNIT.nextval from dual");
                        thisDbHelper.CommandText = sqlsb.ToString();
                        value = Convert.ToInt32(thisDbHelper.ToScalar().ToString());

                        sqlsb = new StringBuilder();
                        sqlsb.Append(@"insert into SSB_UNIT
                          (objid, UNIT_NAME)
                        values (");
                        sqlsb.Append(value.ToString()).Append(",");

                        thisKVSql.Add("UNIT_NAME", stepName);
                        thisKVSql.ToInsert(thisDbHelper, new StringBuilder(), sqlsb);
                        thisKVSql.RemoveLastChar(sqlsb).Append(")");
                        thisDbHelper.CommandText = sqlsb.ToString();
                        thisDbHelper.ExecuteNonQuery();
                    }

                    string key = "UNIT_ID";
                    kvsql.Add(key, value);
                }
            }
            #endregion

            if (kvsql.ContainsKey("MATERIAL_ID")
                && kvsql.ContainsKey("MATERIAL_PARENT_ID"))
            {
                return 0;
            }
            var loginfo = new StringBuilder();
            loginfo.Append("无法导入 ERPID(indx)=").Append(getERPId(row)).Append(" 原因");
            if (!kvsql.ContainsKey("MATERIAL_ID"))
            {
                loginfo.Append("无子物料 MATERIAL_ID(MD001)=").Append(getERPMaterialId(row, "MD001"));
            }
            if (!kvsql.ContainsKey("MATERIAL_PARENT_ID"))
            {
                loginfo.Append("无父物料 MATERIAL_PARENT_ID(MD001)=").Append(getERPMaterialId(row, "MD007"));
            }
            log.Debug(loginfo.ToString());
            return -1;
        }
        #endregion
    }
}
