using System;
using System.Data;
using System.Configuration;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;
using System.Data.SqlClient;
using System.Collections.Generic;

using DBOperator;

/// <summary>
/// SAPInterface 的摘要说明
/// </summary>
public class SAPInterface
{
    System.Net.NetworkCredential credential = new System.Net.NetworkCredential("rfc_admin", "net_159357");
    DM _InterfaceDBAdapter;

    public SAPInterface(string ip, string dbname, string user, string password)
    {
        _InterfaceDBAdapter = new DM(ip, dbname, user, password);
    }

    public SAPInterface(DM dm)
    {
        _InterfaceDBAdapter = dm;
    }

    /// <summary>
    /// 日志记录
    /// </summary>
    private void AppendWebLog(string billNo, string billType, string sapBillNo, string operPerson, string cancelFlag, string remark, string errorFlag, string isReload)
    {
        System.Text.StringBuilder logSql = new System.Text.StringBuilder();
        logSql.AppendLine("insert into IncToSapLog(MesBillNo, MesBillType, SapBillNo, OperPerson, CancelFlag, IsReload, Remark, ErrorFlag, RecordDate)");
        logSql.AppendLine(" values ('" + billNo + "', '" + billType + "', '" + sapBillNo + "', '" + operPerson + "', '" + cancelFlag + "', '" + isReload + "', '" + remark.Replace("'", "''") + "', '" + errorFlag + "', getdate())");
        _InterfaceDBAdapter.ExecuteSql(logSql.ToString());
    }

    #region 送货通知单反馈信息
    public string SetSendChkInfo(string sapBillNo)
    {
        try
        {
            DT_MLJ_in mljIn = new DT_MLJ_in();
            mljIn.Rphead = new DT_Rphead();
            mljIn.Rphead.BUSID = sapBillNo;
            mljIn.Rphead.BUSTYP = "1000";
            mljIn.Rphead.TLDID = "LLMILIS003";
            mljIn.Rphead.TLGNAM = "DNStatusS";
            mljIn.Rphead.DTSEND = DateTime.Now.ToString("yyyyMMddHHmmss");
            mljIn.Rphead.SENDER = "MLJ";
            mljIn.Rphead.RECIEVER = "SAP";
            mljIn.Rphead.Dummy4 = sapBillNo;

            mljIn.DNStatusS = new DT_DNStatusSDNStatus[] { new DT_DNStatusSDNStatus() };
            mljIn.DNStatusS[0].DNID = sapBillNo;
            mljIn.DNStatusS[0].Status = "01";

            //调取SAP方法将数据传值给SAP提供的接口
            SI_MLJ_outService outService = new SI_MLJ_outService();
            outService.Credentials = credential;
            outService.SI_MLJ_out(mljIn);
        }
        catch (Exception ex)
        {
            //写入错误日志
            AppendWebLog(sapBillNo, "1000", sapBillNo, "000001", "0", ex.ToString(), "1", "0");
            return "调用接口异常：" + ex.ToString();
        }

        //写入日志
        AppendWebLog(sapBillNo, "1000", sapBillNo, "000001", "0", string.Empty, "0", "0");

        return "OK";
    }
    #endregion

