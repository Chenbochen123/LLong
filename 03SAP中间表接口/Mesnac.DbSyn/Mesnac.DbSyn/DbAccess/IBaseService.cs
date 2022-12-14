/************************************************************************************
 *      All contents © copyright MESNAC. All rights reserved
 *      File:
 *				IBaseService.cs
 *      Description:
 *				 数据访问基础接口
 *      Author:
 *				孙本强
 *				SunBQ@MESNAC.COM
 *				HTTP://WWWW.MESNAC.COM
 *      Finish DateTime:
 *				2013年11月14日
 *      History:
 ***********************************************************************************/
using System;
using System.Collections.Generic;
using System.Text;
using System.Data;
using Mesnac.DbAccess;
using MyBatis.DataMapper;

namespace Mesnac.DbAccess
{
    public interface IBaseService<T> where T : new()
    {
        #region 基础操作 DbHelper
        /// <summary>
        /// 当前数据访问辅助类
        /// </summary>
        /// <returns></returns>
        DbHelper DbHelper { get; }
        /// <summary>
        /// 获取表操作StatementId
        /// </summary>
        /// <param name="stmtId"></param>
        /// <returns></returns>
        string GetEntityStatementId(string stmtId);
        /// <summary>
        /// 获取表业务操作StatementId
        /// </summary>
        /// <param name="stmtId"></param>
        /// <returns></returns>
        string GetBusinessStatementId(string stmtId);
        #endregion

        #region 单表操作类 命名空间 BasicMapper
        /// <summary>
        /// 获取Sequence.NEXTVAL
        /// </summary>
        /// <param name="stmtId"></param>
        /// <returns></returns>
        int GetSeqNextVal(string seqName);
        /// <summary>
        /// 按照主键查找
        /// </summary>
        /// <param name="ids">主键参数列表</param>
        /// <returns></returns>
        T GetByObjId(int ObjId);
        /// <summary>
        /// 指定条件的查询
        /// </summary>
        /// <param name="top">前几条数据</param>
        /// <param name="entity">查询条件实体</param>
        /// <param name="orderby">排序字段</param>
        /// <returns></returns>
        IList<T> GetEntityList(int top, T entity, string orderby);
        /// <summary>
        /// 指定条件的查询
        /// </summary>
        /// <param name="entity">查询条件实体</param>
        /// <param name="orderby">排序字段</param>
        /// <returns></returns>
        IList<T> GetEntityList(T entity, string orderby);
        /// <summary>
        /// 指定条件的查询
        /// </summary>
        /// <param name="entity">查询条件实体</param>
        /// <returns></returns>
        IList<T> GetEntityList(T entity);
        /// <summary>
        /// 获取某个属性（数据列）的最大值
        /// </summary>
        /// <param name="propertyItem">属性（数据列）</param>
        /// <param name="entity">查询条件</param>
        /// <returns>返回此属性（数据列）对应的最大值</returns>
        object GetMaxValue(string columnName, T entity);
        /// <summary>
        /// 获取数据条数
        /// </summary>
        /// <param name="entity">查询条件</param>
        /// <returns>条数</returns>
        int GetRowCount(T entity);
        /// <summary>
        /// 添加新记录
        /// </summary>
        /// <param name="entity">对应新记录的实体数据</param>
        /// <returns>返回追加记录的主键值</returns>
        int Insert(T entity);
        /// <summary>
        /// 批量添加新纪录
        /// </summary>
        /// <param name="lst">对应的List记录</param>
        /// <returns>返回受影响的记录行数</returns>
        int BatchInsert(List<T> lst);
        /// <summary>
        /// 更新记录
        /// </summary>
        /// <param name="entity">需要更新记录对应的实体数据</param>
        /// <returns>返回更新的记录数</returns>
        int UpdateByObjId(T entity, int id);
        /// <summary>
        /// 更新记录
        /// </summary>
        /// <param name="entity">需要更新记录对应的实体数据</param>
        /// <param name="where">查询条件</param>
        /// <returns>返回更新的记录数</returns>
        int Update(T entity, T where);
        /// <summary>
        /// 删除主键是id值得记录
        /// </summary>
        /// <param name="id">要删除记录的主键值</param>
        /// <returns>返回删除的记录条数</returns>
        int DeleteByObjId(int id);
        /// <summary>
        /// 删除对象对应的记录
        /// </summary>
        /// <param name="entity">与要删除记录对应的对象</param>
        int Delete(T entity);
        /// <summary>
        /// 清除表中所有记录  慎用！！！
        /// </summary>
        void TruncateTable();
        #endregion

