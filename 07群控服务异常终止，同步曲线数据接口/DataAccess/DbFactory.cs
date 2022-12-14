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
    /// ���ݿ⹤����
    /// </summary>
    /// <remarks>
    /// ʹ�ø����������̬�������������ݿ���������
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
       /// �������ݿ����Ͳ�ͬ��ѡ�����Ӧ����
       /// </summary>
       /// <param name="dbType">���ݿ�����</param>
       /// <param name="strDbConn">���ӷ�ʽ</param>
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