    #region 入库单数据返回
    public string SetStoreinInfo(string billNo, string cancelFlag, string isReload)
    {
        string sqlStorinHead = @"select B.ERPCode StorageID, C.SAPFacCode, InputDate, LockedFlag, MakerPerson 
                                from PstMaterialStorein A
	                                left join BasStorage B on A.StorageID = B.StorageID
	                                left join BasFactoryInfo C on A.FactoryID = C.ObjID
                                where BillNo = '" + billNo + "'";
        if (cancelFlag == "0")
            sqlStorinHead += " and ChkResultFlag = '1'";
        else
            sqlStorinHead += " and ChkResultFlag = '0'";
        //合并拆分的入库数量 提交SAP  2016-09-20 李昊
        string sqlStorinDetail = @"select A.Barcode,   B.SAPMaterialShortCode, C.UnitName, max(A.ProcDate) as ProcDate , MAX(InputNum)as InputNum, max(A.PieceWeight)as PieceWeight, sum(InputWeight) as InputWeight, max(A.RecordDate)as RecordDate, SourceBillNo, SourceOrderID, D.NoticeNo, D.Remark, MAX(A.LLBarcode2) as LLBarcode2
                                from PstMaterialStoreinDetail A
                                    left join BasMaterial B on A.MaterCode = B.MaterialCode
                                    left join BasUnit C on B.UnitID = C.ObjID
                                    left join PstMaterialChkDetail D on A.SourceBillNo = D.BillNo and A.SourceOrderID = D.OrderID
                                where A.BillNo = '" + billNo + "' group by a.Barcode,SAPMaterialShortCode,UnitName,SourceBillNo,SourceOrderID,D.NoticeNo,d.Remark";
//        string sqlStorinDetail = @"select A.Barcode, A.OrderID, StoragePlaceID, B.SAPMaterialShortCode, C.UnitName, A.ProcDate, InputNum, A.PieceWeight, InputWeight, A.RecordDate, SourceBillNo, SourceOrderID, D.NoticeNo, D.Remark, A.LLBarcode2
//                                from PstMaterialStoreinDetail A
//                                    left join BasMaterial B on A.MaterCode = B.MaterialCode
//                                    left join BasUnit C on B.UnitID = C.ObjID
//                                    left join PstMaterialChkDetail D on A.SourceBillNo = D.BillNo and A.SourceOrderID = D.OrderID
//                                where A.BillNo = '" + billNo + "'";
         
        DataSet dsHead = _InterfaceDBAdapter.ds(sqlStorinHead);
        DataSet dsDetail = _InterfaceDBAdapter.ds(sqlStorinDetail);

        if (dsHead.Tables[0].Rows.Count == 0 || dsDetail.Tables[0].Rows.Count == 0)
        {
            return "No Data";
        }

        try
        {
            DT_Comm_in commIn = new DT_Comm_in();
            commIn.Rphead = new Rphead();
            commIn.Rphead.MSGID = billNo;
            commIn.Rphead.BUSID = billNo;
            commIn.Rphead.BUSTYP = "1001";
            commIn.Rphead.TLDID = "LLCOMM0001";
            commIn.Rphead.TLGNAM = "MatMove";
            commIn.Rphead.DTSEND = DateTime.Now.ToString("yyyyMMddHHmmss");
            commIn.Rphead.SENDER = "MLJ";
            commIn.Rphead.RECIEVER = "SAP";

            string[] notice1 = dsDetail.Tables[0].Rows[0]["NoticeNo"].ToString().Split(';');
            if (notice1.Length > 0)
                commIn.Rphead.Dummy4 = notice1[0].ToString();

            commIn.GoodsMovements = new DT_GoodsMovements_inGoodsMovement[] { new DT_GoodsMovements_inGoodsMovement() };
            //commIn.GoodsMovements = new DT_GoodsMovements_inGoodsMovement[1];
            //for (int i = 0; i < commIn.GoodsMovements.Length; i++)
            //{
            //    commIn.GoodsMovements[i] = new DT_GoodsMovements_inGoodsMovement();
            //}
            commIn.GoodsMovements[0].MovHeader = new DT_GoodsMovements_inGoodsMovementMovHeader();
            commIn.GoodsMovements[0].MoveItem = new DT_GoodsMovements_inGoodsMovementMoveItem[dsDetail.Tables[0].Rows.Count];

            commIn.GoodsMovements[0].MovHeader.DocDate = DateTime.Now.ToString("yyyyMMdd");
            commIn.GoodsMovements[0].MovHeader.PostDate = DateTime.Now.ToString("yyyyMMdd");
            commIn.GoodsMovements[0].MovHeader.HeadTXT = billNo;

            for (int i = 0; i < dsDetail.Tables[0].Rows.Count; i++)
            {
                commIn.GoodsMovements[0].MoveItem[i] = new DT_GoodsMovements_inGoodsMovementMoveItem();
                if (cancelFlag == "0")
                    commIn.GoodsMovements[0].MoveItem[i].MovType = "101";
                else
                    commIn.GoodsMovements[0].MoveItem[i].MovType = "102";
                commIn.GoodsMovements[0].MoveItem[i].MaterialCode = dsDetail.Tables[0].Rows[i]["SAPMaterialShortCode"].ToString();
                commIn.GoodsMovements[0].MoveItem[i].PlantFrom = "8000";
                commIn.GoodsMovements[0].MoveItem[i].StorageLoc = dsHead.Tables[0].Rows[0]["StorageID"].ToString();
                commIn.GoodsMovements[0].MoveItem[i].BarCode = dsDetail.Tables[0].Rows[i]["Barcode"].ToString();
                commIn.GoodsMovements[0].MoveItem[i].Batch = dsDetail.Tables[0].Rows[i]["LLBarcode2"].ToString();
                commIn.GoodsMovements[0].MoveItem[i].Qty = dsDetail.Tables[0].Rows[i]["InputWeight"].ToString();
                commIn.GoodsMovements[0].MoveItem[i].Unit = "KG";//dsDetail.Tables[0].Rows[i]["UnitName"].ToString();
                string[] PO = dsDetail.Tables[0].Rows[i]["Remark"].ToString().Split(';');
                if (PO.Length > 0)
                    commIn.GoodsMovements[0].MoveItem[i].PO = PO[0].ToString();
                if (PO.Length > 1)
                    commIn.GoodsMovements[0].MoveItem[i].POItem = PO[1].ToString();
                //commIn.GoodsMovements[0].MoveItem[i].PO = dsDetail.Tables[0].Rows[i]["SourceBillNo"].ToString();
                //commIn.GoodsMovements[0].MoveItem[i].POItem = dsDetail.Tables[0].Rows[i]["SourceOrderID"].ToString();
                string[] notice = dsDetail.Tables[0].Rows[i]["NoticeNo"].ToString().Split(';');
                if (notice.Length > 0)
                    commIn.GoodsMovements[0].MoveItem[i].DN = notice[0].ToString();
                if (notice.Length > 1)
                    commIn.GoodsMovements[0].MoveItem[i].DNItem = notice[1].ToString();
            }

            //调取SAP方法将数据传值给SAP提供的接口
            SI_Comm_outService outService = new SI_Comm_outService();
            outService.Credentials = credential;
            outService.SI_Comm_out(commIn);
        }
        catch (Exception ex)
        {
            //写入错误日志
            AppendWebLog(billNo, "1001", dsDetail.Tables[0].Rows[0]["NoticeNo"].ToString(), dsHead.Tables[0].Rows[0]["MakerPerson"].ToString(), cancelFlag, ex.Message.ToString(), "1", isReload);
            return "调用接口异常：" + ex.Message.ToString();
        }
        //写入日志
        AppendWebLog(billNo, "1001", dsDetail.Tables[0].Rows[0]["NoticeNo"].ToString(), dsHead.Tables[0].Rows[0]["MakerPerson"].ToString(), cancelFlag, string.Empty, "0",  isReload);

        return "OK";
    }

    #endregion

