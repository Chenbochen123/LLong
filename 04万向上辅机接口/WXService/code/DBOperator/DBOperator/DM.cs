using System;
using System.Collections.Generic;
using System.Text;
using NUnit.Framework;
using System.Data;
using System.Data.SqlClient;
using XMLHandler;

namespace DBOperator
{
    /// <summary>
    /// 数据库操作基础类
    /// 进行增删改查、事物、存储过程操作
    /// </summary>
    public class DM
    {
        private SqlConnection conn;
        private List<string> TransSqls;

        /// <summary>
        /// 默认读取配置文件创建连接
        /// </summary>
        //public DM()
        //{
        //    TXmlConfigHandler DBConfig = new TXmlConfigHandler(@".\config.xml");
        //    string _serverIP = EncryptionEngine(DBConfig.ReadValue("IP"), string.Empty, false);
        //    string _dbName = EncryptionEngine(DBConfig.ReadValue("DBName"), string.Empty, false);
        //    string _user = EncryptionEngine(DBConfig.ReadValue("UserID"), string.Empty, false);
        //    string _password = EncryptionEngine(DBConfig.ReadValue("Password"), string.Empty, false);
        //    CreateConn(_serverIP, _user, _password, _dbName);
        //    TransSqls = new List<string>();
        //}

        /// <summary>
        /// 创建数据库连接
        /// </summary>
        /// <param name="_serverIP">数据库IP</param>
        /// <param name="_user">用户名</param>
        /// <param name="_password">密码</param>
        /// <param name="_dbName">数据库名</param>
        public DM(string _serverIP, string _user, string _password,string _dbName)
        {
            CreateConn(_serverIP, _user, _password, _dbName);
            TransSqls = new List<string>();
        }

        private void CreateConn(string _serverIP, string _user, string _password, string _dbName)
        {
            string connString = "server=" + EncryptionEngine(_serverIP, string.Empty, false) +
                   ";uid=" + EncryptionEngine(_user, string.Empty, false) +
                   ";pwd=" + EncryptionEngine(_password, string.Empty, false) +
                   ";database=" + EncryptionEngine(_dbName, string.Empty, false) +
                   ";Max Pool Size=300;Min Pool Size=5;Pooling=true";
            conn = new SqlConnection(connString);
        }

        /// <summary>
        /// 获取数据库连接状态
        /// </summary>
        public ConnectionState State
        {
            get
            {
                return conn.State;
            }
        }

        public string ConnectString
        {
            get
            {
                return conn.ConnectionString;
            }
        }

        /// <summary>
        /// 获取字段值
        /// </summary>
        /// <param name="_tableName">表明</param>
        /// <param name="_keyName">已知字段名</param>
        /// <param name="_keyValue">已知字段值</param>
        /// <param name="_expectName">要获取的字段名</param>
        /// <returns>要获取的字段值（仅以string型返回第一个）</returns>
        public string GetDBValue(string _tableName,string _keyName,string _keyValue,string _expectName)
        {
            string sqlstr = "select " + _expectName + " from " + _tableName + " where " + _keyName + "='" + _keyValue + "'";
            //以ds方法获取的dataset第一个表的第一行第一列认为是所需的字段值，不考虑重复
            //如果返回表没有记录，默认返回空字符串
            DataTable dt = this.ds(sqlstr).Tables[0];
            if (dt.Rows.Count == 0)
                return "";
            else
                return dt.Rows[0][0].ToString();
        }

        /// <summary>
        /// 执行SQL语句
        /// </summary>
        /// <param name="_sqlstring">要执行的SQL语句</param>
        /// <returns>返回insert、delete、update影响的行数，其他语句及回滚返回-1</returns>
        public int ExecuteSql(string _sqlstring)
        {
            SqlCommand cmd = new SqlCommand(_sqlstring, this.conn);
            if ((conn.State == ConnectionState.Broken) || (conn.State == ConnectionState.Closed))
                conn.Open();
            int affectedRowsCount = 0;
            try
            {
                affectedRowsCount = cmd.ExecuteNonQuery();
                return affectedRowsCount;
            }
            catch (Exception ex)
            {
                Console.WriteLine(ex.Message + ":" + _sqlstring);
                //return affectedRowsCount;
                throw ex;
            }
            finally
            {
                this.conn.Close();
            } 
        }

