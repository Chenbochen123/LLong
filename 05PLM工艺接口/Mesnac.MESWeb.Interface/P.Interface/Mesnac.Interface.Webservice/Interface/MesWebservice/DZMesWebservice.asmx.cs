using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Services;

namespace Mesnac.Interface.Webservice.MesWebservice
{
    using Mesnac.Interface.Webservice.MesInterface;
    using Mesnac.Interface.Business.Implements;
    using Mesnac.Interface.Business.Interface;
    using Mesnac.Interface.Entity.BasicEntity;

    /// <summary>
    /// DZMesWebservice 的摘要说明
    /// </summary>
    [WebService(Namespace = "http://tempuri.org/")]
    [WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
    //[WebServiceBinding(ConformsTo = WsiProfiles.None)]
    [System.ComponentModel.ToolboxItem(false)]
    // 若要允许使用 ASP.NET AJAX 从脚本中调用此 Web 服务，请取消注释以下行。 
    // [System.Web.Script.Services.ScriptService]
    public class DZMesWebservice : System.Web.Services.WebService
    {
        #region 系统日志  log
        private LogAgent.ILog log = LogAgent.Log.Instance;
        #endregion

        [WebMethod]
        public string HelloWorld()
        {
            log.Debug("HelloWorld");
            return "Hello World";
        }

        public string GetSapMSGs(MT_ReturnMSGsReturnMSG ReturnMSGs)
        {
            return "";
        }
        #region SAP调用,传递给MES的返回消息方法
        [WebMethod(Description = "SAP调用,传递给MES的返回消息方法")]
        public string MT_ReturnMSGs(MT_ReturnMSGsReturnMSG ReturnMSG)
        {
            log.Debug("方法调用：MT_ReturnMSGs(MT_ReturnMSGsReturnMSG ReturnMSG)");

            SaveSapLog(new SiiSapLog()
            {
                DeleteFlag = 0,
                MethodContent = "方法调用：MT_ReturnMSGs(MT_ReturnMSGsReturnMSG ReturnMSG)",
                MethodMemo = "SAP下传MES的返回消息接口方法",
                MethodName = "MT_ReturnMSGs",
            });
            if (ReturnMSG == null)
            {
                SaveSapLog(new SiiSapLog()
                {
                    Dummy1 = "Error",
                    DeleteFlag = 0,
                    MethodContent = "ReturnMSG == null",
                    MethodMemo = "SAP下传MES的返回消息接口方法 错误",
                    MethodName = "MT_ReturnMSGs",
                });
            }
            else
            {
                if (ReturnMSG.MSGHead == null)
                {
                    SaveSapLog(new SiiSapLog()
                    {
                        Dummy1 = "Error",
                        DeleteFlag = 0,
                        MethodContent = "ReturnMSG.MSGHead == null",
                        MethodMemo = "SAP下传MES的返回消息接口方法 错误",
                        MethodName = "GetSapMSGs",
                    });
                }

                if (ReturnMSG.MSGItem == null)
                {
                    SaveSapLog(new SiiSapLog()
                    {
                        Dummy1 = "Error",
                        DeleteFlag = 0,
                        MethodContent = "ReturnMSG.MSGItem == null",
                        MethodMemo = "SAP下传MES的返回消息接口方法 错误",
                        MethodName = "MT_ReturnMSGs",
                    });
                }
                else if (ReturnMSG.MSGItem.Length == 0)
                {
                    SaveSapLog(new SiiSapLog()
                    {
                        Dummy1 = "Error",
                        DeleteFlag = 0,
                        MethodContent = "ReturnMSG.MSGItem.Length == 0",
                        MethodMemo = "SAP下传MES的返回消息接口方法 错误",
                        MethodName = "MT_ReturnMSGs",
                    });
                }

            }
           

            try
            {
                MesMethod method = new MesMethod();
                return method.GetSapMSG(ReturnMSG);
            }
            catch (Exception ex)
            {
                log.Warn("SAP下传MES的返回消息接口方法 错误," + ex.Message, ex);
                SaveSapLog(new SiiSapLog()
                {
                    Dummy1 = "Error",
                    DeleteFlag = 0,
                    MethodContent = ex.Message,
                    MethodMemo = "SAP下传MES的返回消息接口方法 错误",
                    MethodName = "MT_ReturnMSGs",
                });

                throw ex;
            }

            return "";
        }

        #endregion SAP调用,传递给MES的返回消息方法 end

        #region SAP调用,传递给MES的XML数据方法

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

        #region 原先方法
        //[WebMethod(Description = "SAP调用,传递给MES的XML数据方法")]
        //public string GetSapXmlData(string ProcessCode
        //    , MT_DZECC_outDN[] DNs
        //    , MT_DZECC_outReservation[] Reservations
        //    , MT_DZECC_outPlanDN[] PlanDNs
        //    , MT_DZECC_outMatDoc[] MatDocs
        //    )
        //{
        //    log.Debug("方法调用：GetSapXmlData(string ProcessCode, DT_DNsDN[] DNs, DT_ReservationsReservation[] Reservations, DT_PlanDNsPlanDN[] PlanDNs, DT_MatDocsMatDoc[] MatDocs)");

        //    SaveSapLog(new SiiSapLog()
        //    {
        //        DeleteFlag = 0,
        //        MethodContent = "方法调用：GetSapXmlData(string ProcessCode, DT_DNsDN[] DNs, DT_ReservationsReservation[] Reservations, DT_PlanDNsPlanDN[] PlanDNs, DT_MatDocsMatDoc[] MatDocs)",
        //        MethodMemo = "SAP下传MES的接口方法",
        //        MethodName = "GetSapXmlData",
        //    });

        //    try
        //    {
        //        if (string.IsNullOrEmpty(ProcessCode))
        //        {
        //            SaveSapLog(new SiiSapLog()
        //            {
        //                Dummy1 = "Error",
        //                DeleteFlag = 0,
        //                MethodContent = "ProcessCode为空或空字符串",
        //                MethodMemo = "SAP下传MES的接口方法",
        //                MethodName = "GetSapXmlData",
        //            });
        //            throw new Exception("ProcessCode为空或空字符串");
        //        }
        //        log.Debug("ProcessCode=" + ProcessCode);
        //        if (DNs == null)
        //        {
        //            log.Debug("DNs == null");
        //        }
        //        if (Reservations == null)
        //        {
        //            log.Debug("Reservations == null");
        //        }
        //        if (PlanDNs == null)
        //        {
        //            log.Debug("PlanDNs == null");
        //        }
        //        if (MatDocs == null)
        //        {
        //            log.Debug("MatDocs == null");
        //        }

        //        MesMethod method = new MesMethod();
        //        return method.GetSapXmlData(ProcessCode
        //            , DNs
        //            , Reservations
        //            , PlanDNs
        //            , MatDocs
        //            );

        //    }
        //    catch(Exception ex)
        //    {
        //        log.Warn(ex.Message, ex);
        //        SaveSapLog(new SiiSapLog()
        //            {
        //                DeleteFlag = 0,
        //                MethodContent = ex.Message,
        //                MethodMemo = "SAP传递给MES的XML数据",
        //                MethodName = "GetSapXmlData",
        //                Dummy1 = "Error",
        //            });
        //        throw ex;
        //    }

        //    return "";
        //}
        #endregion

        #endregion SAP调用,传递给MES的XML数据方法 end

        #region 171129 SAP调用,传递给MES的XML数据方法重载（多一个参数）
        [WebMethod(Description = "SAP调用,传递给MES的XML数据方法重载")]
        public string GetSapXmlData(string ProcessCode
            , MT_DZECC_outDN[] DNs
            , MT_DZECC_outReservation[] Reservations
            , MT_DZECC_outPlanDN[] PlanDNs
            , MT_DZECC_outMatDoc[] MatDocs
            , MT_DZECC_outProductVersion[] ProductVersions
            )
        {
            log.Debug("方法调用：GetSapXmlData(string ProcessCode, DT_DNsDN[] DNs, DT_ReservationsReservation[] Reservations, DT_PlanDNsPlanDN[] PlanDNs, DT_MatDocsMatDoc[] MatDocs, MT_DZECC_outProductVersion[] ProductVersion)");

            SaveSapLog(new SiiSapLog()
            {
                DeleteFlag = 0,
                MethodContent = "方法调用：GetSapXmlData(string ProcessCode, DT_DNsDN[] DNs, DT_ReservationsReservation[] Reservations, DT_PlanDNsPlanDN[] PlanDNs, DT_MatDocsMatDoc[] MatDocs, MT_DZECC_outProductVersion[] ProductVersion)",
                MethodMemo = "SAP下传MES的接口方法",
                MethodName = "GetSapXmlData",
            });

            try
            {
                if (string.IsNullOrEmpty(ProcessCode))
                {
                    SaveSapLog(new SiiSapLog()
                    {
                        Dummy1 = "Error",
                        DeleteFlag = 0,
                        MethodContent = "ProcessCode为空或空字符串",
                        MethodMemo = "SAP下传MES的接口方法",
                        MethodName = "GetSapXmlData",
                    });
                    throw new Exception("ProcessCode为空或空字符串");
                }
                log.Debug("ProcessCode=" + ProcessCode);
                if (DNs == null)
                {
                    log.Debug("DNs == null");
                }
                if (Reservations == null)
                {
                    log.Debug("Reservations == null");
                }
                if (PlanDNs == null)
                {
                    log.Debug("PlanDNs == null");
                }
                if (MatDocs == null)
                {
                    log.Debug("MatDocs == null");
                }
                if (ProductVersions == null)
                {
                    log.Debug("ProductVersions == null");
                }

                MesMethod method = new MesMethod();
                return method.GetSapXmlData(ProcessCode
                    , DNs
                    , Reservations
                    , PlanDNs
                    , MatDocs
                    , ProductVersions
                    );

            }
            catch (Exception ex)
            {
                log.Warn(ex.Message, ex);
                SaveSapLog(new SiiSapLog()
                {
                    DeleteFlag = 0,
                    MethodContent = ex.Message,
                    MethodMemo = "SAP传递给MES的XML数据",
                    MethodName = "GetSapXmlData",
                    Dummy1 = "Error",
                });
                throw ex;
            }

            return "";
        }
        #endregion
    }
}
