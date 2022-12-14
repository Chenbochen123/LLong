using System;
using System.Collections.Generic;
using System.Text;
using DBOperator;
using XMLHandler;

namespace StandardStoreInService
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
            //ѡ��ÿ�λ����ţ�ͬʱ�ж��Ƿ�Ϊ�տ�λ
            string _specid = BeatRingDBAdarpter.GetSclar("SELECT STANDARDMOULDSPECID FROM TB_SM_STORELOCATIONINFO WHERE LOCATIONID='" + _location + "' AND STOCKAMOUNT = '0'");
            return (_specid==_specID);
        }

        public string BeatRingIn(string _location, string _specID, string _factoryID, string _operID, string _fixedGroupID, string _runningGroupID, string _shiftID)
        {
            if (CheckSameSpec(_location, _specID))
            {
                //��ȡ��ȦID��ͬʱ�жϿ����Ƿ���û����
                string _beatRingID = GetBeatRingID(_specID, _factoryID);
                if (_beatRingID.Equals(""))
                {
                    return "�������޸�Ȧ,���������";
                }
                else
                {
                    string result = ExecuteBeatRingIn(_beatRingID, _specID, _location, _operID, _fixedGroupID, _runningGroupID, _shiftID, _factoryID);
                    if (result.Equals("����ִ�гɹ�"))
                        return "���ɹ�";
                    else
                        return result;
                }
            }
            else
                return "������λ�洢��񲻷����λ���Ѵ��и�Ȧ";
        }

        private string GetBeatRingID(string _specID, string _factoryID)
        {
            BeatRingDBAdarpter = new DM(_ip, _user, _password, _dbname);
            //��̨�ʱ��ȡ��Ȧ���
            return BeatRingDBAdarpter.GetSclar("SELECT BEATRINGID FROM TB_EQ_STANDARDBEATRING WHERE STANDARDMOULDSPECID = '" + _specID + "' AND FACTORYID = '" + _factoryID + "' AND OUTSTOCKAMOUNT >= 1");
        }

        private string ExecuteBeatRingIn(string _beatRingID, string _specID, string _location, string _operID, string _fixedGroupID, string _runningGroupID, string _shiftID,string _factoryID)
        {
            BeatRingDBAdarpter = new DM(_ip, _user, _password, _dbname);
            string _inStockID = BeatRingDBAdarpter.GetSclar("SELECT ISNULL(convert(varchar(10),getdate(),112)+'" + _factoryID + "'+right('000'+CAST(MAX(right(InStockID,4))+1 AS VARCHAR(4)),4), convert(varchar(10),getdate(),112)+'" + _factoryID + "'+'0001') FROM tb_SM_StandardMouldInStock T1 WHERE LEFT(InStockID,9)=convert(varchar(10),getdate(),112)+'" + _factoryID + "'");
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

    public class OtherStoreIn
    {
        DM OtherDBAdarpter;
        string _ip;
        string _dbname;
        string _user;
        string _password;

        public OtherStoreIn()
        {
            string path = System.AppDomain.CurrentDomain.BaseDirectory;
            TXmlConfigHandler _config = new TXmlConfigHandler(path + "WebConfig.xml");
            _ip = _config.ReadValue("IP");
            _dbname = _config.ReadValue("DBName");
            _user = _config.ReadValue("UserID");
            _password = _config.ReadValue("Password");
        }

        /// <summary>
        /// ����λ����Ƿ�Ϊ��ѡ���
        /// </summary>
        /// <param name="_locationID"></param>
        /// <param name="_specID"></param>
        /// <returns></returns>
        private bool CheckSpec(string _locationID, string _specID)
        {
            OtherDBAdarpter = new DM(_ip, _user, _password, _dbname);
            string spec = OtherDBAdarpter.GetDBValue("tb_SM_StoreLocationInfo", "LocationID", _locationID, "StandardMouldSpecID");
            return spec.Equals(_specID);
        }

        public string OtherIn(string _mouldType, string _specID, int _amount, string _location, string _operID, string _fixedGroupID, string _runningGroupID, string _shiftID, string _factory)
        {
            if (CheckSpec(_location, _specID))
            {
                OtherDBAdarpter = new DM(_ip, _user, _password, _dbname);
                string _inStockID = OtherDBAdarpter.GetSclar("SELECT ISNULL(convert(varchar(10),getdate(),112)+'" + _factory + "'+right('000'+CAST(MAX(right(InStockID,4))+1 AS VARCHAR(4)),4), convert(varchar(10),getdate(),112)+'" + _factory + "'+'0001') FROM tb_SM_StandardMouldInStock T1 WHERE LEFT(InStockID,9)=convert(varchar(10),getdate(),112)+'" + _factory + "'");
                OtherDBAdarpter.TransClear();
                string sql = "INSERT INTO TB_SM_STANDARDMOULDINSTOCK (INSTOCKID,MOULDTYPEID,STANDARDMOULDSPECID,INSTOCKAMOUNT,LOCATIONID,INSTOCKTIME,OPERATORID,FIXEDGROUPID,RUNNINGGROUPID,SHIFTID) VALUES ('"
            + _inStockID + "','" + _mouldType + "','"
            + _specID + "','" + _amount.ToString() + "','"
            + _location + "',GETDATE(),'"
            + _operID + "','"
            + _fixedGroupID + "','"
            + _runningGroupID + "','"
            + _shiftID + "')";
                OtherDBAdarpter.TransAdd(sql);
                sql = "UPDATE TB_SM_STORELOCATIONINFO SET STOCKAMOUNT=STOCKAMOUNT+" + _amount.ToString() + " WHERE LOCATIONID = '" + _location + "'";
                OtherDBAdarpter.TransAdd(sql);
                string result = OtherDBAdarpter.TransCommit();
                if (result.Equals("����ִ�гɹ�"))
                    return "���ɹ�";
                else
                    return result;
            }
            else
            {
                return "��񲻷�,���������";
            }
        }
    }
}