        public string GetSclar(string _sqltext)
        {
            SqlCommand cmd = new SqlCommand(_sqltext, this.conn);

            //conn.Open();
            if ((conn.State == ConnectionState.Broken) || (conn.State == ConnectionState.Closed))
                conn.Open();
            try
            {
                return Convert.ToString(cmd.ExecuteScalar());                 
            }
            catch (Exception ex)
            {
                throw ex;
                //throw new ApplicationException("数据访问层异常提示：" + ex.Message);
            }
            finally
            {
                conn.Close();
            }
        }

        /// <summary>
        /// 执行SQL语句，返回一个dataset
        /// </summary>
        /// <param name="_sqlstring">要执行的SQL语句</param>
        /// <returns>返回数据集</returns>
        public DataSet ds(string _sqlstring)
        {
            DataSet ds = new DataSet();

            try
            {
                if ((conn.State == ConnectionState.Broken) || (conn.State == ConnectionState.Closed))
                    conn.Open();
                SqlCommand cmd = new SqlCommand(_sqlstring, this.conn);
                SqlDataAdapter SDA = new SqlDataAdapter(cmd);
                SDA.Fill(ds);
                conn.Close();
                return ds;
            }
            catch (Exception ex)
            {
                Console.WriteLine("Error: {0}", ex.Message);
                throw ex;
                //throw new Exception("获取Dataset异常，异常信息 :{0}", ex);
            }
            finally
            {
                conn.Close();
            }
        }

        /// <summary>
        /// 删除记录
        /// </summary>
        /// <param name="_deleteTable">表名</param>
        /// <param name="_deleteCondition">删除条件</param>
        /// <returns>返回影响行数</returns>
        public int DeleteRecord(string _deleteTable,string _deleteCondition)
        {
            try
            {
                int deletedRowsCount;
                if (_deleteCondition != "")
                    _deleteCondition = "and " + _deleteCondition;
                deletedRowsCount = this.ExecuteSql("delete from " + _deleteTable + " where 1=1 " + _deleteCondition);
                return deletedRowsCount;
            }
            catch (Exception ex)
            {
                Console.WriteLine("Error: {0}", ex.Message);
                //throw new Exception("获取Dataset异常，异常信息 :{0}", ex);
                throw ex;
            }
        }

        /// <summary>
        /// 添加记录
        /// </summary>
        /// <param name="_insertTable">表名</param>
        /// <param name="_field">字段名列表</param>
        /// <param name="_value">字段值列表</param>
        /// <returns>返回影响行数</returns>
        public int AddRecord(string _insertTable,List<string> _field,List<string> _value)
        {
            try
            {
                int insertRowsCount;
                string fieldstring = "", valuestring = "";
                fieldstring = MakeFieldArgsFormat(_field);
                valuestring = MakeValueArgsFormat(_value);
                insertRowsCount = this.ExecuteSql("Insert into " + _insertTable + " (" + fieldstring + ") values (" +
               valuestring + ")");
                return insertRowsCount;
            }
            catch (Exception ex)
            {
                Console.WriteLine("Error: {0}", ex.Message);
                throw ex;
                //throw new Exception("获取Dataset异常，异常信息 :{0}", ex);
            }
        }

        /// <summary>
        /// 格式化参数列表
        /// </summary>
        /// <param name="_stringList">参数列表</param>
        /// <returns>格式化后参数列表</returns>
        private static string MakeFieldArgsFormat(List<string> _stringList)
        {
            string _formatedString = "";
            foreach (string stringElement in _stringList)
            {
                _formatedString = _formatedString + "," + stringElement;

            }
            //delete comma
            _formatedString = _formatedString.Remove(0, 1);
            return _formatedString;
        }

