using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Services;
using System.Text.RegularExpressions;

namespace Mesnac.Interface.Webservice.MesWebservice
{
    using Mesnac.Interface.Webservice.MesInterface;
    using Mesnac.Interface.Business.Implements;
    using Mesnac.Interface.Business.Interface;
    using Mesnac.Interface.Entity.BasicEntity;
    using Mesnac.Interface.Webservice.SapInterface;
    /// <summary>
    /// SDWebservice 的摘要说明
    /// </summary>
    [WebService(Namespace = "http://tempuri.org/")]
    [WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
    [System.ComponentModel.ToolboxItem(false)]
    // 若要允许使用 ASP.NET AJAX 从脚本中调用此 Web 服务，请取消注释以下行。 
    // [System.Web.Script.Services.ScriptService]
    public class SDWebservice : System.Web.Services.WebService
    {
        private LogAgent.ILog log = LogAgent.Log.Instance;
        System.Net.NetworkCredential credential = new System.Net.NetworkCredential("rfc_admin", "net_159357");
        #region SAP调用，传递中转库发货明细的方法

        [WebMethod(Description = "中转库山大App调用，传递中转库发货明细的方法")]
        public string GetSapTransferDetailData(TransferData td)
        {
            IPsmOutStockBillManager billManager = new PsmOutStockBillManager();
            IPsmOutStockMainManager mainManager = new PsmOutStockMainManager();
            IPsmOutStockDetailManager detailManager = new PsmOutStockDetailManager();
            ISiiSapLogManager logManager = new SiiSapLogManager();
            try
            {
                #region 数据校验
                DateTime dt = new DateTime();
                if (string.IsNullOrWhiteSpace(td.Header.SNNo))
                {
                    return "发货单号SNNo不能为空！";
                }
                if (string.IsNullOrWhiteSpace(td.Header.CustomerID))
                {
                    return "客户编码CustomerID不能为空！";
                }
                if (!Regex.IsMatch(td.Header.DocDate, "^(?<year>\\d{2,4})(?<month>\\d{1,2})(?<day>\\d{1,2})$"))
                {
                    return "凭证日期DocDate格式不正确！";
                }

                foreach (TransferDataItems tdi in td.Items)
                {
                    if (string.IsNullOrWhiteSpace(tdi.LineItemNo))
                    {
                        return "行项目编号不能为空！";
                    }
                    if (string.IsNullOrWhiteSpace(tdi.MaterialCode))
                    {
                        return "物料号不能为空！";
                    }
                    if (string.IsNullOrWhiteSpace(tdi.Plant))
                    {
                        return "工厂不能为空！";
                    }
                    if (string.IsNullOrWhiteSpace(tdi.StorageLoc))
                    {
                        return "库位不能为空！";
                    }
                    if (string.IsNullOrWhiteSpace(tdi.Qty))
                    {
                        return "发货数量不能为空！";
                    }
                }
                #endregion

                #region 数据处理
                if (string.IsNullOrWhiteSpace(td.Header.SRFlag))
                {
                    PsmOutStockBill bill = new PsmOutStockBill();
                    IList<PsmOutStockBill> lst = billManager.GetEntityList(new PsmOutStockBill { SNNo = td.Header.SNNo, DeleteFlag = 0 });
                    if (lst != null && lst.Count > 0) //更新
                    {
                        string billId = lst[0].ObjId.ToString();
                        bill.AffirmTime = DateTime.Now;
                        bill.BillState = 1;
                        bill.OutDate = DateTime.Now.Date;
                        bill.UpdateTime = DateTime.Now;
                        billManager.Update(bill, new PsmOutStockBill { ObjId = lst[0].ObjId });

                        foreach (TransferDataItems tdi in td.Items)
                        {
                            string mainId = "0";
                            IList<PsmOutStockMain> mainLst = mainManager.GetEntityList(new PsmOutStockMain { BillId = int.Parse(billId), DeleteFlag = 0, LineItemNo = tdi.LineItemNo });
                            if (mainLst != null && mainLst.Count > 0)
                            {
                                PsmOutStockMain main = new PsmOutStockMain();
                                main.AffirmTime = DateTime.Now;
                                main.MainState = 1;
                                int tmp = 0;
                                int.TryParse(tdi.Qty, out tmp);
                                main.OutAmount = tmp + (string.IsNullOrWhiteSpace(main.OutAmount.ToString()) ? 0 : main.OutAmount);
                                main.UpdateTime = DateTime.Now;
                                mainManager.Update(main, new PsmOutStockMain { ObjId = mainLst[0].ObjId });
                                mainId = mainLst[0].ObjId.ToString();
                            }
                            else
                            {
                                PsmOutStockMain main = new PsmOutStockMain();
                                main.AffirmTime = DateTime.Now;
                                main.Batch = tdi.Batch;
                                main.BillId = int.Parse(billId);
                                main.CheckGradeCode = 1;
                                main.DeleteFlag = 0;
                                main.LineItemNo = tdi.LineItemNo;
                                main.MainState = 1;
                                main.MaterialCode = tdi.MaterialCode;
                                main.MaterialId = GetMaterialID(tdi.MaterialCode);
                                int tmp = 0;
                                int.TryParse(tdi.Qty, out tmp);
                                main.OutAmount = tmp;
                                main.PlanAmount = tmp;
                                main.Plant = tdi.Plant;
                                main.Qty = tmp.ToString();
                                main.RecordTime = DateTime.Now;
                                main.StorageLoc = tdi.StorageLoc;
                                main.UpdateTime = DateTime.Now;
                                main.Dummy1 = "中转库添加";
                                mainManager.Insert(main);
                                IList<PsmOutStockMain> mainObjLst = mainManager.GetEntityList(new PsmOutStockMain { BillId = int.Parse(billId), DeleteFlag = 0, LineItemNo = tdi.LineItemNo });
                                if (mainObjLst != null && mainObjLst.Count > 0)
                                {
                                    mainId = mainObjLst[0].ObjId.ToString();
                                }
                            }
                            string[] barcode = tdi.Barcodes.Split('*');
                            foreach (string b in barcode)
                            {
                                if (b.Length > 0)
                                {
                                    PsmOutStockDetail detail = new PsmOutStockDetail();
                                    detail.BillId = int.Parse(billId);
                                    detail.CheckGradeCode = 1;
                                    detail.DeleteFlag = 0;
                                    detail.DetailState = 1;
                                    detail.MainId = int.Parse(mainId);
                                    detail.RecordTime = DateTime.Now;
                                    detail.TyreNo = b;
                                    detail.UpdateTime = DateTime.Now;
                                    detail.DetailBatch = DateTime.Now.ToString("yyMM");
                                    detail.Remark = "中转库上传";
                                    Dictionary<string, object> insertDic = new Dictionary<string, object>();
                                    insertDic.Add("BillId", detail.BillId);
                                    insertDic.Add("CheckGradeCode", detail.CheckGradeCode);
                                    insertDic.Add("DeleteFlag", detail.DeleteFlag);
                                    insertDic.Add("DetailState", detail.DetailState);
                                    insertDic.Add("MainId", detail.MainId);
                                    insertDic.Add("RecordTime", detail.RecordTime);
                                    insertDic.Add("TyreNo", detail.TyreNo);
                                    insertDic.Add("UpdateTime", detail.UpdateTime);
                                    insertDic.Add("DetailBatch", detail.DetailBatch);
                                    insertDic.Add("Remark", detail.Remark);
                                    detailManager.InsertByStatement("InsertOutStockDetail", insertDic);
                                }
                            }
                        }
                    }
                    else //插入
                    {
                        string CustomerObjid = "0";
                        IList<PsbCustomer> lstCustomer = GetCustomerList(new PsbCustomer()
                        {
                            DeleteFlag = 0,
                            CustomerId = td.Header.CustomerID,
                        }, "");
                        if (lstCustomer.Count == 1)
                        {
                            CustomerObjid = lstCustomer[0].ObjId.ToString();
                        }
                        bill.BillState = 1;
                        bill.CustomerId = td.Header.CustomerID;
                        bill.CustomerObjid = int.Parse(CustomerObjid);
                        bill.DeleteFlag = 0;
                        bill.DocDate = td.Header.DocDate;
                        bill.OutDate = DateTime.Now.Date;
                        bill.RecordTime = DateTime.Now;
                        bill.RecordUserId = 1;
                        bill.Remark = "中转库发送";
                        bill.SNNo = td.Header.SNNo;
                        bill.SRFlag = td.Header.SRFlag;
                        bill.UpdateTime = DateTime.Now;
                        billManager.Insert(bill);
                        string billId = "0";
                        IList<PsmOutStockBill> objLst = billManager.GetEntityList(new PsmOutStockBill { SNNo = td.Header.SNNo, DeleteFlag = 0 });
                        if (objLst != null && objLst.Count > 0)
                        {
                            billId = objLst[0].ObjId.ToString();
                        }
                        foreach (TransferDataItems tdi in td.Items)
                        {
                            string mainId = "0";
                            IList<PsmOutStockMain> mainLst = mainManager.GetEntityList(new PsmOutStockMain { BillId = int.Parse(billId), DeleteFlag = 0, LineItemNo = tdi.LineItemNo });
                            if (mainLst != null && mainLst.Count > 0)
                            {
                                PsmOutStockMain main = new PsmOutStockMain();
                                main.AffirmTime = DateTime.Now;
                                main.MainState = 1;
                                int tmp = 0;
                                int.TryParse(tdi.Qty, out tmp);
                                main.OutAmount = tmp + (string.IsNullOrWhiteSpace(main.OutAmount.ToString()) ? 0 : main.OutAmount);
                                main.UpdateTime = DateTime.Now;
                                mainManager.Update(main, new PsmOutStockMain { ObjId = mainLst[0].ObjId });
                                mainId = mainLst[0].ObjId.ToString();
                            }
                            else
                            {
                                PsmOutStockMain main = new PsmOutStockMain();
                                main.AffirmTime = DateTime.Now;
                                main.Batch = tdi.Batch;
                                main.BillId = int.Parse(billId);
                                main.CheckGradeCode = 1;
                                main.DeleteFlag = 0;
                                main.LineItemNo = tdi.LineItemNo;
                                main.MainState = 1;
                                main.MaterialCode = tdi.MaterialCode;
                                main.MaterialId = GetMaterialID(tdi.MaterialCode);
                                int tmp = 0;
                                int.TryParse(tdi.Qty, out tmp);
                                main.OutAmount = tmp;
                                main.PlanAmount = tmp;
                                main.Plant = tdi.Plant;
                                main.Qty = tmp.ToString();
                                main.RecordTime = DateTime.Now;
                                main.StorageLoc = tdi.StorageLoc;
                                main.UpdateTime = DateTime.Now;
                                main.Dummy1 = "中转库添加";
                                mainManager.Insert(main);
                                IList<PsmOutStockMain> mainObjLst = mainManager.GetEntityList(new PsmOutStockMain { BillId = int.Parse(billId), DeleteFlag = 0, LineItemNo = tdi.LineItemNo });
                                if (mainObjLst != null && mainObjLst.Count > 0)
                                {
                                    mainId = mainObjLst[0].ObjId.ToString();
                                }
                            }
                            string[] barcode = tdi.Barcodes.Split('*');
                            foreach (string b in barcode)
                            {
                                if (b.Length > 0)
                                {
                                    PsmOutStockDetail detail = new PsmOutStockDetail();
                                    detail.BillId = int.Parse(billId);
                                    detail.CheckGradeCode = 1;
                                    detail.DeleteFlag = 0;
                                    detail.DetailState = 1;
                                    detail.MainId = int.Parse(mainId);
                                    detail.RecordTime = DateTime.Now;
                                    detail.TyreNo = b;
                                    detail.UpdateTime = DateTime.Now;
                                    detail.DetailBatch = DateTime.Now.ToString("yyMM");
                                    detail.Remark = "中转库出库";
                                    Dictionary<string, object> insertDic = new Dictionary<string, object>();
                                    insertDic.Add("BillId", detail.BillId);
                                    insertDic.Add("CheckGradeCode", detail.CheckGradeCode);
                                    insertDic.Add("DeleteFlag", detail.DeleteFlag);
                                    insertDic.Add("DetailState", detail.DetailState);
                                    insertDic.Add("MainId", detail.MainId);
                                    insertDic.Add("RecordTime", detail.RecordTime);
                                    insertDic.Add("TyreNo", detail.TyreNo);
                                    insertDic.Add("UpdateTime", detail.UpdateTime);
                                    insertDic.Add("DetailBatch", detail.DetailBatch);
                                    insertDic.Add("Remark", detail.Remark);
                                    detailManager.InsertByStatement("InsertOutStockDetail", insertDic);
                                }
                            }
                        }
                    }
                }
                else if (td.Header.SRFlag.ToUpper().Trim() == "X")
                {
                    PsmOutStockBill bill = new PsmOutStockBill();
                    IList<PsmOutStockBill> lst = billManager.GetEntityList(new PsmOutStockBill { SNNo = td.Header.SNNo, DeleteFlag = 0 });
                    int billId = 0;
                    if (lst != null && lst.Count > 0)
                    {
                        billId = (int)lst[0].ObjId;
                        foreach(TransferDataItems t in td.Items)
                        {
                            IList<PsmOutStockMain> mainLst = mainManager.GetEntityList(new PsmOutStockMain { DeleteFlag = 0, BillId = billId, LineItemNo = t.LineItemNo });
                            if (mainLst != null && mainLst.Count > 0)
                            {
                                PsmOutStockMain main = new PsmOutStockMain();
                                int tmp = 0;
                                int.TryParse(t.Qty, out tmp);
                                main.OutAmount -= tmp;
                                string[] barcode = t.Barcodes.Split('*');
                                foreach (string b in barcode)
                                {
                                    PsmOutStockDetail detail = new PsmOutStockDetail();
                                    detail.DeleteFlag = 1;
                                    detailManager.Update(detail, new PsmOutStockDetail { DeleteFlag = 0, TyreNo = b });
                                }
                            }
                        }
                    }
                }
                #endregion

                #region 上传到SAP
                try
                {
                    Submit_RealDNs(td);

                    SiiSapLog log = new SiiSapLog();
                    log.DeleteFlag = 0;
                    log.MethodName = "中转库上传,上传SAP成功";
                    logManager.Insert(log);
                }
                catch(Exception ex)
                {

                }
                #endregion

                #region 记录日志
                foreach (TransferDataItems t in td.Items)
                {
                    try
                    {
                        SiiSapLog log = new SiiSapLog();
                        log.DeleteFlag = 0;
                        log.MethodName = "中转库上传";
                        log.MethodMemo = td.Header.SNNo + ":" + t.LineItemNo + ":" + t.MaterialCode;
                        log.MethodContent = t.Barcodes;
                        logManager.Insert(log);
                    }
                    catch(Exception ex)
                    { }
                }
                #endregion

                return "Success";
            }
            catch(Exception ex)
            {
                return ex.Message;
            }
        }

        private int? GetMaterialID(string p)
        {
            ISbmMaterialManager manager = new SbmMaterialManager();
            IList<SbmMaterial> lst = manager.GetEntityList(new SbmMaterial { DeleteFlag = 0, SapCode = p });
            if (lst != null && lst.Count > 0)
            {
                return lst[0].ObjId;
            }
            return 0;
        }

        #region 提交实际发货信息
        public string Submit_RealDNs(TransferData td)
        {
            log.Debug("Submit_RealDNs begin");

            log.Debug("处理数据开始");
            PsmOutStockBillManager manager = new PsmOutStockBillManager();
            IList<PsmOutStockBill> lst = manager.GetEntityList(new PsmOutStockBill { DeleteFlag = 0, SNNo = td.Header.SNNo });
            string billId = "0";
            if (lst != null && lst.Count > 0)
            {
                billId = lst[0].ObjId.ToString();
            }
            IList<DT_RealDNsRealDNDNItem> lstDNItems = new List<DT_RealDNsRealDNDNItem>();
            foreach (TransferDataItems ti in td.Items)
            {
                DT_RealDNsRealDNDNItem DNItem = new DT_RealDNsRealDNDNItem();
                DNItem.LineItemNo = ti.LineItemNo;
                DNItem.MaterialCode = ti.MaterialCode;
                DNItem.Plant = ti.Plant;
                DNItem.StorageLoc = ti.StorageLoc.Substring(0, 4);
                DNItem.Qty = ti.Qty;
                if (!string.IsNullOrWhiteSpace(ti.Batch))
                {
                    char[] c = ti.Batch.ToCharArray();
                    if (c[0] >= '0' && c[0]<='9')
                    {
                        DNItem.Batch = ti.Batch;
                    }
                    else
                    {
                        DNItem.Batch = DateTime.Now.ToString("yyMM") + ti.Batch;
                    }
                }

                lstDNItems.Add(DNItem);
            }

            log.Debug("处理数据结束");

            log.Debug("SAP数据填充开始");

            log.Debug("表头填充开始");

            DT_MES_in MES_in = new DT_MES_in();
            MES_in.Rphead = new DT_Rphead();
            // MES_in.Rphead.MSGID = outStockBillId;
            MES_in.Rphead.BUSID = billId;
            MES_in.Rphead.BUSTYP = "2001";
            MES_in.Rphead.TLDID = "DZMESO003";
            MES_in.Rphead.TLGNAM = "RealDNs";
            MES_in.Rphead.DTSEND = DateTime.Now.ToString("yyyyMMddHHmmss");
            MES_in.Rphead.SENDER = "DZMES";
            MES_in.Rphead.RECIEVER = "SAP";
            // MES_in.Rphead.Dummy1 = ""; //备用1(重处理时，填入上次错误返回的BUSID)

            log.Debug("表头填充结束");

            log.Debug("行项目填充开始");

            MES_in.RealDNs = new DT_RealDNsRealDN[] { new DT_RealDNsRealDN() };
            MES_in.RealDNs[0].DNHeader = new DT_RealDNsRealDNDNHeader();
            MES_in.RealDNs[0].DNHeader.SNNo = td.Header.SNNo;
            MES_in.RealDNs[0].DNHeader.SRFlag = td.Header.SRFlag;
            MES_in.RealDNs[0].DNHeader.DeliveryDate = DateTime.Now.ToString("yyyyMMdd");

            MES_in.RealDNs[0].DNItem = new DT_RealDNsRealDNDNItem[lstDNItems.Count];
            for (int i = 0; i < lstDNItems.Count; i++)
            {
                MES_in.RealDNs[0].DNItem[i] = new DT_RealDNsRealDNDNItem();
                MES_in.RealDNs[0].DNItem[i].LineItemNo = lstDNItems[i].LineItemNo;
                MES_in.RealDNs[0].DNItem[i].MaterialCode = lstDNItems[i].MaterialCode;
                MES_in.RealDNs[0].DNItem[i].Plant = lstDNItems[i].Plant;
                MES_in.RealDNs[0].DNItem[i].StorageLoc = lstDNItems[i].StorageLoc;
                MES_in.RealDNs[0].DNItem[i].Qty = lstDNItems[i].Qty;
                MES_in.RealDNs[0].DNItem[i].Batch = lstDNItems[i].Batch;
            }

            log.Debug("行项目填充结束");

            log.Debug("SAP数据填充结束");

            try
            {
                string s_MES_in = getJsonByObject(MES_in);
                log.Debug(s_MES_in);
            
                SaveSapLog(new SiiSapLog()
                {
                    DeleteFlag = 0,
                    MethodContent = s_MES_in,
                    MethodMemo = "实际出货对象转Json字符串",
                    MethodName = "Submit_RealDNs",
                });
                
            }
            catch (Exception ex)
            {
                log.Warn(ex.Message, ex);
               
                SaveSapLog(new SiiSapLog()
                {
                    DeleteFlag = 0,
                    Dummy1 = "Error",
                    MethodContent = ex.Message,
                    MethodMemo = "实际出货对象转Json字符串 错误",
                    MethodName = "Submit_RealDNs",
                });
                
            }


            log.Debug("SAP远程服务方法调用开始");

            //调取SAP方法将数据传值给SAP提供的接口
            SI_DZMES_outService outService = new SI_DZMES_outService();

            log.Debug("SAP远程服务方法凭据填充开始");
            outService.Credentials = credential;
            log.Debug("SAP远程服务方法凭据填充结束");

            log.Debug("SAP远程服务方法执行开始");
            outService.SI_DZMES_out(MES_in);
            log.Debug("SAP远程服务方法执行结束");

            log.Debug("SAP远程服务方法调用结束");

            log.Debug("Submit_RealDNs end");

            return "";
        }
        #endregion 提交实际发货信息 end
        private string getJsonByObject(Object obj)
        {
            //实例化DataContractJsonSerializer对象，需要待序列化的对象类型
            System.Runtime.Serialization.Json.DataContractJsonSerializer serializer = new System.Runtime.Serialization.Json.DataContractJsonSerializer(obj.GetType());
            //实例化一个内存流，用于存放序列化后的数据
            System.IO.MemoryStream stream = new System.IO.MemoryStream();
            //使用WriteObject序列化对象
            serializer.WriteObject(stream, obj);
            //写入内存流中
            byte[] dataBytes = new byte[stream.Length];
            stream.Position = 0;
            stream.Read(dataBytes, 0, (int)stream.Length);
            //通过UTF8格式转换为字符串
            return System.Text.Encoding.UTF8.GetString(dataBytes);
        }
        private void SaveSapLog(SiiSapLog entity)
        {
            ISiiSapLogManager manager = new SiiSapLogManager();
            try
            {
                manager.Insert(entity);
            }
            catch (Exception ex)
            {
                string errorMsg = "";
                if (!string.IsNullOrEmpty(entity.MethodName))
                {
                    errorMsg = "方法调用：" + entity.MethodName + ",";
                }
                errorMsg = errorMsg + "数据库保存日志记录错误," + ex.Message;
                log.Debug(errorMsg, ex);
            }

        }
        private IList<PsbCustomer> GetCustomerList(PsbCustomer entity, string orderby)
        {
            IPsbCustomerManager manager = new PsbCustomerManager();
            return manager.GetEntityList(entity, string.IsNullOrEmpty(orderby) ? "OBJID" : orderby);
        }
        public class TransferDataHeader
        {
            private string sNNo = string.Empty;
            private string sRFlag = string.Empty;
            private string docDate = string.Empty;
            private string customerID = string.Empty;
            private string dummy1 = string.Empty;
            private string dummy2 = string.Empty;
            private string dummy3 = string.Empty;
            private string dummy4 = string.Empty;

            public string SNNo
            {
                get
                {
                    return this.sNNo;
                }
                set
                {
                    this.sNNo = value;
                }
            }
            public string SRFlag
            {
                get
                {
                    return this.sRFlag;
                }
                set
                {
                    this.sRFlag = value;
                }
            }
            public string DocDate
            {
                get
                {
                    return this.docDate;
                }
                set
                {
                    this.docDate = value;
                }
            }
            public string CustomerID
            {
                get
                {
                    return this.customerID;
                }
                set
                {
                    this.customerID = value;
                }
            }
            public string Dummy1
            {
                get
                {
                    return this.dummy1;
                }
                set
                {
                    this.dummy1 = value;
                }
            }
            public string Dummy2
            {
                get
                {
                    return this.dummy2;
                }
                set
                {
                    this.dummy2 = value;
                }
            }
            public string Dummy3
            {
                get
                {
                    return this.dummy3;
                }
                set
                {
                    this.dummy3 = value;
                }
            }
            public string Dummy4
            {
                get
                {
                    return this.dummy4;
                }
                set
                {
                    this.dummy4 = value;
                }
            }
        }

        public class TransferDataItems
        {
            private string lineItemNo = string.Empty;
            private string materialCode = string.Empty;
            private string plant = string.Empty;
            private string storageLoc = string.Empty;
            private string qty = string.Empty;
            private string batch = string.Empty;
            private string barcodes = string.Empty;
            private string dummy2 = string.Empty;
            private string dummy3 = string.Empty;
            private string dummy4 = string.Empty;
            public string LineItemNo
            {
                get
                {
                    return this.lineItemNo;
                }
                set
                {
                    this.lineItemNo = value;
                }
            }

            public string MaterialCode
            {
                get
                {
                    return this.materialCode;
                }
                set 
                { 
                    this.materialCode = value; 
                }
            }
            public string Plant
            {
                get
                {
                    return this.plant;
                }
                set
                {
                    this.plant = value;
                }
            }
            public string StorageLoc
            {
                get
                {
                    return this.storageLoc;
                }
                set
                {
                    this.storageLoc = value;
                }
            }
            public string Qty
            {
                get
                {
                    return this.qty; 
                }
                set
                {
                    this.qty = value;
                }
            }
            public string Batch
            {
                get
                {
                    return this.batch;
                }
                set
                {
                    this.batch = value;
                }
            }
            public string Barcodes
            {
                get
                {
                    return this.barcodes;
                }
                set
                {
                    this.barcodes = value;
                }
            }
            public string Dummy2
            {
                get
                {
                    return this.dummy2;
                }
                set
                {
                    this.dummy2 = value;
                }
            }
            public string Dummy3
            {
                get
                {
                    return this.dummy3;
                }
                set
                {
                    this.dummy3 = value;
                }
            }
            public string Dummy4
            {
                get
                {
                    return this.dummy4;
                }
                set
                {
                    this.dummy4 = value;
                }
            }
        }

        public class TransferData
        {
            private TransferDataHeader header;
            private TransferDataItems[] items;

            public TransferDataHeader Header
            {
                get
                {
                    return this.header;
                }
                set
                {
                    this.header = value;
                }
            }
            public TransferDataItems[] Items
            {
                get
                {
                    return this.items;
                }
                set
                {
                    this.items = value;
                }
            }
        }
        #endregion
    }
}
