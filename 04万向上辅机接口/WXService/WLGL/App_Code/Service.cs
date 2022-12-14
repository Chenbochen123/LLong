using System;
using System.Web;
using System.Web.Services;
using System.Web.Services.Protocols;
using System.Data;
using System.Threading;
using System.IO;
//using Newtonsoft.Json;
using DBOperator;
using Mesnac.Utilities;
using XMLHandler;
using System.Collections.Generic;
using Ext.Net;
//using WebReference;

[WebService(Namespace = "http://tempuri.org/")]
[WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
public class Service : System.Web.Services.WebService
{
    //private Purview.Purview _purview;

    private DM _dm;

    public Service()
    {
        //如果使用设计的组件，请取消注释以下行 
        //InitializeComponent(); 

        CreateDM();
    }

    #region 私有方法

    /// <summary>
    /// 创建权限验证
    /// </summary>
    /// <returns></returns>
    private Purview.Purview CreatePurview()
    {
        Purview.Purview pv = new Purview.Purview(_dm);
        return pv;
    }

    /// <summary>
    /// 创建数据库连接
    /// </summary>
    private void CreateDM()
    {
        //连接动态传入
        string path = System.AppDomain.CurrentDomain.BaseDirectory;
        TXmlConfigHandler _config = new TXmlConfigHandler(path + "WebConfig.xml");
        string _ip = _config.ReadValue("IP");
        string _dbname = _config.ReadValue("DBName");
        string _user = _config.ReadValue("UserID");
        string _password = _config.ReadValue("Password");
        _dm = new DM(_ip, _user, _password, _dbname);
    }

    /// <summary>
    /// 获取配置项的值
    /// </summary>
    /// <param name="key"></param>
    /// <returns></returns>
    private string GetConfigValue(string key)
    {
        string path = System.AppDomain.CurrentDomain.BaseDirectory;
        TXmlConfigHandler _config = new TXmlConfigHandler(path + "WebConfig.xml");
        return _config.ReadValue(key);
    }

    /// <summary>
    /// 设置配置项的值
    /// </summary>
    /// <param name="key"></param>
    /// <returns></returns>
    private bool SetConfigValue(string key, string value)
    {
        string path = System.AppDomain.CurrentDomain.BaseDirectory;
        TXmlConfigHandler _config = new TXmlConfigHandler(path + "WebConfig.xml");
        return _config.WriteValue(key, value);
    }

    /// <summary>
    /// 追加日志记录
    /// </summary>
    /// <param name="userCode">用户编号</param>
    /// <param name="showName">显示名称</param>
    /// <param name="methodResult">函数执行结果</param>
    /// <param name="remark">备注</param>
    private void AppendWebLog(string userCode, string showName, string methodResult, string remark)
    {
        string userIP = HttpContext.Current.Request.UserHostAddress;
        string pageRequest = HttpContext.Current.Request.Url.ToString();

        System.Text.StringBuilder logSql = new System.Text.StringBuilder();
        logSql.AppendLine("insert into SysWebLog (UserCode, PageID, MethodID, UserIP, ShowName, MethodResult, PageRequest, Remark, RecordTime)");
        logSql.AppendLine(" values ('" + userCode + "', 0, 0, '" + userIP + "', '" + showName + "', '" + methodResult + "', '" + pageRequest + "', '" + remark.Replace("'", "''") + "', getdate())");
        _dm.ExecuteSql(logSql.ToString());
    }

    private string GetSerialBatchidString0000(string EquipCode, string ShiftId, string PlanDate, string MaterCode,string EdtCode)
    {
        string SerialBatchid=  "0001";


        string sql = string.Format(@"select 1 from PptLot where Equip_Code ='{0}' and Shift_Id= '{1}' and Plan_Date ='{2}' and Mater_Code ='{3}' and Edt_Code ='{4}'"
                                 , EquipCode, ShiftId, PlanDate, MaterCode, EdtCode);
        DataSet ds = _dm.ds(sql);
        if (ds.Tables[0].Rows.Count > 0)
            SerialBatchid = ds.Tables[0].Rows.Count.ToString().PadLeft(4, '0');
        return SerialBatchid;

    }
    /// <summary>
    /// 获取累计车次
    /// </summary>
    /// <param name="EquipCode">设备编码</param>
    /// <param name="ShiftId">班次</param>
    /// <param name="PlanDate">计划时间</param>
    /// <param name="MaterCode">物料编码</param>
    /// <returns></returns>
    private string GetSerialBatchid(string EquipCode, string ShiftId, string PlanDate, string MaterCode, string EdtCode)
    {
        string SerialBatchid = "1";


        string sql = string.Format(@"select 1 from PptLot where Equip_Code ='{0}' and Shift_Id= '{1}' and Plan_Date ='{2}' and Mater_Code ='{3}'  and Edt_Code ='{4}'"
                                 , EquipCode, ShiftId, PlanDate, MaterCode, EdtCode);
        DataSet ds = _dm.ds(sql);
        if (ds.Tables[0].Rows.Count > 0)
            SerialBatchid = (ds.Tables[0].Rows.Count + 1).ToString();
        return SerialBatchid;

    }

    /// <summary>
    /// 获取玲珑车次
    /// </summary>
    /// <param name="EquipCode"></param>
    /// <param name="ShiftId"></param>
    /// <param name="PlanDate"></param>
    /// <param name="MaterCode"></param>
    /// <returns></returns>
    private string GetLLSerialID(string EquipCode, string ShiftId, string PlanDate, string MaterCode)
    {
        string LLSerialID = "1";


        string sql = string.Format(@"select 1 from PptLot where Equip_Code ='{0}' and Shift_Id= '{1}' and Plan_Date ='{2}' and Mater_Code ='{3}'"
                                 , EquipCode, ShiftId, PlanDate, MaterCode);
        DataSet ds = _dm.ds(sql);
        if (ds.Tables[0].Rows.Count > 0)
            LLSerialID = ds.Tables[0].Rows.Count.ToString();
        return LLSerialID;

    }

    private string GetSerialBatchidList(string PlanID, string Serial_id,int ShelfLotCount)
    {
        string SerialBatchidList = "";
        if (Serial_id == "")
           return ""; 
        int ISerial_id = Convert.ToInt32(Serial_id);
        int I =1;

        string sql = "select PlanNum from PptPlan where PlanID='" + PlanID + "' ";
        DataSet ds = _dm.ds(sql);
        if (ds.Tables[0].Rows.Count > 0)
        {
            int PlanNum = Convert.ToInt32(ds.Tables[0].Rows[0]["PlanNum"].ToString());
            while ((I <= ShelfLotCount) && (ISerial_id <= PlanNum))
            {
                if (SerialBatchidList == "")
                {
                    SerialBatchidList = ISerial_id.ToString();
                }
                else
                {
                    SerialBatchidList = SerialBatchidList + "," + ISerial_id.ToString();
                }
                I = I + 1;
                ISerial_id = ISerial_id + 1;
            }
        }
        return SerialBatchidList;

    }




    private void InsertintoPptShiftConfig(string Barcode, string PlanDate, string EquipCode, string ShiftID, string ClassID,
                                          string MaterialCode, string MaterialName, string BarcodeStart, string BarcodeEnd, string TotalWeight,
                                          string ShelfNum, string RealWeight, string BarcodeUse, string MemNote, string CheckFlag, string PlanID,
                                          string ZJSID, string UserID, string LLMemNote, string LLBarCode)
    {
        string sql = "select PlanNum from PptPlan where PlanID='" + PlanID + "' ";
        DataSet ds = _dm.ds(sql);
        if (ds.Tables[0].Rows.Count > 0)
        {
            int PlanNum = Convert.ToInt32(ds.Tables[0].Rows[0]["PlanNum"].ToString());
            if (Convert.ToInt32(BarcodeEnd) > PlanNum)
            {
                BarcodeEnd = PlanNum.ToString();
            }
            
        }
        
        sql = string.Format(@"insert into pptshiftconfig (Barcode, PlanDate, EquipCode, ShiftID, ClassID, MaterialCode, 
                                    MaterialName, BarcodeStart, BarcodeEnd, TotalWeight, ShelfNum,
                                    RealWeight, BarcodeUse, MemNote, CheckFlag, PlanID, ZJSID,
                                    UserID, LLMemNote, LLBarCode) values
                                  ('{0}','{1}','{2}','{3}','{4}','{5}','{6}','{7}','{8}','{9}',
                                  '{10}','{11}','{12}','{13}','{14}','{15}','{16}',
                                  '{17}','{18}','{19}')"
                                 , Barcode, PlanDate, EquipCode, ShiftID, ClassID, MaterialCode, MaterialName, BarcodeStart,
                                 BarcodeEnd, TotalWeight, ShelfNum, RealWeight, BarcodeUse, MemNote, CheckFlag, PlanID, ZJSID,
                                 UserID, LLMemNote, LLBarCode);
        try
        {
            _dm.ExecuteSql(sql);
        }
        catch (Exception e)
        {
            AppendWebLog("WanXiang", "Error", "PptShiftConfig", sql.Replace("'", "-").Substring(0,490));
        }

    }

    private void UpdatePptPlanInfo(string PlanID, string UserID)
    {
        string sql = string.Format(@"update PptPlan set RealNum= RealNum + 1 ,UserID='{0}' where PlanID = '{1}'"
                                   , UserID, PlanID);

        _dm.ExecuteSql(sql);
    }

    private void UpdatePptLotShelfBarcode(string lotBarcode, string shelfBarcode)
    {
        string sql = string.Format(@"update PptLot set Shelf_BarCode='{0}' where barcode = '{1}'"
                                          , shelfBarcode, lotBarcode);
        _dm.ExecuteSql(sql);
    }

    private string GetShelfBarCode(string PlanID, string Serialid)
    {
        string sql = string.Format(@"select top 1 barcode from PPTShiftConfig where PlanID ='{0}' and BarcodeStart <= '{1}'  and BarcodeEnd >='{2}'"
                                        , PlanID, Serialid, Serialid);

        DataSet ds = _dm.ds(sql);
        if (ds.Tables[0].Rows.Count > 0)
        {
            return (ds.Tables[0].Rows[0]["barcode"].ToString());
        }
        else
        {
            return "0";
        }
    }
         
    #endregion 私有方法

 




 


   
    #region WX Get接口相关方法
    //[WebMethod]
    ////停机类型
    //public DataSet GetStopType()
    //{
    //    String sql = "select * from EqmStopType";
    //    DataSet ds = _dm.ds(sql);

    //    return ds;
    //}

    //[WebMethod]
    ////停机原因
    //public DataSet GetStopFault()
    //{
    //    String sql = "select * from EqmStopFault";
    //    DataSet ds = _dm.ds(sql);

    //    return ds;
    //}


    [WebMethod]
    public DataSet GetMaterialInfo(String Equip_Code)
    {
        String sql = @"select materialcode , materialname,minortypename, validdate from basmaterial left join BasMaterialMinorType
on basmaterial.majortypeid =BasMaterialMinorType.majorid 
and basmaterial.minortypeid =BasMaterialMinorType.minortypeid";
        sql = @"    select distinct * from
     (select distinct M.MaterialCode ,M.materialname, CASE 
     when SUBSTRING( M.MaterialCode,1,3) = '101'   then    '胶料'
     when SUBSTRING( M.MaterialCode,1,3) = '102'   then    '胶料'
     when SUBSTRING( M.MaterialCode,1,3) = '103'   then    '胶料'
     when SUBSTRING( M.MaterialCode,1,3) = '104'   then    '炭黑'
     when SUBSTRING( M.MaterialCode,1,3) = '107'   then    '塑解剂'
     when SUBSTRING( M.MaterialCode,1,3) = '114'   then    '油料'
     when SUBSTRING( M.MaterialCode,1,3) = '201'   then    '小料'
     when SUBSTRING( M.MaterialCode,1,3) = '202'   then    '小料'
     when SUBSTRING( M.MaterialCode,1,1) = '4'   then    '胶料'
     else '其他' end as minortypename
     from PmtRecipeWeight w, BasMaterial M  
     where w.MaterialCode=M.MaterialCode and w.RecipeEquipCode='" + Equip_Code + @"'
     and charindex('塑解',M.MaterialName,1)=0 and charindex('油',M.MaterialName,1)=0
       
      union all
       
       select distinct MaterialCode ,MaterialName,minortypename = '炭黑' from BasMaterial 
       where MajorTypeID=1 and MinorTypeID in ('04') 
       and (MaterialSimpleName='炭黑' or charindex('碳酸钙',MaterialSimpleName,1)>0 
       or (charindex('油',MaterialSimpleName,1)>0 
       and charindex('树脂',MaterialSimpleName,1)=0 and charindex('膏',MaterialSimpleName,1)=0)
       or charindex('塑解',MaterialSimpleName,1)>0 )
       union all
       
       select distinct MaterialCode ,MaterialName,minortypename = '油料' from BasMaterial 
       where MajorTypeID=1 and MinorTypeID in ('07') 
       and (MaterialSimpleName='炭黑' or charindex('碳酸钙',MaterialSimpleName,1)>0 
       or (charindex('油',MaterialName,1)>0 
       and charindex('树脂',MaterialSimpleName,1)=0 and charindex('膏',MaterialSimpleName,1)=0)
        )
        
         union all
      
      
      select distinct MaterialCode ,MaterialName,minortypename = '塑解剂' from BasMaterial 
      where MajorTypeID=1 and MinorTypeID in ('07') 
      and ( charindex('塑解',MaterialName,1)>0 )
       
       union all
       
       
       
       select distinct b.MaterialCode, b.MaterialName,
      minortypename=( case when SUBSTRING( b.MaterialCode,1,3) = '202'   then    '小料'
      when SUBSTRING( b.MaterialCode,1,3) = '201'   then    '小料'
       else '胶料' end)
       from PmtRecipe R inner join basmaterial B 
       on b.MaterialCode =R.RecipeMaterialCode
    
       
     ) T order by MaterialCode
     
     

     
     
 ";
        DataSet ds = _dm.ds(sql);
       
        return  ds;
    
    }
    [WebMethod]
    public DataSet GetRecipeInfo(String Equip_Code,String Mater_Code,String RecipeType , String Version_Id )
    {

        String sql = "select *  from pmtrecipe where RecipeEquipcode = '" + Equip_Code + "'  and recipematerialcode ='" + Mater_Code + "' and recipeversionid ='" + Version_Id + "' and recipetype ='" + RecipeType + "' and recipestate ='1' ";
        DataSet ds = _dm.ds(sql);

        return ds;
    
      
    }

    [WebMethod]
    public DataSet GetRecipeWeightInfo(String RecipeObjid)
    {
        String sql = "select *  from pmtrecipeweight left join pptweighttype on weighttype = id where Recipeobjid = '" + RecipeObjid + "' order  by weighttype, weightid ";
       
        DataSet ds = _dm.ds(sql);

        return ds;

    }
    [WebMethod]
    public DataSet GetpmtTermInfo()
    {
        String sql = "select * from pmtTerm ";

        DataSet ds = _dm.ds(sql);

        return ds;

    }
    [WebMethod]
    public DataSet GetRecipeMixInfo(String RecipeObjid)
    {
        String sql = "select *  from pmtrecipemixing where Recipeobjid = '" + RecipeObjid + "'   ";

        DataSet ds = _dm.ds(sql);

        return ds;

    }
    [WebMethod]
    public DataSet GetJarStoreInfo(String Equip_Code)
    {
        String sql = "select PmtEquipJarStore.*,MaterialName  from PmtEquipJarStore left join  basmaterial on PmtEquipJarStore.materialcode=basmaterial.materialcode where EquipCode = '" + Equip_Code + "'   ";

        DataSet ds = _dm.ds(sql);

        return ds;

    }


    [WebMethod]
    public DataSet GetActionInfo()
    {
        String sql = "select *  from PmtAction ";

        DataSet ds = _dm.ds(sql);

        return ds;

    }
    [WebMethod]
    public DataSet GetRubWeightSet(String Equip_Code)
    {
        String sql = "select *  from PmtRubWeightSetting where EquipCode =  '"+Equip_Code+"' ";

        DataSet ds = _dm.ds(sql);

        return ds;

    }
    [WebMethod]
    public DataSet GetPlanInfo(String Equip_Code ,String PlanDate ,String Shiftid)
    {
        String sql = "select *  from pptplan where RecipeEquipCode = '" + Equip_Code + "'  and plandate = '" + PlanDate + "' and shiftid ='" + Shiftid + "' and planstate > '1' ";

        DataSet ds = _dm.ds(sql);

        return ds;

    }
    #endregion
    #region WX Set接口相关方法

    [WebMethod]
    //上辅机日志
    public String SetFeedingLog(string EquipCode, DateTime dt, string oper, string opertype, string OperDest, string OperMemo)
    {
        String sql ="";
        try {
          sql = "insert into PptFeedingLog values ('" + EquipCode + "','" + dt + "','" + oper + "','" + opertype + "','基本操作','" + OperDest + "','" + OperMemo + "')";
        DataSet ds = _dm.ds(sql);
    }
    catch (Exception e)
    {
        AppendWebLog("WanXiang", "Error", "SetLotIngo", sql.Replace("'", "-"));
        return e.Message;
    }

        return "ok";

    }

    [WebMethod]
    //停机记录
    public String SetStopRecord(string EquipCode, DateTime StartTime, DateTime EndTime, string ShiftID, string ClassName)
    {
        String sql = "";
        string sClassName ="";
        if (ClassName == "1")
            sClassName = "甲";
        else
            if (ClassName == "2")
                sClassName = "乙";
            else
                if (ClassName == "3")
                    sClassName = "丙";
                else
                    if (ClassName == "4")
                        sClassName = "丁";
        try
        {
            
            sql = "insert into EqmStopRecord  (EquipCode,ShiftID,ClassName,StartTime,EndTime) values ('" + EquipCode + "','" + ShiftID + "','" + sClassName + "','" + StartTime.ToString("yyyy-MM-dd HH:mm:ss") + "','" + Convert.ToDateTime(EndTime).ToString("yyyy-MM-dd HH:mm:ss") + "' )";
            DataSet ds = _dm.ds(sql);
        }
        catch (Exception e)
        {
            AppendWebLog("WanXiang", "Error", "SetStopRecord", sql.Replace("'", "-"));
            return e.Message;
        }

        return "ok";

    }


    [WebMethod]
    //停机记录
    public String SetStopRecordNew(string EquipCode, string StartTime, string EndTime, string ShiftID, string ClassName)
    {
        String sql = "";
        string sClassName = "";
        if (ClassName == "1")
            sClassName = "甲";
        else
            if (ClassName == "2")
                sClassName = "乙";
            else
                if (ClassName == "3")
                    sClassName = "丙";
                else
                    if (ClassName == "4")
                        sClassName = "丁";
        try
        {

            sql = "insert into EqmStopRecord  (EquipCode,ShiftID,ClassName,StartTime,EndTime) values ('" + EquipCode + "','" + ShiftID + "','" + sClassName + "','" + Convert.ToDateTime(StartTime).ToString("yyyy-MM-dd HH:mm:ss") + "','" + Convert.ToDateTime(EndTime).ToString("yyyy-MM-dd HH:mm:ss") + "' )";
            DataSet ds = _dm.ds(sql);
        }
        catch (Exception e)
        {
            AppendWebLog("WanXiang", "Error", "SetStopRecordNew", sql.Replace("'", "-"));
            return e.Message;
        }

        return "ok";

    }

    [WebMethod]
    public String SetLotIngo(string Barcode, string Serial_id, string Shelf_Barcode, string Mater_Code, string Equip_Code, string Edt_Code, string Shift_Id, string Shift_Class, string plan_ID, string LLSerial_ID, string Start_Datetime, string Set_Weight
        , string Real_Weight, string UserID, string Done_Allrtime, string Done_Rtime, string Bwb_Time, string Rub_Time, string Cb_Time, string Oil_Time , string Pj_Temp, string Pj_Power,
        string Pj_Energy, string Statu, string Lot_Energy)
    {
        String sql = "select * from pptlot where barcode ='"+Barcode+"' ";
        DataSet ds = _dm.ds(sql);

        try {
            if (ds.Tables[0].Rows.Count == 0)
            {
                String Plan_Date   ="";
                String Mater_Name  = "";
                int Shelf_LotCount = 1;
                string ZJSID = "";

                sql = "select Top 1 PlanDate,PP.RecipeMaterialName,PR.ShelfLotCount from PptPlan PP"
                     +" left join PmtRecipe PR on pp.RecipeEquipCode = Pr.RecipeEquipCode"
                     +" and pp.RecipeMaterialCode = pr.RecipeMaterialCode"
                     +" and pp.RecipeVersionID = pr.RecipeVersionID"
                     +" where PlanID ='" + plan_ID + "' ";

                DataSet dsPlan = _dm.ds(sql);
                if (dsPlan.Tables[0].Rows.Count > 0)
                {
                    Plan_Date      = Convert.ToDateTime(dsPlan.Tables[0].Rows[0]["PlanDate"].ToString()).ToString("yyyy-MM-dd");
                    Mater_Name     = dsPlan.Tables[0].Rows[0]["RecipeMaterialName"].ToString();
                    Shelf_LotCount = Convert.ToInt32(dsPlan.Tables[0].Rows[0]["ShelfLotCount"].ToString()); 
                }

                sql = "Select MainHanderCode From BasMainHander  where UserCode='" + UserID + "' ";

                DataSet dsUser = _dm.ds(sql);
                if (dsUser.Tables[0].Rows.Count > 0)
                {
                     ZJSID = dsUser.Tables[0].Rows[0]["MainHanderCode"].ToString();  
                }
                string SerialBatchid = GetSerialBatchid(Equip_Code, Shift_Id, Plan_Date, Mater_Code, Edt_Code);

                sql = string.Format(@"insert into pptlot (Barcode,Plan_Date,Serial_id,Shelf_Barcode,Mater_Code,Mater_Name,Equip_Code,Edt_Code,Shift_Id,
                                   Shift_Class,plan_ID,LLSerialID,Start_Datetime,max_time,Set_Weight,Real_Weight,Worker_barcode,ZJSID,Done_Allrtime,
                                   Done_Rtime,Bwb_Time,Poly_DisTime,Cb_DisTime,Oil_DisTime,Pj_Temp,Pj_Power,Pj_Ener,Mix_Status,Lot_Energy,Serial_Batchid) values
                                  ('{0}','{1}','{2}','{3}','{4}','{5}','{6}','{7}','{8}','{9}',
                                  '{10}','{11}','{12}','{13}','{14}','{15}','{16}',
                                  '{17}','{18}','{19}','{20}','{21}','{22}','{23}','{24}','{25}','{26}','{27}','{28}','{29}')"
                                 , Barcode, Plan_Date,Serial_id, Shelf_Barcode, Mater_Code,Mater_Name, Equip_Code, Edt_Code, Shift_Id,
                                 Shift_Class, plan_ID, LLSerial_ID, Start_Datetime, Start_Datetime, Set_Weight, Real_Weight, UserID, ZJSID, Done_Allrtime,
                                 Done_Rtime, Bwb_Time, Rub_Time, Cb_Time, Oil_Time, Pj_Temp, Pj_Power, Pj_Energy, Statu, Lot_Energy, SerialBatchid);
            _dm.ExecuteSql(sql);


            if ((Serial_id == "1") || ((Convert.ToInt32(Serial_id) % Shelf_LotCount) == 1))
            {

                string tSerialBatchid = GetSerialBatchidString0000(Equip_Code, Shift_Id, Plan_Date, Mater_Code, Edt_Code);

                string SerialBatchidList = GetSerialBatchidList(plan_ID, Serial_id, Shelf_LotCount);
                string ShelfBarCode = plan_ID + "1" + tSerialBatchid + Shelf_LotCount.ToString();

                InsertintoPptShiftConfig(
                                        ShelfBarCode,
                                        Plan_Date,
                                        Equip_Code,
                                        Shift_Id,
                                        Shift_Class,
                                        Mater_Code,
                                        Mater_Name,
                                        Serial_id,
                                        (Convert.ToInt32(Serial_id) + Convert.ToInt32(Shelf_LotCount) - 1).ToString(),
                                        Set_Weight,
                                        Shelf_LotCount.ToString(),
                                        "0",
                                        "0",
                                        SerialBatchidList,
                                        "N",
                                        plan_ID,
                                        ZJSID,
                                        UserID,

                                        SerialBatchidList,
                                        ""
                                        );
                UpdatePptLotShelfBarcode(Barcode, ShelfBarCode);
            }
            else
            {
                string ShelfBarCode = GetShelfBarCode(plan_ID, Serial_id);
                UpdatePptLotShelfBarcode(Barcode, ShelfBarCode);
            }

            //更新计划实际生产数量和人员
            UpdatePptPlanInfo(plan_ID, UserID);
            try
            { 
              sql = "EXEC Proc_MainBarTraceDZ '" + Barcode + "','" + Serial_id + "','" + plan_ID + "',''";

              _dm.ExecuteSql(sql);
            }
            catch (Exception e)
            {
                AppendWebLog("WanXiang", "Error", "Proc_MainBarTraceDZ", sql.Replace("'", "-"));
                return e.Message;
            }
          

            }
            else
            {//Shelf_Barcode='{2}',
                sql = string.Format(@"update pptlot set Serial_id='{1}',Mater_Code='{3}',Equip_Code='{4}',Edt_Code='{5}',Shift_Id='{6}',
                                    Shift_Class='{7}',plan_ID='{8}',LLSerialID='{9}',Start_Datetime='{10}',Set_Weight='{11}',Real_Weight='{12}',
                                    Worker_barcode='{13}',Done_Allrtime='{14}',Done_Rtime='{15}',Bwb_Time='{16}',Poly_DisTime='{17}',
                                    Cb_DisTime='{18}',Oil_DisTime='{19}',Pj_Temp='{20}',Pj_Power='{21}',Pj_Ener='{22}',Mix_Status='{23}',Lot_Energy='{24}' 
                                   where Barcode = '{0}'"
                                   , Barcode, Serial_id, Shelf_Barcode, Mater_Code, Equip_Code, Edt_Code, Shift_Id, 
                                   Shift_Class, plan_ID, LLSerial_ID, Start_Datetime, Set_Weight, Real_Weight, 
                                   UserID, Done_Allrtime, Done_Rtime, Bwb_Time, Rub_Time, Cb_Time, Oil_Time, 
                                   Pj_Temp, Pj_Power, Pj_Energy, Statu, Lot_Energy);

                _dm.ExecuteSql(sql);
            
            
            }
        
            
        }
        catch (Exception e)
        {
            AppendWebLog("WanXiang", "Error", "SetLotIngo", sql.Replace("'", "-"));
            return e.Message; }



        return "OK";

    }

    [WebMethod]
    public String SetAlarmIngo(String Equip_Code, String Alarm_Code, DateTime Alarm_Time, String Alarm_Message, String Alarm_Barcode)
    {
        string sql = "";
         try {
             sql = string.Format(@"insert into PptAlarm values ('{0}','{1}','{2}','{3}')", Alarm_Barcode, Alarm_Message, Alarm_Time, Equip_Code);
             _dm.ExecuteSql(sql);
         }
         catch (Exception e)
         {
             AppendWebLog("WanXiang", "Error", "SetAlarmIngo", sql.Replace("'", "-"));
             return e.Message;
         }
   
         //FSReference.BasicHttpBinding_ShipmentService ws = new FSReference.BasicHttpBinding_ShipmentService();
         //FSReference.ShipmentDocument ship = new FSReference.ShipmentDocument();
         //ship.DocumentNumber = "";
         //ship.SenderWarehouseCode = "";
         //string[] ss = new string[100];
         //ship.TyreSerialNumbers = ss;
         //ws.CreateDocument(ship);
        return "OK";
    }


    [WebMethod]
    public String SetWeightInfo(String Barcode, int Weight_id, String Mater_Code, String Mater_name, String Equip_Code, String Mater_Barcode
        , Double Set_Weight, Double Real_Weight, Double Error_Out, Double Error_Allow, String Warning_Sgn, DateTime Weigh_Time, String Weigh_Type, String Weigh_State)
    {
        String sql = "select * from PptWeigh where barcode ='" + Barcode + "' and  Mater_Code = '" + Mater_Code + "'";
        DataSet ds ;
        if (Weigh_Type == "0") Weigh_Type = "炭黑";
        if (Weigh_Type == "1") Weigh_Type = "油料";
        if (Weigh_Type == "2") Weigh_Type = "胶料";
        if (Weigh_Type == "3") Weigh_Type = "自动小料";
        if (Weigh_Type == "5") Weigh_Type = "油秤";


        
        string PlanID = Barcode.Substring(0,12);
        string PlanDate ="";
        string serialID = Convert.ToInt32(Barcode.Substring(Barcode.Length - 4, 4)).ToString();
        string CheckWeight = "0";//Math.Round(Real_Weight,3).ToString();
        string CheckSetWeight = Math.Round( Set_Weight,3).ToString();
        string CheckSetError = Math.Round(Error_Allow,3).ToString();

       

        try
        {
            string sqlPlan = "select Top 1 PlanDate from PptPlan "
                         + " where PlanID ='" + PlanID + "' ";

            DataSet dsPlan = _dm.ds(sqlPlan);
            if (dsPlan.Tables[0].Rows.Count > 0)
            {
                PlanDate = Convert.ToDateTime(dsPlan.Tables[0].Rows[0]["PlanDate"].ToString()).ToString("yyyy-MM-dd");
            }
        }
        catch (Exception e)
        {
            AppendWebLog("WanXiang", "Error", "SetWeightInfo", sql.Replace("'", "-"));
            return e.Message;
        }


       
        try
        {
            ds = _dm.ds(sql);
            if (ds.Tables[0].Rows.Count == 0)
            {
                sql = string.Format(@"insert into PptWeigh (Barcode,Weight_id,Mater_Code,Mater_name,Equip_Code,Mater_Barcode,Set_Weight
                                     ,Real_Weight,Error_Out,Error_Allow,Warning_Sgn,Weigh_Time
                                     ,Weigh_Type,Weigh_State,Plan_id,Plan_date,serial_id,Check_weight,Check_SetWeight,Check_SetError) values
                                    ('{0}','{1}','{2}','{3}','{4}','{5}','{6}','{7}','{8}','{9}','{10}','{11}','{12}','{13}','{14}','{15}','{16}','{17}','{18}','{19}')", 
                                     Barcode, Weight_id, Mater_Code, Mater_name, Equip_Code, Mater_Barcode, Math.Round(Set_Weight,3).ToString()
                                    , Math.Round(Real_Weight,3).ToString(), Math.Round(Error_Out,3).ToString(), Math.Round(Error_Allow,3).ToString(), Warning_Sgn,
                                    Convert.ToDateTime(Weigh_Time).ToString("yyyy-MM-dd HH:mm:ss")
                                    , Weigh_Type, Weigh_State, PlanID, PlanDate, serialID, CheckWeight, CheckSetWeight, CheckSetError);
                //AppendWebLog("WanXiang", "Error", "SetWeightInfo", sql.Replace("'", "-").Substring(0, 490));
                _dm.ExecuteSql(sql);
            }
            else
            {
                sql = string.Format(@"update PptWeigh set Mater_Code='{2}',Mater_name='{3}',Equip_Code='{4}',Mater_Barcode='{5}',Set_Weight='{6}',
                                     Real_Weight='{7}',Error_Out='{8}',Error_Allow='{9}',Warning_Sgn='{10}',Weigh_Time='{11}',
                                     Weigh_Type='{12}',Weigh_State='{13}'  where Barcode = '{0}' and Weight_id='{1}'"
                                     , Barcode, Weight_id, Mater_Code, Mater_name, Equip_Code, Mater_Barcode, Set_Weight.ToString()
                                     , Real_Weight.ToString(), Error_Out.ToString(), Error_Allow.ToString(), Warning_Sgn, Weigh_Time
                                     , Weigh_Type, Weigh_State);

                _dm.ExecuteSql(sql);


            }


        }
        catch (Exception e)
        {
            AppendWebLog("WanXiang", "Error", "SetWeightInfo", sql.Replace("'", "-"));
            return e.Message;
        }


        return "OK";
    }
      [WebMethod]
    public String SetMixInfo(String Barcode, int Mix_id, int Act_code, int Term_code, Double Set_time, Double Set_temp
        , Double Set_power, Double Set_pres, Double Set_rota, Double Set_ener, DateTime Save_Time, Double PFTemp, Double PFEner
          , Double PFPower, Double PFPres, Double PFRota, int MixStatus, int MixActTime)
    {
        String sql = "select * from PptMixData where barcode ='" + Barcode + "' and  Mix_id = " + Mix_id;
        DataSet ds = _dm.ds(sql);
        //AppendWebLog("WanXiang", "Error", "SetMixInfo", sql.Replace("'", "-"));
        try
        {
            if (ds.Tables[0].Rows.Count == 0)
            {
                //sql = string.Format(@"insert into PptMixData (Barcode,Mix_id,Act_code,Term_code,Set_time,Set_temp,Set_power
 //,Set_pres,Set_rota,Set_ener,Save_Time,PFTemp
//PFEner,PFPower,PFPres,PFRota,MixStatus,MixActTime) values
//('{0}','{1}','{2}','{3}','{4}','{5}','{6}','{7}','{8}','{9}','{10}','{11}','{12}','{13}','{14}','{15}','{16}','{17}')", Barcode, Mix_id, Act_code, Term_code, Set_time, Set_temp, Set_power
//,Set_pres,Set_rota,Set_ener,Save_Time,PFTemp
//,PFEner,PFPower,PFPres,PFRota,MixStatus,MixActTime);
                sql = string.Format(@"insert into PptMixData (Barcode,Mix_id,Act_code,Term_code,MixActTime,PFTemp,PFPower
,PFPres,PFRota,PFEner,Save_Time,Set_temp
, Set_ener,Set_power,Set_pres,Set_rota,MixStatus,Set_time) values
('{0}','{1}','{2}','{3}','{4}','{5}','{6}','{7}','{8}','{9}','{10}','{11}','{12}','{13}','{14}','{15}','{16}','{17}')", Barcode, Mix_id, Act_code, Term_code, Set_time, Set_temp, Set_power
,Set_pres,Set_rota,Set_ener,Save_Time,PFTemp
,PFEner,PFPower,PFPres,PFRota,MixStatus,MixActTime);
                _dm.ExecuteSql(sql);
            }
            else
            {
                //sql = string.Format(@"update PptMixData set Act_code='{2}',Term_code='{3}',Set_time='{4}',Set_temp='{5}',Set_power='{6}',
//Set_pres='{7}',Set_rota='{8}',Set_ener='{9}',Save_Time='{10}',PFTemp='{11}',
//PFEner='{12}',PFPower='{13}',PFPres='{14}',PFRota='{15}',MixStatus='{16}',MixActTime='{17}'  where Barcode = '{0}' and Mix_id='{1}'"
//                    , Barcode, Mix_id, Act_code, Term_code, Set_time, Set_temp, Set_power
//, Set_pres, Set_rota, Set_ener, Save_Time, PFTemp
//, PFEner, PFPower, PFPres, PFRota, MixStatus, MixActTime);

                sql = string.Format(@"update PptMixData set Act_code='{2}',Term_code='{3}',Set_time='{17}',Set_temp='{11}',Set_power='{13}',
Set_pres='{14}',Set_rota='{15}',Set_ener='{12}',Save_Time='{10}',PFTemp='{5}',
PFEner='{9}',PFPower='{6}',PFPres='{7}',PFRota='{8}',MixStatus='{16}',MixActTime='{4}'  where Barcode = '{0}' and Mix_id='{1}'"
                    , Barcode, Mix_id, Act_code, Term_code, Set_time, Set_temp, Set_power
, Set_pres, Set_rota, Set_ener, Save_Time, PFTemp
, PFEner, PFPower, PFPres, PFRota, MixStatus, MixActTime);

                _dm.ExecuteSql(sql);


            }


        }
        catch (Exception e)
        {
            AppendWebLog("WanXiang", "Error", "SetMixInfo", sql.Replace("'", "-"));
            return e.Message;
        }
        return "OK";
    }



      [WebMethod]
      public String SetMixInfo1(String Barcode, int Mix_id, int Act_code, int Term_code, Double Set_time, Double Set_temp
          , Double Set_power, Double Set_pres, Double Set_rota, Double Set_ener, DateTime Save_Time, Double PFTemp, Double PFEner
            , Double PFPower, Double PFPres, Double PFRota, int MixStatus, int MixActTime,int PFTime)
      {
          String sql = "select * from PptMixData where barcode ='" + Barcode + "' and  Mix_id = " + Mix_id;
          DataSet ds = _dm.ds(sql);
          //AppendWebLog("WanXiang", "Error", "SetMixInfo", sql.Replace("'", "-"));
          try
          {
              if (ds.Tables[0].Rows.Count == 0)
              {
                  //sql = string.Format(@"insert into PptMixData (Barcode,Mix_id,Act_code,Term_code,Set_time,Set_temp,Set_power
                  //,Set_pres,Set_rota,Set_ener,Save_Time,PFTemp
                  //PFEner,PFPower,PFPres,PFRota,MixStatus,MixActTime) values
                  //('{0}','{1}','{2}','{3}','{4}','{5}','{6}','{7}','{8}','{9}','{10}','{11}','{12}','{13}','{14}','{15}','{16}','{17}')", Barcode, Mix_id, Act_code, Term_code, Set_time, Set_temp, Set_power
                  //,Set_pres,Set_rota,Set_ener,Save_Time,PFTemp
                  //,PFEner,PFPower,PFPres,PFRota,MixStatus,MixActTime);
                  sql = string.Format(@"insert into PptMixData (Barcode,Mix_id,Act_code,Term_code,PFTime,PFTemp,PFPower
,PFPres,PFRota,PFEner,Save_Time,Set_temp
, Set_ener,Set_power,Set_pres,Set_rota,MixStatus,Set_time,MixActTime) values
('{0}','{1}','{2}','{3}','{4}','{5}','{6}','{7}','{8}','{9}','{10}','{11}','{12}','{13}','{14}','{15}','{16}','{17}','{18}')", Barcode, Mix_id, Act_code, Term_code, Set_time, Set_temp, Set_power
  , Set_pres, Set_rota, Set_ener, Save_Time, PFTemp
  , PFEner, PFPower, PFPres, PFRota, MixStatus, MixActTime, PFTime);
                  _dm.ExecuteSql(sql);
              }
              else
              {
                  //sql = string.Format(@"update PptMixData set Act_code='{2}',Term_code='{3}',Set_time='{4}',Set_temp='{5}',Set_power='{6}',
                  //Set_pres='{7}',Set_rota='{8}',Set_ener='{9}',Save_Time='{10}',PFTemp='{11}',
                  //PFEner='{12}',PFPower='{13}',PFPres='{14}',PFRota='{15}',MixStatus='{16}',MixActTime='{17}'  where Barcode = '{0}' and Mix_id='{1}'"
                  //                    , Barcode, Mix_id, Act_code, Term_code, Set_time, Set_temp, Set_power
                  //, Set_pres, Set_rota, Set_ener, Save_Time, PFTemp
                  //, PFEner, PFPower, PFPres, PFRota, MixStatus, MixActTime);

                  sql = string.Format(@"update PptMixData set Act_code='{2}',Term_code='{3}',Set_time='{17}',Set_temp='{11}',Set_power='{13}',
Set_pres='{14}',Set_rota='{15}',Set_ener='{12}',Save_Time='{10}',PFTemp='{5}',
PFEner='{9}',PFPower='{6}',PFPres='{7}',PFRota='{8}',MixStatus='{16}',PFTime='{4}',MixActTime='{18}'  where Barcode = '{0}' and Mix_id='{1}'"
                      , Barcode, Mix_id, Act_code, Term_code, Set_time, Set_temp, Set_power
  , Set_pres, Set_rota, Set_ener, Save_Time, PFTemp
  , PFEner, PFPower, PFPres, PFRota, MixStatus, MixActTime, PFTime);

                  _dm.ExecuteSql(sql);


              }


          }
          catch (Exception e)
          {
              AppendWebLog("WanXiang", "Error", "SetMixInfo", sql.Replace("'", "-"));
              return e.Message;
          }
          return "OK";
      }
     [WebMethod]
      public String SetCurveInfo(String Barcode, String Plan_date, String Plan_id, DateTime Start_datetime,
String Mixing_Time,String Mixing_Temp,String Mixing_Power,String Mixing_Energy,String Mixing_Press,
         String Mixing_Speed, String Mixing_position, String Mixing_Blend)
      {
          String sql = "select * from MENSCurve.dbo.Ppt_curvedata where barcode ='" + Barcode + "' ";
          DataSet ds = _dm.ds(sql);
          try
          {
              string serialID = Convert.ToInt32(Barcode.Substring(Barcode.Length - 4, 4)).ToString();
              if (ds.Tables[0].Rows.Count == 0)
              {
                  sql = string.Format(@"insert into MENSCurve.dbo.Ppt_curvedata  (Barcode,Plan_date,Plan_id,Start_datetime,Mixing_Time,
Mixing_Temp,Mixing_Power
,Mixing_Energy,Mixing_Press,Mixing_Speed,Mixing_position,Mixing_Blend,Serial_id) values
('{0}','{1}','{2}','{3}','{4}','{5}','{6}','{7}','{8}','{9}','{10}','{11}','{12}')", Barcode, Plan_date, Plan_id, Start_datetime, Mixing_Time, Mixing_Temp, Mixing_Power
  , Mixing_Energy, Mixing_Press, Mixing_Speed, Mixing_position, Mixing_Blend, serialID);
                  _dm.ExecuteSql(sql);
              }
              else
              {
                  sql = string.Format(@"update  MENSCurve.dbo.Ppt_curvedata set Plan_date='{1}',Plan_id='{2}',Start_datetime='{3}',Mixing_Time='{4}',Mixing_Temp='{5}',Mixing_Power='{6}',
Mixing_Energy='{7}',Mixing_Press='{8}',Mixing_Speed='{9}',Mixing_position='{10}',Mixing_Blend='{11}' where Barcode = '{0}' "
                      , Barcode, Plan_date, Plan_id, Start_datetime, Mixing_Time, Mixing_Temp, Mixing_Power
  , Mixing_Energy, Mixing_Press, Mixing_Speed,Mixing_position, Mixing_Blend);

                  _dm.ExecuteSql(sql);


              }


          }
          catch (Exception e)
          {
              AppendWebLog("WanXiang", "Error", "SetCurveInfo", sql.Replace("'", "-").Substring(0, 490));
              return e.Message;
          }
          return "OK";
     }
     [WebMethod]
     public String SetShiftInfo(String Plan_date, String Equip_Code, int Shift_id, int shift_Classid, string User_id)
     {
         String sql = "Select * from BasUser Where HRCode = '" + User_id + "'  And DeleteFlag = 0 ";
         DataSet ds = _dm.ds(sql);
         string username = "";
         try
         {
             if (ds.Tables[0].Rows.Count == 0)
             { return "人员编码不存在"; }
             username=ds.Tables[0].Rows[0]["UserName"].ToString();
             sql = "Exec proc_SFJHuanBan '" + Plan_date + "','" + Equip_Code + "','" + Shift_id + "','" + User_id + "' ";
             ds = _dm.ds(sql);

             sql = @" Update Ppt_WorkerShiftRecord Set FSIGN = 2,MemNote = '已下班'
Where FSIGN = 1 and HRCode='" + User_id + "' And EquipCode = '" + Equip_Code + "'";
             ds = _dm.ds(sql);
             sql = @"Insert Into Ppt_WorkerShiftRecord (HRCode,HrName,ZJSID,EquipCode,FShiftDate,MemNote,FSIGN) 
Values('" + User_id + "','" + username + "','" + User_id + "','" + Equip_Code + "',Convert(Varchar(19),GetDate(),120),'上班',1) ";
  
           
         }
         catch (Exception e)
         {
             AppendWebLog("WanXiang", "Error", "SetShiftInfo", sql.Replace("'", "-"));
             return e.Message;
         }


         return "OK";
     }

      [WebMethod]
     public String UpdatePlanState(String PlanID, int PlanState)
    {
          if (PlanState<3)
              return "更新计划状态必须大于2";
          if(PlanID.Length!=12)
              return "计划ID长度必须为12";
    String sql = "update pptplan set   PlanState = '" + PlanState + "'  Where   planid = '" + PlanID + "' ";
             try
         {
    DataSet ds = _dm.ds(sql);

    
        
    if (PlanState == 4)
    {   String  EquipCpde="";
          sql = "Select * from PptPlan Where planid = '" + PlanID + "'   ";
          ds = _dm.ds(sql);
        if(ds.Tables[0].Rows.Count>0)
        {EquipCpde = ds.Tables[0].Rows[0]["RecipeEquipCode"].ToString();
        sql = "Delete from PptPreShelfBarDZ Where EquipCode = '" + EquipCpde + "' ";
        ds = _dm.ds(sql);
        sql = "Delete from PptShelfBarDZ Where EquipCode ='" + EquipCpde + "'";
        ds = _dm.ds(sql);
        sql = " Delete from PpmLineSideLib where UsedFlag='2' and StoragePlaceID in   (select StockKW from BasEquip where EquipCode='" + EquipCpde + "')"; //删除线边库中使用完毕物料
        ds = _dm.ds(sql);
        }
    
    }
    if (PlanState == 4)
    {
        sql = "update pptplan set RealStartTime = getdate()  Where   planid = '" + PlanID + "' ";
        _dm.ds(sql);
    }

    if (PlanState == 5)
    {
        sql = "update pptplan set RealEndtime = getdate()  Where   planid = '" + PlanID + "' ";
        _dm.ds(sql);
    }

         }
             catch (Exception e)
             {
                 AppendWebLog("WanXiang", "Error", "UpdatePlanState", sql.Replace("'", "-"));
                 return e.Message;
             }
  
          
          
          
          
          
          return "OK";
     }



      [WebMethod]
      public String UpdatePlanNum(String PlanID, int PlanNum)
      {
          //if (PlanNum < 3)
          //    return "更新计划状态必须大于2";
          if (PlanID.Length != 12)
              return "计划ID长度必须为12";
          String sql = "update pptplan set   PlanNum = '" + PlanNum + "'  Where   planid = '" + PlanID + "' ";
          DataSet ds;
           try
         {
             ds = _dm.ds(sql);
         }
           catch (Exception e)
           {
               AppendWebLog("WanXiang", "Error", "UpdatePlanNum", sql.Replace("'", "-"));
               return e.Message;
           }


          return "OK";

      }
    #endregion 
}

