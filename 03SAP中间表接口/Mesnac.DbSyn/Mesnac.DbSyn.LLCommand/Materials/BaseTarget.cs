using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using Mesnac.DbAccess;
using Mesnac.DbSyn.Business.Implements;

namespace Mesnac.DbSyn.LLERP.Materials
{
    /// <summary>
    /// 同步主表物料信息
    /// </summary>
    public class BaseTarget : TableSyn.BaseTarget
    {
        #region ExcuteRowSyn 执行同步
        #region 数据获取
        #region 子类重写
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
        /// 添加子数据信息
        /// </summary>
        /// <param name="dbSyn"></param>
        /// <returns></returns>
        protected virtual int insertSubData(DbSynResult dbSyn, int primarykey)
        {
            var result = 0;
            return result;
        }
        /// <summary>
        /// 更新子数据信息
        /// </summary>
        /// <param name="dbSyn"></param>
        /// <returns></returns>
        protected virtual int updateSubData(DbSynResult dbSyn, int primarykey)
        {
            var result = 0;
            return result;
        }
        #endregion
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
            //<SourceTargetField SourceFieldName="MaterialCode" TargetFieldName="SBM_MATERIAL.MATERIAL_CODE"/>
            {
                string tfieldName = "MATERIAL_CODE";
                string sfieldName = "MaterialCode";
                if (!row.IsNull(sfieldName))
                {
                    object value = getString(row, sfieldName);
                    if (value != null && value != DBNull.Value)
                    {
                        value = value.ToString();
                        if (value.ToString().Length > 10)
                        {
                            value = value.ToString().Substring(10) + getString(row, "MaterialDesc");
                        }
                        else
                        {
                            value = getString(row, "MatDescFull");
                        }
                    }
                    kvsql.Add(tfieldName, value);
                }
            }
            {
                string tfieldName = "MATERIAL_NAME";
                string sfieldName1 = "MaterialCode";
                string sfieldName2 = "MatDescFull";
                var value = getString(row, sfieldName1);
                if (string.IsNullOrWhiteSpace(value) || value.Length < 11)
                {
                   var str = getString(row, sfieldName2);
                   if (str.Length > value.Length)
                   {
                       value = value.ToString().Substring(0, 10) + str;
                   }
                   else
                   {
                       value = value.ToString().Substring(0, 10) + str;
                   }
                }
                kvsql.Add(tfieldName, value);
            }
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



        #region 获取ERP与MES物料类型对应表
        private DbSqlHelper getNewDbSqlHelper(DbSynResult dbSyn)
        {
            var dbInfo = new DbInfo();
            dbInfo.DbName = dbSyn.SynTable.Target.TableInfo.DbSourceName;
            dbInfo.SynName = dbSyn.SynTable.Name;
            return DbSqlHelperFactory.Instance.NewDbSqlHelper(dbInfo);
        }
        private string getString(DataRow row, string column)
        {
            var result = string.Empty;
            if (!row.Table.Columns.Contains(column))
            {
                return result;
            }
            if (row[column] == null || row[column] == DBNull.Value)
            {
                return result;
            }
            return row[column].ToString();
        }
        private DataTable materialMinorTypeTable = new DataTable();
        private DataTable getMaterialMinorTypeTable(DbSynResult dbSyn)
        {
            if (materialMinorTypeTable.Rows.Count > 0)
            {
                return materialMinorTypeTable;
            }
            var thisDbHelper = getNewDbSqlHelper(dbSyn);
            var sqlsb = new StringBuilder();
            sqlsb.Append("select t.* from SBM_MATERIAL_MINOR_TYPE t");
            thisDbHelper.CommandText = sqlsb.ToString();
            materialMinorTypeTable = thisDbHelper.ToDataTable();
            return materialMinorTypeTable;
        }
        private string getErpMatGrp(DbSynResult dbSyn)
        {
            var row = dbSyn.Target.CurrentRow.DataRow;
            return getString(row, "MatGrp");
        }
        private bool isErpCode(string erps, string erp)
        {
            if (string.IsNullOrWhiteSpace(erps))
            {
                return false;
            }
            if (string.IsNullOrWhiteSpace(erp))
            {
                return false;
            }
            if (erps.ToLower().Trim() == erp.ToLower().Trim())
            {
                return true;
            }
            string[] ss = erps.Split(',');
            foreach (string str in ss)
            {
                if (str.ToLower().Trim() == erp.ToLower().Trim())
                {
                    return true;
                }
            }
            return false;
        }
        /// <summary>
        /// 获取大类编号
        /// </summary>
        /// <param name="erpCode"></param>
        /// <returns></returns>
        protected int getMAJOR_TYPE_ID(DbSynResult dbSyn)
        {
            var dtable = getMaterialMinorTypeTable(dbSyn);
            var erp = getErpMatGrp(dbSyn);
            foreach (DataRow row in dtable.Rows)
            {
                var mes = getString(row, "ERP_CODE");//ERP编号
                if (isErpCode(mes, erp))
                {
                    var str = getString(row, "MAJOR_TYPE_ID");
                    var id = 0;
                    int.TryParse(str, out id);
                    return id;
                }
            }
            return 0;
        }
        /// <summary>
        /// 获取细类编号
        /// </summary>
        /// <param name="erpCode"></param>
        /// <returns></returns>
        protected int getMINOR_TYPE_ID(DbSynResult dbSyn)
        {
            var dtable = getMaterialMinorTypeTable(dbSyn);
            var erp = getErpMatGrp(dbSyn);
            foreach (DataRow row in dtable.Rows)
            {
                var mes = getString(row, "ERP_CODE");//ERP编号
                if (isErpCode(mes, erp))
                {
                    var Objid = Convert.ToInt32(getString(row, "OBJID"));
                    return Objid;
                }
            }
            return 0;
        }
        #endregion