    #region 调拨单数据返回
    public string SetAdjustInfo(string billNo, string sapBillNo, string cancelFlag, string isReload)
    {
        string sqlAdjustHead=string.Empty;
        string sqlAdjustDetail = string.Empty;
        if (billNo.Length > 1 && billNo.Substring(0, 2) == "DB")
        {
            sqlAdjustHead = @"select B.ERPCode SourceStorage, C.ERPCode TargetStorage, MakerPerson
                                from PstMaterialAdjust A 
	                                left join BasStorage B on A.SourceStorage = B.StorageID
	                                left join BasStorage C on A.TargetStorage = C.StorageID
                                where BillNo = '" + billNo + "'";
            if (cancelFlag == "0")
                sqlAdjustHead += " and ChkResultFlag = '1'";
            else
                sqlAdjustHead += " and ChkResultFlag = '0'";
            sqlAdjustDetail = @"select Barcode, OrderID, B.SAPMaterialShortCode, C.UnitName, ProcDate, AdjustNum, PieceWeight, AdjustWeight, RecordDate, '' Batch
                                from PstMaterialAdjustDetail A
	                                left join BasMaterial B on A.MaterCode = B.MaterialCode
	                                left join BasUnit C on B.UnitID = C.ObjID
                                where BillNo = '" + billNo + "'";
        }
        else if (billNo.Length > 1 && billNo.Substring(0, 2) == "RK")
        {
            sqlAdjustHead = @"select '' SourceStorage, B.ERPCode TargetStorage, MakerPerson
                                from PstMaterialStorein A
	                                left join BasStorage B on A.StorageID = B.StorageID
                                where BillNo = '" + billNo + "' and ChkResultFlag = '1'";
            sqlAdjustDetail = @"select Barcode, OrderID, B.SAPMaterialShortCode, C.UnitName, ProcDate, InputNum AdjustNum, PieceWeight, InputWeight AdjustWeight, RecordDate, LLBarcode2 Batch
                                from PstMaterialStoreinDetail A
	                                left join BasMaterial B on A.MaterCode = B.MaterialCode
	                                left join BasUnit C on B.UnitID = C.ObjID
                                where BillNo = '" + billNo + "'";
        }
        else if (!string.IsNullOrEmpty(billNo))
        {
            sqlAdjustHead = @"select B.ERPCode SourceStorage, C.ERPCode TargetStorage, A.OperPerson MakerPerson
                            from PstShopReturn A 
                                left join BasStorage B on A.SourceStorageID = B.StorageID
                                left join BasStorage C on A.TargetStorageID = C.StorageID
                            where A.ObjID = '" + billNo + "'";
            sqlAdjustDetail = @"select Barcode, '1' OrderID, B.SAPMaterialShortCode, C.UnitName, '' ProcDate, '0 'AdjustNum, '' PieceWeight, ReturnWeight AdjustWeight, RecordDate, '' Batch
                            from PstShopReturn A
                                left join BasMaterial B on A.MaterCode = B.MaterialCode
                                left join BasUnit C on B.UnitID = C.ObjID
                            where A.ObjID = '" + billNo + "'";
        }
        else
        {
            return "No Data";
        }

        DataSet dsHead = _InterfaceDBAdapter.ds(sqlAdjustHead);
        DataSet dsDetail = _InterfaceDBAdapter.ds(sqlAdjustDetail);

        //AppendWebLog(billNo, "1003", sapBillNo, "ZYTest", cancelFlag, sqlAdjustHead, "1", isReload);
        //AppendWebLog(billNo, "1003", sapBillNo, "ZYTest", cancelFlag, sqlAdjustDetail, "1", isReload);

        if (dsHead.Tables[0].Rows.Count == 0 || dsDetail.Tables[0].Rows.Count == 0)
        {
            return "No Data";
        }

        try
        {
            DT_Comm_in commIn = new DT_Comm_in();
            commIn.Rphead = new Rphead();
            commIn.Rphead.MSGID = billNo;
            commIn.Rphead.BUSID = billNo;
            commIn.Rphead.BUSTYP = "1003";
            commIn.Rphead.TLDID = "LLCOMM0001";
            commIn.Rphead.TLGNAM = "MatMove";
            commIn.Rphead.DTSEND = DateTime.Now.ToString("yyyyMMddHHmmss");
            commIn.Rphead.SENDER = "MLJ";
            commIn.Rphead.RECIEVER = "SAP";
            commIn.Rphead.Dummy4 = sapBillNo;

            commIn.GoodsMovements = new DT_GoodsMovements_inGoodsMovement[] { new DT_GoodsMovements_inGoodsMovement() };
            commIn.GoodsMovements[0].MovHeader = new DT_GoodsMovements_inGoodsMovementMovHeader();
            commIn.GoodsMovements[0].MoveItem = new DT_GoodsMovements_inGoodsMovementMoveItem[dsDetail.Tables[0].Rows.Count];

            commIn.GoodsMovements[0].MovHeader.DocDate = DateTime.Now.ToString("yyyyMMdd");
            commIn.GoodsMovements[0].MovHeader.PostDate = DateTime.Now.ToString("yyyyMMdd");
            commIn.GoodsMovements[0].MovHeader.HeadTXT = billNo;

            for (int i = 0; i < dsDetail.Tables[0].Rows.Count; i++)
            {
                commIn.GoodsMovements[0].MoveItem[i] = new DT_GoodsMovements_inGoodsMovementMoveItem();
                commIn.GoodsMovements[0].MoveItem[i].Reservation = sapBillNo;
                if (cancelFlag == "0")
                    commIn.GoodsMovements[0].MoveItem[i].MovType = "311";
                else
                    commIn.GoodsMovements[0].MoveItem[i].MovType = "312";
                commIn.GoodsMovements[0].MoveItem[i].MaterialCode = dsDetail.Tables[0].Rows[i]["SAPMaterialShortCode"].ToString();
                commIn.GoodsMovements[0].MoveItem[i].PlantFrom = "8000";
                commIn.GoodsMovements[0].MoveItem[i].StorageLoc = dsHead.Tables[0].Rows[0]["SourceStorage"].ToString();
                commIn.GoodsMovements[0].MoveItem[i].RecBatch = dsDetail.Tables[0].Rows[i]["Batch"].ToString();
                commIn.GoodsMovements[0].MoveItem[i].BarCode = dsDetail.Tables[0].Rows[i]["Barcode"].ToString();
                commIn.GoodsMovements[0].MoveItem[i].Qty = dsDetail.Tables[0].Rows[i]["AdjustWeight"].ToString();
                commIn.GoodsMovements[0].MoveItem[i].Unit = "KG";// dsDetail.Tables[0].Rows[i]["UnitName"].ToString();
                commIn.GoodsMovements[0].MoveItem[i].RecPlant = "8000";
                if (string.IsNullOrEmpty(sapBillNo))
                    commIn.GoodsMovements[0].MoveItem[i].RecStoLoc = dsHead.Tables[0].Rows[0]["TargetStorage"].ToString();
            }

            //调取SAP方法将数据传值给SAP提供的接口
            SI_Comm_outService outService = new SI_Comm_outService();
            outService.Credentials = credential;
            outService.SI_Comm_out(commIn);
        }
        catch (Exception ex)
        {
            //写入错误日志
            AppendWebLog(billNo, "1003", sapBillNo, dsHead.Tables[0].Rows[0]["MakerPerson"].ToString(), cancelFlag, ex.Message.ToString(), "1", isReload);
            return "调用接口异常：" + ex.ToString();
        }

        //写入日志
        AppendWebLog(billNo, "1003", sapBillNo, dsHead.Tables[0].Rows[0]["MakerPerson"].ToString(), cancelFlag, string.Empty, "0", isReload);

        return "OK";
    }

    #endregion

