//ͨ�����ݿ���ʰ�����DbHelper.cs
// �� ��: DbHelper.cs
// �� ��: 
// ʱ ��: 
// ժ Ҫ: .NETͨ�����ݿ����������,��֧��Odbc��OleDb��OracleClient��SqlClient��SqlServerCe�ȶ������ݿ��ṩ�������

using System;
using System.Collections.Generic;
using System.Data;
using System.Configuration;
using System.Data.Common;
using System.Text;

namespace Mesnac.Data
{
    /// <summary>
    /// ˵ ��: .NETͨ�����ݿ����������,��֧��Odbc��OleDb��OracleClient��SqlClient��SqlServerCe�ȶ������ݿ��ṩ�������
    /// �� ��: 
    /// ʱ ��:  
    /// </summary>
    /// <remarks>
    /// �� ��: 
    /// ʱ ��:  
    /// </remarks>
    public sealed class DbHelper
    {
        #region �ֶ�����

        #region ��̬�����ֶ�
        /// <summary>
        /// ��ȡ��ǰ���ݿ����õ��ṩ��������ֵDbProviderName
        /// </summary>
        public static readonly string DbProviderName = System.Configuration.ConfigurationManager.AppSettings["DbProviderName"];

        /// <summary>
        /// ��ȡ��ǰ���ݿ����õ������ַ���ֵDbConnectionString
        /// </summary>
        public static readonly string DbConnectionString = System.Configuration.ConfigurationManager.AppSettings["DbConnectionString"];
        #endregion

        #region ˽���ֶ�
        /// <summary>
        /// ��ǰĬ�����õ����ݿ��ṩ����DbProviderFactory
        /// </summary>
        private DbProviderFactory _dbFactory = null;

        /// <summary>
        /// ��ǰ���ݿ�����DbConnection����
        /// </summary>
        private DbConnection _dbConnection = null;

        /// <summary>
        /// ��ǰ�����ݿ��ṩ����
        /// </summary>
        private string _dbProviderName = null;

        /// <summary>
        /// ��ǰ�����ݿ������ַ���
        /// </summary>
        private string _dbConnectionString = null;
        #endregion

        #endregion

        #region ���캯��
        /// <summary>
        /// �������õ����ݿ��ṩ��������Ӵ����г�ʼ���˶���ʵ��
        /// </summary>
        public DbHelper()
            : this(DbHelper.DbConnectionString, DbHelper.DbProviderName)
        {
        }

        /// <summary>
        /// �������ݿ����Ӵ������ݿ��ṩ�������������������г�ʼ���˶���ʵ��
        /// </summary>
        /// <param name="connectionString">���ݿ����������ַ���</param>
        /// <param name="providerName">���ݿ��ṩ���������</param>
        public DbHelper(string connectionString, string providerName)
        {
            if (!string.IsNullOrEmpty(providerName))
            {
                this._dbFactory = DbHelper.CreateDbProviderFactory(providerName);//����Ĭ�����õ����ݿ��ṩ����
            }
            else
            {
                throw new ArgumentNullException("providerName", "���ݿ��ṩ�������Ʋ���ֵ����Ϊ��,���������ļ������ø���ֵ!");
            }

            if (!string.IsNullOrEmpty(connectionString))
            {
                this._dbConnection = DbHelper.CreateDbConnection(connectionString, providerName);//������ǰ���ݿ����Ӷ���
            }
            else
            {
                throw new ArgumentNullException("connectionString", "���ݿ����Ӵ�����ֵ����Ϊ��,���������ļ������ø���ֵ!");
            }

            //���浱ǰ�����ַ��������ݿ��ṩ��������
            this._dbConnectionString = connectionString;
            this._dbProviderName = providerName;
        }
        #endregion

        #region ��������

        #region ����DbProviderFactory����(��̬����)
        /// <summary>
        /// �������õ����ݿ��ṩ�����DbProviderName����������һ�����ݿ����õ��ṩ����DbProviderFactory����
        /// </summary>
        public static DbProviderFactory CreateDbProviderFactory()
        {
            DbProviderFactory dbFactory = DbHelper.CreateDbProviderFactory(DbHelper.DbProviderName);

            return dbFactory;
        }

        /// <summary>
        /// ���ݲ������ƴ���һ�����ݿ��ṩ����DbProviderFactory����
        /// </summary>
        /// <param name="dbProviderName">���ݿ��ṩ���������</param>
        public static DbProviderFactory CreateDbProviderFactory(string dbProviderName)
        {
            DbProviderFactory dbFactory = DbProviderFactories.GetFactory(dbProviderName);

            return dbFactory;
        }
        #endregion