        /// <summary>
        /// 格式化值列表
        /// </summary>
        /// <param name="_stringList">值列表</param>
        /// <returns>格式化后值列表</returns>
        private static string MakeValueArgsFormat(List<string> _stringList)
        {
            string _formatedString = "";
            foreach (string stringElement in _stringList)
            {
                _formatedString = _formatedString + ",'" + stringElement + "'";
                
            }
            //delete comma
            _formatedString = _formatedString.Remove(0, 1);
            return _formatedString;
        }

        /// <summary>
        /// 格式化修改语句
        /// </summary>
        /// <param name="_field">字段名列表</param>
        /// <param name="_newValue">字段新值列表</param>
        /// <returns>格式化后修改语句</returns>
        private static string MakeUpdateStringFormat(List<string> _field, List<string> _newValue)
        {
            if (_field.Count != _newValue.Count)
            {
                return "";
            }
            else
            {
                string returnString="";
                for (int _count = 0; _count < _field.Count; _count++)
                {
                    returnString = returnString + "," + _field[_count] + "='" + _newValue[_count] + "'";
                }
                //delete comma
                returnString = returnString.Remove(0, 1);
                return returnString;
            }
        }

        /// <summary>
        /// 全部修改
        /// </summary>
        /// <param name="_tableName">表名</param>
        /// <param name="_field">字段名列表</param>
        /// <param name="_newValue">修改值列表</param>
        /// <returns>返回影响行数</returns>
        public int ChangeRecord(string _tableName, List<string> _field,List<string> _newValue)
        {
            string sqlStr = "";
            try
            {
                int updateRowsCount = 0;
                string updateString = MakeUpdateStringFormat(_field, _newValue);
                sqlStr = "Update " + _tableName + " set " + updateString;
                updateRowsCount = this.ExecuteSql(sqlStr);
                return updateRowsCount;
            }
            catch (Exception ex)
            {
                Console.WriteLine("Error:{0}", ex.Message);
                Console.WriteLine("Error Sql:{0}", sqlStr);
                //throw new Exception("更新数据异常,异常信息:{0}", ex);
                throw ex;
            }
        }

        /// <summary>
        /// 按条件修改
        /// </summary>
        /// <param name="_tableName">表名</param>
        /// <param name="_field">字段名列表</param>
        /// <param name="_newValue">修改值列表</param>
        /// <param name="_condition">修改条件</param>
        /// <returns>返回影响行数</returns>
        public int ChangeRecord(string _tableName, List<string> _field, List<string> _newValue, string _condition)
        {
            string sqlStr = "";
            try
            {
                int updateRowsCount = 0;
                string updateString = MakeUpdateStringFormat(_field, _newValue);
                sqlStr = "Update " + _tableName + " set " + updateString + " where " + _condition;
                updateRowsCount = this.ExecuteSql(sqlStr);
                return updateRowsCount;
            }
            catch (Exception ex)
            {
                Console.WriteLine("Error:{0}", ex.Message);
                Console.WriteLine("Error Sql:{0}", sqlStr);
                //throw new Exception("更新数据异常,异常信息:{0}", ex);
                throw ex;
            }
        }

        /// <summary>
        /// 返回select查询获得行数
        /// </summary>
        /// <param name="_sqlString">从表名开始的字符串，例如：tb_eq_equip where ...</param>        
        /// <returns></returns>
        public int GetCount(string _tableName)
        {
            try
            {
                if ((conn.State == ConnectionState.Broken) || (conn.State == ConnectionState.Closed))
                    conn.Open();
                SqlCommand cmd = new SqlCommand("SELECT COUNT(1) FROM " + _tableName, this.conn);
                string count = cmd.ExecuteScalar().ToString();
                conn.Close();
                return Convert.ToInt32(count);
            }
            catch (Exception ex)
            {
                throw ex;
                //throw new Exception(ex.Message);
            }
            finally
            {
                conn.Close();
            }
        }

        /// <summary>
        /// 清除事务语句
        /// </summary>
        public void TransClear()
        {
            TransSqls.Clear();
        }

        /// <summary>
        /// 添加一条事务语句
        /// </summary>
        /// <param name="_sqlstring">待执行的sql语句</param>
        public void TransAdd(string _sqlstring)
        {
            TransSqls.Add(_sqlstring);
        }