    #region 原材料销售出库
    public string SetStoreoutInfo(string billNo, string sapBillNo, string isReload)
    {
        string sqlStoroutHead = string.Empty;
        string sqlStoroutDetail = string.Empty;
        if (billNo.Substring(0, 2) == "CK")
        {
            sqlStoroutHead = @"select B.ERPCode StorageID, C.SAPFacCode, OutputDate, LockedFlag, MakerPerson 
                                from PstMaterialStoreout A
                                    left join BasStorage B on A.StorageID = B.StorageID
                                    left join BasFactoryInfo C on A.DeptCode = C.ObjID
                                where BillNo = '" + billNo + "' and ChkResultFlag = '1'";
            sqlStoroutDetail = @"select Barcode, OrderID, StoragePlaceID, B.SAPMaterialShortCode, C.UnitName, ProcDate, OutputNum, PieceWeight, OutputWeight, RecordDate
                                from PstMaterialStoreoutDetail A
                                    left join BasMaterial B on A.MaterCode = B.MaterialCode
                                    left join BasUnit C on B.UnitID = C.ObjID
                                where BillNo = '" + billNo + "'";
        }
        else if (billNo.Substring(0, 2) == "TK")
        {
            sqlStoroutHead = @"select B.ERPCode StorageID, C.SAPFacCode, ReturninDate OutputDate, ChkResultFlag LockedFlag, MakerPerson 
                                from PstMaterialReturnin A
                                    left join BasStorage B on A.StorageID = B.StorageID
                                    left join BasFactoryInfo C on A.FactoryID = C.ObjID
                                where BillNo = '" + billNo + "' and ChkResultFlag = '0'";
            sqlStoroutDetail = @"select Barcode, OrderID, StoragePlaceID, B.SAPMaterialShortCode, C.UnitName, ProcDate, ReturninNum OutputNum, PieceWeight, ReturninWeight OutputWeight, RecordDate
                                from PstMaterialReturninDetail A
                                    left join BasMaterial B on A.MaterCode = B.MaterialCode
                                    left join BasUnit C on B.UnitID = C.ObjID
                                where BillNo = '" + billNo + "'";
        }

        DataSet dsHead = _InterfaceDBAdapter.ds(sqlStoroutHead);
        DataSet dsDetail = _InterfaceDBAdapter.ds(sqlStoroutDetail);

        if (dsHead.Tables[0].Rows.Count == 0 || dsDetail.Tables[0].Rows.Count == 0)
        {
            return "No Data";
        }

        try
        {
            DT_MLJ_in mljIn = new DT_MLJ_in();
            mljIn.Rphead = new DT_Rphead();
            mljIn.Rphead.BUSID = billNo;
            mljIn.Rphead.BUSTYP = "1002";
            mljIn.Rphead.TLDID = "LLMILIS004";
            mljIn.Rphead.TLGNAM = "ActOutDNs";
            mljIn.Rphead.DTSEND = DateTime.Now.ToString("yyyyMMddHHmmss");
            mljIn.Rphead.SENDER = "MLJ";
            mljIn.Rphead.RECIEVER = "SAP";
            mljIn.Rphead.Dummy4 = sapBillNo;

            mljIn.RealDNs = new DT_RealDNsRealDN[] { new DT_RealDNsRealDN() };
            mljIn.RealDNs[0].DNHeader = new DT_RealDNsRealDNDNHeader();
            mljIn.RealDNs[0].DNItem = new DT_RealDNsRealDNDNItem[dsDetail.Tables[0].Rows.Count];

            mljIn.RealDNs[0].DNHeader.SNNo = sapBillNo;
            //mljIn.RealDNs[0].DNHeader.SRFlag = "0";
            mljIn.RealDNs[0].DNHeader.DeliveryDate = DateTime.Now.ToString("yyyyMMdd");
            
            for (int i = 0; i < dsDetail.Tables[0].Rows.Count; i++)
            {
                mljIn.RealDNs[0].DNItem[i] = new DT_RealDNsRealDNDNItem();
                mljIn.RealDNs[0].DNItem[i].LineItemNo = dsDetail.Tables[0].Rows[i]["OrderID"].ToString();
                mljIn.RealDNs[0].DNItem[i].MaterialCode = dsDetail.Tables[0].Rows[i]["SAPMaterialShortCode"].ToString();
                mljIn.RealDNs[0].DNItem[i].Plant = "8000";
                mljIn.RealDNs[0].DNItem[i].StorageLoc = dsHead.Tables[0].Rows[0]["StorageID"].ToString();
                mljIn.RealDNs[0].DNItem[i].Qty = dsDetail.Tables[0].Rows[i]["OutputWeight"].ToString();
                mljIn.RealDNs[0].DNItem[i].Batch = dsDetail.Tables[0].Rows[i]["Barcode"].ToString();
            }

            //调取SAP方法将数据传值给SAP提供的接口
            SI_MLJ_outService outService = new SI_MLJ_outService();
            outService.Credentials = credential;
            outService.SI_MLJ_out(mljIn);
        }
        catch (Exception ex)
        {
            //写入错误日志
            AppendWebLog(billNo, "1002", sapBillNo, dsHead.Tables[0].Rows[0]["MakerPerson"].ToString(), "0", ex.ToString(), "1", isReload);
            return "调用接口异常：" + ex.ToString();
        }

        //写入日志
        AppendWebLog(billNo, "1002", sapBillNo, dsHead.Tables[0].Rows[0]["MakerPerson"].ToString(), "0", string.Empty, "0", isReload);

        return "OK";
    }
    #endregion

