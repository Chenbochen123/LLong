using System.Data;
using System;
using System.Data.Common;


namespace Mesnac.DbSyn
{
    /// <summary>
    /// 数据库操作类
    /// </summary>
    public class DbSqlHelper : IDisposable
    {
        protected LogAgent.ILog log = LogAgent.Log.Instance;
        public DbSqlHelper(DbSqlSession dbSession)
        {
            this.dbSession = dbSession;
        }

        #region 私有变量
        private bool closeByHandle = false;
        private DbSqlSession dbSession = null;
        private IDbTransaction transaction = null;
        #endregion

        #region 属性
        /// <summary>
        /// 数据库连接信息
        /// </summary>
        public DbSqlSession DbSession
        {
            get { return this.dbSession; }
        }
        /// <summary>
        /// 数据操作类型 指定如何解释命令字符串
        /// </summary>
        public CommandType CommandType
        {
            get
            {
                return this.dbSession.Command.CommandType;
            }
            set
            {
                this.dbSession.Command.CommandType = value;
            }
        }
        /// <summary>
        /// 获取或设置针对数据源运行的文本命令。
        /// </summary>
        public string CommandText
        {
            get
            {
                return this.dbSession.Command.CommandText;
            }
            set
            {
                this.dbSession.Command.CommandText = value;
            }
        }
        /// <summary>
        /// 数据库参数前缀
        /// </summary>
        public string ParameterPrefix
        {
            get
            {
                return this.dbSession.ParameterPrefix;
            }
        }
        #endregion

        #region 方法
        /// <summary>
        /// 程序类型转化为数据类型
        /// </summary>
        /// <param name="o"></param>
        /// <returns></returns>
        private DbType ToDbType(object o)
        {
            Type t = o.GetType();
            DbType dbt = DbType.Object;
            try
            {
                dbt = (DbType)Enum.Parse(typeof(DbType), t.Name);
            }
            catch
            {
            }
            return dbt;
        }
        /// <summary>
        /// 清理参数
        /// </summary>
        public void ClearParameter()
        {
            if (this.dbSession.Command != null)
            {
                this.dbSession.Command.Parameters.Clear();
            }
        }
        /// <summary>
        /// 创建参数
        /// </summary>
        /// <param name="key"></param>
        /// <param name="value"></param>
        /// <returns></returns>
        public IDbDataParameter CreateParameter(string key, object value)
        {
            IDbDataParameter Result = this.dbSession.Command.CreateParameter();
            Result.ParameterName = key;
            if (value == null || value == System.DBNull.Value)
            {
                Result.Value = System.DBNull.Value;
            }
            else
            {
                Result.DbType = ToDbType(value);
                Result.Value = value;
            }
            return Result;
        }
        /// <summary>
        /// 添加参数
        /// </summary>
        /// <param name="key"></param>
        /// <param name="value"></param>
        public void AddParameter(string key, object value)
        {
            this.dbSession.Command.Parameters.Add(CreateParameter(key, value));
        }
        /// <summary>
        /// 打开连接
        /// </summary>
        /// <param name="closeByHandle">手工关闭</param>
        public void OpenConnection(bool closeByHandle)
        {
            this.closeByHandle = closeByHandle;
            try
            {
                if (this.dbSession.Connection.State != ConnectionState.Open)
                {
                    this.dbSession.Connection.Open();
                }
            }
            catch (Exception ex)
            {
                log.Error(this.CommandText + "|" + ex.ToString());
                throw ex;
            }
        }
        /// <summary>
        /// 打开连接 自动关闭
        /// closeByHandle = false
        /// </summary>
        public void OpenConnection()
        {
            this.OpenConnection(false);
        }
        /// <summary>
        /// 关闭连接
        /// </summary>
        private void CloseConnection()
        {
            try
            {
                this.ClearParameter();
                this.dbSession.Connection.Close();
                this.dbSession.Connection.Dispose();
                this.dbSession.Command.Dispose();
                this.dbSession.Close();
            }
            catch { }
        }
        /// <summary>
        /// 释放资源
        /// </summary>
        public void Dispose()
        {
            this.CloseConnection();
        }
        /// <summary>
        /// 自动关闭连接
        /// </summary>
        private void AutoCloseConnection()
        {
            ClearParameter();
            if (this.closeByHandle) { return; }
            if (this.transaction != null) { return; }
            if (this.dbSession.Command.Transaction != null) { return; }
            this.CloseConnection();
        }
        /// <summary>
        /// 执行SQL 语句，并返回受影响的行数。
        /// </summary>
        public int ExecuteNonQuery()
        {
            var result = 0;
            try
            {
                this.OpenConnection();
                result = this.dbSession.Command.ExecuteNonQuery();
            }
            catch (Exception ex)
            {
                log.Debug(this.CommandText + "|" + ex.ToString());
                throw ex;
            }
            finally
            {
                this.AutoCloseConnection();
            }
            return result;

        }
        /// <summary>
        /// 根据IDataReader返回DataTable
        /// </summary>
        /// <param name="myTable"></param>
        /// <param name="myReader"></param>
        private void FullDataRow(DataTable myTable, IDataReader myReader)
        {
            DataRow dataRow = myTable.NewRow();
            for (int i = 0; i < myReader.FieldCount; i++)
            {
                dataRow[i] = myReader[i];
            }
            myTable.Rows.Add(dataRow);
        }
        /// <summary>
        /// 执行SQL 语句，并返回DataSet。
        /// </summary>
        /// <returns></returns>
        public object ToDataSet()
        {
            this.OpenConnection();
            DataSet result = new DataSet();
            #region IDataReader to DataSet
            IDataReader myReader = this.ToDbDataReader();
            try
            {
                if (myReader == null)
                {
                    return result;
                }
                if (true) //isFirst
                {
                    DataTable table = new DataTable();
                    for (int i = 0; i < myReader.FieldCount; i++)
                    {
                        DataColumn col = new DataColumn(myReader.GetName(i), myReader.GetFieldType(i));
                        table.Columns.Add(col);
                    }
                    while (myReader.Read())
                    {
                        FullDataRow(table, myReader);
                    }
                    table.TableName = System.Guid.NewGuid().ToString("D");
                    result.Tables.Add(table);
                }
                while (myReader.NextResult())
                {
                    DataTable table = new DataTable();
                    for (int i = 0; i < myReader.FieldCount; i++)
                    {
                        DataColumn col = new DataColumn(myReader.GetName(i), myReader.GetFieldType(i));
                        table.Columns.Add(col);
                    }
                    while (myReader.Read())
                    {
                        FullDataRow(table, myReader);
                    }
                    table.TableName = System.Guid.NewGuid().ToString("D");
                    result.Tables.Add(table);
                }
            }
            finally
            {
                if (myReader != null)
                {
                    myReader.Close();
                    myReader.Dispose();
                }
                this.AutoCloseConnection();
            }
            #endregion
            return result;
        }
        /// <summary>
        /// 执行SQL 语句，并返回DataTable。
        /// </summary>
        /// <returns></returns>
        public DataTable ToDataTable()
        {
            return this.ToDataTable(0);
        }
        /// <summary>
        /// 执行SQL 语句，并返回DataTable。
        /// </summary>
        /// <returns></returns>
        public DataTable ToDataTable(int count)
        {
            return ToDataTable(0, count);
        }

