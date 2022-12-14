using System;
using System.Collections.Generic;
using System.Text;
using System.Reflection;
using System.Data;

using Mesnac.Utilities;
using DBOperator;

namespace Purview
{
    public class Purview
    {
        DM _dm;
        //public Purview()
        //{
        //    //连接动态传入
        //    string path = System.AppDomain.CurrentDomain.BaseDirectory;
        //    TXmlConfigHandler _config = new TXmlConfigHandler(path + "WebConfig.xml");
        //    string _ip = _config.ReadValue("IP");
        //    string _dbname = _config.ReadValue("DBName");
        //    string _user = _config.ReadValue("UserID");
        //    string _password = _config.ReadValue("Password");
        //    DBOperator = new DM(_ip, _user, _password, _dbname);
        //}

        public Purview(string _ip, string _user, string _password, string _dbname)
        {
            _dm = new DM(_ip, _user, _password, _dbname);
        }

        public Purview(DM dm)
        {
            _dm = dm;
        }

        public DM _DM
        {
            get
            {
                return _dm;
            }
        }

        private string GetEmployeeID(string _userID)
        {
            return _dm.GetDBValue("Sys_user", "USER_ID", _userID, "Worker_barcode");
        }

        public string GetUserName(string _userID)
        {
            return _dm.GetDBValue("Sys_user", "USER_ID", _userID, "USER_NAME");
        }

        public bool GetPassword(string _userID, string _password)
        {
            //string _employee = GetEmployeeID(_userID);
            //string GetPasswd = DBOperator.GetDBValue("Sys_User", "Worker_barcode", _employee, "PASSWORD");
            //if (GetPasswd == _password)
            //{
            //    return _employee;  //如果密码正确 返回员工EMPID
            //}
            //else
            //{
            //    return "FALSE";
            //}

            string GetPasswd = _dm.GetDBValue("BasUser", "HRCode", _userID, "UserPWD");
            if (Encrypt.EncryptionEngine(GetPasswd, "", false) == _password)
            {
                return true;  //密码正确
            }

            return false;
        }
        /// <summary>
        ///  密码修改
        /// </summary>
        /// <param name="_userID"></param>
        /// <param name="_Oldpassword"></param>
        /// <param name="_Newpassword"></param>
        /// <returns>-1:原密码不正确 0:修改失败 1:修改成功 其他:修改失败</returns>
        public int UpdatePass(string _userID, string _Oldpassword, string _Newpassword)
        {
            string GetPasswd = _dm.GetDBValue("BasUser", "HRCode", _userID, "UserPWD");
            if (Encrypt.EncryptionEngine(GetPasswd, "", false) != _Oldpassword)
            {
                return -1;  //密码正确
            }

            return _dm.ExecuteSql("Update BasUser set UserPWD='" + Encrypt.EncryptionEngine(_Newpassword, "", true) + "'  where HRCode='" + _userID + "' ");

        }

        public bool GetRight1(string _userID, string _windowName, string _functionID)
        {
            if (_dm.ds("SELECT t1.PURVIEWPOSTID FROM Tb_SY_CEPOSTPURVIEW t1 WHERE " +
                "t1.WINDOWNAME='" + _windowName + "' AND t1.FUNCTIONID='" + _functionID + "' AND " +
                "EXISTS (SELECT * FROM TB_SY_CEUSERPOST t2 WHERE t2.USERID='" + _userID + "' AND t2.PURVIEWPOSTID=t1.PURVIEWPOSTID)").Tables[0].Rows.Count > 0)
                return true;
            else
                return false;
        }

        public string GetServerTime()
        {
            return _dm.GetSclar("SELECT GETDATE()");
        }

//        public bool HasMenuRight(string userCode, string menuLevel)
//        {
//            string sql = @"SELECT COUNT(*)
//                            FROM dbo.SysUserAllAction t1
//                            INNER JOIN dbo.SysPageAction t2 ON t1.ActionID = t2.ObjID
//                            inner join SysPageMenu t3 on t3.ObjID = t2.PageMenuID
//                            WHERE t1.UserCode = '" + userCode + @"'
//                            and t3.MenuLevel = '" + menuLevel + @"'
//                            and t2.DeleteFlag = '0'
//                            and t3.DeleteFlag = '0'";
//            if (_dm.GetSclar(sql) == "0")
//            {
//                return false;
//            }
//            return true;
//        }

        public DataSet GetMenuRight(string userCode)
        {
            string sql = @"SELECT distinct MenuLevel
                            FROM dbo.SysUserAllAction t1
                            INNER JOIN dbo.SysPageAction t2 ON t1.ActionID = t2.ObjID
                            inner join SysPageMenu t3 on t3.ObjID = t2.PageMenuID
                            WHERE t3.MenuLevel like '90%'
                            and t2.DeleteFlag = '0'
                            and t3.DeleteFlag = '0'
                            and t1.UserCode = '" + userCode + "'";
            return _dm.ds(sql);
        }
    }

}
