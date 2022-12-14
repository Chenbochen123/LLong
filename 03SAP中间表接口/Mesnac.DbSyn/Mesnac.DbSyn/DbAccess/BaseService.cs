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
using MyBatis.DataMapper.Session;
using MyBatis.DataMapper.Session.Transaction;
using MyBatis.DataMapper.MappedStatements;
using MyBatis.DataMapper.Scope;
using System.Text;

namespace Mesnac.DbAccess
{
    /// <summary>
    /// 基于泛型数据访问抽象基类，封装了基本数据访问操作CRUD
    /// </summary>
    /// <typeparam name="T"></typeparam>
    public abstract class BaseService<T> : IDisposable, IBaseService<T> where T : new()
    {
        #region 系统日志  log
        private LogAgent.ILog log = LogAgent.Log.Instance;
        #endregion

        #region 私有字段
        protected string tableName = String.Empty;         //对应泛型的表名
        protected string stmtPrefix = String.Empty;        //MyBatis语句标识前缀
        private string entityNamespace = "BasicMapper";    //单表业务处理Mapper文件命名空间
        private string businessNamespace = "BusinessMapper";  //业务处理Mapper文件命名空间

        private string dbName = string.Empty; //数据库配置名称 
        private DbHelper @_dbHelper = null;  //代码中不得使用此变量
        private DbHelper dbHelper
        {
            get
            {
                if (@_dbHelper == null)
                {
                    @_dbHelper = DbHelper.GetInstance(getDbInfo(dbName));
                }
                return @_dbHelper;
            }
        }

        #endregion

        #region 内部函数
        /// <summary>
        /// 获取版本
        /// </summary>
        /// <returns></returns>
        private string getVersion()
        {
            string result = string.Empty;
            try
            {
                if (System.Web.HttpContext.Current.Session["dbVersion"] != null)
                {
                    result = System.Web.HttpContext.Current.Session["dbVersion"].ToString();
                }
            }
            catch { }
            if (string.IsNullOrWhiteSpace(result))
            {
                result = "Default";
            }
            return result;
        }
        /// <summary>
        /// 获取数据库连接文件
        /// </summary>
        /// <param name="dbName"></param>
        /// <returns></returns>
        private DbInfo getDbInfo(string dbName)
        {
            return DbVersion.Instance.GetDbInfo(getVersion(), dbName);
        }
        #endregion

        #region 构造方法
        private void _baseService(string dbName)
        {
            this.stmtPrefix = typeof(T).FullName;
            this.tableName = this.stmtPrefix;
            this.dbName = dbName;
        }
        /// <summary>
        /// 构造函数
        /// </summary>
        /// <param name="dbName">数据库配置名称</param>
        public BaseService(string dbName)
        {
            _baseService(dbName);
        }
        /// <summary>
        /// 构造函数
        /// </summary>
        public BaseService()
        {
            string str = typeof(T).FullName;
            string[] ss = str.Split('.');
            if (ss.Length > 1)
            {
                str = ss[1];
            }
            var dbMapper = DbVersion.Instance.GetDbMapperByPluginName(str);
            str = dbMapper.DbName;
            _baseService(str);
        }

        #endregion

        #region 构析函数
        public void Dispose()
        {
            transactionDispose();
        }
        ~BaseService()
        {
            Dispose();
        }
        #endregion

        #region 基础函数
        private object getHashtableFirstObject(object obj)
        {
            var result = obj;
            if (result is System.Collections.Hashtable)
            {
                var ht = result as System.Collections.Hashtable;
                foreach (var k in ht.Keys)
                {
                    return ht[k];
                }
            }
            return result;
        }
        #endregion

