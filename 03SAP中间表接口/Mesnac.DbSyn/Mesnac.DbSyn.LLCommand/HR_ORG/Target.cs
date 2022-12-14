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
    public class Target : TableSyn.Target
    {
        #region 获取插入数据的基础信息
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
            #endregion
            #region RECORD_USER_ID
            kvsql.Add("RECORD_USER_ID", 0);
            #endregion
            #region DELETE_FLAG
            kvsql.Add("DELETE_FLAG", 0);
            #endregion
            #region RECORD_TIME
            kvsql.Add("RECORD_TIME", DateTime.Now);
            #endregion

            var result = 0;
            return result;
        }
        #endregion

        #region FinishRowSyn 单条执行完成
        /// <summary>
        /// 单条执行完成
        /// </summary>
        /// <param name="dbSyn"></param>
        /// <returns></returns>
        public override int FinishRowSyn(DbSynResult dbSyn)
        {
            var result = 0;
            return result;
        }
        #endregion

        #region FinishSyn 批量执行完成
        private class ParentInfo
        {
            public int ObjId { get; set; }
            public int ParentId { get; set; }
            public int Level { get; set; }
            public string HR_CODE { get; set; }
        }
        private int UpdateParent(DbSynResult dbSyn, ParentInfo parInfo)
        {
            var result = 0;
            #region 基础数据
            var table = dbSyn.SynTable.Target.TableInfo;
            var dbHelper = getDbSqlHelper(dbSyn);
            var kvsql = new KVSQL();
            #endregion
            var sqlsb = new StringBuilder();
            sqlsb.Append("UPDATE SSB_DEPT SET ");
            #region PARENT_ID
            kvsql.Add("PARENT_ID", parInfo.ParentId);
            #endregion
            #region DEPT_LEVEL
            kvsql.Add("DEPT_LEVEL", parInfo.Level);
            #endregion
            kvsql.ToUpdate(dbHelper, sqlsb);
            kvsql.RemoveLastChar(sqlsb).Append(" where 1=1 ");
            #region OBJID
            kvsql.Add("OBJID", parInfo.ObjId);
            #endregion
            kvsql.ToWhere(dbHelper, sqlsb);
            dbHelper.CommandText = sqlsb.ToString();
            result = dbHelper.ExecuteNonQuery();
            return result;
        }

        #region FinishSyn 批量执行完成 一次性处理，升级Level
        private void IniChild(DbSynResult dbSyn, ParentInfo info)
        {
            #region 基础数据
            var table = dbSyn.SynTable.Target.TableInfo;
            var dbHelper = getDbSqlHelper(dbSyn);
            var sourceTable = dbSyn.Source.SelectData;
            #endregion
            var sqlsb = new StringBuilder();
            sqlsb.Append(@"select * from ssb_dept where hr_code_parent=");
            sqlsb.Append(info.HR_CODE.ToString());
            dbHelper.CommandText = sqlsb.ToString();
            var dbTable = dbHelper.ToDataTable();
            foreach (DataRow row in dbTable.Rows)
            {
                ParentInfo parInfo = new ParentInfo();
                parInfo.ObjId = Convert.ToInt32(row["OBJID"].ToString());
                parInfo.HR_CODE = row["HR_CODE"].ToString();
                parInfo.ParentId = info.ObjId;
                parInfo.Level = info.Level + 1;
                UpdateParent(dbSyn, parInfo);
                IniChild(dbSyn, parInfo);
            }
        }
        /// <summary>
        /// 批量执行完成
        /// </summary>
        /// <param name="dbSyn"></param>
        /// <returns></returns>
        public override int FinishSyn(DbSynResult dbSyn)
        {
            #region 基础数据
            var table = dbSyn.SynTable.Target.TableInfo;
            var dbHelper = getDbSqlHelper(dbSyn);
            var sourceTable = dbSyn.Source.SelectData;
            #endregion
            var result = 0;
            var sqlsb = new StringBuilder();
            sqlsb.Append(@"select t1.* from ssb_dept t1 
                    left join ssb_dept t2 on t1.hr_code_parent=t2.hr_code
                    where t2.objid is null and t1.hr_code  is not null
                    ");
            dbHelper.CommandText = sqlsb.ToString();
            var dbTable = dbHelper.ToDataTable();
            foreach (DataRow row in dbTable.Rows)
            {
                ParentInfo parInfo = new ParentInfo();
                parInfo.ObjId = Convert.ToInt32(row["OBJID"].ToString());
                parInfo.HR_CODE = row["HR_CODE"].ToString();
                parInfo.ParentId = 0;
                parInfo.Level = 1;
                UpdateParent(dbSyn, parInfo);
                IniChild(dbSyn, parInfo);
            }
            return result;
        }
        #endregion

        #endregion
    }
}
