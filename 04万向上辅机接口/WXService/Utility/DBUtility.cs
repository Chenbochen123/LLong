using System;
using System.Collections.Generic;
using System.Text;

namespace Utility
{
    public class DBUtility
    {
        public static void Create
                    //连接动态传入
            string path = System.AppDomain.CurrentDomain.BaseDirectory;
            TXmlConfigHandler _config = new TXmlConfigHandler(path + "WebConfig.xml");
            string _ip = _config.ReadValue("IP");
            string _dbname = _config.ReadValue("DBName");
            string _user = _config.ReadValue("UserID");
            string _password = _config.ReadValue("Password");
            DBOperator = new DM(_ip, _user, _password, _dbname);

    }
}
