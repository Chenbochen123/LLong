using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text.RegularExpressions;
using System.Web;
using System.Web.Services;
using Newtonsoft.Json;
//using Mesnac.Interface.Webservice.Interface.SapWebservice.mac;

namespace Mesnac.Interface.Webservice.SapWebservice
{
    /// <summary>
    /// DZSapWebservice 的摘要说明
    /// </summary>
    [WebService(Namespace = "http://tempuri.org/")]
    [WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
    [System.ComponentModel.ToolboxItem(false)]
    // 若要允许使用 ASP.NET AJAX 从脚本中调用此 Web 服务，请取消注释以下行。 
    // [System.Web.Script.Services.ScriptService]
    public class DZSapWebservice : System.Web.Services.WebService
    {

        private Regex regexTyreNo = new Regex("^[^(C|c)][0-9a-zA-Z]{9}$");
        private Regex regexGreenTyreNo = new Regex("^[^(C|c)][0-9a-zA-Z]{9}$");
        private LogAgent.ILog log = LogAgent.Log.Instance;

        [WebMethod]
        public string HelloWorld()
        {
            return "Hello World";
        }

        [WebMethod]
        public string CRMSearch(string tire_codes)
        {
            try
            {
                Mesnac.Interface.Business.Implements.PsmOutStockBillManager manager = new Mesnac.Interface.Business.Implements.PsmOutStockBillManager();
                Mesnac.InterfaceBG.Business.Implements.PsmOutStockBillManager bgmanager = new Mesnac.InterfaceBG.Business.Implements.PsmOutStockBillManager("BGDB");

                string ss = "";
                string[] str = tire_codes.Split(',');

                Dictionary<string, object> unitDic = new Dictionary<string, object>();
                DataTable crmDt = new DataTable();

                Mesnac.Interface.Webservice.Interface.SapWebservice.mac.datas datas = new Mesnac.Interface.Webservice.Interface.SapWebservice.mac.datas();
                Mesnac.Interface.Webservice.Interface.SapWebservice.mac.data[] df = new Mesnac.Interface.Webservice.Interface.SapWebservice.mac.data[str.Length];

                //log.Info(str.Length);

                for (int i = 0; i < str.Length; i++)
                {

                    Mesnac.Interface.Webservice.Interface.SapWebservice.mac.data ds = new Mesnac.Interface.Webservice.Interface.SapWebservice.mac.data();
                    unitDic.Clear();

                    if (regexTyreNo.IsMatch(str[i]))
                    {
                        // 硫化条码
                        ss = "green";
                    }
                    else
                    {
                        // 成型条码
                        ss = "tyre";
                    }

                    if (ss == "tyre")
                    {
                        log.Info(ss);
                        unitDic.Add("TYRE_NO", str[i]);
                    }
                    else
                    {
                        log.Info(ss);
                        unitDic.Add("GREEN_TYRE_NO", str[i]);
                    }

                    crmDt = manager.GetDataTableByStatement("getCrmDate", unitDic);

                    if (crmDt == null || crmDt.Rows.Count == 0)
                    {
                        crmDt = bgmanager.GetDataTableByStatement("getCrmDate", unitDic);
                    }

                    if (crmDt == null || crmDt.Rows.Count == 0)
                    {
                        //ds.remark = "没有找到任何数据";
                        //df[i] = ds;
                        continue;
                    }
                    log.Info("erp1001");
                    ds.tire_code = crmDt.Rows[0]["tyre_no"].ToString();

                    ds.doc_number = crmDt.Rows[0]["s_n_no"].ToString();
                    ds.account_code = crmDt.Rows[0]["customer_id"].ToString();
                    ds.product_code = crmDt.Rows[0]["material_name"].ToString();
                    ds.production_spec = crmDt.Rows[0]["material_code"].ToString();
                    //Convert.ToDateTime(crmDt.Rows[0]["end_time"].ToString()).ToShortDateString();
                    ds.manufacture_date = Convert.ToDateTime(crmDt.Rows[0]["end_time"].ToString()).ToString("yyyy-MM-dd");
                    
                    ds.outage_spec = crmDt.Rows[0]["material_code"].ToString();
                    ds.outage_time = crmDt.Rows[0]["record_time"].ToString();
                    ds.outage_date = crmDt.Rows[0]["record_time"].ToString();
                    ds.outage_grade = crmDt.Rows[0]["CHECK_GRADE_NAME"].ToString();
                    ds.remark = "调拨单备注" + crmDt.Rows[0]["remark1"].ToString() + ";" + "出库单备注" + crmDt.Rows[0]["remark2"].ToString() + ".";
                    ds.group_name = "德州厂";
                    df[i] = ds;
                    log.Info("erp1002");
                }
                datas.data = df;
                datas.msg = "获取信息成功";
                datas.code = "1";

                string jsonstr = JsonConvert.SerializeObject(datas);


                return jsonstr;
            }
            catch (Exception e )
            {
                log.Info(e.Message);
                return e.Message;
            }
        }

        [WebMethod]
        public DataSet CRMSearchTest(string barcode)
        {
            Mesnac.Interface.Business.Implements.PsmOutStockBillManager manager = new Mesnac.Interface.Business.Implements.PsmOutStockBillManager();
            Mesnac.InterfaceBG.Business.Implements.PsmOutStockBillManager bgmanager = new Mesnac.InterfaceBG.Business.Implements.PsmOutStockBillManager("BGDB");

            string ss = "";
            string[] str = barcode.Split(',');

            DataSet dse = new DataSet();

            Dictionary<string, object> unitDic = new Dictionary<string, object>();
            DataTable crmDt=new DataTable();

            Mesnac.Interface.Webservice.Interface.SapWebservice.mac.data data = new Mesnac.Interface.Webservice.Interface.SapWebservice.mac.data();

            

            for (int i = 0; i <= str.Length; i++)
            {
                Mesnac.Interface.Webservice.Interface.SapWebservice.mac.datas ds = new Mesnac.Interface.Webservice.Interface.SapWebservice.mac.datas();

                if (regexTyreNo.IsMatch(str[i]))
                {
                    // 硫化条码
                    ss = "green";
                }
                else
                {
                    // 成型条码
                    ss = "tyre";
                }

                if (ss == "tyre")
                {
                    log.Info(ss);
                    unitDic.Add("TYRE_NO", barcode);
                }
                else
                {
                    log.Info(ss);
                    unitDic.Add("GREEN_TYRE_NO", barcode);
                }


                crmDt = manager.GetDataTableByStatement("getCrmDate", unitDic);

                if (crmDt == null || crmDt.Rows.Count == 0)
                {
                    crmDt = bgmanager.GetDataTableByStatement("getCrmDate", unitDic);
                }
 
                dse.Tables.Add(crmDt.Copy());
                unitDic.Clear();

            }


            return dse;
        }


    }
}
