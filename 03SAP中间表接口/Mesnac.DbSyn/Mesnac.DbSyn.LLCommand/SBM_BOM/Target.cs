using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using Mesnac.DbAccess;
using Mesnac.DbSyn.Business.Implements;

namespace Mesnac.DbSyn.LLERP.SBM_BOM
{
    /// <summary>
    /// 目标 命令
    /// </summary>
    public class Target : TableSyn.BaseTarget
    {
        #region 执行同步 ExcuteRowSyn
        /// <summary>
        /// 插入数据
        /// </summary>
        /// <param name="dbSyn"></param>
        /// <returns></returns>
        private int insertData(DbSynResult dbSyn)
        {
            #region 基础数据
            var table = dbSyn.SynTable.Target.TableInfo;
            var dbHelper = getDbSqlHelper(dbSyn);
            var row = dbSyn.Target.CurrentRow.DataRow;
            var kvsql = new KVSQL();
            #endregion
            var result = 0;
            #region 整理 sql 语句
            var sqlsb_fields = new StringBuilder();
            sqlsb_fields.AppendLine(@"insert into sbm_bom
                  (objid, lastmodify_date, material_id, unit_id, group_num, greentyre_version, bom_type, bom_factroy, bom_version, group_unit_num, effect_date, lose_effect_date, pdm_code, drop_flag, greentyre_material_id, material_parent_id, record_user_id, record_time, backup_flag, backup_time, delete_flag)
                select objid, lastmodify_date, material_id, unit_id, group_num, greentyre_version, bom_type, bom_factroy, bom_version, group_unit_num, effect_date, lose_effect_date, pdm_code, drop_flag, greentyre_material_id, material_parent_id, record_user_id, record_time, backup_flag, backup_time, delete_flag
                from  sbm_bom_data t1
                where t1.delete_flag=0 and rownum=1");
            foreach (DataColumn dc in row.Table.Columns)
            {
                kvsql.Add(dc.ColumnName, row[dc]);
            }
            kvsql.ToWhere(dbHelper, sqlsb_fields);
            dbHelper.CommandText = sqlsb_fields.ToString();
            #endregion
            result += dbHelper.ExecuteNonQuery();
            return result;
        }

        /// <summary>
        /// 执行同步
        /// </summary>
        /// <param name="dbSyn"></param>
        /// <returns></returns>
        public override int ExcuteRowSyn(DbSynResult dbSyn)
        {
            var result = insertData(dbSyn);
            return result;
        }
        #endregion
    }
}