    #region 原材料销售退库
    public string SetReturninInfo(string billNo, string sapBillNo, string isReload)
    {
        string sqlReturnHead = string.Empty;
        string sqlReturnDetail = string.Empty;
        if (billNo.Substring(0, 2) == "TK")
        {
            sqlReturnHead = @"select B.ERPCode StorageID, C.SAPFacCode, ReturninDate, ChkResultFlag, MakerPerson 
                                from PstMaterialReturnin A
                                    left join BasStorage B on A.StorageID = B.StorageID
                                    left join BasFactoryInfo C on A.FactoryID = C.ObjID
                                where BillNo = '" + billNo + "' and ChkResultFlag = '1'";
            sqlReturnDetail = @"select Barcode, OrderID, StoragePlaceID, B.SAPMaterialShortCode, C.UnitName, ProcDate, ReturninNum, PieceWeight, ReturninWeight, RecordDate
                                from PstMaterialReturninDetail A
                                    left join BasMaterial B on A.MaterCode = B.MaterialCode
                                    left join BasUnit C on B.UnitID = C.ObjID
                                where BillNo = '" + billNo + "'";
        }
        else if (billNo.Substring(0, 2) == "CK")
        {
            sqlReturnHead = @"select B.ERPCode StorageID, C.SAPFacCode, OutputDate ReturninDate, LockedFlag ChkResultFlag, MakerPerson 
                                from PstMaterialStoreout A
                                    left join BasStorage B on A.StorageID = B.StorageID
                                    left join BasFactoryInfo C on A.DeptCode = C.ObjID
                                where BillNo = '" + billNo + "' and ChkResultFlag = '0'";
            sqlReturnDetail = @"select Barcode, OrderID, StoragePlaceID, B.SAPMaterialShortCode, C.UnitName, ProcDate, OutputNum ReturninNum, PieceWeight, OutputWeight ReturninWeight, RecordDate
                                from PstMaterialStoreoutDetail A
                                    left join BasMaterial B on A.MaterCode = B.MaterialCode
                                    left join BasUnit C on B.UnitID = C.ObjID
                                where BillNo = '" + billNo + "'";
        }

        DataSet dsHead = _InterfaceDBAdapter.ds(sqlReturnHead);
        DataSet dsDetail = _InterfaceDBAdapter.ds(sqlReturnDetail);

        if (dsHead.Tables[0].Rows.Count == 0 || dsDetail.Tables[0].Rows.Count == 0)
        {
            return "No Data";
        }

        try
        {
            DT_MLJ_in mljIn = new DT_MLJ_in();
            mljIn.Rphead = new DT_Rphead();
            mljIn.Rphead.BUSID = billNo;
            mljIn.Rphead.BUSTYP = "1004";
            mljIn.Rphead.TLDID = "LLMILIS004";
            mljIn.Rphead.TLGNAM = "RealDNs";
            mljIn.Rphead.DTSEND = DateTime.Now.ToString("yyyyMMddHHmmss");
            mljIn.Rphead.SENDER = "MLJ";
            mljIn.Rphead.RECIEVER = "SAP";
            mljIn.Rphead.Dummy4 = sapBillNo;

            mljIn.RealDNs = new DT_RealDNsRealDN[] { new DT_RealDNsRealDN() };
            mljIn.RealDNs[0].DNHeader = new DT_RealDNsRealDNDNHeader();
            mljIn.RealDNs[0].DNItem = new DT_RealDNsRealDNDNItem[dsDetail.Tables[0].Rows.Count];

            mljIn.RealDNs[0].DNHeader.SNNo = sapBillNo;
            //mljIn.RealDNs[0].DNHeader.SRFlag = "X";
            mljIn.RealDNs[0].DNHeader.DeliveryDate = DateTime.Now.ToString("yyyyMMdd");
            for (int i = 0; i < dsDetail.Tables[0].Rows.Count; i++)
            {
                mljIn.RealDNs[0].DNItem[i] = new DT_RealDNsRealDNDNItem();
                mljIn.RealDNs[0].DNItem[i].LineItemNo = dsDetail.Tables[0].Rows[i]["OrderID"].ToString();
                mljIn.RealDNs[0].DNItem[i].MaterialCode = dsDetail.Tables[0].Rows[i]["SAPMaterialShortCode"].ToString();
                mljIn.RealDNs[0].DNItem[i].Plant = "8000";
                mljIn.RealDNs[0].DNItem[i].StorageLoc = dsHead.Tables[0].Rows[0]["StorageID"].ToString();
                mljIn.RealDNs[0].DNItem[i].Qty = dsDetail.Tables[0].Rows[i]["ReturninWeight"].ToString();
                mljIn.RealDNs[0].DNItem[i].Batch = dsDetail.Tables[0].Rows[i]["Barcode"].ToString();
            }

            //调取SAP方法将数据传值给SAP提供的接口
            SI_MLJ_outService outService = new SI_MLJ_outService();
            outService.Credentials = credential;
            outService.SI_MLJ_out(mljIn);
        }
        catch (Exception ex)
        {
            //写入错误日志                                                                                                                                                                                                                                                                                                                                                                   
            AppendWebLog(billNo, "1004", sapBillNo, dsHead.Tables[0].Rows[0]["MakerPerson"].ToString(), "0", ex.ToString(), "1", isReload);
            return "调用接口异常：" + ex.ToString();
        }
        //写入日志
        AppendWebLog(billNo, "1004", sapBillNo, dsHead.Tables[0].Rows[0]["MakerPerson"].ToString(), "0", string.Empty, "0", isReload);

        return "OK";
    }
    #endregion

