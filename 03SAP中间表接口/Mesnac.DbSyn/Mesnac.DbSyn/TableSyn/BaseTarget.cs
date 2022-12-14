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
    /// 目标 命令
    /// </summary>
    public abstract class BaseTarget : BaseData, ISynTargetCommand
    {
        #region 构造函数
        public BaseTarget()
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
            dbInfo.DbName = dbSyn.SynTable.Target.TableInfo.DbSourceName;
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
            dbInfo.DbName = dbSyn.SynTable.Target.TableInfo.DbSourceName;
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
            var keyValues = dbSyn.SynTable.Target.BeginSyn;
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
            string result = string.Empty;
            return result;
        }
        #endregion
        #region ExcuteRowSyn 执行同步
        /// <summary>
        /// 执行同步
        /// </summary>
        /// <param name="dbSyn"></param>
        /// <returns></returns>
        public abstract int ExcuteRowSyn(DbSynResult dbSyn);
        #endregion
        #region FinishRowSyn 单条执行完成
        /// <summary>
        /// 单条执行完成
        /// </summary>
        /// <param name="dbSyn"></param>
        /// <returns></returns>
        public virtual int FinishRowSyn(DbSynResult dbSyn)
        {
            var result = 0;
            return result;
        }
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
