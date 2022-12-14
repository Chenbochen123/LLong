using System;
using System.Collections.Generic;
using System.Data;
using System.Data.Common;
using System.IO;
using System.Reflection;
using Mesnac.DbAccess;

namespace Mesnac.DbSyn
{
    /// <summary>
    /// 数据库会话类
    /// </summary>
    public class DbSqlSession : IDisposable
    {

        public DbSqlSession(DbHelper dbHelper)
        {
            this._dbHelper = dbHelper;
        }

        private DbHelper _dbHelper = null;
        private IDbConnection getIDbConnection()
        {
            var dbHelper = this._dbHelper;
            var session = dbHelper.SessionFactory.OpenSession();
            var prefix = dbHelper.SessionFactory.DataSource.DbProvider.ParameterPrefix;
            session.OpenConnection();
            return dbHelper.CurrentSession.Connection;
        }

        /// <summary>
        /// 数据库参数前缀
        /// </summary>
        public string ParameterPrefix
        {
            get
            {
                var dbHelper = this._dbHelper;
                return dbHelper.SessionFactory.DataSource.DbProvider.ParameterPrefix;
            }
        }

        private IDbConnection _connection = null;
        /// <summary>
        /// 数据库连接
        /// </summary>
        public IDbConnection Connection
        {
            get
            {
                if (this._connection == null)
                {
                    this._connection = getIDbConnection();
                }
                if (this._connection.State != ConnectionState.Open)
                {
                    this._connection.Open();
                }
                return this._connection;
            }
        }
        private IDbCommand _command = null;
        /// <summary>
        /// 数据库操作命令
        /// </summary>
        public IDbCommand Command
        {
            get
            {
                if (_command == null)
                {
                    this._command = this.Connection.CreateCommand();
                    this._command.Connection = this.Connection;
                    this._command.CommandType = System.Data.CommandType.Text;
                }
                return _command;
            }
        }
        /// <summary>
        /// 关闭数据库会话
        /// </summary>
        public void Close()
        {
            try
            {
                this.Connection.Close();
                this.Connection.Dispose();
                this.Command.Dispose();
            }
            catch { }
            finally
            {
                this._connection = null;
                this._command = null;
            }
        }
        /// <summary>
        /// 释放资源
        /// </summary>
        public void Dispose()
        {
            this.Close();
        }
    }

}