        /// <summary>
        /// 添加多条事务语句
        /// </summary>
        /// <param name="_sqlstrings">待执行的sql语句泛型</param>
        public void TransAddSqls(List<string> _sqlstrings)
        {
            foreach (string s in _sqlstrings)
            {
                TransSqls.Add(s);
            }
        }


        /// <summary>
        /// 函数功能：处理带参数的存储过程
        /// 函数名称：
        /// 参    数：
        /// 返 回 值：
        /// 程 序 员：
        /// 编制日期：
        /// 函数说明：
        /// </summary>
        public SqlCommand BuildQueryCommand(string storedProcName, SqlParameter[] parameters)
        {
            SqlCommand command = new SqlCommand();
            command.Connection = conn;
            command.CommandText = "[" + storedProcName.Trim() + "]";
            command.CommandType = CommandType.StoredProcedure;

            if (parameters != null)
            {
                foreach (SqlParameter p in parameters)
                {
                    command.Parameters.Add(p);
                }
            }
            return command;
        }

        public void ExecuteProcedure(string ProcedureName, SqlParameter[] Parameters)
        {
            SqlCommand cmd = BuildQueryCommand(ProcedureName, Parameters);
            cmd.Connection = conn;
            try
            {
                if ((conn.State == ConnectionState.Broken) || (conn.State == ConnectionState.Closed))
                    conn.Open();
                //cmd.Connection.Open();
                int i = cmd.ExecuteNonQuery();
            }
            catch (Exception ex)
            {
                throw ex;
                //throw new ApplicationException("提示：" + ex.Message);
            }
            finally
            {
                cmd.Connection.Close();
            }
        }
        public DataSet ExecuteProcedureFillDataSet(string ProcedureName, SqlParameter[] Parameters)
        {
            SqlCommand cmd = BuildQueryCommand(ProcedureName, Parameters);
            cmd.Connection = conn;
            try
            {
                if ((conn.State == ConnectionState.Broken) || (conn.State == ConnectionState.Closed))
                    conn.Open();
                SqlDataAdapter da = new SqlDataAdapter(cmd);
                DataSet ds = new DataSet();
                da.Fill(ds);
                return ds;
            }
            catch (Exception ex)
            {
                throw ex;
                //throw new ApplicationException("提示：" + ex.Message);
            }
            finally
            {
                cmd.Connection.Close();
            }
        }
        public string ExecuteCmdProcedure(string ProcedureName, SqlParameter[] Parameters)
        {
            SqlCommand cmd = BuildQueryCommand(ProcedureName, Parameters);
            cmd.Connection = conn;
            try
            {
                if ((conn.State == ConnectionState.Broken) || (conn.State == ConnectionState.Closed))
                    conn.Open();
                //cmd.Connection.Open();
                int i = cmd.ExecuteNonQuery();
                return "";
            }
            catch (Exception ex)
            {
                throw ex;
                //cmd.Connection.Close();
                //return ex.Message;
                //throw new ApplicationException("提示：" + ex.Message);
            }
            finally
            {
                conn.Close();
                cmd.Connection.Close();
            }
        }


        /// <summary>
        /// 执行一个事务
        /// </summary>
        /// <returns></returns>
        public string TransCommit()
        {
            if ((conn.State == ConnectionState.Broken) || (conn.State == ConnectionState.Closed))
                conn.Open();
            SqlTransaction sqlTran = conn.BeginTransaction();
            SqlCommand cmd = conn.CreateCommand();
            cmd.Transaction = sqlTran;

            try
            {
                foreach (string s in TransSqls)
                {
                    cmd.CommandText = s;
                    cmd.ExecuteNonQuery();
                }
                sqlTran.Commit();
                return "事务执行成功";
            }
            catch (Exception ex)
            {
                sqlTran.Rollback();
                throw ex;
                //return ex.Message;
            }
            finally
            {
                conn.Close();
            }
        }