        #region ����DbConnection����(��̬����)
        /// <summary>
        /// �������õ����ݿ��ṩ��������Ӵ����������ݿ�����.
        /// </summary>
        public static DbConnection CreateDbConnection()
        {
            DbConnection dbConn = DbHelper.CreateDbConnection(DbHelper.DbConnectionString, DbHelper.DbProviderName);

            return dbConn;
        }

        /// <summary>
        /// �������ݿ������ַ����������������ݿ�����.
        /// </summary>
        /// <param name="connectionString">���ݿ����������ַ���</param>
        /// <param name="dbProviderName">���ݿ��ṩ���������</param>
        /// <returns></returns>
        public static DbConnection CreateDbConnection(string connectionString, string dbProviderName)
        {
            DbProviderFactory dbFactory = DbHelper.CreateDbProviderFactory(dbProviderName);

            DbConnection dbConn = dbFactory.CreateConnection();
            dbConn.ConnectionString = connectionString;

            return dbConn;
        }
        #endregion

        #region ��ȡDbCommand����
        /// <summary>
        /// ���ݴ洢����������������ǰ���ݿ����ӵ�DbCommand����
        /// </summary>
        /// <param name="storedProcedure">�洢��������</param>
        public DbCommand GetStoredProcedureCommond(string storedProcedure)
        {
            DbCommand dbCmd = this._dbConnection.CreateCommand();

            dbCmd.CommandText = storedProcedure;
            dbCmd.CommandType = CommandType.StoredProcedure;

            return dbCmd;
        }

        /// <summary>
        /// ����SQL�����������ǰ���ݿ����ӵ�DbCommand����
        /// </summary>
        /// <param name="sqlQuery">SQL��ѯ���</param>
        public DbCommand GetSqlStringCommond(string sqlQuery)
        {
            DbCommand dbCmd = this._dbConnection.CreateCommand();

            dbCmd.CommandText = sqlQuery;
            dbCmd.CommandType = CommandType.Text;

            return dbCmd;
        }
        #endregion

        #region ���DbCommand����
        /// <summary>
        /// �Ѳ���������ӵ�DbCommand������
        /// </summary>
        /// <param name="cmd">���ݿ������������</param>
        /// <param name="dbParameterCollection">���ݿ��������</param>
        public void AddParameterCollection(DbCommand cmd, DbParameterCollection dbParameterCollection)
        {
            if (cmd != null)
            {
                foreach (DbParameter dbParameter in dbParameterCollection)
                {
                    cmd.Parameters.Add(dbParameter);
                }
            }
        }

        /// <summary>
        /// �����������ӵ�DbCommand������
        /// </summary>
        /// <param name="cmd">���ݿ������������</param>
        /// <param name="parameterName">��������</param>
        /// <param name="dbType">����������</param>
        /// <param name="size">�����Ĵ�С</param>
        public void AddOutParameter(DbCommand cmd, string parameterName, DbType dbType, int size)
        {
            if (cmd != null)
            {
                DbParameter dbParameter = cmd.CreateParameter();

                dbParameter.DbType = dbType;
                dbParameter.ParameterName = parameterName;
                dbParameter.Size = size;
                dbParameter.Direction = ParameterDirection.Output;

                cmd.Parameters.Add(dbParameter);
            }
        }

        /// <summary>
        /// �����������ӵ�DbCommand������
        /// </summary>
        /// <param name="cmd">���ݿ������������</param>
        /// <param name="parameterName">��������</param>
        /// <param name="dbType">����������</param>
        /// <param name="value">����ֵ</param>
        public void AddInParameter(DbCommand cmd, string parameterName, DbType dbType, object value)
        {
            if (cmd != null)
            {
                DbParameter dbParameter = cmd.CreateParameter();

                dbParameter.DbType = dbType;
                dbParameter.ParameterName = parameterName;
                dbParameter.Value = value;
                dbParameter.Direction = ParameterDirection.Input;

                cmd.Parameters.Add(dbParameter);
            }
        }

        /// <summary>
        /// �ѷ��ز�����ӵ�DbCommand������
        /// </summary>
        /// <param name="cmd">���ݿ������������</param>
        /// <param name="parameterName">��������</param>
        /// <param name="dbType">����������</param>
        public void AddReturnParameter(DbCommand cmd, string parameterName, DbType dbType)
        {
            if (cmd != null)
            {
                DbParameter dbParameter = cmd.CreateParameter();

                dbParameter.DbType = dbType;
                dbParameter.ParameterName = parameterName;
                dbParameter.Direction = ParameterDirection.ReturnValue;

                cmd.Parameters.Add(dbParameter);
            }
        }

