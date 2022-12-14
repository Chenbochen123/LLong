using System;
using System.Collections.Generic;
using System.Text;
using DBOperator;
using NUnit.Framework;
using System.Data;
using XMLHandler;
using System.Data.SqlClient;

namespace BaseService
{
    public class Base
    {
        private DataSet _mouldTypeList;
        public DataSet MouldTypeList
        {
            get
            {
                return _mouldTypeList;
            }
        }

        private DataSet _storeInTypeList;
        public DataSet StoreInTypeList
        {
            get
            {
                return _storeInTypeList;
            }
        }

        private DataSet _storeOutTypeList;
        public DataSet StoreOutTypeList
        {
            get
            {
                return _storeOutTypeList;
            }
        }

        private DataSet _shiftList;
        public DataSet ShiftList
        {
            get
            {
                return _shiftList;
            }
        }

        private DataSet _typeTypeList;
        public DataSet TypeTypeList
        {
            get
            {
                return _typeTypeList;
            }
        }

        private DataSet _standardSpecList;
        public DataSet StandardSpecList
        {
            get
            {
                return _standardSpecList;
            }
        }

        private DataSet _gradeList;
        public DataSet GradeList
        {
            get
            {
                return _gradeList;
            }
        }

        private DataSet _faultList;
        public DataSet FaultList
        {
            get
            {
                return _faultList;
            }
        }

        private DataSet _equipList;
        public DataSet EquipList
        {
            get
            {
                return _equipList;
            }
        }

        private DM _baseInfo;

        public Base()
        {
            string path = System.AppDomain.CurrentDomain.BaseDirectory; 
            TXmlConfigHandler _config = new TXmlConfigHandler(path + "WebConfig.xml");
            string _ip = _config.ReadValue("IP");
            string _dbname = _config.ReadValue("DBName");
            string _user = _config.ReadValue("UserID");
            string _password = _config.ReadValue("Password");
            _baseInfo = new DM(_ip, _user, _password, _dbname);
            CreateBaseInfos();
            GetBaseInfos();
        }

        public Base(string _ip, string _dbname, string _user, string _password)
        {
            _baseInfo = new DM(_ip, _user, _password, _dbname);
            CreateBaseInfos();
            GetBaseInfos();
        }

        private void CreateBaseInfos()
        {
            _mouldTypeList = new DataSet();
        }

        /// <summary>
        /// �����ݿ��ж�ȡ��������
        /// </summary>
        private void GetBaseInfos()
        {
            GetNonStandardMouldType();
            GetNonStandardStoreInType();
            GetNonStandardStoreOutType();
            GetTypeType();
            GetShift();
            GetGrade();
            GetFault();
            GetEquip();
            GetStandardSpec();
        }

        private void GetTypeType()
        {
            _typeTypeList = _baseInfo.ds("SELECT TYPETYPEID,TYPETYPENAME FROM TB_EQ_TYPETYPE"); 
        }

        /// <summary>
        /// ��ȡ�Ǳ�׼������
        /// </summary>
        private void GetNonStandardMouldType()
        {
            _mouldTypeList = _baseInfo.ds("SELECT MOULDTYPEID,MOULDTYPENAME,STANDARDFLAG FROM TB_EQ_MOULDTYPE WHERE STANDARDFLAG = '0'"); // AND OPERATIONTYPE = '1' ע�Ͳ���Ϊ�������ֿ���ķǱ�׼�����͡�
        }

        /// <summary>
        /// ��ȡ�Ǳ�׼���������
        /// </summary>
        private void GetNonStandardStoreInType()
        {
            _storeInTypeList = _baseInfo.ds("SELECT TYPEID,TYPENAME FROM TB_SM_INVENTORYTYPE WHERE STOREHOUSETYPEID = '01' AND OUTORIN = '0'");
        }

        /// <summary>
        /// ��ȡ�Ǳ�׼����������
        /// </summary>
        private void GetNonStandardStoreOutType()
        {
            _storeOutTypeList = _baseInfo.ds("SELECT * FROM TB_SM_INVENTORYTYPE WHERE OUTORIN = '1' AND STOREHOUSETYPEID = '01'");
        }

        /// <summary>
        /// ��ȡƷ����
        /// </summary>
        private void GetGrade()
        {
            _gradeList = _baseInfo.ds("SELECT WORKPROID, GRADEID, GRADENAME, HAVEFAULTS FROM TB_QU_GRADELIST");
        }

        /// <summary>
        /// ��ȡ����
        /// </summary>
        private void GetFault()
        {
            _faultList = _baseInfo.ds("SELECT WORKSEQ, FAULTID, FAULTCODE, FAULTNAME FROM TB_QU_FAULTS");
        }

