using System;
using System.Collections.Generic;
//using System.Linq;
using System.Text;

using System.Configuration;

namespace DataAccess.Config
{
    /// <summary>
    /// 
    /// </summary>
    public class ConnDB
    {
        private static string strConn = "";
        private static string strType="";
        private static object obj = new object();

        /// <summary>
        /// 
        /// </summary>
        public ConnDB()
        {
            try
            {
                strConn = ConfigurationManager.AppSettings["strDbCon"].ToString();
                strType = ConfigurationManager.AppSettings["dbType"].ToString();
            }
            catch
            {
            }
        }

        /// <summary>
        /// 
        /// </summary>
        public string StrConn
        {
            get
            {
                lock (obj)
                {
                    return strConn;
                }
            }
            set
            {
                lock (obj)
                {
                    strConn = value;
                    saveConfig("connstr", strConn);
                }
            }
        }

        public string StrType
        {
            get
            {
                lock (obj)
                {
                    return strType;
                }
            }
            set
            {
                lock (obj)
                {
                    strConn = value;
                    saveConfig("dbType", strType);
                }
            }
        }

        #region 修改配置文件中的键值

        private void saveConfig(string key, string value)
        {
            try
            {
                Configuration config = ConfigurationManager.OpenExeConfiguration(ConfigurationUserLevel.None);
                config.AppSettings.Settings[key].Value = value;
                config.Save(ConfigurationSaveMode.Modified);
            }
            catch
            {
            }
        }

        #endregion

    }
}