        /// <summary>
        /// ���ݲ������ƴ�DbCommand�����л�ȡ��Ӧ�Ĳ�������
        /// </summary>
        /// <param name="cmd">���ݿ������������</param>
        /// <param name="parameterName">��������</param>
        public DbParameter GetParameter(DbCommand cmd, string parameterName)
        {
            if (cmd != null && cmd.Parameters.Count > 0)
            {
                DbParameter param = cmd.Parameters[parameterName];

                return param;
            }

            return null;
        }
        #endregion

        #region ִ��SQL�ű����
        /// <summary>
        /// ִ����Ӧ��SQL�������һ��DataSet���ݼ���
        /// </summary>
        /// <param name="sqlQuery">��Ҫִ�е�SQL���</param>
        /// <returns>����һ��DataSet���ݼ���</returns>
        public DataSet ExecuteDataSet(string sqlQuery)
        {
            DataSet ds = new DataSet();

            if (!string.IsNullOrEmpty(sqlQuery))
            {
                DbCommand cmd = GetSqlStringCommond(sqlQuery);

                ds = ExecuteDataSet(cmd);
            }

            return ds;
        }

        /// <summary>
        /// ִ����Ӧ��SQL�������һ��DataTable���ݼ�
        /// </summary>
        /// <param name="sqlQuery">��Ҫִ�е�SQL���</param>
        /// <returns>����һ��DataTable���ݼ�</returns>
        public DataTable ExecuteDataTable(string sqlQuery)
        {
            DataTable dt = new DataTable();

            if (!string.IsNullOrEmpty(sqlQuery))
            {
                DbCommand cmd = GetSqlStringCommond(sqlQuery);

                dt = ExecuteDataTable(cmd);
            }

            return dt;
        }

        /// <summary>
        /// ִ����Ӧ��SQL�������һ��DbDataReader���ݶ������û���򷵻�nullֵ
        /// </summary>
        /// <param name="sqlQuery">��Ҫִ�е�SQL����</param>
        /// <returns>����һ��DbDataReader���ݶ������û���򷵻�nullֵ</returns>
        public DbDataReader ExecuteReader(string sqlQuery)
        {
            if (!string.IsNullOrEmpty(sqlQuery))
            {
                DbCommand cmd = GetSqlStringCommond(sqlQuery);

                DbDataReader reader = ExecuteReader(cmd);

                return reader;
            }

            return null;
        }

        /// <summary>
        /// ִ����Ӧ��SQL�������Ӱ������ݼ�¼����������ɹ��򷵻�-1
        /// </summary>
        /// <param name="sqlQuery">��Ҫִ�е�SQL����</param>
        /// <returns>����Ӱ������ݼ�¼����������ɹ��򷵻�-1</returns>
        public int ExecuteNonQuery(string sqlQuery)
        {
            if (!string.IsNullOrEmpty(sqlQuery))
            {
                DbCommand cmd = GetSqlStringCommond(sqlQuery);

                int retVal = ExecuteNonQuery(cmd);

                return retVal;
            }

            return -1;
        }

        /// <summary>
        /// ִ����Ӧ��SQL������ؽ�����еĵ�һ�е�һ�е�ֵ��������ɹ��򷵻�nullֵ
        /// </summary>
        /// <param name="sqlQuery">��Ҫִ�е�SQL����</param>
        /// <returns>���ؽ�����еĵ�һ�е�һ�е�ֵ��������ɹ��򷵻�nullֵ</returns>
        public object ExecuteScalar(string sqlQuery)
        {
            if (!string.IsNullOrEmpty(sqlQuery))
            {
                DbCommand cmd = GetSqlStringCommond(sqlQuery);

                object retVal = ExecuteScalar(cmd);

                return retVal;
            }

            return null;
        }

        #endregion

        #region ִ��DbCommand����
        /// <summary>
        /// ִ����Ӧ���������һ��DataSet���ݼ���
        /// </summary>
        /// <param name="cmd">��Ҫִ�е�DbCommand�������</param>
        /// <returns>����һ��DataSet���ݼ���</returns>
        public DataSet ExecuteDataSet(DbCommand cmd)
        {
            DataSet ds = new DataSet();

            if (cmd != null)
            {
                DbDataAdapter dbDataAdapter = this._dbFactory.CreateDataAdapter();
                dbDataAdapter.SelectCommand = cmd;

                dbDataAdapter.Fill(ds);
            }

            return ds;
        }