        public void StoreProcedure(List<SqlParameter> _paras, string _procedureName)
        {
            if ((conn.State == ConnectionState.Broken) || (conn.State == ConnectionState.Closed))
                conn.Open();
            //conn.Open();
            SqlCommand cmd = new SqlCommand();
            cmd.CommandText = _procedureName;
            cmd.Connection = conn;
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.GetEnumerator();
            foreach (SqlParameter sp in _paras)
            {
                Console.WriteLine("Ready to...");
                cmd.Parameters.Add(sp);
                Console.WriteLine("finIshed");
            }
            cmd.ExecuteNonQuery();
            //string result = cmd.Parameters["@Result"].Value.ToString();
            //Console.WriteLine("Oh");
            conn.Close();
            //return result;
        }

        /// <summary>
        /// 功能：分布式事务处理的C#实现（事务嵌套法）
        /// </summary>
        /// <param name="tran1">事务1</param>
        /// <param name="tran2">事务2</param>
        /// <param name="tran1_Commands">事务1要执行的命令</param>
        /// <param name="tran2_Commands">事务2要执行的命令</param>
        /// <returns>如果成功则返回空字符，否则返回异常信息</returns>
        public string ExecuteRemoteTransactions(SqlConnection conn1, SqlConnection conn2,
            SqlCommand[] tran1_Commands, SqlCommand[] tran2_Commands)
        {
            SqlTransaction tran1 = null;
            SqlTransaction tran2 = null;

            try
            {
                // 连接1打开
                conn1.Open();
                // 事务1开启
                tran1 = conn1.BeginTransaction();
                foreach (SqlCommand cmd in tran1_Commands)
                {
                    cmd.Transaction = tran1;
                    int effect = cmd.ExecuteNonQuery();
                }
                // 连接2打开
                conn2.Open();
                // 事务2开启
                tran2 = conn2.BeginTransaction();
                foreach (SqlCommand cmd in tran2_Commands)
                {
                    cmd.Transaction = tran2;
                    int effect = cmd.ExecuteNonQuery();
                }
                tran2.Commit();
                tran1.Commit();
                return "";
            }
            catch (Exception ex)
            {
                if (tran1 != null)
                {
                    tran1.Rollback();
                }
                //return ex.Message;
                throw ex;
            }
            finally
            {
                conn1.Close();
                conn2.Close();
            }
        }

        public string EncryptionEngine(string src, string key, Boolean Encrypt)
        {
            int KeyLen;
            int KeyPos;
            int offset;
            string dest;
            int SrcPos;
            int SrcAsc;
            int TmpSrcAsc;
            int Range;

            KeyLen = key.Length;
            if (KeyLen == 0)
            {
                key = "Mesnac";
            }
            KeyPos = 0;
            SrcPos = 0;
            SrcAsc = 0;
            Range = 256;
            if (Encrypt)   //加密
            {
                //System.Random r = new Random(Range);
                //offset = r.Next(Range);
                System.Random r = new Random();
                offset = r.Next() % 256 + 1;
                dest = string.Format("{0:X}", offset);
                if (dest.Length == 1)
                {
                    dest = "0" + dest;
                }
                for (SrcPos = 0; SrcPos < src.Length; SrcPos++)
                {
                    SrcAsc = ((int)src[SrcPos] + offset) % 255;
                    if (KeyPos < KeyLen)
                    {
                        KeyPos = KeyPos + 1;
                    }
                    else { KeyPos = 0; }

                    SrcAsc = SrcAsc ^ (int)key[KeyPos]; //异或

                    string tempSrcAsc = string.Format("{0:X}", SrcAsc);
                    if (tempSrcAsc.Length == 1)
                    {
                        tempSrcAsc = "0" + tempSrcAsc;
                    }
                    dest = dest + tempSrcAsc;
                    offset = SrcAsc;
                }

                return dest;

            }
            else   //解密
            {
                if (src.Length <= 2)
                {
                    return "";
                }
                dest = "";
                //offset = (int)("0x" + src.Substring(1, 2));
                offset = Convert.ToInt32(src.Substring(0, 2), 16);
                SrcPos = 2;
                while (SrcPos < src.Length)
                {
                    SrcAsc = Convert.ToInt32(src.Substring(SrcPos, 2), 16);
                    if (KeyPos < KeyLen)
                    {
                        KeyPos = KeyPos + 1;
                    }
                    else { KeyPos = 0; }

                    TmpSrcAsc = SrcAsc ^ (int)key[KeyPos]; //异或
                    if (TmpSrcAsc <= offset)
                    {
                        TmpSrcAsc = 255 + TmpSrcAsc - offset;
                    }
                    else
                    {
                        TmpSrcAsc = TmpSrcAsc - offset;
                    }
                    dest = dest + (char)TmpSrcAsc;
                    offset = SrcAsc;
                    SrcPos = SrcPos + 2;

                }
            }

            return dest;
        }
    }