        #region 扩展操作类 命名空间 BusinessMapper
        /// <summary>
        /// 通过stmtId添加数据库
        /// </summary>
        /// <param name="stmtId">SQL语句对象Id</param>
        /// <param name="param">SQL语句参数</param>
        /// <returns></returns>
        object InsertByStatement(string stmtId, object param);
        /// <summary>
        /// 通过stmtId更新数据库
        /// </summary>
        /// <param name="stmtId">SQL语句对象Id</param>
        /// <param name="param">SQL语句参数</param>
        /// <returns></returns>
        int UpdateByStatement(string stmtId, object param);
        /// <summary>
        /// 通过stmtId删除数据库
        /// </summary>
        /// <param name="stmtId">SQL语句对象Id</param>
        /// <param name="param">SQL语句参数</param>
        /// <returns></returns>
        int DeleteByStatement(string stmtId, object param);
        /// <summary>
        /// 获取数据实体类型
        /// </summary>
        /// <param name="stmtId">SQL语句对象Id</param>
        /// <param name="param">SQL语句参数</param>
        /// <returns></returns>
        IList<T> GetEntityByStatement(string stmtId, object param);
        /// <summary>
        /// 获取int数据
        /// </summary>
        /// <param name="stmtId">SQL语句对象Id</param>
        /// <param name="param">SQL语句参数</param>
        /// <returns></returns>
        int GetIntByStatement(string stmtId, object param);
        /// <summary>
        /// 获取Object数据
        /// </summary>
        /// <param name="stmtId">SQL语句对象Id</param>
        /// <param name="param">SQL语句参数</param>
        /// <returns></returns>
        object GetObjectByStatement(string stmtId, object param);
        /// <summary>
        /// 获取DataReader
        /// </summary>
        /// <param name="stmtId">SQL语句对象Id</param>
        /// <param name="param">SQL语句参数</param>
        /// <returns></returns>
        IDataReader GetDataReaderByStatement(string stmtId, object param);
        /// <summary>
        /// 获取DataTable数据
        /// </summary>
        /// <param name="stmtId">SQL语句对象Id</param>
        /// <param name="param">SQL语句参数</param>
        /// <returns></returns>
        DataTable GetDataTableByStatement(string stmtId, object param);
        /// <summary>
        /// 获取DataSet数据
        /// </summary>
        /// <param name="stmtId">SQL语句对象Id</param>
        /// <param name="param">SQL语句参数</param>
        /// <returns></returns>
        DataSet GetDataSetByStatement(string stmtId, object param);
        /// <summary>
        /// 调用存储过程的分页查询方法
        /// </summary>
        /// <param name="stmtId">SQL语句对象Id</param>
        /// <param name="pageQuery">用于传递查询条件的分页类的对象</param>
        /// <returns>返回封装了页面数据和总记录数据的分页类对象</returns>
        PageResult GetPageDataByReader(PageResult pageResult);
        #endregion

        #region 数据库事务 Transaction
        /// <summary>
        /// 数据库事务 创建
        /// </summary>
        void BeginTransaction();
        /// <summary>
        /// 数据库事务 提交
        /// </summary>
        void CompleteTransaction();
        /// <summary>
        /// 数据库事务 回滚
        /// </summary>
        void RollbackTransaction();
        #endregion
    }
}