        /// <summary>
        /// ִ����Ӧ���������һ��DataTable���ݼ���
        /// </summary>
        /// <param name="cmd">��Ҫִ�е�DbCommand�������</param>
        /// <returns>����һ��DataTable���ݼ���</returns>
        public DataTable ExecuteDataTable(DbCommand cmd)
        {
            DataTable dataTable = new DataTable();

            if (cmd != null)
            {
                DbDataAdapter dbDataAdapter = this._dbFactory.CreateDataAdapter();
                dbDataAdapter.SelectCommand = cmd;

                dbDataAdapter.Fill(dataTable);
            }

            return dataTable;
        }

        /// <summary>
        /// ִ����Ӧ���������һ��DbDataReader���ݶ������û���򷵻�nullֵ
        /// </summary>
        /// <param name="cmd">��Ҫִ�е�DbCommand�������</param>
        /// <returns>����һ��DbDataReader���ݶ������û���򷵻�nullֵ</returns>
        public DbDataReader ExecuteReader(DbCommand cmd)
        {
            if (cmd != null && cmd.Connection != null)
            {
                if (cmd.Connection.State != ConnectionState.Open)
                {
                    cmd.Connection.Open();
                }

                DbDataReader reader = cmd.ExecuteReader(CommandBehavior.CloseConnection);//��reader��ȡ����ʱ�Զ��ر����ݿ�����

                return reader;
            }

            return null;
        }

        /// <summary>
        /// ִ����Ӧ���������Ӱ������ݼ�¼����������ɹ��򷵻�-1
        /// </summary>
        /// <param name="cmd">��Ҫִ�е�DbCommand�������</param>
        /// <returns>����Ӱ������ݼ�¼����������ɹ��򷵻�-1</returns>
        public int ExecuteNonQuery(DbCommand cmd)
        {
            if (cmd != null && cmd.Connection != null)
            {
                if (cmd.Connection.State != ConnectionState.Open)
                {
                    cmd.Connection.Open();
                }

                int retVal = cmd.ExecuteNonQuery();

                cmd.Connection.Close();

                return retVal;
            }

            return -1;
        }

        /// <summary>
        /// ִ����Ӧ��������ؽ�����еĵ�һ�е�һ�е�ֵ��������ɹ��򷵻�nullֵ
        /// </summary>
        /// <param name="cmd">��Ҫִ�е�DbCommand�������</param>
        /// <returns>���ؽ�����еĵ�һ�е�һ�е�ֵ��������ɹ��򷵻�nullֵ</returns>
        public object ExecuteScalar(DbCommand cmd)
        {
            if (cmd != null && cmd.Connection != null)
            {
                if (cmd.Connection.State != ConnectionState.Open)
                {
                    cmd.Connection.Open();
                }

                object retVal = cmd.ExecuteScalar();

                cmd.Connection.Close();

                return retVal;
            }

            return null;
        }
        #endregion

        #region ִ��DbTransaction����
        /// <summary>
        /// ������ķ�ʽִ����Ӧ���������һ��DataSet���ݼ���
        /// </summary>
        /// <param name="cmd">��Ҫִ�е�DbCommand�������</param>
        /// <param name="trans">���ݿ��������</param>
        /// <returns>����һ��DataSet���ݼ���</returns>
        public DataSet ExecuteDataSet(DbCommand cmd, Trans trans)
        {
            DataSet ds = new DataSet();

            if (cmd != null)
            {
                cmd.Connection = trans.Connection;
                cmd.Transaction = trans.Transaction;

                DbDataAdapter dbDataAdapter = this._dbFactory.CreateDataAdapter();
                dbDataAdapter.SelectCommand = cmd;

                dbDataAdapter.Fill(ds);
            }

            return ds;
        }

        /// <summary>
        /// ������ķ�ʽִ����Ӧ���������һ��DataTable���ݼ���
        /// </summary>
        /// <param name="cmd">��Ҫִ�е�DbCommand�������</param>
        /// <param name="trans">���ݿ��������</param>
        /// <returns>����һ��DataTable���ݼ���</returns>
        public DataTable ExecuteDataTable(DbCommand cmd, Trans trans)
        {
            DataTable dataTable = new DataTable();

            if (cmd != null)
            {
                cmd.Connection = trans.Connection;
                cmd.Transaction = trans.Transaction;

                DbDataAdapter dbDataAdapter = this._dbFactory.CreateDataAdapter();
                dbDataAdapter.SelectCommand = cmd;

                dbDataAdapter.Fill(dataTable);
            }

            return dataTable;
        }

