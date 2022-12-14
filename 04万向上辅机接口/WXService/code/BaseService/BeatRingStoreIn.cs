using System;
using System.Collections.Generic;
using System.Text;
using DBOperator;
using XMLHandler;

namespace BeatRingStoreInService
{
    public class BeatRingStoreIn
    {
        DM BeatRingDBAdarpter;
        string _ip;
        string _dbname;
        string _user;
        string _password;

        public BeatRingStoreIn()
        {
            string path = System.AppDomain.CurrentDomain.BaseDirectory;
            TXmlConfigHandler _config = new TXmlConfigHandler(path + "WebConfig.xml");
            _ip = _config.ReadValue("IP");
            _dbname = _config.ReadValue("DBName");
            _user = _config.ReadValue("UserID");
            _password = _config.ReadValue("Password");
        }

        private bool CheckSameSpec(string _location, string _specID)
        {
            BeatRingDBAdarpter = new DM(_ip, _user, _password, _dbname);
            //选择该库位规格编号，同时判断是否为空库位
            string _specid = BeatRingDBAdarpter.GetSclar("SELECT STANDARDMOULDSPECID FROM TB_SM_STORELOCATIONINFO WHERE LOCATIONID='" + _location + "' AND STOCKAMOUNT = '0'");
            return (_specid==_specID);
        }

        public string BeatRingIn(string _location, string _specID, string _factoryID, string _operID, string _fixedGroupID, string _runningGroupID, string _shiftID)
        {
            if (CheckSameSpec(_location, _specID))
            {
                //获取钢圈ID，同时判断库外是否有没入库的
                string _beatRingID = GetBeatRingID(_specID, _factoryID);
                if (_beatRingID.Equals(""))
                {
                    return "库外已无钢圈,不允许入库";
                }
                else
                {
                    string result = ExecuteBeatRingIn(_beatRingID, _specID, _location, _operID, _fixedGroupID, _runningGroupID, _shiftID);
                    if (result.Equals("事务执行成功"))
                        return "入库成功";
                    else
                        return result;
                }
            }
            else
                return "规格与库位存储规格不符或库位中已存有钢圈";
        }

        private string GetBeatRingID(string _specID, string _factoryID)
        {
            BeatRingDBAdarpter = new DM(_ip, _user, _password, _dbname);
            //从台帐表获取钢圈编号
            return BeatRingDBAdarpter.GetSclar("SELECT BEATRINGID FROM TB_EQ_STANDARDBEATRING WHERE STANDARDMOULDSPECID = '" + _specID + "' AND FACTORYID = '" + _factoryID + "' AND OUTSTOCKAMOUNT >= 1");
        }

        private string ExecuteBeatRingIn(string _beatRingID, string _specID, string _location, string _operID, string _fixedGroupID, string _runningGroupID, string _shiftID)
        {
            BeatRingDBAdarpter = new DM(_ip, _user, _password, _dbname);
            string _inStockID = BeatRingDBAdarpter.GetSclar("SELECT ISNULL(convert(varchar(10),getdate(),112)+'1'+right('000'+CAST(MAX(right(InStockID,4))+1 AS VARCHAR(4)),4), convert(varchar(10),getdate(),112)+'1'+'0001') FROM tb_SM_StandardMouldInStock T1 WHERE LEFT(InStockID,9)=convert(varchar(10),getdate(),112)+'1'");
            BeatRingDBAdarpter.TransClear();
            BeatRingDBAdarpter.TransAdd("UPDATE TB_EQ_STANDARDBEATRING SET STOCKAMOUNT=STOCKAMOUNT+1,OUTSTOCKAMOUNT=OUTSTOCKAMOUNT-1 WHERE BEATRINGID = '" + _beatRingID + "'");
            BeatRingDBAdarpter.TransAdd("INSERT INTO TB_SM_STANDARDMOULDINSTOCK (INSTOCKID,MOULDTYPEID,STANDARDMOULDSPECID,INSTOCKAMOUNT,LOCATIONID,INSTOCKTIME,OPERATORID,FIXEDGROUPID,RUNNINGGROUPID,SHIFTID) VALUES ('"
            + _inStockID + "','03','"
            + _specID + "','1','"
            + _location + "',GETDATE(),'"
            + _operID + "','"
            + _fixedGroupID + "','"
            + _runningGroupID + "','"
            + _shiftID + "')");
            BeatRingDBAdarpter.TransAdd("UPDATE TB_SM_STORELOCATIONINFO SET STOCKAMOUNT=STOCKAMOUNT+1 WHERE LOCATIONID = '" + _location + "'");
            return BeatRingDBAdarpter.TransCommit();
        }
    }

   
}