        #region 检验数据是否已经存在 checkData
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
            var kvsql = new KVSQL();
            #endregion

            #region 整理 sql 语句
            StringBuilder sqlsb = new StringBuilder();
            sqlsb.Append("select OBJID from SBM_MATERIAL where 1=1 ");
            kvsql.Add("SAP_CODE", row["MaterialPure"]);
            kvsql.ToWhere(dbHelper, sqlsb);
            dbHelper.CommandText = sqlsb.ToString();
            #endregion
            var dt = dbHelper.ToDataTable();
            if (dt.Rows.Count > 0)
            {
                result = Convert.ToInt32(dt.Rows[0]["OBJID"].ToString());
            }
            return result;
        }
        #endregion

        #region 更新数据 updateData
        /// <summary>
        /// 更新数据
        /// </summary>
        /// <param name="dbSyn"></param>
        /// <returns></returns>
        private int updateData(DbSynResult dbSyn, int primarykey)
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
            sqlsb.Append("update SBM_MATERIAL set ");
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
            kvsql.Add("OBJID", primarykey);
            kvsql.ToWhere(dbHelper, sqlsb);
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
            #region 基础数据
            var table = dbSyn.SynTable.Target.TableInfo;
            var dbHelper = getDbSqlHelper(dbSyn);
            var kvsql = new KVSQL();
            var primarykey = getSequenceNextVal(dbHelper, "SEQ_SBM_MATERIAL");
            #endregion
            #region 整理 sql 语句
            var sqlsb_fields = new StringBuilder();
            var sqlsb_values = new StringBuilder();
            sqlsb_fields.Append("insert into SBM_MATERIAL (");
            #region 主键
            kvsql.Add("OBJID", primarykey);
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
            int n = getDefaultTargetData(dbSyn, kvsql, false);
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
            kvsql.ToInsert(dbHelper, sqlsb_fields, sqlsb_values);
            kvsql.RemoveLastChar(sqlsb_fields);
            kvsql.RemoveLastChar(sqlsb_values);
            dbHelper.CommandText = sqlsb_fields.Append(") values (").Append(sqlsb_values).Append(")").ToString();
            #endregion
            dbHelper.ExecuteNonQuery();
            return primarykey;
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
            if (getMINOR_TYPE_ID(dbSyn) == 0)
            {
                log.Debug("无此物料细类：" + getErpMatGrp(dbSyn));
                return 0;
            }
            var result = 0;
            result = checkData(dbSyn);
            if (result == 0)
            {
                var pk = insertData(dbSyn);
                result = insertSubData(dbSyn, pk);
            }
            else
            {
                var pk = result;
                result = updateData(dbSyn, pk);
                result = updateSubData(dbSyn, pk);
            }
            return result;
        }
        #endregion

        #endregion
    }
}