        /// <summary>
        /// ������ķ�ʽִ����Ӧ���������һ��DbDataReader���ݶ������û���򷵻�nullֵ
        /// </summary>
        /// <param name="cmd">��Ҫִ�е�DbCommand�������</param>
        /// <param name="trans">���ݿ��������</param>
        /// <returns>����һ��DbDataReader���ݶ������û���򷵻�nullֵ</returns>
        public DbDataReader ExecuteReader(DbCommand cmd, Trans trans)
        {
            if (cmd != null)
            {
                cmd.Connection.Close();

                cmd.Connection = trans.Connection;
                cmd.Transaction = trans.Transaction;

                DbDataReader reader = cmd.ExecuteReader();

                return reader;
            }

            return null;
        }

        /// <summary>
        /// ������ķ�ʽִ����Ӧ���������Ӱ������ݼ�¼����������ɹ��򷵻�-1
        /// </summary>
        /// <param name="cmd">��Ҫִ�е�DbCommand�������</param>
        /// <param name="trans">���ݿ��������</param>
        /// <returns>����Ӱ������ݼ�¼����������ɹ��򷵻�-1</returns>
        public int ExecuteNonQuery(DbCommand cmd, Trans trans)
        {
            if (cmd != null)
            {
                cmd.Connection.Close();

                cmd.Connection = trans.Connection;
                cmd.Transaction = trans.Transaction;

                int retVal = cmd.ExecuteNonQuery();

                return retVal;
            }

            return -1;
        }

        /// <summary>
        /// ������ķ�ʽִ����Ӧ��������ؽ�����еĵ�һ�е�һ�е�ֵ��������ɹ��򷵻�nullֵ
        /// </summary>
        /// <param name="cmd">��Ҫִ�е�DbCommand�������</param>
        /// <param name="trans">���ݿ��������</param>
        /// <returns>���ؽ�����еĵ�һ�е�һ�е�ֵ��������ɹ��򷵻�nullֵ</returns>
        public object ExecuteScalar(DbCommand cmd, Trans trans)
        {
            if (cmd != null)
            {
                cmd.Connection.Close();

                cmd.Connection = trans.Connection;
                cmd.Transaction = trans.Transaction;

                object retVal = cmd.ExecuteScalar();

                return retVal;
            }

            return null;
        }
        #endregion

        #endregion
    }

    /// <summary>
    /// ˵ ��: ���ݿ������������
    /// �� ��: 
    /// ʱ ��:  
    /// </summary>
    /// <remarks>
    /// �� ��: 
    /// ʱ ��:  
    /// </remarks>
    public sealed class Trans : IDisposable
    {
        #region �ֶ�����
        private DbConnection connection = null;
        /// <summary>
        /// ��ȡ��ǰ���ݿ����Ӷ���
        /// </summary>
        public DbConnection Connection
        {
            get
            {
                return this.connection;
            }
        }

        private DbTransaction transaction = null;
        /// <summary>
        /// ��ȡ��ǰ���ݿ��������
        /// </summary>
        public DbTransaction Transaction
        {
            get
            {
                return this.transaction;
            }
        }
        #endregion

        #region ���캯��
        /// <summary>
        /// �������õ����ݿ��ṩ����������ַ������������������
        /// </summary>
        public Trans()
            : this(DbHelper.DbConnectionString, DbHelper.DbProviderName)
        {
        }

        /// <summary>
        /// �������ݿ������ַ������������������
        /// </summary>
        /// <param name="connectionString">���ݿ������ַ���</param>
        /// <param name="dbProviderName">���ݿ��ṩ���������</param>
        public Trans(string connectionString, string dbProviderName)
        {
            if (!string.IsNullOrEmpty(connectionString))
            {
                this.connection = DbHelper.CreateDbConnection(connectionString, dbProviderName);
                this.Connection.Open();

                this.transaction = this.Connection.BeginTransaction();
            }
            else
            {
                throw new ArgumentNullException("connectionString", "���ݿ����Ӵ�����ֵ����Ϊ��!");
            }
        }
        #endregion

        #region ��������
        /// <summary>
        /// �ύ�����ݿ��������
        /// </summary>
        public void Commit()
        {
            this.Transaction.Commit();

            this.Close();
        }

        /// <summary>
        /// �ع������ݿ��������
        /// </summary>
        public void RollBack()
        {
            this.Transaction.Rollback();

            this.Close();
        }

        /// <summary>
        /// �رմ����ݿ���������
        /// </summary>
        public void Close()
        {
            if (this.Connection.State != System.Data.ConnectionState.Closed)
            {
                this.Connection.Close();
            }
        }
        #endregion

        #region IDisposable ��Ա
        /// <summary>
        /// ִ�����ͷŻ����÷��й���Դ��ص�Ӧ�ó����������
        /// </summary>
        public void Dispose()
        {
            this.Close();
        }
        #endregion
    }
}