        /// <summary>
        /// 执行SQL 语句，并返回DataTable。
        /// </summary>
        /// <returns></returns>
        public DataTable ToDataTable(int istart, int count)
        {
            this.OpenConnection();
            DataTable result = new DataTable();
            result.TableName = System.Guid.NewGuid().ToString("D");
            #region IDataReader to DataTable
            IDataReader myReader = this.ToDbDataReader();
            try
            {
                if (myReader == null)
                {
                    return result;
                }
                for (int i = 0; i < myReader.FieldCount; i++)
                {
                    DataColumn col = new DataColumn(myReader.GetName(i), myReader.GetFieldType(i));
                    result.Columns.Add(col);
                }
                int totalcount = 0;
                int iRowCount = 0;
                while (myReader.Read())
                {
                    totalcount++;
                    if (totalcount <= istart)
                    {
                        continue;
                    }
                    iRowCount++;
                    if (count > 0 && iRowCount > count)
                    {
                        break;
                    }
                    FullDataRow(result, myReader);
                }
            }
            finally
            {
                if (myReader != null)
                {
                    myReader.Close();
                    myReader.Dispose();
                }
                this.AutoCloseConnection();
            }
            #endregion
            return result;
        }
        /// <summary>
        /// 执行SQL 语句，并返回Object。
        /// </summary>
        /// <returns></returns>
        public object ToScalar()
        {
            try
            {
                this.OpenConnection();
                return this.dbSession.Command.ExecuteScalar();
            }
            finally
            {
                this.AutoCloseConnection();
            }
        }
        /// <summary>
        /// 执行SQL 语句，并返回IDataReader。
        /// </summary>
        /// <returns></returns>
        public IDataReader ToDbDataReader()
        {
            try
            {
                this.OpenConnection();
                return this.dbSession.Command.ExecuteReader();
            }
            catch (Exception ex)
            {
                this.AutoCloseConnection();
                //throw ex;
                return null;
            }
        }
        /// <summary>
        /// 开始事务处理
        /// </summary>
        /// <returns></returns>
        public IDbTransaction BeginTransaction()
        {
            try
            {
                this.OpenConnection();
                if (this.transaction == null)
                {
                    this.transaction = this.dbSession.Connection.BeginTransaction();
                }
                this.dbSession.Command.Transaction = this.transaction;
                return this.transaction;
            }
            finally
            {
                this.AutoCloseConnection();
            }
        }
        /// <summary>
        /// 回滚事务处理
        /// </summary>
        public void RollbackTransaction()
        {
            try
            {
                if (this.transaction != null)
                {
                    this.transaction.Rollback();
                }
            }
            finally
            {
                this.transaction = null;
                this.AutoCloseConnection();
            }
        }
        /// <summary>
        /// 提交事务处理
        /// </summary>
        public void CommitTransaction()
        {
            try
            {
                if (this.transaction != null)
                {
                    this.transaction.Commit();
                }
            }
            finally
            {
                this.transaction = null;
                this.AutoCloseConnection();
            }
        }
        #endregion
    }
}
