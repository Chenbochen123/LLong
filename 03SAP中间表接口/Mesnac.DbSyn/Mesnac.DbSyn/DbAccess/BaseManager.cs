/************************************************************************************
 *      All contents © copyright MESNAC. All rights reserved
 *      File:
 *				BaseService.cs
 *      Description:
 *				 基于泛型数据访问抽象基类
 *      Author:
 *				孙本强
 *				SunBQ@MESNAC.COM
 *				HTTP://WWWW.MESNAC.COM
 *      Finish DateTime:
 *				2013年11月14日
 *      History:
 *      
 ***********************************************************************************/
using System;
using System.Collections;
using System.Collections.Generic;
using System.Data;
using MyBatis.DataMapper.MappedStatements;
using MyBatis.DataMapper.Scope;
using MyBatis.DataMapper.Session;
using MyBatis.DataMapper.Session.Transaction;

namespace Mesnac.DbAccess
{
    /// <summary>
    /// 基于泛型数据访问抽象基类，封装了基本数据访问操作CRUD
    /// </summary>
    /// <typeparam name="T"></typeparam>
    public abstract class BaseManager<T> : IBaseManager<T> where T : new()
    {

        private IBaseService<T> baseService;

        public IBaseService<T> BaseService
        {
            set { baseService = value; }
        }

        #region 封装数据访问层的常规数据访问方法

        #region 基础操作 DbHelper
        /// <summary>
        /// 当前数据访问辅助类
        /// </summary>
        /// <returns></returns>
        public DbHelper DbHelper { get { return this.baseService.DbHelper; } }
        /// <summary>
        /// 获取表操作StatementId
        /// </summary>
        /// <param name="stmtId"></param>
        /// <returns></returns>
        public string GetEntityStatementId(string stmtId)
        {
            return this.baseService.GetEntityStatementId(stmtId);
        }
        /// <summary>
        /// 获取表业务操作StatementId
        /// </summary>
        /// <param name="stmtId"></param>
        /// <returns></returns>
        public string GetBusinessStatementId(string stmtId)
        {
            return this.baseService.GetBusinessStatementId(stmtId);
        }
        #endregion

        #region 单表操作类 命名空间 BasicMapper
        /// <summary>
        /// 获取Sequence.NEXTVAL
        /// </summary>
        /// <param name="stmtId"></param>
        /// <returns></returns>
        public int GetSeqNextVal(string seqName)
        {
            return this.baseService.GetSeqNextVal(seqName);
        }
        /// <summary>
        /// 按照主键查找
        /// </summary>
        /// <param name="ids">主键参数列表</param>
        /// <returns></returns>
        public T GetByObjId(int ObjId)
        {
            return this.baseService.GetByObjId(ObjId);
        }
        /// <summary>
        /// 指定条件的查询
        /// </summary>
        /// <param name="entity">查询条件实体</param>
        /// <returns></returns>
        public IList<T> GetEntityList(T entity)
        {
            return this.baseService.GetEntityList(entity);
        }
        /// <summary>
        /// 指定条件的查询
        /// </summary>
        /// <param name="top">前几条数据</param>
        /// <param name="entity">查询条件实体</param>
        /// <param name="orderby">排序字段</param>
        /// <returns></returns>
        public IList<T> GetEntityList(int top, T entity, string orderby)
        {
            return this.baseService.GetEntityList(top, entity, orderby);
        }
        /// <summary>
        /// 指定条件的查询
        /// </summary>
        /// <param name="entity">查询条件实体</param>
        /// <param name="orderby">排序字段</param>
        /// <returns></returns>
        public IList<T> GetEntityList(T entity, string orderby)
        {
            return this.baseService.GetEntityList(entity, orderby);
        }
        /// <summary>
        /// 获取某个属性（数据列）的最大值
        /// </summary>
        /// <param name="propertyItem">属性（数据列）</param>
        /// <param name="entity">查询条件</param>
        /// <returns>返回此属性（数据列）对应的最大值</returns>
        public object GetMaxValue(string columnName, T entity)
        {
            return this.baseService.GetMaxValue(columnName, entity);
        }
        /// <summary>
        /// 获取数据条数
        /// </summary>
        /// <param name="entity">查询条件</param>
        /// <returns>条数</returns>
        public int GetRowCount(T entity)
        {
            return this.baseService.GetRowCount(entity);
        }
        /// <summary>
        /// 添加新记录
        /// </summary>
        /// <param name="entity">对应新记录的实体数据</param>
        /// <returns>返回追加记录的主键值</returns>
        public int Insert(T entity)
        {
            return this.baseService.Insert(entity);
        }
        /// <summary>
        /// 批量添加新纪录
        /// </summary>
        /// <param name="lst">对应的List记录</param>
        /// <returns>返回受影响的记录行数</returns>
        public int BatchInsert(List<T> lst)
        {
            return this.baseService.BatchInsert(lst);
        }
        /// <summary>
        /// 更新记录
        /// </summary>
        /// <param name="entity">需要更新记录对应的实体数据</param>
        /// <returns>返回更新的记录数</returns>
        public int UpdateByObjId(T entity, int id)
        {
            return this.baseService.UpdateByObjId(entity, id);
        }
        /// <summary>
        /// 更新记录
        /// </summary>
        /// <param name="entity">需要更新记录对应的实体数据</param>
        /// <param name="where">查询条件</param>
        /// <returns>返回更新的记录数</returns>
        public int Update(T entity, T where)
        {
            return this.baseService.Update(entity, where);
        }
        /// <summary>
        /// 删除主键是id值得记录
        /// </summary>
        /// <param name="id">要删除记录的主键值</param>
        /// <returns>返回删除的记录条数</returns>
        public int DeleteByObjId(int id)
        {
            return this.baseService.DeleteByObjId(id);
        }
        /// <summary>
        /// 删除对象对应的记录
        /// </summary>
        /// <param name="entity">与要删除记录对应的对象</param>
        public int Delete(T entity)
        {
            return this.baseService.Delete(entity);
        }
        /// <summary>
        /// 清除表中所有记录  慎用！！！
        /// </summary>
        public void TruncateTable()
        {
            this.baseService.TruncateTable();
        }
        #endregion