    #region 生产数据统计/返工报废
    public string SetProductionsUpload(string productType, string isReload, string planDate, string shiftID, string workShopCode, string objID)
    {
        string sql = @"select A.*, B.SAPMaterialShortCode, C.ERPCode, D.EquipName, E.ShiftName from PpmRubber001 A
                            left join BasMaterial B on A.MaterCode = B.MaterialCode
                            left join BasStorage C on A.StorageID = C.StorageID
                            left join BasEquip D on A.EquipCode = D.EquipCode
                            left join PptShift E on A.ShiftID = E.ObjID
                        where RubberType = 'ZL'";
        if (isReload == "1")
            sql += @" and PlanDate = '" + planDate + "' and A.ObjID = '" + objID + "'";
        else
            sql += @" and PlanDate = '" + planDate + "' and ShiftID = '" + shiftID + "' and D.WorkShopCode = '" + workShopCode + "'";
        if (productType == "1")
            sql += " and A.StockType = '1'";
        else
            sql += " and A.StockType = '-1'";

        DataSet dsProductions = _InterfaceDBAdapter.ds(sql);
        if (dsProductions.Tables[0].Rows.Count == 0)
        {
            return "No Data";
        }

        string busID = Convert.ToDateTime(dsProductions.Tables[0].Rows[0]["PlanDate"].ToString()).ToString("yyyyMMdd") + shiftID + workShopCode;

        try
        {
            //for (int i = 0; i < dsProductions.Tables[0].Rows.Count; i++)
            //{
            //    busID = Convert.ToDateTime(dsProductions.Tables[0].Rows[0]["PlanDate"].ToString()).ToString("yyyyMMdd") + shiftID + workShopCode + dsProductions.Tables[0].Rows[i]["ObjID"].ToString(); ;
            //    DT_MLJ_in mljIn = new DT_MLJ_in();
            //    mljIn.Rphead = new DT_Rphead();
            //    mljIn.Rphead.BUSID = busID;
            //    if (productType == "1")
            //        mljIn.Rphead.BUSTYP = "0001";
            //    else
            //        mljIn.Rphead.BUSTYP = "0002";
            //    mljIn.Rphead.TLDID = "LLMILIS001";
            //    mljIn.Rphead.TLGNAM = "Productions";
            //    mljIn.Rphead.DTSEND = DateTime.Now.ToString("yyyyMMddHHmmss");
            //    mljIn.Rphead.SENDER = "MLJ";
            //    mljIn.Rphead.RECIEVER = "SAP";

            //    mljIn.Productions = new DT_ProductionsProduction[1];
            //    mljIn.Productions[0] = new DT_ProductionsProduction();
            //    mljIn.Productions[0].Serid = dsProductions.Tables[0].Rows[i]["ObjID"].ToString();
            //    if (productType == "0")
            //        mljIn.Productions[0].ProductType = "02";
            //    else
            //        mljIn.Productions[0].ProductType = "01";
            //    mljIn.Productions[0].Plant = "8000";
            //    mljIn.Productions[0].MaterialCode = dsProductions.Tables[0].Rows[i]["SAPMaterialShortCode"].ToString();
            //    mljIn.Productions[0].ProVersion = dsProductions.Tables[0].Rows[i]["SAPVersionID"].ToString();
            //    mljIn.Productions[0].Qty = dsProductions.Tables[0].Rows[i]["TotalWeight"].ToString();
            //    mljIn.Productions[0].PostDate = Convert.ToDateTime(dsProductions.Tables[0].Rows[0]["PlanDate"].ToString()).ToString("yyyyMMdd");//DateTime.Now.ToString("yyyyMMdd");
            //    mljIn.Productions[0].DocDate = Convert.ToDateTime(dsProductions.Tables[0].Rows[0]["PlanDate"].ToString()).ToString("yyyyMMdd");
            //    mljIn.Productions[0].StorageLoc = dsProductions.Tables[0].Rows[i]["ERPCode"].ToString();
            //    mljIn.Productions[0].Batch = dsProductions.Tables[0].Rows[i]["Barcode"].ToString();
            //    mljIn.Productions[0].HeadTxt = mljIn.Productions[0].ProductType + "-" + dsProductions.Tables[0].Rows[i]["EquipName"].ToString() + "-" + dsProductions.Tables[0].Rows[i]["ShiftName"].ToString();

            //    //调取SAP方法将数据传值给SAP提供的接口
            //    SI_MLJ_outService outService = new SI_MLJ_outService();
            //    outService.Credentials = credential;
            //    outService.SI_MLJ_out(mljIn);
            //}
            DT_MLJ_in mljIn = new DT_MLJ_in();
            mljIn.Rphead = new DT_Rphead();
            mljIn.Rphead.BUSID = busID;
            if (productType == "1")
                mljIn.Rphead.BUSTYP = "0001";
            else
                mljIn.Rphead.BUSTYP = "0002";
            mljIn.Rphead.TLDID = "LLMILIS001";
            mljIn.Rphead.TLGNAM = "Productions";
            mljIn.Rphead.DTSEND = DateTime.Now.ToString("yyyyMMddHHmmss");
            mljIn.Rphead.SENDER = "MLJ";
            mljIn.Rphead.RECIEVER = "SAP";
            //mljIn.Rphead.Dummy1 = "重处理时，填入上次错误返回时的BUSID";

            mljIn.Productions = new DT_ProductionsProduction[dsProductions.Tables[0].Rows.Count];
            for (int i = 0; i < dsProductions.Tables[0].Rows.Count; i++)
            {
                mljIn.Productions[i] = new DT_ProductionsProduction();
                mljIn.Productions[i].Serid = dsProductions.Tables[0].Rows[i]["ObjID"].ToString();
                if (productType == "0")
                    mljIn.Productions[i].ProductType = "02";
                else
                    mljIn.Productions[i].ProductType = "01";
                mljIn.Productions[i].Plant = "8000";
                mljIn.Productions[i].MaterialCode = dsProductions.Tables[0].Rows[i]["SAPMaterialShortCode"].ToString();
                mljIn.Productions[i].ProVersion = dsProductions.Tables[0].Rows[i]["SAPVersionID"].ToString();
                mljIn.Productions[i].Qty = dsProductions.Tables[0].Rows[i]["TotalWeight"].ToString();
                mljIn.Productions[i].PostDate = Convert.ToDateTime(dsProductions.Tables[0].Rows[0]["PlanDate"].ToString()).ToString("yyyyMMdd");//DateTime.Now.ToString("yyyyMMdd");
                mljIn.Productions[i].DocDate = Convert.ToDateTime(dsProductions.Tables[0].Rows[0]["PlanDate"].ToString()).ToString("yyyyMMdd");
                mljIn.Productions[i].StorageLoc = dsProductions.Tables[0].Rows[i]["ERPCode"].ToString();
                mljIn.Productions[i].Batch = dsProductions.Tables[0].Rows[i]["Barcode"].ToString();
                mljIn.Productions[i].HeadTxt = mljIn.Productions[i].ProductType + "-" + dsProductions.Tables[0].Rows[i]["EquipName"].ToString() + "-" + dsProductions.Tables[0].Rows[i]["ShiftName"].ToString();
                
            }

            //调取SAP方法将数据传值给SAP提供的接口
            SI_MLJ_outService outService = new SI_MLJ_outService();
            outService.Credentials = credential;
            outService.SI_MLJ_out(mljIn);
        }
        catch (Exception ex)
        {
            //写入错误日志
            if (productType == "1")
                AppendWebLog(busID, "0001", "", dsProductions.Tables[0].Rows[0]["OperPerson"].ToString(), "0", ex.Message, "1", isReload);
            else
                AppendWebLog(busID, "0002", "", dsProductions.Tables[0].Rows[0]["OperPerson"].ToString(), "0", ex.Message, "1", isReload);
            return "调用接口异常：" + ex.ToString();
        }
        //写入日志
        if (productType == "1")
            AppendWebLog(busID, "0001", "", dsProductions.Tables[0].Rows[0]["OperPerson"].ToString(), "0", string.Empty, "0", isReload);
        else
            AppendWebLog(busID, "0002", "", dsProductions.Tables[0].Rows[0]["OperPerson"].ToString(), "0", string.Empty, "0", isReload);

        return "OK";
    }
    #endregion