        #region IBaseService<T> 成员
        #region 基础操作 DbHelper
        /// <summary>
        /// 当前数据访问辅助类
        /// </summary>
        public DbHelper DbHelper
        {
            get
            {
                return this.dbHelper;
            }
        }
        /// <summary>
        /// 获取表操作StatementId
        /// </summary>
        /// <param name="stmtId"></param>
        /// <returns></returns>
        public string GetEntityStatementId(string stmtId)
        {
            string ss = this.stmtPrefix;
            ss = ss.Replace(".Entity.", ".Mapper.");
            ss = ss.Replace(".BasicEntity.", "." + entityNamespace + ".");
            ss = ss + "." + stmtId;
            return ss.Trim();
        }
        /// <summary>
        /// 获取表业务操作StatementId
        /// </summary>
        /// <param name="stmtId"></param>
        /// <returns></returns>
        public string GetBusinessStatementId(string stmtId)
        {
            string ss = this.stmtPrefix;
            ss = ss.Replace(".Entity.", ".Mapper.");
            ss = ss.Replace(".BasicEntity.", "." + businessNamespace + ".");
            ss = ss + "." + stmtId;
            return ss.Trim();
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
            try
            {
                string stmtId = GetEntityStatementId("GetSeqNextVal");
                GetRuntimeSql(stmtId, null);
                var result = dbHelper.DataMapper.QueryForObject<int>(stmtId, seqName);
                return result;
            }
            finally
            {
                this.Close();
            }
        }
        /// <summary>
        /// 按照主键查找
        /// </summary>
        /// <param name="ids">主键参数列表</param>
        /// <returns></returns>
        public T GetByObjId(int ObjId)
        {
            try
            {
                string stmtId = GetEntityStatementId("GetByObjId");
                GetRuntimeSql(stmtId, null);
                T entity = dbHelper.DataMapper.QueryForObject<T>(stmtId, ObjId);
                return entity;
            }
            finally
            {
                this.Close();
            }
        }
        /// <summary>
        /// 指定条件的查询
        /// </summary>
        /// <param name="top">前几条数据,oracle不支持</param>
        /// <param name="entity">查询条件实体</param>
        /// <param name="orderby">排序字段</param>
        /// <returns></returns>
        public IList<T> GetEntityList(int top, T entity, string orderby)
        {
            try
            {
                string stmtId = GetEntityStatementId("GetEntityList");
                Hashtable param = new Hashtable(3);
                param["where"] = entity;
                if (top > 0)
                {
                    param["TopCount"] = top;
                }
                if (!string.IsNullOrWhiteSpace(orderby))
                {
                    param["OrderString"] = orderby;
                }
                GetRuntimeSql(stmtId, param);
                IList<T> resultList = dbHelper.DataMapper.QueryForList<T>(stmtId, param);
                return resultList;
            }
            finally
            {
                this.Close();
            }
        }
        /// <summary>
        /// 指定条件的查询
        /// </summary>
        /// <param name="entity">查询条件实体</param>
        /// <param name="orderby">排序字段</param>
        /// <returns></returns>
        public IList<T> GetEntityList(T entity, string orderby)
        {
            try
            {
                string stmtId = GetEntityStatementId("GetEntityList");
                Hashtable param = new Hashtable(3);
                param["where"] = entity;
                if (!string.IsNullOrWhiteSpace(orderby))
                {
                    param["OrderString"] = orderby;
                }
                GetRuntimeSql(stmtId, param);
                IList<T> resultList = dbHelper.DataMapper.QueryForList<T>(stmtId, param);
                return resultList;
            }
            finally
            {
                this.Close();
            }
        }
        /// <summary>
        /// 指定条件的查询
        /// </summary>
        /// <param name="entity">查询条件实体</param>
        /// <returns></returns>
        public IList<T> GetEntityList(T entity)
        {
            return this.GetEntityList(0, entity, string.Empty);
        }
        /// <summary>
        /// 获取某个属性（数据列）的最大值
        /// </summary>
        /// <param name="propertyItem">属性（数据列）</param>
        /// <param name="entity">查询条件</param>
        /// <returns>返回此属性（数据列）对应的最大值</returns>
        public object GetMaxValue(string columnName, T entity)
        {
            try
            {
                string stmtId = GetEntityStatementId("GetColumnMaxValue");
                Hashtable param = new Hashtable(2);
                param["where"] = entity;
                if (!string.IsNullOrWhiteSpace(columnName))
                {
                    param["ColumnName"] = columnName;
                }
                GetRuntimeSql(stmtId, param);
                object result = dbHelper.DataMapper.QueryForObject(stmtId, param);
                if (result != null)
                {
                    result = getHashtableFirstObject(result);
                }
                if (result == null || result == DBNull.Value)
                {
                    return 0;
                }
                if (result != null && result != DBNull.Value)
                {
                    int iMax = 0;
                    if (int.TryParse(result.ToString(), out iMax))
                    {
                        return iMax;
                    }

                }
                return result;
            }
            finally
            {
                this.Close();
            }
        }
        /// <summary>
        /// 获取数据条数
        /// </summary>
        /// <param name="entity">查询条件</param>
        /// <returns>条数</returns>
        public int GetRowCount(T entity)
        {
            try
            {
                string stmtId = GetEntityStatementId("GetRowCount");
                Hashtable param = new Hashtable(1);
                param["where"] = entity;
                GetRuntimeSql(stmtId, param);
                int result = dbHelper.DataMapper.QueryForObject<int>(stmtId, param);
                return result;
            }
            finally
            {
                this.Close();
            }
        }
        /// <summary>
        /// 添加新记录
        /// </summary>
        /// <param name="entity">对应新记录的实体数据</param>
        /// <returns>返回追加记录的主键值</returns>
        public int Insert(T entity)
        {
            try
            {
                string stmtId = GetEntityStatementId("Insert");
                GetRuntimeSql(stmtId, entity);
                object result = dbHelper.DataMapper.Insert(stmtId, entity);
                return result == null ? 1 : Convert.ToInt32(result);
            }
            finally
            {
                this.Close();
            }
        }
        /// <summary>
        /// 批量添加新纪录
        /// </summary>
        /// <param name="lst">对应的List记录</param>
        /// <returns>返回受影响的记录行数</returns>
        public int BatchInsert(List<T> lst)
        {
            try
            {
                string stmtId = GetEntityStatementId("Insert");
                using (ISession session = dbHelper.SessionFactory.OpenSession())
                {
                    using (ITransaction transaction = session.BeginTransaction())
                    {
                        foreach (T entity in lst)
                        {
                            GetRuntimeSql(stmtId, entity);
                            object result = dbHelper.DataMapper.Insert(stmtId, entity);
                        }
                        transaction.Complete();
                    }
                    return Convert.ToInt32(lst.Count);
                }
            }
            finally
            {
                this.Close();
            }
        }
        /// <summary>
        /// 更新记录
        /// </summary>
        /// <param name="entity">需要更新记录对应的实体数据</param>
        /// <returns>返回更新的记录数</returns>
        public int UpdateByObjId(T entity, int id)
        {
            try
            {
                string stmtId = GetEntityStatementId("UpdateByObjId");
                Hashtable param = new Hashtable(2);
                param["ObjId"] = id;
                param["update"] = entity;
                GetRuntimeSql(stmtId, param);
                object result = dbHelper.DataMapper.Update(stmtId, param);
                return Convert.ToInt32(result);
            }
            finally
            {
                this.Close();
            }
        }
        /// <summary>
        /// 更新记录
        /// </summary>
        /// <param name="entity">需要更新记录对应的实体数据</param>
        /// <returns>返回更新的记录数</returns>
        public int Update(T entity, T where)
        {
            try
            {
                string stmtId = GetEntityStatementId("Update");
                Hashtable param = new Hashtable(2);
                param["update"] = entity;
                param["where"] = where;
                GetRuntimeSql(stmtId, param);
                object result = dbHelper.DataMapper.Update(stmtId, param);
                return Convert.ToInt32(result);
            }
            finally
            {
                this.Close();
            }
        }
        /// <summary>
        /// 删除主键是id值得记录
        /// </summary>
        /// <param name="id">要删除记录的主键值</param>
        /// <returns>返回删除的记录条数</returns>
        public int DeleteByObjId(int id)
        {
            try
            {
                string stmtId = GetEntityStatementId("DeleteByObjId");
                GetRuntimeSql(stmtId, id);
                int result = dbHelper.DataMapper.Delete(stmtId, id);
                return result;
            }
            finally
            {
                this.Close();
            }
        }
        /// <summary>
        /// 删除对象对应的记录
        /// </summary>
        /// <param name="entity">与要删除记录对应的对象</param>
        public int Delete(T entity)
        {
            try
            {
                string stmtId = GetEntityStatementId("Delete");
                Hashtable param = new Hashtable(1);
                param["where"] = entity;
                GetRuntimeSql(stmtId, param);
                int result = dbHelper.DataMapper.Delete(stmtId, param);
                return result;
            }
            finally
            {
                this.Close();
            }
        }
        /// <summary>
        /// 清除表中所有记录  慎用！！！
        /// </summary>
        public void TruncateTable()
        {
            try
            {
                string stmtId = GetEntityStatementId("TruncateTable");
                GetRuntimeSql(stmtId, null);
                dbHelper.DataMapper.QueryForObject(stmtId, null);
            }
            finally
            {
                this.Close();
            }
        }
        #endregion

