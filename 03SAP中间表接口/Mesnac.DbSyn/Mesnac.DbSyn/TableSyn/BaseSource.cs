using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using Mesnac.DbAccess;
using Mesnac.DbSyn.Business.Implements;

namespace Mesnac.DbSyn.TableSyn
{
    /// <summary>
    /// 源数据 命令
    /// </summary>
    public abstract class BaseSource : BaseData, ISynSourceCommand
    {
        #region 构造函数
        public BaseSource()
        {
        }
        /// <summary>
        /// 获取数据连接
        /// </summary>
        /// <param name="dbSyn"></param>
        /// <returns></returns>
        protected DbSqlHelper getDbSqlHelper(DbSynResult dbSyn)
        {
            var dbInfo = new DbInfo();
            dbInfo.DbName = dbSyn.SynTable.Source.TableInfo.DbSourceName;
            dbInfo.SynName = dbSyn.SynTable.Name;
            return DbSqlHelperFactory.Instance.GetDbSqlHelper(dbInfo);
        }
        /// <summary>
        /// 获取数据管理
        /// </summary>
        /// <param name="dbSyn"></param>
        /// <returns></returns>
        protected McSynTableManager getManager(DbSynResult dbSyn)
        {
            var dbInfo = new DbInfo();
            dbInfo.DbName = dbSyn.SynTable.Source.TableInfo.DbSourceName;
            dbInfo.SynName = dbSyn.SynTable.Name;
            return DbSqlHelperFactory.Instance.GetManager(dbInfo);
        }
        #endregion

        #region BeginSyn 开始同步
        /// <summary>
        /// 开始同步
        /// </summary>
        /// <param name="dbSyn"></param>
        /// <returns></returns>
        public virtual int BeginSyn(DbSynResult dbSyn)
        {
            var result = 0;
            #region 基础数据
            var dbHelper = getDbSqlHelper(dbSyn);
            var keyValues = dbSyn.SynTable.Source.BeginSyn;
            #endregion
            #region 整理 sql 语句
            foreach (var kv in keyValues)
            {
                try
                {
                    string key = kv.Key;
                    string value = kv.Value;
                    if (key.ToLower() == k_sql)
                    {
                        if (string.IsNullOrWhiteSpace(value))
                        {
                            continue;
                        }
                        dbHelper.CommandText = value;
                        result = dbHelper.ExecuteNonQuery();
                    }
                }
                catch { }
            }
            #endregion
            return result;
        }
        #endregion
        #region SelectData 查询数据
        /// <summary>
        /// 查询数据
        /// </summary>
        /// <param name="dbSyn"></param>
        /// <returns></returns>
        public abstract DataTable SelectData(DbSynResult dbSyn);
        #endregion
        #region VerifyRow 校验数据
        /// <summary>
        /// 校验数据
        /// </summary>
        /// <param name="dbSyn"></param>
        /// <returns></returns>
        public virtual int VerifyRow(DbSynResult dbSyn)
        {
            var result = 0;
            return result;
        }
        #endregion
        #region PKValue 获取主键
        /// <summary>
        /// 获取主键
        /// </summary>
        /// <param name="dbSyn"></param>
        /// <returns></returns>
        public virtual string PKValue(DbSynResult dbSyn)
        {
            var result = string.Empty;
            return result;
        }
        #endregion
        #region ExcuteRowSyn 执行同步
        /// <summary>
        /// 执行同步
        /// </summary>
        /// <param name="dbSyn"></param>
        /// <returns></returns>
        public virtual int ExcuteRowSyn(DbSynResult dbSyn)
        {
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
        public abstract int FinishRowSyn(DbSynResult dbSyn);
        #endregion
        #region FinishSyn 批量执行完成
        /// <summary>
        /// 批量执行完成
        /// </summary>
        /// <param name="dbSyn"></param>
        /// <returns></returns>
        public virtual int FinishSyn(DbSynResult dbSyn)
        {
            var result = 0;
            return result;
        }
        #endregion
    }
}