    //[TestFixture]
    //public class TestDBOperator
    //{
    //    DM DMTester;
    //    public TestDBOperator()
    //    {
    //        DMTester = new DM();
    //    }

    //    [Test]
    //    public void TestSqlCount()
    //    {
    //        Assert.AreEqual(10, DMTester.GetCount("tb_eq_mouldtype"));
    //    }

    //    [Test]
    //    public void TestTrans()
    //    {
    //        DMTester.TransClear();
    //        DMTester.TransAdd("insert into tb_SM_MouldInStockDetail (instockid,mouldid,locationid,mouldtypeid) values ('0001020301','0003','123123','5')");
    //        DMTester.TransAdd("INSERT INto tb_SM_MouldInStock (InStockID,TypeID,RecordID,RecordTime,FixedGroupID,RunningGroupID,ShiftID) values ('0000000000001','5','0000000000',getdate(),'00','00','00')");
    //        Assert.AreEqual("事务执行成功", DMTester.TransCommit());
    //    }

    //    [Test]
    //    public void TestProcedure()
    //    {
    //        //string Procedurename = "up_SM_NonstandardMouldInStock";
    //        List<SqlParameter> ParaList = new List<SqlParameter>();
    //        SqlParameter sp1 = new SqlParameter("@InstockID", "123");
    //        SqlParameter sp2 = new SqlParameter("@TypeID", "05");
    //        SqlParameter sp3 = new SqlParameter("@RecordID", "323");
    //        SqlParameter sp4 = new SqlParameter("@FixedGroupID", "11");
    //        SqlParameter sp5 = new SqlParameter("@RunningGroupID", "22");
    //        SqlParameter sp6 = new SqlParameter("@ShiftID", "33");
    //        SqlParameter sp7 = new SqlParameter("@MouldID", "3123");
    //        SqlParameter sp8 = new SqlParameter("@LocationID", "2333");
    //        SqlParameter sp9 = new SqlParameter("@MouldTypeID", "10");
    //        SqlParameter sp10 = new SqlParameter("@Result", "");
    //        sp10.Size = 40;
    //        sp10.Direction = ParameterDirection.InputOutput;
    //        ParaList.Add(sp1);
    //        ParaList.Add(sp2);
    //        ParaList.Add(sp3);
    //        ParaList.Add(sp4);
    //        ParaList.Add(sp5);
    //        ParaList.Add(sp6);
    //        ParaList.Add(sp7);
    //        ParaList.Add(sp8);
    //        ParaList.Add(sp9);
    //        ParaList.Add(sp10);
    //        Console.WriteLine("a");
    //        //Assert.AreEqual("0", DMTester.StoreProcedure(ParaList, Procedurename));
    //    }

    //    [Test]
    //    public void TestScalar()
    //    {
    //        string sql="SELECT ISNULL(CAST(MAX('InStockID')+1"
    //            + " AS VARCHAR(13)), convert(varchar(10),getdate(),112)+'"
    //                + "1" + "'+'0001')"
    //                + "FROM tb_SM_TypeDetailInStock T1 "
    //                + "WHERE LEFT(InStockID,9)=convert(varchar(10),getdate(),112)+'"
    //                + "1" + "'";
    //        Console.Write(sql);
    //        Console.Write(DMTester.GetSclar(sql));
            
    //    }
    //}
}
