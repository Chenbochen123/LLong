using NUnit.Framework;

namespace Mesnac.Curing.NUTest
{
    [TestFixture]
    public class _Test
    {
        #region 系统日志  log
        private LogAgent.ILog log = LogAgent.Log.Instance;
        #endregion

        #region 内部变量
        #endregion

        #region 构造函数
        /// <summary>
        /// 测试类初始化
        /// 必须存在无参数构造函数，并且为public
        /// </summary>
        public _Test()
        {

        }
        #endregion

        #region 测试初始化
        [SetUp]
        public void TestInit()
        {

        }
        #endregion


        [Test]
        public void TestCase()
        {
            #region 单元测试
            #region 期望值 expected
            var expected = true;
            #endregion

            #region 初始化 actual
            var actual = expected;
            #endregion

            #region 执行
            var manager = new Mesnac.Interface.Business.Implements.PsbCustomerManager();
            manager.GetEntityList(1, new Mesnac.Interface.Entity.BasicEntity.PsbCustomer() { DeleteFlag = 0 }, "OBJID");

            if (false)
            {
                /*
                Mesnac.Interface.Webservice.MesInterface.MesMethod mesMethod = new Interface.Webservice.MesInterface.MesMethod();
                Interface.Webservice.MesInterface.DT_PlanDNsPlanDN PlanDN = new Interface.Webservice.MesInterface.DT_PlanDNsPlanDN();
                PlanDN.DNHeader = new Interface.Webservice.MesInterface.DT_PlanDNsPlanDNDNHeader()
                {
                    CustomerID = "1",
                    DocDate = "20150831",
                    Dummy1 = "Dummy1",
                    Dummy2 = "Dummy2",
                    Dummy3 = "Dummy3",
                    Dummy4 = "Dummy4",
                    SNNo = "1",
                    SRFlag = "1",
                };
                PlanDN.DNItem = new Interface.Webservice.MesInterface.DT_PlanDNsPlanDNDNItem[] { 
                    new Interface.Webservice.MesInterface.DT_PlanDNsPlanDNDNItem(){
                                    Batch = "1",
                                    Dummy1 = "Dummy1",
                                    Dummy2 = "Dummy2",
                                    Dummy3 = "Dummy3",
                                    Dummy4 = "Dummy4",
                                    LineItemNo = "1",
                                    MaterialCode = "1",
                                    Plant = "1",
                                    Qty = "1",
                                    StorageLoc = "1",
                                },
                                new Interface.Webservice.MesInterface.DT_PlanDNsPlanDNDNItem(){
                                    Batch = "2",
                                    Dummy1 = "Dummy1",
                                    Dummy2 = "Dummy2",
                                    Dummy3 = "Dummy3",
                                    Dummy4 = "Dummy4",
                                    LineItemNo = "2",
                                    MaterialCode = "2",
                                    Plant = "2",
                                    Qty = "2",
                                    StorageLoc = "2",
                                },
                };

                mesMethod.GetSapXmlData_PlanDN(PlanDN);
                */
            }


            #endregion

            #region 断言
            Assert.AreEqual(expected, actual, "错误时显示此信息");
            log.Debug("actual=" + actual.ToString());
            #endregion
            #endregion
        }
    }
}

