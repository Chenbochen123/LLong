using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using Mesnac.DbAccess;
using Mesnac.DbSyn.Business.Implements;

namespace Mesnac.DbSyn.LLERP.HR_PERSON
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
            if (!isUpdate)
            {
                #region OBJID
                var objId = 0;
                {
                    var sqlsb = new StringBuilder();
                    sqlsb.Append("select SEQ_SSB_USER.nextval from dual");
                    thisDbHelper.CommandText = sqlsb.ToString();
                    objId = Convert.ToInt32(thisDbHelper.ToScalar().ToString());
                    kvsql.Add("OBJID", objId);
                }
                #endregion
                #region WORK_BARCODE
                //kvsql.Add("WORK_BARCODE", objId.ToString("D6"));
                #endregion
            }
            #region BAKUP_FLAG
            kvsql.Add("BAKUP_FLAG", 0);
            #endregion
            #region DEPT_ID
            {
                var value = 0;
                var dept_hr_code = row["ORG_ID"];
                if (dept_hr_code != null
                    && dept_hr_code != DBNull.Value
                    && (!string.IsNullOrWhiteSpace(dept_hr_code.ToString())))
                {
                    var sqlsb = new StringBuilder();
                    sqlsb.Append("select OBJID from SSB_DEPT where 1=1");
                    thisKVSql.Add("hr_code", dept_hr_code);
                    thisKVSql.ToWhere(thisDbHelper, sqlsb);
                    thisDbHelper.CommandText = sqlsb.ToString();
                    var dbObjid = thisDbHelper.ToScalar();
                    if (dbObjid != null
                        && dbObjid != DBNull.Value
                        && (!string.IsNullOrWhiteSpace(dbObjid.ToString())))
                    {
                        value = Convert.ToInt32(dbObjid.ToString());
                    }
                }
                if (value > 0)
                {
                    kvsql.Add("DEPT_ID", value);
                }
            }
            #endregion
            #region RECORD_USER_ID
            kvsql.Add("RECORD_USER_ID", 0);
            #endregion
            #region RECORD_TIME
            kvsql.Add("RECORD_TIME", DateTime.Now);
            #endregion

            var result = 0;
            return result;
        }
        #endregion
    }
}