    #region 暂不使用该方法
    public string SetRetproductionsUpload(string productType, string isReload, string planDate, string objID)
    {
        string sql = @"select A.*, B.SAPMaterialShortCode, C.ERPCode from PpmRubber008 A
	                        left join BasMaterial B on A.MaterCode = B.MaterialCode
	                        left join BasStorage C on A.StorageID = C.StorageID";
        if (!string.IsNullOrEmpty(planDate))
            sql += @" where PlanDate = '" + planDate + "' and A.ObjID in (" + objID + ")";
        else
            sql += @" where PlanDate = CONVERT(varchar(10), GETDATE(), 120)";

        DataSet dsRetproductions = _InterfaceDBAdapter.ds(sql);
        if (dsRetproductions.Tables[0].Rows.Count == 0)
        {
            return "No Data";
        }

        string busID = dsRetproductions.Tables[0].Rows[0]["PlanDate"].ToString().Replace("-", "").Substring(0, 8) + dsRetproductions.Tables[0].Rows[0]["ObjID"].ToString();

        try
        {
            DT_MLJ_in mljIn = new DT_MLJ_in();
            mljIn.Rphead = new DT_Rphead();
            mljIn.Rphead.BUSID = busID;
            if (productType == "1")
                mljIn.Rphead.BUSTYP = "0003";
            else
                mljIn.Rphead.BUSTYP = "0004";
            mljIn.Rphead.TLDID = "LLMILIS002";
            mljIn.Rphead.TLGNAM = "RetProductions";
            mljIn.Rphead.DTSEND = DateTime.Now.ToString("yyyyMMddHHmmss");
            mljIn.Rphead.SENDER = "MLJ";
            mljIn.Rphead.RECIEVER = "SAP";
            //mljIn.Rphead.Dummy1 = "重处理时，填入上次错误返回时的BUSID";

            mljIn.RetProductions = new DT_RetProductionsRetProduction[dsRetproductions.Tables[0].Rows.Count];
            for (int i = 0; i < dsRetproductions.Tables[0].Rows.Count; i++)
            {
                mljIn.RetProductions[i] = new DT_RetProductionsRetProduction();
                mljIn.RetProductions[i].Serid = dsRetproductions.Tables[0].Rows[i]["ObjID"].ToString();
                mljIn.RetProductions[i].ProductType = "03";
                mljIn.RetProductions[i].Plant = "8000";
                mljIn.RetProductions[i].HeadMatCode = dsRetproductions.Tables[0].Rows[i]["MaterCode"].ToString();//dsRetproductions.Tables[0].Rows[i]["SAPMaterialShortCode"].ToString();
                mljIn.RetProductions[i].HeadMatVersion = dsRetproductions.Tables[0].Rows[i]["SAPVersionID"].ToString();
                mljIn.RetProductions[i].Qty = dsRetproductions.Tables[0].Rows[i]["TotalWeight"].ToString();
                mljIn.RetProductions[i].PostDate = Convert.ToDateTime(dsRetproductions.Tables[0].Rows[0]["PlanDate"].ToString()).ToString("yyyyMMdd");
                mljIn.RetProductions[i].DocDate = Convert.ToDateTime(dsRetproductions.Tables[0].Rows[0]["PlanDate"].ToString()).ToString("yyyyMMdd");
                mljIn.RetProductions[i].StorageLoc = dsRetproductions.Tables[0].Rows[i]["ERPCode"].ToString();
                mljIn.RetProductions[i].ComponentMat = dsRetproductions.Tables[0].Rows[i]["Barcode"].ToString();
            }

            //调取SAP方法将数据传值给SAP提供的接口
            SI_MLJ_outService outService = new SI_MLJ_outService();
            outService.Credentials = credential;
            outService.SI_MLJ_out(mljIn);
        }
        catch (Exception ex)
        {
            //写入错误日志                                                                                                                                                                                                                                                                                                                                                                   
            AppendWebLog(busID, "0003", "", dsRetproductions.Tables[0].Rows[0]["OperPerson"].ToString(), "0", ex.ToString(), "1", isReload);
            return "调用接口异常：" + ex.ToString();
        }
        //写入日志
        AppendWebLog(busID, "0003", "", dsRetproductions.Tables[0].Rows[0]["OperPerson"].ToString(), "0", string.Empty, "0", isReload);

        return "OK";
    }
    #endregion

    #region 胶料出库--SAP属于调拨
    public string SetRubberAdjustInfo(string barcode, string cancelFlag, string isReload)
    {
        string sqlAdjustInfo = @"select C.ERPCode SourceStorage, D.ERPCode TargetStorage, A.Barcode, A.LLBarcode2 Batch, E.SAPMaterialShortCode, B.RealWeight AdjustWeight, A.OperPerson, G.ShiftName
                                from PpmRubberStorage A
	                                left join PpmSemiStorage B on A.Barcode = B.Barcode
	                                left join BasStorage C on A.StorageID = C.StorageID
	                                left join BasStorage D on B.StorageID = D.StorageID
	                                left join BasMaterial E on A.MaterCode = E.MaterialCode
                                    left join (select top 1 * from PpmRubberStorageDetail where Barcode = '" + barcode + @"' and OperType = '002' and RubberType = 'O') F on A.Barcode = F.Barcode
                                    left join PptShift G on F.ShiftID = G.ObjID
                                where A.StockFlag = '1' and A.BarCode = '" + barcode + "'";

        DataSet dsInfo = _InterfaceDBAdapter.ds(sqlAdjustInfo);

        if (dsInfo.Tables[0].Rows.Count == 0)
        {
            return "No Data";
        }

        try
        {
            DT_Comm_in commIn = new DT_Comm_in();
            commIn.Rphead = new Rphead();
            commIn.Rphead.MSGID = barcode;
            commIn.Rphead.BUSID = barcode;
            commIn.Rphead.BUSTYP = "003";
            commIn.Rphead.TLDID = "LLCOMM0001";
            commIn.Rphead.TLGNAM = "MatMove";
            commIn.Rphead.DTSEND = DateTime.Now.ToString("yyyyMMddHHmmss");
            commIn.Rphead.SENDER = "MLJ";
            commIn.Rphead.RECIEVER = "SAP";
            //commIn.Rphead.Dummy1 = "重处理时，填入上次错误返回时的MSGID";

            commIn.GoodsMovements = new DT_GoodsMovements_inGoodsMovement[] { new DT_GoodsMovements_inGoodsMovement() };
            commIn.GoodsMovements[0].MovHeader = new DT_GoodsMovements_inGoodsMovementMovHeader();
            commIn.GoodsMovements[0].MoveItem = new DT_GoodsMovements_inGoodsMovementMoveItem[dsInfo.Tables[0].Rows.Count];

            commIn.GoodsMovements[0].MovHeader.DocDate = DateTime.Now.ToString("yyyyMMdd");
            commIn.GoodsMovements[0].MovHeader.PostDate = DateTime.Now.ToString("yyyyMMdd");
            commIn.GoodsMovements[0].MovHeader.HeadTXT = dsInfo.Tables[0].Rows[0]["ShiftName"].ToString();
            for (int i = 0; i < dsInfo.Tables[0].Rows.Count; i++)
            {
                commIn.GoodsMovements[0].MoveItem[i] = new DT_GoodsMovements_inGoodsMovementMoveItem();
                commIn.GoodsMovements[0].MoveItem[i].Reservation = "";
                if (cancelFlag == "0")
                    commIn.GoodsMovements[0].MoveItem[i].MovType = "311";
                else
                    commIn.GoodsMovements[0].MoveItem[i].MovType = "312";
                commIn.GoodsMovements[0].MoveItem[i].MaterialCode = dsInfo.Tables[0].Rows[i]["SAPMaterialShortCode"].ToString();
                commIn.GoodsMovements[0].MoveItem[i].PlantFrom = "8000";
                commIn.GoodsMovements[0].MoveItem[i].StorageLoc = dsInfo.Tables[0].Rows[0]["SourceStorage"].ToString();
                commIn.GoodsMovements[0].MoveItem[i].RecBatch = dsInfo.Tables[0].Rows[i]["Batch"].ToString();
                commIn.GoodsMovements[0].MoveItem[i].BarCode = dsInfo.Tables[0].Rows[i]["Barcode"].ToString();
                commIn.GoodsMovements[0].MoveItem[i].Qty = dsInfo.Tables[0].Rows[i]["AdjustWeight"].ToString();
                commIn.GoodsMovements[0].MoveItem[i].Unit = "KG";
                commIn.GoodsMovements[0].MoveItem[i].RecPlant = "8000";
                commIn.GoodsMovements[0].MoveItem[i].RecStoLoc = dsInfo.Tables[0].Rows[0]["TargetStorage"].ToString();
            }

            //调取SAP方法将数据传值给SAP提供的接口
            SI_Comm_outService outService = new SI_Comm_outService();
            outService.Credentials = credential;
            outService.SI_Comm_out(commIn);
        }
        catch (Exception ex)
        {
            //写入错误日志
            AppendWebLog(barcode, "003", "胶料出库", dsInfo.Tables[0].Rows[0]["OperPerson"].ToString(), cancelFlag, ex.Message.ToString(), "1", isReload);
            return "调用接口异常：" + ex.ToString();
        }

        //写入日志
        AppendWebLog(barcode, "003", "胶料出库", dsInfo.Tables[0].Rows[0]["OperPerson"].ToString(), cancelFlag, string.Empty, "0", isReload);

        return "OK";
    }
    #endregion

