using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Services;

namespace Mesnac.Interface.Webservice
{
    /// <summary>
    /// WebService1 的摘要说明
    /// </summary>
    [WebService(Namespace = "http://tempuri.org/")]
    [WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
    [System.ComponentModel.ToolboxItem(false)]
    // 若要允许使用 ASP.NET AJAX 从脚本中调用此 Web 服务，请取消注释以下行。 
    // [System.Web.Script.Services.ScriptService]
    public class WebService1 : System.Web.Services.WebService
    {

        [WebMethod]
        public string HelloWorld()
        {
            return new MesInterface.MesMethod().Get() + "2";
            var manager = new Mesnac.Interface.Business.Implements.PsbCustomerManager();
            return manager.GetEntityList(1, new Entity.BasicEntity.PsbCustomer() { DeleteFlag = 0 }, "OBJID").Count.ToString();

            LogAgent.Log.Instance.Debug("Test");
            return "Hello World";
        }

        [WebMethod]
        public string TestReturnMSG()
        {
            MesInterface.MesMethod mesMethod = new MesInterface.MesMethod();
            MesInterface.MT_ReturnMSGsReturnMSG ReturnMSG = new MesInterface.MT_ReturnMSGsReturnMSG();
            ReturnMSG.MSGHead = new MesInterface.MT_ReturnMSGsReturnMSGMSGHead()
            {
                BUSID = "41",
                BUSTYP = "2001",
            };
            ReturnMSG.MSGItem = new MesInterface.MT_ReturnMSGsReturnMSGMSGItem[] { 
                new MesInterface.MT_ReturnMSGsReturnMSGMSGItem(){
                    MSTYP = "E",
                    ERRDES= "Test",
                }
            };
            mesMethod.GetSapMSG(ReturnMSG);

            return "";
        }

        [WebMethod(Description = "测试调拨单下传")]
        public string TestReservations_Transfer()
        {
            Mesnac.Interface.Webservice.MesInterface.MesMethod mesMethod = new Interface.Webservice.MesInterface.MesMethod();
            Interface.Webservice.MesInterface.MT_DZECC_outReservation[] Reservations = new Interface.Webservice.MesInterface.MT_DZECC_outReservation[] { 
                new Interface.Webservice.MesInterface.MT_DZECC_outReservation(){
                    Batch = "A",
                    CostCenter = "",
                    DemondsDate = "20150911",
                    Department = "",
                    Dummy1 = "",
                    Dummy2 = "",
                    Dummy3 = "",
                    Dummy4 = "",
                    MatCode = "211002781",
                    MovType = "311",
                    Order = "",
                    PlantFrom = "",
                    PlantTo = "",
                    Qty = "15.000",
                    ReserItem = "0000010",
                    ReserNo = "8170987",
                    StorLocFrom = "8005",
                    StorLocTo = "6021",
                    Unit = "",
                },
                new Interface.Webservice.MesInterface.MT_DZECC_outReservation(){
                    Batch = "A",
                    CostCenter = "",
                    DemondsDate = "20150911",
                    Department = "",
                    Dummy1 = "",
                    Dummy2 = "",
                    Dummy3 = "",
                    Dummy4 = "",
                    MatCode = "211002946",
                    MovType = "311",
                    Order = "",
                    PlantFrom = "",
                    PlantTo = "",
                    Qty = "10.000",
                    ReserItem = "0000030",
                    ReserNo = "8170987",
                    StorLocFrom = "8005",
                    StorLocTo = "8007",
                    Unit = "",
                },
            };

            new Mesnac.Interface.Webservice.MesWebservice.DZMesWebservice().GetSapXmlData("Y", null, Reservations, null, null, null);

            //mesMethod.GetSapXmlData_Reservations(Reservations);

            return "";
        }

        [WebMethod]
        public string TestPlanDNs()
        {
            Mesnac.Interface.Webservice.MesInterface.MesMethod mesMethod = new Interface.Webservice.MesInterface.MesMethod();
            Interface.Webservice.MesInterface.MT_DZECC_outPlanDN PlanDN = new Interface.Webservice.MesInterface.MT_DZECC_outPlanDN();
            PlanDN.DNHeader = new MesInterface.MT_DZECC_outPlanDNDNHeader[]{
                new Interface.Webservice.MesInterface.MT_DZECC_outPlanDNDNHeader()
                {
                    CustomerID = "0000010253",
                    DocDate = "20150831",
                    Dummy1 = "Dummy1",
                    Dummy2 = "Dummy2",
                    Dummy3 = "Dummy3",
                    Dummy4 = "Dummy4",
                    SNNo = "1",
                    SRFlag = " ",
                }
            };
            PlanDN.DNItem = new Interface.Webservice.MesInterface.MT_DZECC_outPlanDNDNItem[] { 
                    new Interface.Webservice.MesInterface.MT_DZECC_outPlanDNDNItem(){
                                    Batch = "A",
                                    Dummy1 = "Dummy1",
                                    Dummy2 = "Dummy2",
                                    Dummy3 = "Dummy3",
                                    Dummy4 = "Dummy4",
                                    LineItemNo = "1",
                                    MaterialCode = "211002337",
                                    Plant = "1",
                                    Qty = "12.00",
                                    StorageLoc = "8000",
                                },
                                new Interface.Webservice.MesInterface.MT_DZECC_outPlanDNDNItem(){
                                    Batch = "B",
                                    Dummy1 = "Dummy1",
                                    Dummy2 = "Dummy2",
                                    Dummy3 = "Dummy3",
                                    Dummy4 = "Dummy4",
                                    LineItemNo = "2",
                                    MaterialCode = "211002319",
                                    Plant = "2",
                                    Qty = "24.000",
                                    StorageLoc = "8007",
                                },
                };

            mesMethod.GetSapXmlData_PlanDNs(new Interface.Webservice.MesInterface.MT_DZECC_outPlanDN[] { PlanDN });


            return "";
        }

        [WebMethod]
        public string Test3()
        {
            MesWebservice.SDWebservice.TransferData td = new MesWebservice.SDWebservice.TransferData();
            MesWebservice.SDWebservice.TransferDataHeader header = new MesWebservice.SDWebservice.TransferDataHeader();
            MesWebservice.SDWebservice.TransferDataItems[] items = new MesWebservice.SDWebservice.TransferDataItems[2];
            for (int i = 0; i < 2; i++)
            {
                items[i] = new MesWebservice.SDWebservice.TransferDataItems();
            }
            items[0].Barcodes = "12321321321*34342432*1242132121*2123213214*";
            items[0].Batch = "A";
            items[0].LineItemNo = "000001";
            items[0].MaterialCode = "211003518";
            items[0].Plant = "8002";
            items[0].Qty = "4";
            items[0].StorageLoc = "8005";
            items[1].Barcodes = "987070797*5646363*436345435*2325325235*646464564";
            items[1].Batch = "1704A";
            items[1].LineItemNo = "000002";
            items[1].MaterialCode = "2110035";
            items[1].Plant = "8003";
            items[1].Qty = "5";
            items[1].StorageLoc = "8004";
            header.CustomerID = "42142142";
            header.DocDate = DateTime.Now.ToString("yyyyMMdd");
            header.SNNo = "4444444";
            header.SRFlag = "";
            td.Header = header;
            td.Items = items;
            MesWebservice.SDWebservice sw = new MesWebservice.SDWebservice();

            return sw.GetSapTransferDetailData(td);
        }
    }
}