        #region 数据库事务
        #region Transaction
        /// <summary>
        /// 资源回收
        /// </summary>
        private void transactionDispose()
        {
            try
            {
                #region 获取 session
                ISession session = dbHelper.CurrentSession;
                if (session == null)
                {
                    return;
                }
                #endregion
                #region 获取 transaction
                ITransaction transaction = session.Transaction;
                if (transaction == null)
                {
                    return;
                }
                #endregion
                #region  transaction.Dispose
                try
                {
                    transaction.Rollback();
                    transaction.Dispose();
                }
                catch
                {
                }
                transaction = null;
                #endregion
                #region Close
                this.Close();
                #endregion

            }
            catch { }
        }
        #endregion
        /// <summary>
        /// 数据库事务 创建
        /// </summary>
        public void BeginTransaction()
        {
            #region 获取 session
            ISession session = dbHelper.CurrentSession;
            if (session == null)
            {
                session = dbHelper.SessionFactory.OpenSession();
            }
            #endregion
            #region 获取 transaction
            ITransaction transaction = session.Transaction;
            if (transaction == null)
            {
                transaction = session.BeginTransaction();
            }
            #endregion
        }
        /// <summary>
        /// 数据库事务 提交
        /// </summary>
        public void CompleteTransaction()
        {
            #region 获取 session
            ISession session = dbHelper.CurrentSession;
            if (session == null)
            {
                return;
            }
            #endregion
            #region 获取 transaction
            ITransaction transaction = session.Transaction;
            if (transaction == null)
            {
                return;
            }
            #endregion
            #region Complete
            try
            {
                transaction.Complete();
                transaction.Commit();
            }
            finally
            {
                transactionDispose();
            }
            #endregion
        }
        /// <summary>
        /// 数据库事务 回滚
        /// </summary>
        public void RollbackTransaction()
        {
            #region 获取 session
            ISession session = dbHelper.CurrentSession;
            if (session == null)
            {
                return;
            }
            #endregion
            #region 获取 transaction
            ITransaction transaction = session.Transaction;
            if (transaction == null)
            {
                return;
            }
            #endregion
            #region Rollback
            try
            {
                transaction.Rollback();
            }
            finally
            {
                transactionDispose();
            }
            #endregion
        }
        #endregion