        private void GetEquip()
        {
            _equipList = _baseInfo.ds("SELECT EQUIPID,EQUIPCODE FROM TB_EQ_EQUIPACOUNT WHERE USESTATE = '0' AND WORKINGPROCEDUREID = '30' AND ISHOST = '1'");
        }

        public void GetShift()
        {
            _shiftList = _baseInfo.ds("SELECT SHIFTID,SHIFTNAME FROM TB_HR_SHIFT");
        }

        public string FixedGroup(string _operatorCode)
        {
            return _baseInfo.ds("SELECT FIXEDGROUPID FROM TB_HR_EMPLOYEE WHERE EMPID = '" + _operatorCode + "'").Tables[0].Rows[0][0].ToString();
        }

        public string RunningGroup(string _operatorCode)
        {
            return _baseInfo.ds("SELECT RUNNINGGROUPID FROM TB_HR_EMPLOYEE WHERE EMPID = '" + _operatorCode + "'").Tables[0].Rows[0][0].ToString();
        }

        public string GetAttribute(string _locationID)
        {
            string result = _baseInfo.GetSclar("SELECT T1.STOCKATTRIBUTE FROM tb_SM_StoreExtentInfo T1 LEFT JOIN tb_SM_StoreLocationInfo T2 ON T1.EXTENTID = T2.EXTENTID WHERE T2.LOCATIONID = '" + _locationID + "'");
            if (result.Equals("1"))   //���ֻ������һ�� ����֤�����Ƿ�����
            {
                string amount = _baseInfo.GetSclar("SELECT STOCKAMOUNT FROM TB_SM_STORELOCATIONINFO WHERE LOCATIONID = '" + _locationID + "'");
                if (amount.Equals("0"))
                {
                    return "1";
                }
                else
                {
                    return "�˿�λ����";
                }

            }
            else
            {
                return result;
            }
        }

        public DataSet GetLocationMouldType(string _locationID)
        {
            return _baseInfo.ds("SELECT T3.MOULDTYPEID,T2.STANDARDMOULDSPECID FROM TB_SM_MATERIALTOSTORE T3 LEFT JOIN TB_SM_STORELOCATIONINFO T2 ON T3.EXTENTID=T2.EXTENTID WHERE LOCATIONID = '" + _locationID + "'");
        }

        public DataSet GetNonStandardLocationInfo(string _locationID)
        {
            return _baseInfo.ds("SELECT T1.MOULDID,T1.MOULDCODE,T1.MOULDTYPEID,T2.MOULDTYPENAME FROM V_EQ_NONSTANDARDMOULDINFO T1 LEFT JOIN TB_EQ_MOULDTYPE T2 ON T1.MOULDTYPEID = T2.MOULDTYPEID WHERE LOCATIONID = '" + _locationID + "' AND T1.USEABLESTATE = '01'");
        }

        /// <summary>
        /// ��ȡ��׼�����
        /// </summary>
        private void GetStandardSpec()
        {
            _standardSpecList = _baseInfo.ds("SELECT StandardMouldSpecID,StandardMouldSpecName,MOULDTYPEID FROM TB_EQ_STANDARDMOULDSPEC");
        }

    }

    [TestFixture]
    public class TestBase
    {
        private Base bi;

        public TestBase()
        {
            bi = new Base("172.16.194.99", "TMIS", "sa", "123");
        }

        [Test]
        public void TestMouldTypeList()
        {
            foreach (DataTable dt in bi.MouldTypeList.Tables)
                foreach (DataRow dr in dt.Rows)
                    Console.WriteLine(dr[0].ToString() + "\t" + dr[1].ToString() + "\t" + dr[2].ToString());
            Assert.AreEqual(8, bi.MouldTypeList.Tables[0].Rows.Count);
        }

        [Test]
        public void TestStoreInType()
        {
            foreach (DataTable dt in bi.StoreInTypeList.Tables)
                foreach (DataRow dr in dt.Rows)
                {
                    Console.WriteLine(dr[0].ToString() + "\t" + dr[1].ToString());
                }
            Assert.AreEqual(7, bi.MouldTypeList.Tables[0].Rows.Count);
        }

        [Test]
        public void TestTypeType()
        {
            foreach (DataTable dt in bi.TypeTypeList.Tables)
                foreach (DataRow dr in dt.Rows)
                {
                    Console.WriteLine(dr[0].ToString() + "\t" + dr[1].ToString());
                }
            Assert.AreEqual(9, bi.TypeTypeList.Tables[0].Rows.Count);
        }

        [Test]
        public void TestBeatRingSpec()
        {
            foreach (DataRow dr in bi.StandardSpecList.Tables[0].Rows)
            {
                Console.WriteLine(dr[0].ToString() + "\t" + dr[1].ToString());
            }
            Assert.AreEqual(3, bi.StandardSpecList.Tables[0].Rows.Count);
        }

    }
}
