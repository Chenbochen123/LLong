using System;
using System.Collections.Generic;
using System.Text;
using System.Reflection;
using System.Configuration;
using System.IO;
using System.Data;
using System.Data.SqlClient;

namespace DataAccess
{
    /// <summary>
    /// 数据库工厂类
    /// </summary>
    /// <remarks>
    /// 使用该类的两个静态方法创建对数据库操作类对象
    /// </remarks>
    public class DbFactory
    {
       
        
        /// <summary>
        /// 
        /// </summary>
        /// <returns></returns>
        public static IAccessDB CreateDb()
        {
            Config.ConnDB ConnDB = new Config.ConnDB();
            string DbName = ConnDB.StrConn;
            IAccessDB db = (IAccessDB)Assembly.Load("DataAccess").CreateInstance("DataAccess." + DbName,true);
            return db;
        }
        
       /// <summary>
       /// 根据数据库类型不同，选择相对应的类
       /// </summary>
       /// <param name="dbType">数据库类型</param>
       /// <param name="strDbConn">连接方式</param>
       /// <returns></returns>
        public static IAccessDB CreateDb(string dbType, string strDbConn)
        {
            try
            {
                object[] args = new object[] { strDbConn };
                IAccessDB db = null;// 
                switch (dbType.ToString())
                {
                    case "SqlDB":
                        db = new SqlDB(strDbConn);
                        break;
                    case "OracleDB":
                        db = new OracleDB(strDbConn);
                        break;
                    case "AccessDB":
                        db = new AccessDB(strDbConn);
                        break;
                }
                return db;
            }
            catch (Exception e)
            {
                StreamWriter sw = File.AppendText(@"c:\myText.txt");
                sw.WriteLine(e.Message);
                sw.Flush();
                sw.Close();
                return null;
            }
        }
    }
}