        #region 数据库关闭
        public void Close()
        {
            try
            {
                #region 获取 ISession
                ISession session = dbHelper.CurrentSession;
                if (session == null)
                {
                    return;
                }
                #endregion
                #region 获取 ITransaction
                ITransaction transaction = session.Transaction;
                if ((transaction != null)
                    && (transaction.IsStarted)
                    && (!transaction.WasCommit)
                    && (!transaction.WasRollback)
                    )
                {
                    return;
                }
                #endregion
                #region  session.Close()
                try
                {
                    session.Close();
                }
                catch
                {
                }
                #endregion
                #region  session.Dispose
                try
                {
                    session.Dispose();
                }
                catch
                {
                }
                session = null;
                #endregion
            }
            catch { }
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
            try
            {
                stmtId = GetBusinessStatementId(stmtId);
                GetRuntimeSql(stmtId, param);
                return dbHelper.DataMapper.Insert(stmtId, param);
            }
            finally
            {
                this.Close();
            }
        }
        /// <summary>
        /// 通过stmtId更新数据库
        /// </summary>
        /// <param name="stmtId">SQL语句对象Id</param>
        /// <param name="param">SQL语句参数</param>
        /// <returns></returns>
        public int UpdateByStatement(string stmtId, object param)
        {
            try
            {
                stmtId = GetBusinessStatementId(stmtId);
                GetRuntimeSql(stmtId, param);
                int result = dbHelper.DataMapper.Update(stmtId, param);
                return result;
            }
            finally
            {
                this.Close();
            }
        }
        /// <summary>
        /// 通过stmtId删除数据库
        /// </summary>
        /// <param name="stmtId">SQL语句对象Id</param>
        /// <param name="param">SQL语句参数</param>
        /// <returns></returns>
        public int DeleteByStatement(string stmtId, object param)
        {
            try
            {
                stmtId = GetBusinessStatementId(stmtId);
                GetRuntimeSql(stmtId, param);
                int result = dbHelper.DataMapper.Delete(stmtId, param);
                return result;
            }
            finally
            {
                this.Close();
            }
        }
        /// <summary>
        /// 获取数据实体类型
        /// </summary>
        /// <param name="stmtId">SQL语句对象Id</param>
        /// <param name="param">SQL语句参数</param>
        /// <returns></returns>
        public IList<T> GetEntityByStatement(string stmtId, object param)
        {
            try
            {
                stmtId = GetBusinessStatementId(stmtId);
                GetRuntimeSql(stmtId, param);
                IList<T> resultList = dbHelper.DataMapper.QueryForList<T>(stmtId, param);
                return resultList;
            }
            finally
            {
                this.Close();
            }
        }
        /// <summary>
        /// 获取int数据
        /// </summary>
        /// <param name="stmtId">SQL语句对象Id</param>
        /// <param name="param">SQL语句参数</param>
        /// <returns></returns>
        public int GetIntByStatement(string stmtId, object param)
        {
            try
            {
                stmtId = GetBusinessStatementId(stmtId);
                GetRuntimeSql(stmtId, param);
                int result = dbHelper.DataMapper.QueryForObject<int>(stmtId, param);
                return result;
            }
            finally
            {
                this.Close();
            }
        }
        /// <summary>
        /// 获取Object数据
        /// </summary>
        /// <param name="stmtId">SQL语句对象Id</param>
        /// <param name="param">SQL语句参数</param>
        /// <returns></returns>
        public object GetObjectByStatement(string stmtId, object param)
        {
            try
            {
                stmtId = GetBusinessStatementId(stmtId);
                GetRuntimeSql(stmtId, param);
                object result = dbHelper.DataMapper.QueryForObject(stmtId, param);
                return result;
            }
            finally
            {
                this.Close();
            }
        }
        /// <summary>
        /// 获取DataReader
        /// </summary>
        /// <param name="stmtId">SQL语句对象Id</param>
        /// <param name="param">SQL语句参数</param>
        /// <returns></returns>
        public IDataReader GetDataReaderByStatement(string stmtId, object param)
        {
            stmtId = GetBusinessStatementId(stmtId);
            GetRuntimeSql(stmtId, param);
            IDataReader result = dbHelper.DataMapper.QueryForDataReader(stmtId, param);
            return result;
        }
        /// <summary>
        /// 获取DataTable数据
        /// </summary>
        /// <param name="stmtId">SQL语句对象Id</param>
        /// <param name="param">SQL语句参数</param>
        /// <returns></returns>
        public DataTable GetDataTableByStatement(string stmtId, object param)
        {
            try
            {
                stmtId = GetBusinessStatementId(stmtId);
                GetRuntimeSql(stmtId, param);
                DataTable result = dbHelper.DataMapper.QueryForDataTable(stmtId, param);
                return result;
            }
            finally
            {
                this.Close();
            }
        }
        /// <summary>
        /// 获取DataSet数据
        /// </summary>
        /// <param name="stmtId">SQL语句对象Id</param>
        /// <param name="param">SQL语句参数</param>
        /// <returns></returns>
        public DataSet GetDataSetByStatement(string stmtId, object param)
        {
            try
            {
                stmtId = GetBusinessStatementId(stmtId);
                GetRuntimeSql(stmtId, param);
                DataSet result = dbHelper.DataMapper.QueryForDataSet(stmtId, param);
                return result;
            }
            finally
            {
                this.Close();
            }
        }
        private string[] getTotalFields(string fields)
        {
            if (string.IsNullOrWhiteSpace(fields))
            {
                return new string[0];
            }
            string[] ss = fields.Split(',');
            List<string> result = new List<string>();
            foreach (string str in ss)
            {
                if (!string.IsNullOrWhiteSpace(str))
                {
                    result.Add(str);
                }
            }
            return result.ToArray();
        }
        /// <summary>
        /// 获取行中数据
        /// </summary>
        /// <param name="dc"></param>
        /// <param name="row"></param>
        /// <returns></returns>
        private int getRowIntValue(DataColumn dc, DataRow row)
        {
            if (row[dc] != null
                    && row[dc] != DBNull.Value)
            {
                string str = row[dc].ToString();
                int result = 0;
                if (int.TryParse(str, out result))
                {
                    return result;
                }
            }
            return 0;
        }
        /// <summary>
        /// 合计行中数据
        /// </summary>
        /// <param name="totalColumn"></param>
        /// <param name="row"></param>
        /// <param name="totalRow"></param>
        private void totalDataRow(DataColumn totalColumn, DataRow row, ref DataRow totalRow)
        {
            if (totalColumn.DataType == typeof(int))
            {
                int total = getRowIntValue(totalColumn, row)
                    + getRowIntValue(totalColumn, totalRow);
                totalRow[totalColumn] = total;
            }
        }
        /// <summary>
        /// 合计数据
        /// </summary>
        /// <param name="totalFields"></param>
        /// <param name="row"></param>
        /// <param name="totalRow"></param>
        private void totalDataRow(string[] totalFields, DataRow row, ref DataRow totalRow)
        {
            totalRow[0] = "合计/Total";
            foreach (DataColumn dc in row.Table.Columns)
            {
                foreach (string totalField in totalFields)
                {
                    if (dc.ColumnName.Equals(totalField, StringComparison.CurrentCultureIgnoreCase))
                    {
                        totalDataRow(dc, row, ref totalRow);
                    }
                }
            }
        }
        /// <summary>
        /// 判断当前条是否需要加入到返回结果中
        /// </summary>
        /// <param name="setPageSize"></param>
        /// <param name="totalCount"></param>
        /// <param name="thisPageIndex"></param>
        /// <param name="thisPageSize"></param>
        /// <returns></returns>
        private bool isAddRowForPageData(int setPageSize, int totalCount, int thisPageIndex, int thisPageSize)
        {
            if (setPageSize <= 0)
            {
                return true;
            }
            if (thisPageIndex < 1)
            {
                thisPageIndex = 1;
            }
            int begin = setPageSize * (thisPageIndex - 1) + 1;
            if (totalCount >= begin && thisPageSize < setPageSize)
            {
                return true;
            }
            return false;
        }
        /// <summary>
        /// 调用存储过程的分页查询方法
        /// </summary>
        /// <param name="stmtId">SQL语句对象Id</param>
        /// <param name="pageQuery">用于传递查询条件的分页类的对象</param>
        /// <returns>返回封装了页面数据和总记录数据的分页类对象</returns>
        public PageResult GetPageDataByReader(PageResult pageResult)
        {
            try
            {
                #region StatementId  param
                string stmtId = pageResult.StatementId;
                if (string.IsNullOrWhiteSpace(stmtId))
                {
                    stmtId = "GetPageDataByReader";
                }
                Hashtable param = new Hashtable(2);
                param["where"] = pageResult.ParameterObject;
                if (!string.IsNullOrWhiteSpace(pageResult.OrderString))
                {
                    param["OrderString"] = pageResult.OrderString;
                }
                #endregion
                using (IDataReader reader = this.GetDataReaderByStatement(stmtId, param))
                {
                    int begin = pageResult.PageSize * (pageResult.PageIndex - 1) + 1;
                    int count = 0;
                    int pageSize = 0;
                    string[] totalFields = getTotalFields(pageResult.TotalFields);
                    DataTable table = new DataTable();
                    for (int i = 0; i < reader.FieldCount; i++)
                    {
                        DataColumn col = new DataColumn(reader.GetName(i), reader.GetFieldType(i));
                        table.Columns.Add(col);
                    }
                    DataRow totalRow = table.NewRow();
                    while (reader.Read())
                    {
                        if (totalFields.Length > 0)
                        {
                            DataRow row = table.NewRow();
                            for (int i = 0; i < reader.FieldCount; i++)
                            {
                                row[i] = reader[i];
                            }
                            totalDataRow(totalFields, row, ref totalRow);
                        }
                        count++;
                        if (isAddRowForPageData(pageResult.PageSize, count, pageResult.PageIndex, pageSize))
                        {
                            DataRow row = table.NewRow();
                            for (int i = 0; i < reader.FieldCount; i++)
                            {
                                row[i] = reader[i];
                            }
                            table.Rows.Add(row);
                            pageSize++;
                        }
                    }
                    if (totalFields.Length > 0 && table.Rows.Count > 0)
                    {
                        table.Rows.InsertAt(totalRow, 0);
                    }
                    reader.Close();
                    DataSet ds = new DataSet();
                    ds.Tables.Add(table);
                    pageResult.ResultDataSet = ds;
                    pageResult.RecordCount = count;
                }
                return pageResult;
            }
            finally
            {
                this.Close();
            }
        }
        #endregion
        #endregion