    #region 返回胶退回--SAP属于调拨
    public string SetReturnRubberAdjustInfo(string barcode, string cancelFlag, string isReload)
    {
        string sqlReturnRubberAdjustInfo = @"select F.ERPCode SourceStorage, C.ERPCode TargetStorage, '' Barcode, '' Batch, D.SAPMaterialShortCode, A.RealWeight AdjustWeight, A.OperPerson
                                            from PpmRubberStorage A
                                                left join PpmRubberStorageDetail B on A.StorageID = B.StorageID and A.StoragePlaceID = B.StoragePlaceID and A.Barcode = B.Barcode
                                                left join BasStorage C on A.StorageID = C.StorageID
                                                left join BasMaterial D on A.MaterCode = D.MaterialCode
                                                left join PpmReturnRubber E on A.Barcode = E.Barcode
                                                left join BasStorage F on E.StockNo = F.StorageID
                                            where A.Barcode = '" + barcode + "' and B.OperType = '008'";

        DataSet dsInfo = _InterfaceDBAdapter.ds(sqlReturnRubberAdjustInfo);

        if (dsInfo.Tables[0].Rows.Count == 0)
        {
            return "No Data";
        }

        try
        {
            DT_Comm_in commIn = new DT_Comm_in();
            commIn.Rphead = new Rphead();
            commIn.Rphead.MSGID = barcode;
            commIn.Rphead.BUSID = barcode;
            commIn.Rphead.BUSTYP = "008";
            commIn.Rphead.TLDID = "LLCOMM0001";
            commIn.Rphead.TLGNAM = "MatMove";
            commIn.Rphead.DTSEND = DateTime.Now.ToString("yyyyMMddHHmmss");
            commIn.Rphead.SENDER = "MLJ";
            commIn.Rphead.RECIEVER = "SAP";
            //commIn.Rphead.Dummy1 = "重处理时，填入上次错误返回时的MSGID";

            commIn.GoodsMovements = new DT_GoodsMovements_inGoodsMovement[] { new DT_GoodsMovements_inGoodsMovement() };
            commIn.GoodsMovements[0].MovHeader = new DT_GoodsMovements_inGoodsMovementMovHeader();
            commIn.GoodsMovements[0].MoveItem = new DT_GoodsMovements_inGoodsMovementMoveItem[dsInfo.Tables[0].Rows.Count];

            commIn.GoodsMovements[0].MovHeader.DocDate = DateTime.Now.ToString("yyyyMMdd");
            commIn.GoodsMovements[0].MovHeader.PostDate = DateTime.Now.ToString("yyyyMMdd");
            for (int i = 0; i < dsInfo.Tables[0].Rows.Count; i++)
            {
                commIn.GoodsMovements[0].MoveItem[i] = new DT_GoodsMovements_inGoodsMovementMoveItem();
                commIn.GoodsMovements[0].MoveItem[i].Reservation = "";
                if (cancelFlag == "0")
                    commIn.GoodsMovements[0].MoveItem[i].MovType = "311";
                else
                    commIn.GoodsMovements[0].MoveItem[i].MovType = "312";
                commIn.GoodsMovements[0].MoveItem[i].MaterialCode = dsInfo.Tables[0].Rows[i]["SAPMaterialShortCode"].ToString();
                commIn.GoodsMovements[0].MoveItem[i].PlantFrom = "8000";
                commIn.GoodsMovements[0].MoveItem[i].StorageLoc = dsInfo.Tables[0].Rows[0]["SourceStorage"].ToString();
                commIn.GoodsMovements[0].MoveItem[i].RecBatch = dsInfo.Tables[0].Rows[i]["Batch"].ToString();
                commIn.GoodsMovements[0].MoveItem[i].BarCode = dsInfo.Tables[0].Rows[i]["Barcode"].ToString();
                commIn.GoodsMovements[0].MoveItem[i].Qty = dsInfo.Tables[0].Rows[i]["AdjustWeight"].ToString();
                commIn.GoodsMovements[0].MoveItem[i].Unit = "KG";
                commIn.GoodsMovements[0].MoveItem[i].RecPlant = "8000";
                commIn.GoodsMovements[0].MoveItem[i].RecStoLoc = dsInfo.Tables[0].Rows[0]["TargetStorage"].ToString();
            }

            //调取SAP方法将数据传值给SAP提供的接口
            SI_Comm_outService outService = new SI_Comm_outService();
            outService.Credentials = credential;
            outService.SI_Comm_out(commIn);
        }
        catch (Exception ex)
        {
            //写入错误日志
            AppendWebLog(barcode, "008", "返回胶", dsInfo.Tables[0].Rows[0]["OperPerson"].ToString(), cancelFlag, ex.Message.ToString(), "1", isReload);
            return "调用接口异常：" + ex.ToString();
        }

        //写入日志
        AppendWebLog(barcode, "008", "返回胶", dsInfo.Tables[0].Rows[0]["OperPerson"].ToString(), cancelFlag, string.Empty, "0", isReload);

        return "OK";
    }
    #endregion

}
