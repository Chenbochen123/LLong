using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using Mesnac.DbAccess;
using Mesnac.DbSyn.Business.Implements;

namespace Mesnac.DbSyn.LLERP.CPT_PDM_MES_PARMC
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
        private DateTime getDate(DataRow row, string fieldName, string fieldName2)
        {
            var result = getDate(row, fieldName);
            if (result == DateTime.MinValue)
            {
                result = getDate(row, fieldName2);
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
            #region PARM_COMBINE
            kvsql.Add("PARM_COMBINE", 0);
            #endregion
            #region BACKUP_FLAG
            kvsql.Add("BACKUP_FLAG", 0);
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
            #region LASTMODIFIER
            kvsql.Add("LASTMODIFIER", 0);
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
                var value = 0;
                var dbvaule = getRowString(row,"VALIDFLAG");
                if (!string.IsNullOrWhiteSpace(dbvaule))
                {
                    value = 1;
                }
                kvsql.Add("DELETE_FLAG", value);
            }
            #endregion

            #region PARM_GROUP_ID
            var parmGroupName = row["PARMINDX"];
            if ((parmGroupName != null)
                && (parmGroupName != DBNull.Value)
                && (!string.IsNullOrWhiteSpace(parmGroupName.ToString())))
            {
                var parmGroupId = 0;
                var sqlsb = new StringBuilder();

                sqlsb.Append("select objid from CPT_CURING_TECH_PARM_GROUP where 1=1");
                thisKVSql.Add("PDM_CODE", parmGroupName);
                thisKVSql.ToWhere(thisDbHelper, sqlsb);
                thisDbHelper.CommandText = sqlsb.ToString();
                var scalar = thisDbHelper.ToScalar();
                if ((scalar != null)
                    && (scalar != DBNull.Value)
                    && (!string.IsNullOrWhiteSpace(scalar.ToString())))
                {
                    parmGroupId = Convert.ToInt32(scalar.ToString());
                }
                else
                {
                    sqlsb = new StringBuilder();
                    sqlsb.Append("select SEQ_CPT_CURING_TECH_PARM_GROUP.nextval from dual");
                    thisDbHelper.CommandText = sqlsb.ToString();
                    parmGroupId = Convert.ToInt32(thisDbHelper.ToScalar().ToString());

                    sqlsb = new StringBuilder();
                    sqlsb.Append(@"insert into CPT_CURING_TECH_PARM_GROUP
                          (OBJID,RECORD_USER_ID,RECORD_TIME,BACKUP_FLAG,DELETE_FLAG,
                           PDM_CODE,PARM_GROUP_NAME) VALUES (");
                    sqlsb.Append(parmGroupId.ToString()).Append(",0,sysdate,0,0,");
                    thisKVSql.Add("PDM_CODE", parmGroupName);
                    thisKVSql.Add("PARM_GROUP_NAME", parmGroupName);
                    thisKVSql.ToInsert(thisDbHelper, new StringBuilder(), sqlsb);
                    thisKVSql.RemoveLastChar(sqlsb).Append(")");
                    thisDbHelper.CommandText = sqlsb.ToString();
                    thisDbHelper.ExecuteNonQuery();
                }

                string key = "PARM_GROUP_ID";
                kvsql.Add(key, parmGroupId);
            }
            #endregion

            #region PARM_TYPE_ID
            var parmTypeCode = row["PARMTYPECODE"];
            var parmTypeId = 0;
            if ((parmTypeCode != null)
                && (parmTypeCode != DBNull.Value)
                && (!string.IsNullOrWhiteSpace(parmTypeCode.ToString())))
            {
                var sqlsb = new StringBuilder();
                var parmTypeName = row["PARMTYPENAME"];

                sqlsb.Append("select objid from CPT_CURING_TECH_PARM_TYPE where 1=1");
                thisKVSql.Add("PDM_CODE", parmTypeCode);
                thisKVSql.ToWhere(thisDbHelper, sqlsb);
                thisDbHelper.CommandText = sqlsb.ToString();
                var scalar = thisDbHelper.ToScalar();
                if ((scalar != null)
                    && (scalar != DBNull.Value)
                    && (!string.IsNullOrWhiteSpace(scalar.ToString())))
                {
                    parmTypeId = Convert.ToInt32(scalar.ToString());
                }
                else
                {
                    sqlsb = new StringBuilder();
                    sqlsb.Append("select SEQ_CPT_CURING_TECH_PARM_TYPE.nextval from dual");
                    thisDbHelper.CommandText = sqlsb.ToString();
                    parmTypeId = Convert.ToInt32(thisDbHelper.ToScalar().ToString());

                    sqlsb = new StringBuilder();
                    sqlsb.Append(@"insert into CPT_CURING_TECH_PARM_TYPE
                          (OBJID,RECORD_USER_ID,RECORD_TIME,BACKUP_FLAG,DELETE_FLAG,
                           PDM_CODE,PARM_TYPE_NAME) VALUES (");
                    sqlsb.Append(parmTypeId.ToString()).Append(",0,sysdate,0,0,");
                    thisKVSql.Add("PDM_CODE", parmTypeCode);
                    thisKVSql.Add("PARM_TYPE_NAME", parmTypeName);
                    thisKVSql.ToInsert(thisDbHelper, new StringBuilder(), sqlsb);
                    thisKVSql.RemoveLastChar(sqlsb).Append(")");
                    thisDbHelper.CommandText = sqlsb.ToString();
                    thisDbHelper.ExecuteNonQuery();
                }

                string key = "PARM_TYPE_ID";
                kvsql.Add(key, parmTypeId);
            }
            #endregion

            #region PARM_INFO_ID
            var parmInfoCode = row["PARMCODE"];
            if ((parmInfoCode != null)
                && (parmInfoCode != DBNull.Value)
                && (!string.IsNullOrWhiteSpace(parmInfoCode.ToString())))
            {
                var parmInfoId = 0;
                var sqlsb = new StringBuilder();
                var parmInfoName = row["PARMNAME"];

                sqlsb.Append("select objid from CPT_CURING_TECH_PARM_INFO where 1=1");
                thisKVSql.Add("PDM_CODE", parmInfoCode);
                thisKVSql.ToWhere(thisDbHelper, sqlsb);
                thisDbHelper.CommandText = sqlsb.ToString();
                var scalar = thisDbHelper.ToScalar();
                if ((scalar != null)
                    && (scalar != DBNull.Value)
                    && (!string.IsNullOrWhiteSpace(scalar.ToString())))
                {
                    parmInfoId = Convert.ToInt32(scalar.ToString());
                }
                else
                {
                    sqlsb = new StringBuilder();
                    sqlsb.Append("select SEQ_CPT_CURING_TECH_PARM_INFO.nextval from dual");
                    thisDbHelper.CommandText = sqlsb.ToString();
                    parmInfoId = Convert.ToInt32(thisDbHelper.ToScalar().ToString());

                    sqlsb = new StringBuilder();
                    sqlsb.Append(@"insert into CPT_CURING_TECH_PARM_INFO
                          (OBJID,RECORD_USER_ID,RECORD_TIME,BACKUP_FLAG,DELETE_FLAG,
                           PDM_CODE,PARM_NAME,PARM_TYPE_ID) VALUES (");
                    sqlsb.Append(parmInfoId.ToString()).Append(",0,sysdate,0,0,");
                    thisKVSql.Add("PDM_CODE", parmInfoCode);
                    thisKVSql.Add("PARM_NAME", parmInfoName);
                    thisKVSql.Add("PARM_TYPE_ID", parmTypeId);
                    thisKVSql.ToInsert(thisDbHelper, new StringBuilder(), sqlsb);
                    thisKVSql.RemoveLastChar(sqlsb).Append(")");
                    thisDbHelper.CommandText = sqlsb.ToString();
                    thisDbHelper.ExecuteNonQuery();
                }

                string key = "PARM_INFO_ID";
                kvsql.Add(key, parmInfoId);
            }
            #endregion

            return 0;
        }
        #endregion
    }
}
