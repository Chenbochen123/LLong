using System;
using System.Collections.Generic;
using System.Text;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;

namespace DataAccess
{
    /// <summary>
    /// Sql Server���ݿ������
    /// </summary>
    /// <remarks>
    /// ��װSql Server���ݿ����
    /// </remarks>
    public class SqlDB : IAccessDB
    {
        private string connStr;
        private SqlCommand comm;
        private SqlConnection conn;


        /// <summary>
        /// ���캯��
        /// </summary>
        /// <param name="strConn">���ݿ������ַ���</param>
        public SqlDB(string strConn)
        {
            connStr = strConn;
        }

        /// <summary>
        /// ���캯��
        /// </summary>
        /// <remarks>
        /// ���ݿ������ַ�������ΪĬ��ֵ
        /// </remarks>
        public SqlDB()
        {
            Config.ConnDB ConnDB = new DataAccess.Config.ConnDB();
            connStr = ConnDB.StrConn;
        }

        /// <summary>
        /// ʹ�ö�̬SQL�������ݼ�
        /// </summary>
        /// <returns></returns>
        public DataSet GetDataSet(string strSql, string[] strKey, object[] objValue)
        {

            conn = new SqlConnection();
            comm = new SqlCommand();
            DataSet ds = new DataSet();
            try
            {
                conn.ConnectionString = connStr;
                comm.Connection = conn;
                comm.CommandText = strSql;
                comm.CommandType = CommandType.Text;
                if (strKey != null)
                {
                    for (int i = 0; i < strKey.Length; i++)
                    {
                        comm.Parameters.AddWithValue(strKey[i], objValue[i]);
                    }
                }
                SqlDataAdapter da = new SqlDataAdapter();
                da.SelectCommand = comm;
                if (conn.State == ConnectionState.Closed)
                {
                    conn.Open();
                }
                da.Fill(ds);
                conn.Close();
            }
            catch
            {
            }
            finally
            {
                if (conn != null && conn.State != ConnectionState.Closed)
                {
                    conn.Close();
                }
            }
            return ds;
        }

        /// <summary>
        /// ִ�ж�̬SQL
        /// </summary>
        /// <returns></returns>
        public bool ExeSql(string strSql, string[] strKey, object[] objValue)
        {
            bool res = false;
            conn = new SqlConnection();
            comm = new SqlCommand();
            try
            {
                conn.ConnectionString = connStr;
                comm.Connection = conn;
                comm.CommandText = strSql;
                comm.CommandType = CommandType.Text;
                if (strKey != null)
                {
                    for (int i = 0; i < strKey.Length; i++)
                    {
                        comm.Parameters.AddWithValue(strKey[i], objValue[i]);
                    }
                }
                if (conn.State == ConnectionState.Closed)
                {
                    conn.Open();
                }
                comm.ExecuteNonQuery();
                res = true;
                conn.Close();
            }
            catch
            {
                res = false;
            }
            finally
            {
                if (conn != null && conn.State != ConnectionState.Closed)
                {
                    conn.Close();
                }
            }
            return res;
        }

        /// <summary>
        /// ִ�д洢���̷������ݼ�
        /// </summary>
        /// <returns></returns>
        public DataSet GetDataSetByProc(string procName, string[] strKey, object[] objValue)
        {

            conn = new SqlConnection();
            comm = new SqlCommand();
            DataSet ds = new DataSet();
            try
            {
                conn.ConnectionString = connStr;
                comm.Connection = conn;
                comm.CommandText = procName;
                comm.CommandType = CommandType.StoredProcedure;
                if (strKey != null)
                {
                    for (int i = 0; i < strKey.Length; i++)
                    {
                        comm.Parameters.AddWithValue(strKey[i], objValue[i]);
                    }
                }
                SqlDataAdapter da = new SqlDataAdapter();
                da.SelectCommand = comm;
                if (conn.State == ConnectionState.Closed)
                {
                    conn.Open();
                }
                da.Fill(ds);
                conn.Close();
            }
            catch
            {
            }
            finally
            {
                if (conn != null && conn.State != ConnectionState.Closed)
                {
                    conn.Close();
                }
            }
            return ds;
        }

        /// <summary>
        /// ִ�д洢����
        /// </summary>
        /// <returns></returns>
        public bool ExeSqlByProc(string procName, string[] strKey, object[] objValue)
        {
            bool res = false;
            conn = new SqlConnection();
            comm = new SqlCommand();
            try
            {
                conn.ConnectionString = connStr;
                comm.Connection = conn;
                comm.CommandText = procName;
                comm.CommandType = CommandType.StoredProcedure;
                if (strKey != null)
                {
                    for (int i = 0; i < strKey.Length; i++)
                    {
                        comm.Parameters.AddWithValue(strKey[i], objValue[i]);
                    }
                }
                if (conn.State == ConnectionState.Closed)
                {
                    conn.Open();
                }
                comm.ExecuteNonQuery();
                res = true;
                conn.Close();
            }
            catch
            {
                res = false;
            }
            finally
            {
                if (conn != null && conn.State != ConnectionState.Closed)
                {
                    conn.Close();
                }
            }
            return res;
        }

        /// <summary>
        /// ��������
        /// </summary>
        /// <param name="dt">���ݼ�</param>
        /// <param name="tableName">Ŀ���</param>
        /// <param name="colMap">�ֶ�ӳ�䣨Դ�ֶΣ�Ŀ���ֶΣ�</param>
        /// <returns></returns>
        public bool BatchInsert(DataTable dt, string tableName, Dictionary<string, string> colMap)
        {
            bool res = false;
            if (string.IsNullOrEmpty(tableName) || colMap==null || colMap.Count < 1)
            {
                return false;
            }
            using (SqlConnection Connection = new SqlConnection(connStr))
            {
                Connection.Open();

                SqlTransaction sqlbulkTransaction = Connection.BeginTransaction();

                using (SqlBulkCopy sqlBulkCopy = new SqlBulkCopy(Connection, SqlBulkCopyOptions.Default, sqlbulkTransaction))
                {
                    foreach (string key in colMap.Keys)
                    {
                        string value = "";
                        colMap.TryGetValue(key,out value);
                        sqlBulkCopy.ColumnMappings.Add(key, value);
                    }
                    sqlBulkCopy.BatchSize = dt.Rows.Count;
                    sqlBulkCopy.BulkCopyTimeout = 180;
                    sqlBulkCopy.DestinationTableName = tableName;
                    if (dt != null && dt.Rows.Count != 0)
                    {
                        try
                        {
                            sqlBulkCopy.WriteToServer(dt);
                            sqlbulkTransaction.Commit();
                            res = true;
                        }
                        catch (Exception ex)
                        {
                            try
                            {
                                sqlbulkTransaction.Rollback();
                                res = false;
                            }
                            catch
                            {
                                res = false;
                            }
                            throw ex;
                        }
                        finally
                        {
                            if (conn != null && conn.State != ConnectionState.Closed)
                            {
                                conn.Close();
                            }
                        }
                    }
                }
                if (conn != null && conn.State != ConnectionState.Closed)
                {
                    conn.Close();
                }
            }
            return res;
        }

    }
}
