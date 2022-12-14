using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using Mesnac.DbAccess;
using Mesnac.DbSyn.Business.Implements;
using System.Threading;

namespace Mesnac.DbSyn.LLERP.Materials
{
    /// <summary>
    /// 同步主表物料信息
    /// </summary>
    public class Target : Materials.BaseTarget
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
            #region MAJOR_TYPE_ID
            kvsql.Add("MAJOR_TYPE_ID", getMAJOR_TYPE_ID(dbSyn));  //大类
            #endregion
            #region MINOR_TYPE_ID
            kvsql.Add("MINOR_TYPE_ID", getMINOR_TYPE_ID(dbSyn));   //细类
            #endregion
            var result = 0;
            return result;
        }
        #endregion

        #region 更新子信息  insertSubData
        /// <summary>
        /// 获取插入数据的基础信息
        /// </summary>
        /// <param name="dbSyn"></param>
        /// <param name="dbHelper"></param>
        /// <param name="sqlsb_fields"></param>
        /// <param name="sqlsb_values"></param>
        private int getSourceToTargetData41(DbSynResult dbSyn, KVSQL kvsql)
        {
            #region 基础数据
            var table = dbSyn.SynTable.Target.TableInfo;
            var row = dbSyn.Target.CurrentRow.DataRow;
            var thisDbHelper = getNewDbSqlHelper(dbSyn);
            var thisKVSql = new KVSQL();
            #endregion

            #region CBM_PLYRATING
            #endregion
            #region CBM_PATTERN
            var patternName = row["PATTERN"];
            if ((patternName != null)
                && (patternName != DBNull.Value)
                && (!string.IsNullOrWhiteSpace(patternName.ToString())))
            {
                var patternId = 0;
                var sqlsb = new StringBuilder();

                sqlsb.Append("select objid from CBM_PATTERN where 1=1");
                thisKVSql.Add("PATTERN_NAME", patternName);
                thisKVSql.ToWhere(thisDbHelper, sqlsb);
                thisDbHelper.CommandText = sqlsb.ToString();
                var scalar = thisDbHelper.ToScalar();
                if ((scalar != null)
                    && (scalar != DBNull.Value)
                    && (!string.IsNullOrWhiteSpace(scalar.ToString())))
                {
                    patternId = Convert.ToInt32(scalar.ToString());
                }
                else
                {
                    sqlsb = new StringBuilder();
                    sqlsb.Append("select SEQ_CBM_PATTERN.nextval from dual");
                    thisDbHelper.CommandText = sqlsb.ToString();
                    patternId = Convert.ToInt32(thisDbHelper.ToScalar().ToString());

                    sqlsb = new StringBuilder();
                    sqlsb.Append(@"insert into CBM_PATTERN
                          (objid, record_user_id, record_time, backup_flag, delete_flag, seq_index,PATTERN_NAME)
                        values (");
                    sqlsb.Append(patternId.ToString()).Append(",0,sysdate,0,0,0,");

                    thisKVSql.Add("PATTERN_NAME", patternName);
                    thisKVSql.ToInsert(thisDbHelper, new StringBuilder(), sqlsb);
                    thisKVSql.RemoveLastChar(sqlsb).Append(")");
                    thisDbHelper.CommandText = sqlsb.ToString();
                    thisDbHelper.ExecuteNonQuery();
                }

                string key = "Pattern_Id";
                kvsql.Add(key, patternId);
            }
            #endregion

            var result = 0;
            return result;
        }
        /// <summary>
        /// 获取插入数据的基础信息
        /// </summary>
        /// <param name="dbSyn"></param>
        /// <param name="dbHelper"></param>
        /// <param name="sqlsb_fields"></param>
        /// <param name="sqlsb_values"></param>
        private int getSourceToTargetData51(DbSynResult dbSyn, KVSQL kvsql)
        {
            #region 基础数据
            var table = dbSyn.SynTable.Target.TableInfo;
            var row = dbSyn.Target.CurrentRow.DataRow;
            var thisDbHelper = getNewDbSqlHelper(dbSyn);
            var thisKVSql = new KVSQL();
            #endregion

            #region CBM_BRAND
            try
            {
                var brandName = row["Brand"];
                if ((brandName != null)
                    && (brandName != DBNull.Value)
                    && (!string.IsNullOrWhiteSpace(brandName.ToString())))
                {
                    var brandId = 0;
                    var sqlsb = new StringBuilder();

                    sqlsb.Append("select objid from CBM_BRAND where 1=1");
                    thisKVSql.Add("BRAND_NAME", brandName);
                    thisKVSql.ToWhere(thisDbHelper, sqlsb);
                    thisDbHelper.CommandText = sqlsb.ToString();
                    var scalar = thisDbHelper.ToScalar();
                    if ((scalar != null)
                        && (scalar != DBNull.Value)
                        && (!string.IsNullOrWhiteSpace(scalar.ToString())))
                    {
                        brandId = Convert.ToInt32(scalar.ToString());
                    }
                    else
                    {
                        sqlsb = new StringBuilder();
                        sqlsb.Append("select SEQ_CBM_BRAND.nextval from dual");
                        thisDbHelper.CommandText = sqlsb.ToString();
                        brandId = Convert.ToInt32(thisDbHelper.ToScalar().ToString());

                        sqlsb = new StringBuilder();
                        sqlsb.Append(@"insert into CBM_BRAND
                          (objid, record_user_id, record_time, backup_flag, delete_flag, seq_index,brand_name, other_name)
                        values (");
                        sqlsb.Append(brandId.ToString()).Append(",0,sysdate,0,0,0,");
                        thisKVSql.Add("BRAND_NAME", brandName);
                        thisKVSql.Add("other_name", brandName);
                        thisKVSql.ToInsert(thisDbHelper, new StringBuilder(), sqlsb);
                        thisKVSql.RemoveLastChar(sqlsb).Append(")");
                        thisDbHelper.CommandText = sqlsb.ToString();
                        thisDbHelper.ExecuteNonQuery();
                    }

                    string key = "BRAND_ID";
                    kvsql.Add(key, brandId);
                }
            }
            catch (Exception ex)
            {
                log.Error("CBM_BRAND" + ex.ToString());
                throw ex;
            }
            
            #endregion

            #region CBM_PATTERN
            try
            {
                var patternName = row["PATTERN"];
                if ((patternName != null)
                    && (patternName != DBNull.Value)
                    && (!string.IsNullOrWhiteSpace(patternName.ToString())))
                {
                    var patternId = 0;
                    var sqlsb = new StringBuilder();

                    sqlsb.Append("select objid from CBM_PATTERN where 1=1");
                    thisKVSql.Add("PATTERN_NAME", patternName);
                    thisKVSql.ToWhere(thisDbHelper, sqlsb);
                    thisDbHelper.CommandText = sqlsb.ToString();
                    var scalar = thisDbHelper.ToScalar();
                    if ((scalar != null)
                        && (scalar != DBNull.Value)
                        && (!string.IsNullOrWhiteSpace(scalar.ToString())))
                    {
                        patternId = Convert.ToInt32(scalar.ToString());
                    }
                    else
                    {
                        sqlsb = new StringBuilder();
                        sqlsb.Append("select SEQ_CBM_PATTERN.nextval from dual");
                        thisDbHelper.CommandText = sqlsb.ToString();
                        patternId = Convert.ToInt32(thisDbHelper.ToScalar().ToString());

                        sqlsb = new StringBuilder();
                        sqlsb.Append(@"insert into CBM_PATTERN
                          (objid, record_user_id, record_time, backup_flag, delete_flag, seq_index,PATTERN_NAME)
                        values (");
                        sqlsb.Append(patternId.ToString()).Append(",0,sysdate,0,0,0,");

                        thisKVSql.Add("PATTERN_NAME", patternName);
                        thisKVSql.ToInsert(thisDbHelper, new StringBuilder(), sqlsb);
                        thisKVSql.RemoveLastChar(sqlsb).Append(")");
                        thisDbHelper.CommandText = sqlsb.ToString();
                        thisDbHelper.ExecuteNonQuery();
                    }

                    string key = "Pattern_Id";
                    kvsql.Add(key, patternId);
                }
            }
            catch (Exception ex)
            {

                log.Error("CBM_PATTERN" + ex.ToString());
                throw ex;
            }
            
            #endregion

            #region CBM_SIZE
            try
            {
                //by dingby 20161021(规格)
                var sizeName = row["THSpec"];
                if ((sizeName != null)
                    && (sizeName != DBNull.Value)
                    && (!string.IsNullOrWhiteSpace(sizeName.ToString())))
                {
                    var sizeId = 0;
                    var sqlsb = new StringBuilder();

                    sqlsb.Append("select objid from CBM_SIZE where 1=1");
                    thisKVSql.Add("SIZE_NAME", sizeName);
                    thisKVSql.ToWhere(thisDbHelper, sqlsb);
                    thisDbHelper.CommandText = sqlsb.ToString();
                    var scalar = thisDbHelper.ToScalar();
                    if ((scalar != null)
                        && (scalar != DBNull.Value)
                        && (!string.IsNullOrWhiteSpace(scalar.ToString())))
                    {
                        sizeId = Convert.ToInt32(scalar.ToString());
                    }
                    else
                    {
                        sqlsb = new StringBuilder();
                        sqlsb.Append("select SEQ_CBM_SIZE.nextval from dual");
                        thisDbHelper.CommandText = sqlsb.ToString();
                        sizeId = Convert.ToInt32(thisDbHelper.ToScalar().ToString());

                        sqlsb = new StringBuilder();
                        sqlsb.Append(@"insert into CBM_SIZE
                          (objid, record_user_id, record_time, backup_flag, delete_flag, size_name)
                        values (");
                        sqlsb.Append(sizeId.ToString()).Append(",0,sysdate,0,0,");
                        thisKVSql.Add("SIZE_NAME", sizeName);
                        thisKVSql.ToInsert(thisDbHelper, new StringBuilder(), sqlsb);
                        thisKVSql.RemoveLastChar(sqlsb).Append(")");
                        thisDbHelper.CommandText = sqlsb.ToString();
                        thisDbHelper.ExecuteNonQuery();
                    }

                    string key = "SIZE_ID";
                    kvsql.Add(key, sizeId);
                }
            }
            catch (Exception ex)
            {
                log.Error("CBM_SIZE" + ex.ToString());
                throw ex;
                
            }
            
            #endregion

            #region CBM_LOAD_INDEX
            try
            {
                //by dingby 20161021(负荷指数)
                var loadIndexName = row["ZCS02"];
                if ((loadIndexName != null)
                    && (loadIndexName != DBNull.Value)
                    && (!string.IsNullOrWhiteSpace(loadIndexName.ToString())))
                {
                    var loadIndexId = 0;
                    var sqlsb = new StringBuilder();

                    sqlsb.Append("select objid from CBM_LOAD_INDEX where 1=1");
                    thisKVSql.Add("LOAD_INDEX_NAME", loadIndexName);
                    thisKVSql.ToWhere(thisDbHelper, sqlsb);
                    thisDbHelper.CommandText = sqlsb.ToString();
                    var scalar = thisDbHelper.ToScalar();
                    if ((scalar != null)
                        && (scalar != DBNull.Value)
                        && (!string.IsNullOrWhiteSpace(scalar.ToString())))
                    {
                        loadIndexId = Convert.ToInt32(scalar.ToString());
                    }
                    else
                    {
                        sqlsb = new StringBuilder();
                        sqlsb.Append("select SEQ_CBM_LOAD_INDEX.nextval from dual");
                        thisDbHelper.CommandText = sqlsb.ToString();
                        loadIndexId = Convert.ToInt32(thisDbHelper.ToScalar().ToString());

                        sqlsb = new StringBuilder();
                        sqlsb.Append(@"insert into CBM_LOAD_INDEX
                          (objid, record_user_id, record_time, backup_flag, delete_flag, load_index_name)
                        values (");
                        sqlsb.Append(loadIndexId.ToString()).Append(",0,sysdate,0,0,");
                        thisKVSql.Add("LOAD_INDEX_NAME", loadIndexName);
                        thisKVSql.ToInsert(thisDbHelper, new StringBuilder(), sqlsb);
                        thisKVSql.RemoveLastChar(sqlsb).Append(")");
                        thisDbHelper.CommandText = sqlsb.ToString();
                        thisDbHelper.ExecuteNonQuery();
                    }

                    string key = "LOAD_INDEX_ID";
                    kvsql.Add(key, loadIndexId);
                }
            }
            catch (Exception ex)
            {
                log.Error("CBM_LOAD_INDEX" + ex.ToString());
                throw ex;
            }
           
            #endregion

            #region CBM_SPEED_LEVEL
            try
            {
                //by dingby 20161021(速度级别)
                var speedLevelName = row["ZCS03"];
                if ((speedLevelName != null)
                    && (speedLevelName != DBNull.Value)
                    && (!string.IsNullOrWhiteSpace(speedLevelName.ToString())))
                {
                    var speedLevelId = 0;
                    var sqlsb = new StringBuilder();

                    sqlsb.Append("select objid from CBM_SPEED_LEVEL where 1=1");
                    thisKVSql.Add("SPEED_LEVEL_NAME", speedLevelName);
                    thisKVSql.ToWhere(thisDbHelper, sqlsb);
                    thisDbHelper.CommandText = sqlsb.ToString();
                    var scalar = thisDbHelper.ToScalar();
                    if ((scalar != null)
                        && (scalar != DBNull.Value)
                        && (!string.IsNullOrWhiteSpace(scalar.ToString())))
                    {
                        speedLevelId = Convert.ToInt32(scalar.ToString());
                    }
                    else
                    {
                        sqlsb = new StringBuilder();
                        sqlsb.Append("select SEQ_CBM_SPEED_LEVEL.nextval from dual");
                        thisDbHelper.CommandText = sqlsb.ToString();
                        speedLevelId = Convert.ToInt32(thisDbHelper.ToScalar().ToString());

                        sqlsb = new StringBuilder();
                        sqlsb.Append(@"insert into CBM_SPEED_LEVEL
                          (objid, record_user_id, record_time, backup_flag, delete_flag, speed_level_name)
                        values (");
                        sqlsb.Append(speedLevelId.ToString()).Append(",0,sysdate,0,0,");
                        thisKVSql.Add("SPEED_LEVEL_NAME", speedLevelName);
                        thisKVSql.ToInsert(thisDbHelper, new StringBuilder(), sqlsb);
                        thisKVSql.RemoveLastChar(sqlsb).Append(")");
                        thisDbHelper.CommandText = sqlsb.ToString();
                        thisDbHelper.ExecuteNonQuery();
                    }

                    string key = "SPEED_LEVEL_ID";
                    kvsql.Add(key, speedLevelId);
                }
            }
            catch (Exception ex)
            {
                log.Error("CBM_SPEED_LEVEL" + ex.ToString());
                throw ex;
            }
           
            #endregion

            #region CBM_PLYRATING
            try
            {
                //by dingby 20161021(层级)
                var plyratingName = row["CJ"];
                if ((plyratingName != null)
                    && (plyratingName != DBNull.Value)
                    && (!string.IsNullOrWhiteSpace(plyratingName.ToString())))
                {
                    var plyratingId = 0;
                    var sqlsb = new StringBuilder();

                    sqlsb.Append("select objid from CBM_PLYRATING where 1=1");
                    thisKVSql.Add("PLYRATING_NAME", plyratingName);
                    thisKVSql.ToWhere(thisDbHelper, sqlsb);
                    thisDbHelper.CommandText = sqlsb.ToString();
                    var scalar = thisDbHelper.ToScalar();
                    if ((scalar != null)
                        && (scalar != DBNull.Value)
                        && (!string.IsNullOrWhiteSpace(scalar.ToString())))
                    {
                        plyratingId = Convert.ToInt32(scalar.ToString());
                    }
                    else
                    {
                        sqlsb = new StringBuilder();
                        sqlsb.Append("select SEQ_CBM_PLYRATING.nextval from dual");
                        thisDbHelper.CommandText = sqlsb.ToString();
                        plyratingId = Convert.ToInt32(thisDbHelper.ToScalar().ToString());

                        sqlsb = new StringBuilder();
                        sqlsb.Append(@"insert into CBM_PLYRATING
                          (objid, record_user_id, record_time, backup_flag, delete_flag, plyrating_name)
                        values (");
                        sqlsb.Append(plyratingId.ToString()).Append(",0,sysdate,0,0,");
                        thisKVSql.Add("PLYRATING_NAME", plyratingName);
                        thisKVSql.ToInsert(thisDbHelper, new StringBuilder(), sqlsb);
                        thisKVSql.RemoveLastChar(sqlsb).Append(")");
                        thisDbHelper.CommandText = sqlsb.ToString();
                        thisDbHelper.ExecuteNonQuery();
                    }

                    string key = "PLYRATING_ID";
                    kvsql.Add(key, plyratingId);
                }
            }
            catch (Exception ex)
            {
                log.Error("CBM_PLYRATING" + ex.ToString());
                throw ex;
            }
           
            #endregion
            

            var result = 0;
            return result;
        }
        #region insertSubData
        private int insertSubData41(DbSynResult dbSyn, int primarykey)
        {
            #region 基础数据
            var table = dbSyn.SynTable.Target.TableInfo;
            var dbHelper = getDbSqlHelper(dbSyn);
            var kvsql = new KVSQL();
            #endregion
            #region 整理 sql 语句
            var sqlsb_fields = new StringBuilder();
            var sqlsb_values = new StringBuilder();
            sqlsb_fields.Append("insert into  BBM_MATERIAL(");
            #region 主键
            kvsql.Add("MATERIAL_ID", primarykey);
            #endregion
            var n = getSourceToTargetData41(dbSyn, kvsql);
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
        private int insertSubData51(DbSynResult dbSyn, int primarykey)
        {
            #region 基础数据
            var table = dbSyn.SynTable.Target.TableInfo;
            var dbHelper = getDbSqlHelper(dbSyn);
            var kvsql = new KVSQL();
            #endregion
            #region 整理 sql 语句
            var sqlsb_fields = new StringBuilder();
            var sqlsb_values = new StringBuilder();
            sqlsb_fields.Append("insert into  CBM_MATERIAL(");
            #region 主键
            kvsql.Add("MATERIAL_ID", primarykey);
            #endregion
            var n = getSourceToTargetData51(dbSyn, kvsql);
            if (n < 0)
            {
                dbHelper.Dispose();
                return 1;
            }
            kvsql.ToInsert(dbHelper, sqlsb_fields, sqlsb_values);
            kvsql.RemoveLastChar(sqlsb_fields);
            kvsql.RemoveLastChar(sqlsb_values);
            dbHelper.CommandText = sqlsb_fields.Append(") values (").Append(sqlsb_values).Append(")").ToString();
            log.Error(primarykey + dbHelper.CommandText);
            #endregion
            dbHelper.ExecuteNonQuery();
            return primarykey;
        }
        protected override int insertSubData(DbSynResult dbSyn, int primarykey)
        {
            if (getMAJOR_TYPE_ID(dbSyn) == 41)
            {
                return insertSubData41(dbSyn, primarykey);
            }
            Thread.Sleep(1000);
            if (getMAJOR_TYPE_ID(dbSyn) == 51)
            {
                return insertSubData51(dbSyn, primarykey);
            }
            return 1;
        }
        #endregion
        #region updateSubData
        private int updateSubData41(DbSynResult dbSyn, int primarykey)
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
            sqlsb.Append("update BBM_MATERIAL set ");
            var n = getSourceToTargetData41(dbSyn, kvsql);
            if (n < 0)
            {
                dbHelper.Dispose();
                return 1;
            }
            if (kvsql.Count == 0)
            {
                dbHelper.Dispose();
                return 1;
            }
            kvsql.ToUpdate(dbHelper, sqlsb);
            kvsql.RemoveLastChar(sqlsb);

            sqlsb.Append(" where 1=1 ");
            #endregion
            #region  整理 sql 语句 where
            kvsql.Add("MATERIAL_ID", primarykey);
            kvsql.ToWhere(dbHelper, sqlsb);
            dbHelper.CommandText = sqlsb.ToString();
            log.Error(dbHelper.CommandText);
            #endregion
            result = dbHelper.ExecuteNonQuery();
            return result;
        }
        private int updateSubData51(DbSynResult dbSyn, int primarykey)
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
            sqlsb.Append("update CBM_MATERIAL SET ");
            var n = getSourceToTargetData51(dbSyn, kvsql);
            if (n < 0)
            {
                dbHelper.Dispose();
                return 1;
            }
            if (kvsql.Count == 0)
            {
                dbHelper.Dispose();
                return 1;
            }
            kvsql.ToUpdate(dbHelper, sqlsb);
            kvsql.RemoveLastChar(sqlsb);
            sqlsb.Append(" where 1=1 ");
            #endregion
            #region  整理 sql 语句 where
            kvsql.Add("MATERIAL_ID", primarykey);
            kvsql.ToWhere(dbHelper, sqlsb);
            dbHelper.CommandText = sqlsb.ToString();
            log.Error(primarykey + dbHelper.CommandText);
            #endregion
            result = dbHelper.ExecuteNonQuery();
            return result;
        }

        protected override int updateSubData(DbSynResult dbSyn, int primarykey)
        {
            if (getMAJOR_TYPE_ID(dbSyn) == 41)
            {
                return updateSubData41(dbSyn, primarykey);
            }
            Thread.Sleep(1000);
            if (getMAJOR_TYPE_ID(dbSyn) == 51)
            {
                return updateSubData51(dbSyn, primarykey);
            }
            return 1;
        }
        #endregion
        #endregion
    }
}