        #region 扩展操作类 命名空间 BusinessMapper
        /// <summary>
        /// 通过stmtId添加数据库
        /// </summary>
        /// <param name="stmtId">SQL语句对象Id</param>
        /// <param name="param">SQL语句参数</param>
        /// <returns></returns>
        public object InsertByStatement(string stmtId, object param)
        {
            return this.baseService.InsertByStatement(stmtId, param);
        }
        /// <summary>
        /// 通过stmtId更新数据库
        /// </summary>
        /// <param name="stmtId">SQL语句对象Id</param>
        /// <param name="param">SQL语句参数</param>
        /// <returns></returns>
        public int UpdateByStatement(string stmtId, object param)
        {
            return this.baseService.UpdateByStatement(stmtId, param);
        }
        /// <summary>
        /// 通过stmtId删除数据库
        /// </summary>
        /// <param name="stmtId">SQL语句对象Id</param>
        /// <param name="param">SQL语句参数</param>
        /// <returns></returns>
        public int DeleteByStatement(string stmtId, object param)
        {
            return this.baseService.DeleteByStatement(stmtId, param);
        }
        /// <summary>
        /// 获取数据实体类型
        /// </summary>
        /// <param name="stmtId">SQL语句对象Id</param>
        /// <param name="param">SQL语句参数</param>
        /// <returns></returns>
        public IList<T> GetEntityByStatement(string stmtId, object param)
        {
            return this.baseService.GetEntityByStatement(stmtId, param);
        }
        /// <summary>
        /// 获取int数据
        /// </summary>
        /// <param name="stmtId">SQL语句对象Id</param>
        /// <param name="param">SQL语句参数</param>
        /// <returns></returns>
        public int GetIntByStatement(string stmtId, object param)
        {
            return this.baseService.GetIntByStatement(stmtId, param);
        }
        /// <summary>
        /// 获取Object数据
        /// </summary>
        /// <param name="stmtId">SQL语句对象Id</param>
        /// <param name="param">SQL语句参数</param>
        /// <returns></returns>
        public object GetObjectByStatement(string stmtId, object param)
        {
            return this.baseService.GetObjectByStatement(stmtId, param);
        }
        /// <summary>
        /// 获取DataReader
        /// </summary>
        /// <param name="stmtId">SQL语句对象Id</param>
        /// <param name="param">SQL语句参数</param>
        /// <returns></returns>
        public IDataReader GetDataReaderByStatement(string stmtId, object param)
        {
            return this.baseService.GetDataReaderByStatement(stmtId, param);
        }
        /// <summary>
        /// 获取DataTable数据
        /// </summary>
        /// <param name="stmtId">SQL语句对象Id</param>
        /// <param name="param">SQL语句参数</param>
        /// <returns></returns>
        public DataTable GetDataTableByStatement(string stmtId, object param)
        {
            return this.baseService.GetDataTableByStatement(stmtId, param);
        }
        /// <summary>
        /// 获取DataSet数据
        /// </summary>
        /// <param name="stmtId">SQL语句对象Id</param>
        /// <param name="param">SQL语句参数</param>
        /// <returns></returns>
        public DataSet GetDataSetByStatement(string stmtId, object param)
        {
            return this.baseService.GetDataSetByStatement(stmtId, param);
        }
        /// <summary>
        /// 调用存储过程的分页查询方法
        /// </summary>
        /// <param name="stmtId">SQL语句对象Id</param>
        /// <param name="pageQuery">用于传递查询条件的分页类的对象</param>
        /// <returns>返回封装了页面数据和总记录数据的分页类对象</returns>
        public PageResult GetPageDataByReader(PageResult pageResult)
        {
            return this.baseService.GetPageDataByReader(pageResult);
        }
        #endregion

        #region 数据库事务 Transaction
        /// <summary>
        /// 数据库事务 创建
        /// </summary>
        public void BeginTransaction()
        {
            this.baseService.BeginTransaction();
        }
        /// <summary>
        /// 数据库事务 提交
        /// </summary>
        public void CompleteTransaction()
        {
            this.baseService.CompleteTransaction();
        }
        /// <summary>
        /// 数据库事务 回滚
        /// </summary>
        public void RollbackTransaction()
        {
            this.baseService.RollbackTransaction();
        }
        #endregion

        #endregion
    }
}
