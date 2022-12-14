using System;
using System.Collections.Generic;
using System.Text;
using System.Data;
using System.Data.OleDb;
using System.Web;
using System.Configuration;
namespace DataAccess
{
    /// <summary>
    /// access数据库操作类
    /// </summary>
    public class AccessDB:IAccessDB
    {
         private string connStr;
        private OleDbCommand comm;
        private OleDbConnection conn;
        private string[] strKey;
        private object[] ObjValue;

        /// <summary>
        /// 
        /// </summary>
        /// <param name="strConn"></param>
        /// <param name="key"></param>
        /// <param name="value"></param>
        public AccessDB(string strConn)
        {
            connStr = strConn;
        }


        /// <summary>
        /// 构造函数
        /// </summary>
        public AccessDB()
        {
            Config.ConnDB ConnDB = new DataAccess.Config.ConnDB();
            connStr = ConnDB.StrConn;
        }


        /// <summary>
        /// 使用动态SQL返回数据集
        /// </summary>
        /// <returns></returns>
        public DataSet GetDataSet(string strSql, string[] strKey, object[] objValue)
        {

            conn = new OleDbConnection();
            comm = new OleDbCommand();
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
                OleDbDataAdapter da = new OleDbDataAdapter();
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
                throw;
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
        /// 执行动态SQL
        /// </summary>
        /// <returns></returns>
        public bool ExeSql(string strSql, string[] strKey, object[] objValue)
        {
            bool res = false;
            conn = new OleDbConnection();
            comm = new OleDbCommand();
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
        /// 执行存储过程返回数据集
        /// </summary>
        /// <returns></returns>
        public DataSet GetDataSetByProc(string procName, string[] strKey, object[] objValue)
        {

            conn = new OleDbConnection();
            comm = new OleDbCommand();
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
                OleDbDataAdapter da = new OleDbDataAdapter();
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
        /// 执行存储过程
        /// </summary>
        /// <returns></returns>
        public bool ExeSqlByProc(string procName, string[] strKey, object[] objValue)
        {
            bool res = false;
            conn = new OleDbConnection();
            comm = new OleDbCommand();
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
        /// 批量插入
        /// </summary>
        /// <param name="dt">数据集</param>
        /// <param name="tableName">目标表</param>
        /// <param name="colMap">字段映射（源字段，目标字段）</param>
        /// <returns></returns>
        public bool BatchInsert(DataTable dt, string tableName, Dictionary<string, string> colMap)
        {
            return false;
        }
    }
}