        #region 辅助方法

        /// <summary>
        /// 得到运行时ibatis.net动态生成的SQL
        /// </summary>
        /// <param name="sqlMapper"></param>
        /// <param name="statementName"></param>
        /// <param name="paramObject"></param>
        /// <returns></returns>
        public virtual void GetRuntimeSql(string statementName, object paramObject)
        {
            StringBuilder paraLog = new StringBuilder();
            try
            {
                IMappedStatement statement = dbHelper.Engine.ModelStore.GetMappedStatement(statementName);
                if (null == dbHelper.Engine.ModelStore.SessionStore.CurrentSession)
                {
                    dbHelper.Engine.ModelStore.SessionFactory.OpenSession();
                }
                RequestScope scope = statement.Statement.Sql.GetRequestScope(statement, paramObject, dbHelper.Engine.ModelStore.SessionStore.CurrentSession);
                paraLog.AppendLine(statementName);
                paraLog.AppendLine(scope.PreparedStatement.PreparedSql).AppendLine("参数：");
                int count = scope.PreparedStatement.DbParameters.Length;
                for (int i = 0; i < count; ++i)
                {
                    IDbDataParameter para = scope.PreparedStatement.DbParameters[i];
                    if (para.Direction != ParameterDirection.Output)
                    {
                        scope.ParameterMap.SetParameter(scope.ParameterMap.GetProperty(i), para, paramObject);
                        paraLog.Append(para.ParameterName).Append("=").Append(para.Value).AppendLine(string.Empty);
                    }
                }
            }
            catch (Exception ex)
            {
                paraLog.Append("获取SQL语句出现异常:" + ex.Message);
            }
            log.Debug(paraLog.ToString());
        }

        #endregion

    }
}
