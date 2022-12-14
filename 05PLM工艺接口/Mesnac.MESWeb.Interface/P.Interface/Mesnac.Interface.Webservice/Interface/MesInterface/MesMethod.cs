using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace Mesnac.Interface.Webservice.MesInterface
{
    using Mesnac.Interface.Business.Interface;
    using Mesnac.Interface.Business.Implements;
    using Mesnac.Interface.Entity.BasicEntity;

    // using Mesnac.Interface.Entity.SapEntity;
    //using Mesnac.Interface.Webservice.SapInterface;
    public class MesMethod
    {
        #region 系统日志  log
        private LogAgent.ILog log = LogAgent.Log.Instance;
        #endregion

        #region 消息接口处理

        public string GetSapMSG(MT_ReturnMSGsReturnMSG ReturnMSG)
        {
            try
            {
                string s_ReturnMSG = getJsonByObject(ReturnMSG);
                SaveSapLog(new SiiSapLog() { 
                    DeleteFlag = 0,
                    MethodContent = s_ReturnMSG,
                    MethodMemo = "ReturnMSG转换Json字符串",
                    MethodName = "GetSapMSG",
                });
            }
            catch(Exception ex)
            {
                log.Warn("ReturnMSG转换Json字符串 错误," + ex.Message, ex);
                SaveSapLog(new SiiSapLog()
                {
                    Dummy1 = "Error",
                    DeleteFlag = 0,
                    MethodContent = ex.Message,
                    MethodMemo = "ReturnMSG转换Json字符串 错误",
                    MethodName = "GetSapMSG",
                });
            }

            try
            {
                if (ReturnMSG.MSGItem[0].MSTYP.ToUpper() == "E")
                {
                    SaveSapLog(new SiiSapLog()
                    {
                        Dummy1 = "Error",
                        DeleteFlag = 0,
                        MethodContent = ReturnMSG.MSGItem[0].ERRDES,
                        MethodMemo = "返回错误消息 E",
                        MethodName = "GetSapMSG",
                    });
                }
            }
            catch (Exception ex)
            {
                log.Warn("" + ex.Message, ex);
                SaveSapLog(new SiiSapLog()
                {
                    Dummy1 = "Error",
                    DeleteFlag = 0,
                    MethodContent = ex.Message,
                    MethodMemo = "判断ReturnMSG.MSGItem[0].MSTYP=E 错误",
                    MethodName = "GetSapMSG",
                });
            }

            
            switch (ReturnMSG.MSGHead.BUSTYP)
            {
                case "2001":
                    UpdateSapFlag_OutStockBill(ReturnMSG);
                    break;
                case "MoldingProduct":
                    UpdateMoldingProductSuccessFlag(ReturnMSG);
                    break;
                case "CuringProduct":
                    UpdateProductCuringSuccessFlag(ReturnMSG);
                    break;
                case "PSM_IN":
                    GetStorageReturnMsg(ReturnMSG);
                    break;
                default:
                    break;
            }

            return "";
        }

        private string UpdateProductCuringSuccessFlag(MT_ReturnMSGsReturnMSG ReturnMSG)
        {
            try
            {
                IItfSapProductionRecordsManager manager = new ItfSapProductionRecordsManager();
                ISiiSapLogManager logManager = new SiiSapLogManager();
                SiiSapLog log = new SiiSapLog();
                if (ReturnMSG != null && ReturnMSG.MSGItem != null && ReturnMSG.MSGItem.Length > 0)
                {
                    foreach (MT_ReturnMSGsReturnMSGMSGItem item in ReturnMSG.MSGItem)
                    {
                        var dic = new Dictionary<string, object>();
                        if (item.MSTYP == "E")
                        {
                            log.MethodContent += (item.SERID + "硫化E ");
                            dic.Add("SuccessFlag", 3);
                        }
                        else if (item.MSTYP == "S")
                        {
                            log.MethodContent += (item.SERID + "硫化S ");
                            dic.Add("SuccessFlag", 2);
                        }
                        else
                        {
                            log.MethodContent += (item.SERID + "硫化N ");
                            dic.Add("SuccessFlag", 4);
                        }
                        dic.Add("SerId", item.SERID);
                        dic.Add("ReturnMsg", item.ERRDES);
                        manager.UpdateByStatement("UpdateCuringProductSuccessFlag", dic);
                    }
                    log.MethodMemo = "Curing";
                    logManager.Insert(log);
                }
                return "1";
            }
            catch (Exception ex)
            {
                return ex.ToString();
            }
        }

        private string GetStorageReturnMsg(MT_ReturnMSGsReturnMSG ReturnMSG)
        {
            ISiiSapLogManager logManager = new SiiSapLogManager();
            PsmMesStorageQtyManager manager = new PsmMesStorageQtyManager();
            if (ReturnMSG != null && ReturnMSG.MSGItem != null && ReturnMSG.MSGItem.Length > 0)
            {
                foreach (MT_ReturnMSGsReturnMSGMSGItem item in ReturnMSG.MSGItem)
                {
                    SiiSapLog log = new SiiSapLog();
                    var dic = new Dictionary<string, object>();
                    if (item.MSTYP == "E")
                    {
                        log.MethodMemo = "E";
                        dic.Add("SuccessFlag",3);
                        
                    }
                    else if (item.MSTYP == "S")
                    {
                        log.MethodMemo = "S";
                        dic.Add("SuccessFlag", 2);
                    }
                    else
                    {
                        log.MethodMemo = "N";
                        dic.Add("SuccessFlag", 4);
                    }
                    string tmpMSG = item.ERRDES + "  " + item.SAPID;
                    if (tmpMSG.Length > 1300)
                    {
                        tmpMSG = tmpMSG.Substring(0, 1300);
                    }
                    dic.Add("BusID", ReturnMSG.MSGHead.BUSID);
                    dic.Add("ReturnMsg", tmpMSG);
                    string tempStr = item.MSTYP + "|" + ReturnMSG.MSGHead.BUSID + "|" + item.ERRDES + "|" + item.SAPID;
                    if (tempStr.Length > 1300)
                    {
                        tempStr = tempStr.Substring(0, 1300);
                    }
                    log.MethodContent = tempStr;
                    log.RecordTime = DateTime.Now;
                    log.DeleteFlag = 0;
                    logManager.Insert(log);
                    manager.UpdateByStatement("UpdateStorageSuccessFlag", dic);
                    manager.UpdateByStatement("UpdateStorageHeadSuccessFlag", dic);
                }
            }
            return "1";
        }

        private string UpdateMoldingProductSuccessFlag(MT_ReturnMSGsReturnMSG ReturnMSG)
        {
            try
            {
                IItfSapProductionRecordsManager manager = new ItfSapProductionRecordsManager();
                ISiiSapLogManager logManager = new SiiSapLogManager();
                SiiSapLog log = new SiiSapLog();
                if (ReturnMSG != null && ReturnMSG.MSGItem != null && ReturnMSG.MSGItem.Length > 0)
                {
                    foreach (MT_ReturnMSGsReturnMSGMSGItem item in ReturnMSG.MSGItem)
                    {
                        var dic = new Dictionary<string, object>();
                        if (item.MSTYP == "E")
                        {
                            log.MethodContent +=(item.SERID+"成型E ");
                            dic.Add("SuccessFlag", 3);
                        }
                        else if (item.MSTYP == "S")
                        {
                            log.MethodContent += (item.SERID + "成型S ");
                            dic.Add("SuccessFlag", 2);
                        }
                        else
                        {
                            log.MethodContent += (item.SERID + "成型N ");
                            dic.Add("SuccessFlag", 4);
                        }
                        dic.Add("SerId", item.SERID);
                        dic.Add("ReturnMsg", item.ERRDES);
                        manager.UpdateByStatement("UpdateMoldingProductSuccessFlag", dic);
                    }
                    log.MethodMemo = "Molding";
                    logManager.Insert(log);
                }
                return "1";
            }
            catch (Exception ex)
            {
                return ex.ToString();
            }
        }             

        private string UpdateSapFlag_OutStockBill(MT_ReturnMSGsReturnMSG ReturnMSG)
        {
            string outStockBillId = ReturnMSG.MSGHead.BUSID;
            IPsmOutStockBillManager manager = new PsmOutStockBillManager();

            string s_MSTYP = string.IsNullOrEmpty(ReturnMSG.MSGItem[0].MSTYP) ? "" : ReturnMSG.MSGItem[0].MSTYP;
            string s_ERRDES = string.IsNullOrEmpty(ReturnMSG.MSGItem[0].ERRDES) ? "" : ReturnMSG.MSGItem[0].ERRDES;

            manager.UpdateByObjId(new PsmOutStockBill() {
                Remark = s_MSTYP + "|" + s_ERRDES,
                UpdateTime = DateTime.Now,
                UpdateUserId = 0,
            }, Convert.ToInt32(outStockBillId));
            return "";
        }

        #endregion 消息接口处理 end

        public string Get()
        {
            var manger = new PsbCustomerManager();
            if (manger == null)
            {
                throw new Exception("manager = null");
            }
            else
            {
                var entity = new PsbCustomer();
                manger.GetRowCount(entity);
            }
            return "a";
            return new PsbCustomerManager().GetEntityList(new PsbCustomer() { }).Count.ToString();
        }

        #region 下传接口处理

        public string GetSapXmlData(string ProcessCode
            , MT_DZECC_outDN[] DNs
            , MT_DZECC_outReservation[] Reservations
            , MT_DZECC_outPlanDN[] PlanDNs
            , MT_DZECC_outMatDoc[] MatDocs
            )
        {
            string result = "";
            SaveSapLog(new SiiSapLog() { 
                DeleteFlag = 0,
                MethodContent = "ProcessCode=" + ProcessCode,
                MethodMemo = "MesMethod.GetSapXmlData",
                MethodName = "GetSapXmlData",
            });

            switch (ProcessCode.ToUpper())
            {
                case "N":
                    // 内向交货单
                    return GetSapXmlData_DNs(DNs);
                    break;
                case "Y":
                    // 预留单
                    return GetSapXmlData_Reservations(Reservations);
                    break;
                case "H":
                    // 计划发货/退货
                    log.Debug("H:计划发货/退货");
                    return GetSapXmlData_PlanDNs(PlanDNs);
                    break;
                default:
                    throw new Exception("未找到相关业务类型" + ",ProcessCode=" + ProcessCode);
                    break;
            }

            return result;
        }

        #region 171129 下传接口处理方法重载
        public string GetSapXmlData(string ProcessCode
            , MT_DZECC_outDN[] DNs
            , MT_DZECC_outReservation[] Reservations
            , MT_DZECC_outPlanDN[] PlanDNs
            , MT_DZECC_outMatDoc[] MatDocs
            , MT_DZECC_outProductVersion[] ProductVersions
            )
        {
            string result = "";
            SaveSapLog(new SiiSapLog()
            {
                DeleteFlag = 0,
                MethodContent = "ProcessCode=" + ProcessCode,
                MethodMemo = "MesMethod.GetSapXmlData",
                MethodName = "GetSapXmlData",
            });

            switch (ProcessCode.ToUpper())
            {
                case "N":
                    // 内向交货单
                    return GetSapXmlData_DNs(DNs);
                    break;
                case "Y":
                    // 预留单
                    return GetSapXmlData_Reservations(Reservations);
                    break;
                case "H":
                    // 计划发货/退货
                    log.Debug("H:计划发货/退货");
                    return GetSapXmlData_PlanDNs(PlanDNs);
                    break;
                case "E":
                    // 生产版本
                    log.Debug("E:生产版本");
                    return GetMaterProductVersions(ProductVersions);
                    break;
                default:
                    throw new Exception("未找到相关业务类型" + ",ProcessCode=" + ProcessCode);
                    break;
            }

            return result;
        }

        public string GetMaterProductVersions(MT_DZECC_outProductVersion[] ProductVersions)
        {
            log.Debug("GetMaterProductVersions(MT_DZECC_outProductVersion[] ProductVersions)");

            string s_ProductVersions = getJsonByObject(ProductVersions);
            log.Debug(s_ProductVersions);

            SaveSapLog(new SiiSapLog()
            {
                DeleteFlag = 0,
                MethodContent = s_ProductVersions,
                MethodMemo = "MesMethod.GetMaterProductVersions",
                MethodName = "GetMaterProductVersions",
            });

            foreach (MT_DZECC_outProductVersion ProductVersion in ProductVersions)
            {
                try
                {
                    GetSapXmlData_MaterProductVersion(ProductVersion);
                }
                catch (Exception ex)
                {
                    log.Warn(ex.Message, ex);
                    string No = string.Empty;
                    No = ProductVersion.MaterialCode;
                    SaveSapLog(new SiiSapLog()
                    {
                        DeleteFlag = 0,
                        MethodContent = ex.Message,

                        MethodMemo = "生产版本下传,单个物料错误，物料code：" + No,
                        MethodName = "GetMaterProductVersions",
                        Dummy1 = "Error",
                    });
                }
            }

            return "";
        }

        public string GetSapXmlData_MaterProductVersion(MT_DZECC_outProductVersion ProductVersion)
        {
            log.Debug("调用方法：GetSapXmlData_MaterProductVersion(MT_DZECC_outProductVersion ProductVersion)");
            var manager = new Mesnac.Interface.Business.Implements.SbmMaterialProductionverManager();

            try
            {
                manager.BeginTransaction();

                string MaterialCode = ProductVersion.MaterialCode;
                string Plant = ProductVersion.Plant;
                string ProductionVer = ProductVersion.ProductionVer;
                string VerDesc = ProductVersion.VerDesc;
                string CostColStatus = ProductVersion.CostColStatus;
                //string MatStatus = ProductVersion.MatStatus;
                string MatStatus = string.IsNullOrEmpty(ProductVersion.MatStatus) ? "" : ProductVersion.MatStatus;
                string Mksp = ProductVersion.Mksp;
                string Dummy1 = ProductVersion.Dummy1;
                string Dummy2 = ProductVersion.Dummy2;
                string Dummy3 = ProductVersion.Dummy3;
                string Dummy4 = ProductVersion.Dummy4;

                IList<SbmMaterialProductionver> lstProductionVer = GetProductionVerList(new SbmMaterialProductionver()
                {
                    DeleteFlag = 0,
                    SapCode = MaterialCode,
                    ProductionVer = ProductionVer
                }, "");
                SbmMaterialProductionver materialProductionver = null;
                string dbSapCode = "";
                string dbProductionVer = "";
                if (lstProductionVer.Count == 0)
                {
                    #region 创建物料生产版本
                    // 创建物料生产版本
                    materialProductionver = InsertMaterialProductionver(new SbmMaterialProductionver()
                    {
                        SapCode = MaterialCode,
                        ProductionVer = ProductionVer,
                        VerDesc = VerDesc,
                        Plant = Plant,
                        CostcolStatus = CostColStatus,
                        MatStatus = MatStatus,
                        MKsp = Mksp,
                        DeleteFlag = 0,
                        Dummy1 = Dummy1,
                        Dummy2 = Dummy2,
                        Dummy3 = Dummy3,
                        Dummy4 = Dummy4,
                        RecordTime = DateTime.Now,
                        RecordUserId = 0,
                        BackupTime = DateTime.Now,
                        BackupFlag = 0,
                    });
                    #endregion 
                }
                else
                {
                    #region 更新物料生产版本
                    materialProductionver = lstProductionVer[0];
                    dbSapCode = materialProductionver.SapCode.ToString();
                    dbProductionVer = materialProductionver.ProductionVer.ToString();
                    // 更新物料生产版本
                    UpdateMaterialProductionver(new SbmMaterialProductionver()
                    {
                        VerDesc = VerDesc,
                        Plant = Plant,
                        CostcolStatus = CostColStatus,
                        MatStatus = MatStatus,
                        MKsp = Mksp,
                        DeleteFlag = 0,
                        Dummy1 = Dummy1,
                        Dummy2 = Dummy2,
                        Dummy3 = Dummy3,
                        Dummy4 = Dummy4,
                        BackupTime = DateTime.Now,
                        BackupFlag = 0,
                    }, new SbmMaterialProductionver() 
                    {
                        SapCode = dbSapCode,
                        ProductionVer = dbProductionVer
                    });

                    #endregion
                }
                manager.CompleteTransaction();
            }
            catch (Exception ex)
            {
                manager.RollbackTransaction();
                log.Warn(ex.Message, ex);
                SaveSapLog(new SiiSapLog()
                {
                    DeleteFlag = 0,
                    MethodContent = ex.Message,
                    MethodMemo = "生产版本下传,更新数据",
                    MethodName = "GetSapXmlData_MaterProductVersion",
                    Dummy1 = "Error",
                });
                if (ex.InnerException != null)
                {
                    throw new Exception(ex.Message, ex.InnerException);
                }
                throw ex;
            }


            return "";
        }

        /// <summary>
        /// 获取物料版本
        /// </summary>
        /// <param name="entity"></param>
        /// <param name="orderby"></param>
        /// <returns></returns>
        private IList<SbmMaterialProductionver> GetProductionVerList(SbmMaterialProductionver entity, string orderby)
        {
            ISbmMaterialProductionverManager manager = new SbmMaterialProductionverManager();
            return manager.GetEntityList(entity, string.IsNullOrEmpty(orderby) ? "SAP_CODE" : orderby);
        }

        /// <summary>
        /// 插入物料生产版本
        /// </summary>
        /// <param name="entity"></param>
        /// <returns></returns>
        private SbmMaterialProductionver InsertMaterialProductionver(SbmMaterialProductionver entity)
        {
            ISbmMaterialProductionverManager manager = new SbmMaterialProductionverManager();
            manager.Insert(entity);
            return entity;
        }

        /// <summary>
        /// 更新物料生产版本
        /// </summary>
        /// <param name="entity"></param>
        /// <param name="objId"></param>
        /// <returns></returns>
        private int UpdateMaterialProductionver(SbmMaterialProductionver entity, SbmMaterialProductionver where)
        {
            ISbmMaterialProductionverManager manager = new SbmMaterialProductionverManager();
            return manager.Update(entity, where);
        }
        #endregion

        public string GetSapXmlData_DNs(MT_DZECC_outDN[] DNs)
        {
            return "";
        }

        public string GetSapXmlData_Reservations(MT_DZECC_outReservation[] Reservations)
        {
            log.Debug("GetSapXmlData_Reservations(MT_DZECC_outReservation[] Reservations)");
            SaveSapLog(new SiiSapLog()
            {
                DeleteFlag = 0,
                MethodContent = "",
                MethodMemo = "预留单下传接口调用开始",
                MethodName = "GetSapXmlData_Reservations",
            });
            if (Reservations == null)
            {
                SaveSapLog(new SiiSapLog()
                {
                    Dummy1 = "Error",
                    DeleteFlag = 0,
                    MethodContent = "Reservations == null",
                    MethodMemo = "MesMethod.GetSapXmlData_Reservations的参数Reservations为空",
                    MethodName = "GetSapXmlData_Reservations",
                });
                throw new Exception("参数Reservations为空");
            }
            string s_Reservations = getJsonByObject(Reservations);
            log.Debug(s_Reservations);

            SaveSapLog(new SiiSapLog()
            {
                DeleteFlag = 0,
                MethodContent = s_Reservations,
                MethodMemo = "Reservations转Json字符串",
                MethodName = "GetSapXmlData_Reservations",
            });

            Check_Reservations_MovType(Reservations);

            Check_Reservations_ReserNo(Reservations);

            var q_ReserNo =
            from p in Reservations
            group p by p.ReserNo into g
            select new
            {
                g.Key,
                numproducts = g.Count()
            };

            foreach (var i_ReserNo in q_ReserNo)
            {
                try
                {
                    MT_DZECC_outReservation[] Reservations_Single =
                        Reservations.Where(m => m.ReserNo == i_ReserNo.Key).ToArray();

                    Check_Reservations(Reservations_Single);

                    switch (Reservations_Single[0].MovType)
                    {
                        case "311":
                            // 调拨单
                            Check_Reservations_Transfer(Reservations_Single);
                            GetSapXmlData_Reservations_Transfer(Reservations_Single);
                            break;
                        case "Z07":
                            // 赠品调拨单
                            Check_Reservations_Transfer(Reservations_Single);
                            GetSapXmlData_Reservations_Transfer(Reservations_Single);
                            break;
                        case "Z01":
                            // 客户领用单
                            Check_Reservations_Transfer(Reservations_Single);
                            GetSapXmlData_Reservations_Transfer(Reservations_Single);
                            break;
                        case "201":
                            // 实验胎调拨单
                            Check_Reservations_Transfer(Reservations_Single);
                            GetSapXmlData_Reservations_Transfer(Reservations_Single);
                            break;
                        case "Z03":
                            // 理赔调拨单
                            Check_Reservations_Transfer(Reservations_Single);
                            GetSapXmlData_Reservations_Transfer(Reservations_Single);
                            break;
                        default:
                            throw new Exception("未知操作业务类型" + ",MovType=" + Reservations_Single[0].MovType);
                            break;
                    }

                }
                catch (Exception ex)
                {
                    log.Warn("下传调拨单失败(single)," + ex.Message, ex);
                    SaveSapLog(new SiiSapLog()
                    {
                        Dummy1 = "Error",
                        DeleteFlag = 0,
                        MethodContent = ex.Message,
                        MethodMemo = "下传调拨单失败(single)",
                        MethodName = "GetSapXmlData_Reservations",
                    });
                }

            }

            SaveSapLog(new SiiSapLog()
            {
                DeleteFlag = 0,
                MethodContent = "",
                MethodMemo = "预留单下传接口调用完成",
                MethodName = "GetSapXmlData_Reservations",
            });

            return "";
        }

        /// <summary>
        /// 检验SAP的Reservations数据(移动类型)
        /// </summary>
        /// <param name="Reservations"></param>
        /// <returns></returns>
        private string Check_Reservations_MovType(MT_DZECC_outReservation[] Reservations)
        {
            try
            {
                #region 移动类型
                // 移动类型
                var q_MovType =
                    from p in Reservations
                    group p by p.MovType into g
                    select new
                    {
                        g.Key,
                        numproducts = g.Count()
                    };
                if (q_MovType.Count() > 1)
                {
                    throw new Exception("移动类型不唯一");
                }
                string MovType = q_MovType.First().Key;
                if (string.IsNullOrEmpty(MovType))
                {
                    throw new Exception("移动类型为空");
                }
                #endregion 移动类型 end

            }
            catch (Exception ex)
            {
                log.Warn("下传预留接口参数校验失败," + ex.Message, ex);
                SaveSapLog(new SiiSapLog()
                {
                    Dummy1 = "Error",
                    DeleteFlag = 0,
                    MethodContent = ex.Message,
                    MethodMemo = "下传预留接口参数校验失败",
                    MethodName = "Check_Reservations",
                });
                throw ex;
            }

            return "";
        }

        private string Check_Reservations_ReserNo(MT_DZECC_outReservation[] Reservations)
        {
            try
            {
                #region 预留单号
                // 预留单号
                var q_ReserNo =
                    from p in Reservations
                    group p by p.ReserNo into g
                    select new
                    {
                        g.Key,
                        numproducts = g.Count()
                    };

                foreach (var ReserNo in q_ReserNo)
                {
                    if (string.IsNullOrEmpty(ReserNo.Key))
                    {
                        throw new Exception("预留单号为空");
                    }
                }

                #endregion 预留单号 end

            }
            catch (Exception ex)
            {
                log.Warn("下传预留接口参数校验失败," + ex.Message, ex);
                SaveSapLog(new SiiSapLog()
                {
                    Dummy1 = "Error",
                    DeleteFlag = 0,
                    MethodContent = ex.Message,
                    MethodMemo = "下传预留接口参数校验失败",
                    MethodName = "Check_Reservations",
                });
                throw ex;
            }

            return "";
        }

        /// <summary>
        /// 检验SAP的Reservations数据
        /// </summary>
        /// <param name="Reservations"></param>
        /// <returns></returns>
        private string Check_Reservations(MT_DZECC_outReservation[] Reservations)
        {
            try
            {
                #region 移动类型
                // 移动类型
                var q_MovType =
                    from p in Reservations
                    group p by p.MovType into g
                    select new
                    {
                        g.Key,
                        numproducts = g.Count()
                    };
                if (q_MovType.Count() > 1)
                {
                    throw new Exception("移动类型不唯一");
                }
                string MovType = q_MovType.First().Key;
                if (string.IsNullOrEmpty(MovType))
                {
                    throw new Exception("移动类型为空");
                }
                #endregion 移动类型 end

                #region 需求日期
                // 需求日期
                var q_DemondsDate =
                    from p in Reservations
                    group p by p.DemondsDate into g
                    select new
                    {
                        g.Key,
                        numproducts = g.Count()
                    };
                if (q_DemondsDate.Count() > 1)
                {
                    throw new Exception("需求日期不唯一");
                }
                string DemondsDate = q_DemondsDate.First().Key;
                if (string.IsNullOrEmpty(DemondsDate))
                {
                    throw new Exception("需求日期为空");
                }
                try
                {
                    string TransferDate = DateTime.Parse(DemondsDate.Substring(0, 4) + '-' + DemondsDate.Substring(4, 2) + "-" + DemondsDate.Substring(6, 2)).ToString("yyyy-MM-dd");
                }
                catch (Exception ex)
                {
                    throw new Exception("需求日期格式错误" + ",DemondsDate=" + DemondsDate, ex);
                }
                #endregion 需求日期 end

                #region 预留单号
                // 预留单号
                var q_ReserNo =
                    from p in Reservations
                    group p by p.ReserNo into g
                    select new
                    {
                        g.Key,
                        numproducts = g.Count()
                    };

                if (q_ReserNo.Count() > 1)
                {
                    throw new Exception("预留单号不唯一");
                }
                #endregion 预留单号 end

                #region 预留单行号
                // 预留单行号
                var q_ReserItem =
                    from p in Reservations
                    group p by p.ReserItem into g
                    select new
                    {
                        g.Key,
                        numproducts = g.Count()
                    };
                if (q_ReserItem.Where(m => m.numproducts > 1).Count() > 0)
                {
                    string ReserItem = q_ReserItem.Where(m => m.numproducts > 1).First().Key;
                    ReserItem = string.IsNullOrEmpty(ReserItem) ? "" : ReserItem;
                    throw new Exception("预留单行号重复" + ",ReserItem=" + ReserItem);
                }
                #endregion 预留单行号 end

                #region 逐行校验
                foreach (MT_DZECC_outReservation Reservation in Reservations)
                {
                    if (string.IsNullOrEmpty(Reservation.ReserNo))
                    {
                        throw new Exception("预留单号为空");
                    }
                    if (string.IsNullOrEmpty(Reservation.ReserItem))
                    {
                        throw new Exception("预留单行号为空" + ",预留单号=" + Reservation.ReserNo);
                    }
                    if (string.IsNullOrEmpty(Reservation.MovType))
                    {
                        throw new Exception("移动类型为空" + ",预留单号=" + Reservation.ReserNo + ",预留单行号=" + Reservation.ReserItem);
                    }
                    if (string.IsNullOrEmpty(Reservation.MatCode))
                    {
                        throw new Exception("物料号为空" + ",预留单号=" + Reservation.ReserNo + ",预留单行号=" + Reservation.ReserItem);
                    }
                    if (string.IsNullOrEmpty(Reservation.Qty))
                    {
                        throw new Exception("转入数量为空" + ",预留单号=" + Reservation.ReserNo + ",预留单行号=" + Reservation.ReserItem);
                    }
                    if (string.IsNullOrEmpty(Reservation.DemondsDate))
                    {
                        throw new Exception("需求日期为空" + ",预留单号=" + Reservation.ReserNo + ",预留单行号=" + Reservation.ReserItem);
                    }

                    try
                    {
                        string Qty = Reservation.Qty;
                        int PlanAmount = (int)Convert.ToDouble(Qty);
                    }
                    catch (Exception ex)
                    {
                        throw new Exception("转入数量格式错误", ex);
                    }

                    string MatCode = Reservation.MatCode;
                    var lstMaterial = GetMaterialList(new SbmMaterial()
                    {
                        DeleteFlag = 0,
                        SapCode = MatCode,
                    }, "");
                    if (lstMaterial.Count == 0)
                    {
                        if (!string.IsNullOrEmpty(MatCode) 
                            && MatCode.Length >= 9 && MatCode.Substring(2, 1) != "1")
                        {
                            
                        }
                        else
                        {
                            throw new Exception("未找到物料" + ",MatCode=" + MatCode);
                        }
                    }
                    if (lstMaterial.Count > 1)
                    {
                        throw new Exception("物料记录多于1条" + ",MatCode=" + MatCode);
                    }

                }
                #endregion 逐行校验

            }
            catch (Exception ex)
            {
                log.Warn("下传预留接口参数校验失败," + ex.Message, ex);
                SaveSapLog(new SiiSapLog()
                {
                    Dummy1 = "Error",
                    DeleteFlag = 0,
                    MethodContent = ex.Message,
                    MethodMemo = "下传预留接口参数校验失败",
                    MethodName = "Check_Reservations",
                });
                throw ex;
            }

            return "";
        }

        /// <summary>
        /// 调拨单业务数据校验
        /// </summary>
        /// <param name="Reservations"></param>
        /// <returns></returns>
        private string Check_Reservations_Transfer(MT_DZECC_outReservation[] Reservations)
        {
            try
            {
                #region 预留单号
                // 预留单号
                string ReserNo = Reservations[0].ReserNo;

                IList<PsmTransferBill> lstPsmTransferBill = GetTransferBillList(new PsmTransferBill() { 
                    DeleteFlag = 0,
                    ReserNo = ReserNo,
                }, "");
                if (lstPsmTransferBill.Count > 1)
                {
                    throw new Exception("调拨单记录多于1条" + ",ReserNo=" + ReserNo);
                }

                foreach (MT_DZECC_outReservation Reservation in Reservations)
                {
                    string ReserItem = Reservation.ReserItem;
                    IList<PsmTransferMain> lstPsmTransferMain = GetTransferMainList(new PsmTransferMain()
                    {
                        DeleteFlag = 0,
                        ReserNo = ReserNo,
                        ReserItem = ReserItem
                    }, "");
                    if (lstPsmTransferMain.Count > 1)
                    {
                        throw new Exception("调拨主数据记录多于1条" + ",ReserNo=" + ReserNo + ",ReserItem=" + ReserItem);
                    }

                    string Dummy2 = Reservation.Dummy2;
                    string MaterCode = Reservation.MatCode;
                    if (Reservation.MovType == "311" || Reservation.MovType == "Z07" || Reservation.MovType == "Z03" || Reservation.MovType == "Z01" || Reservation.MovType == "201")
                    {
                        if (!string.IsNullOrEmpty(MaterCode) && MaterCode.Length >= 3 && MaterCode.StartsWith("211"))
                        {
                            if (string.IsNullOrEmpty(Dummy2))
                            {
                                throw new Exception("质量等级为空" + ",ReserNo=" + ReserNo + ",ReserItem=" + Reservation.ReserItem);
                            }
                            string checkGradeCode = GetCheckGradeCode(Dummy2);
                            if (string.IsNullOrEmpty(checkGradeCode))
                            {
                                throw new Exception("质量等级不存在" + ",ReserNo=" + ReserNo + ",ReserItem=" + Reservation.ReserItem);
                            }

                        }
                    }
                }

                #endregion 预留单号 end

            }
            catch (Exception ex)
            {
                log.Warn("调拨单业务数据校验失败," + ex.Message, ex);
                SaveSapLog(new SiiSapLog()
                {
                    Dummy1 = "Error",
                    DeleteFlag = 0,
                    MethodContent = ex.Message,
                    MethodMemo = "调拨单业务数据校验失败",
                    MethodName = "Check_Reservations_Transfer",
                });
                throw ex;
            }

            return "";

        }

        #region 调拨单业务数据处理
        /// <summary>
        /// 调拨单业务数据处理
        /// </summary>
        /// <param name="Reservations"></param>
        /// <returns></returns>
        private string GetSapXmlData_Reservations_Transfer(MT_DZECC_outReservation[] Reservations)
        {
            IPsbCustomerManager manager = new Mesnac.Interface.Business.Implements.PsbCustomerManager();
            try
            {
                manager.BeginTransaction();

                foreach (MT_DZECC_outReservation Reservation in Reservations)
                {
                    GetSapXmlData_Reservation_Transfer(Reservation);
                }

                manager.CompleteTransaction();
            }
            catch (Exception ex)
            { 
                manager.RollbackTransaction();
                log.Debug("GetSapXmlData_Reservations_Transfer 出错," + ex.Message, ex);
                SaveSapLog(new SiiSapLog() { 
                    Dummy1 = "Error",
                    DeleteFlag = 0,
                    MethodContent = ex.Message,
                    MethodMemo = "调拨单下传接口业务处理 错误",
                    MethodName = "GetSapXmlData_Reservations_Transfer",
                });
                throw ex;
            }
            return "";
        }
        #endregion 调拨单业务数据处理 end

        #region 获取调拨单记录集合
        /// <summary>
        /// 获取调拨单记录集合
        /// </summary>
        /// <param name="entity"></param>
        /// <param name="orderby"></param>
        /// <returns></returns>
        private IList<PsmTransferBill> GetTransferBillList(PsmTransferBill entity, string orderby)
        {
            IPsmTransferBillManager manager = new PsmTransferBillManager();
            return manager.GetEntityList(entity, string.IsNullOrEmpty(orderby) ? "OBJID" : orderby);
        }
        #endregion 获取调拨单记录集合 end

        #region 插入调拨单记录
        /// <summary>
        /// 插入调拨单记录
        /// </summary>
        /// <param name="entity"></param>
        /// <returns></returns>
        private PsmTransferBill InsertTransferBill(PsmTransferBill entity)
        {
            IPsmTransferBillManager manager = new PsmTransferBillManager();
            if (entity.ObjId == null)
            {
                int objId = manager.GetSeqNextVal("SEQ_PSM_TRANSFER_BILL");
                entity.ObjId = objId;
            }
            manager.Insert(entity);

            return entity;
        }
        #endregion 插入调拨单记录 end

        #region 更新调拨单记录
        /// <summary>
        /// 更新调拨单记录
        /// </summary>
        /// <param name="objId"></param>
        /// <param name="entity"></param>
        /// <returns></returns>
        private int UpdateTransferBillByObjId(string objId, PsmTransferBill entity)
        {
            IPsmTransferBillManager manager = new PsmTransferBillManager();
            return manager.UpdateByObjId(entity, Convert.ToInt32(objId));
        }
        #endregion 更新调拨单记录 end

        #region 获取调拨主数据记录集合
        /// <summary>
        /// 获取调拨主数据记录集合
        /// </summary>
        /// <param name="entity"></param>
        /// <param name="orderby"></param>
        /// <returns></returns>
        private IList<PsmTransferMain> GetTransferMainList(PsmTransferMain entity, string orderby)
        {
            IPsmTransferMainManager manager = new PsmTransferMainManager();
            return manager.GetEntityList(entity, string.IsNullOrEmpty(orderby) ? "OBJID" : orderby);
        }
        #endregion 获取调拨主数据记录集合 end

        #region 插入调拨主数据记录
        /// <summary>
        /// 插入调拨主数据记录
        /// </summary>
        /// <param name="entity"></param>
        /// <returns></returns>
        private PsmTransferMain InsertTransferMain(PsmTransferMain entity)
        {
            IPsmTransferMainManager manager = new PsmTransferMainManager();
            if (entity.ObjId == null)
            {
                int objId = manager.GetSeqNextVal("SEQ_PSM_TRANSFER_MAIN");
                entity.ObjId = objId;
            }
            manager.Insert(entity);

            return entity;
        }
        #endregion 插入调拨主数据记录 end

        #region 更新调拨主数据记录
        /// <summary>
        /// 更新调拨主数据记录
        /// </summary>
        /// <param name="objId"></param>
        /// <param name="entity"></param>
        /// <returns></returns>
        private int UpdateTransferMainByObjId(string objId, PsmTransferMain entity)
        {
            IPsmTransferMainManager manager = new PsmTransferMainManager();
            return manager.UpdateByObjId(entity, Convert.ToInt32(objId));
        }
        #endregion 更新调拨主数据记录 end

        #region 调拨单行项目数据处理
        /// <summary>
        /// 调拨单行项目数据处理
        /// </summary>
        /// <param name="Reservation"></param>
        /// <returns></returns>
        private string GetSapXmlData_Reservation_Transfer(MT_DZECC_outReservation Reservation)
        {
            log.Debug("调用方法：GetSapXmlData_Reservation(MT_DZECC_outReservation Reservation)");
            string s_Reservation = getJsonByObject(Reservation);
            log.Debug("Reservation转Json字符串," + s_Reservation);
            SaveSapLog(new SiiSapLog()
            {
                DeleteFlag = 0,
                MethodContent = s_Reservation,
                MethodMemo = "Reservation转Json字符串",
                MethodName = "GetSapXmlData_Reservation",
            });

            string ReserNo = Reservation.ReserNo;
            string ReserItem = Reservation.ReserItem;
            string MovType = Reservation.MovType;
            string MatCode = Reservation.MatCode;
            string Unit = Reservation.Unit;
            string Department = Reservation.Department;
            string Qty = Reservation.Qty;
            string PlantFrom = Reservation.PlantFrom;
            string StorLocFrom = Reservation.StorLocFrom;
            string PlantTo = Reservation.PlantTo;
            string StorLocTo = Reservation.StorLocTo;
            string CostCenter = Reservation.CostCenter;
            string Order1 = Reservation.Order;
            string DemondsDate = Reservation.DemondsDate;
            string Batch = Reservation.Batch;
            string Dummy1 = Reservation.Dummy1;
            string Dummy2 = Reservation.Dummy2;
            string Dummy3 = Reservation.Dummy3;
            string Dummy4 = Reservation.Dummy4;
            string StorLocFromName = GetStorageLocName(StorLocFrom);
            string StorLocToName = GetStorageLocName(StorLocTo);
            string TransferDate = DemondsDate.Substring(0, 4) + "-" + DemondsDate.Substring(4, 2) + "-" + DemondsDate.Substring(6, 2);
            string planAmount = ((int)Convert.ToDouble(Qty)).ToString();

            IList<SbmMaterial> lstMaterial = GetMaterialList(new SbmMaterial()
            {
                DeleteFlag = 0,
                SapCode = MatCode,
            }, "");
            if (lstMaterial.Count == 0)
            {
                SaveSapLog(new SiiSapLog()
                {
                    Dummy1 = "Warn",
                    DeleteFlag = 0,
                    MethodContent = "物料不是外胎，不保存该条数据",
                    MethodMemo = "MaterCode=" + MatCode,
                    MethodName = "GetSapXmlData_Reservation_Transfer",
                });

                return "";
            }
            string CheckGradeCode = "1"; // 默认为正品
            if (MovType == "311" || MovType == "Z07" || MovType == "Z03" || MovType == "Z01" || MovType == "201")
            {
                CheckGradeCode = GetCheckGradeCode(Dummy2);
            }

            // 查找调拨单
            IList<PsmTransferBill> lstTransferBill = GetTransferBillList(new PsmTransferBill()
            {
                DeleteFlag = 0,
                ReserNo = ReserNo,
            }, "");
            PsmTransferBill entityTransferBill = null;
            if (lstTransferBill.Count == 0)
            {
                #region 插入调拨单记录
                // 插入调拨单记录
                entityTransferBill = InsertTransferBill(new PsmTransferBill()
                {
                    Batch = Batch,
                    BillState = 0,
                    CostCenter = CostCenter,
                    DeleteFlag = 0,
                    DemondsDate = DemondsDate,
                    Department = Department,
                    Dummy1 = Dummy1,
                    Dummy2 = Dummy2,
                    Dummy3 = Dummy3,
                    Dummy4 = Dummy4,
                    InterfaceUpdateTime = DateTime.Now,
                    MatCode = MatCode,
                    MovType = MovType,
                    Order1 = Order1,
                    PlantFrom = PlantFrom,
                    PlantTo = PlantTo,
                    Qty = Qty,
                    RecordTime = DateTime.Now,
                    RecordUserId = 0,
                    ReserItem = ReserItem,
                    ReserNo = ReserNo,
                    StorLocFrom = StorLocFromName,
                    StorLocTo = StorLocToName,
                    TransferDate = DateTime.Parse(TransferDate),
                    Unit = Unit,
                    UpdateTime = DateTime.Now,
                    UpdateUserId = 0,
                });
                #endregion 插入调拨单记录
            }
            else
            {
                #region 更新调拨单记录
                // 更新调拨单记录
                entityTransferBill = lstTransferBill[0];
                entityTransferBill.Batch = Batch;
                entityTransferBill.CostCenter = CostCenter;
                entityTransferBill.DemondsDate = DemondsDate;
                entityTransferBill.Department = Department;
                entityTransferBill.Dummy1 = Dummy1;
                entityTransferBill.Dummy2 = Dummy2;
                entityTransferBill.Dummy3 = Dummy3;
                entityTransferBill.Dummy4 = Dummy4;
                entityTransferBill.InterfaceUpdateTime = DateTime.Now;
                entityTransferBill.MatCode = MatCode;
                entityTransferBill.MovType = MovType;
                entityTransferBill.Order1 = Order1;
                entityTransferBill.PlantFrom = PlantFrom;
                entityTransferBill.PlantTo = PlantTo;
                entityTransferBill.Qty = Qty;
                entityTransferBill.ReserItem = ReserItem;
                entityTransferBill.ReserNo = ReserNo;
                entityTransferBill.StorLocFrom = StorLocFromName;
                entityTransferBill.StorLocTo = StorLocToName;
                entityTransferBill.TransferDate = DateTime.Parse(TransferDate);
                entityTransferBill.Unit = Unit;
                entityTransferBill.UpdateTime = DateTime.Now;
                entityTransferBill.UpdateUserId = 0;

                UpdateTransferBillByObjId(entityTransferBill.ObjId.ToString(), entityTransferBill);
                #endregion 更新调拨单记录 end
            }
            string transferBillId = entityTransferBill.ObjId.ToString();

            string materialId = lstMaterial[0].ObjId.ToString();

            PsmTransferMain entityTransferMain = null;
            IList<PsmTransferMain> lstTransferMain = GetTransferMainList(new PsmTransferMain()
            {
                DeleteFlag = 0,
                BillId = Convert.ToInt32(transferBillId),
                ReserItem = ReserItem,
            }, "");
            int deleteFlag = 0;
            if (Dummy3 == "X")
            {
                deleteFlag = 1;
            }
            if (lstTransferMain.Count == 0)
            {
                #region 插入调拨主数据记录
                // 插入调拨主数据记录
                entityTransferMain = InsertTransferMain(new PsmTransferMain()
                {
                    Batch = Batch,
                    BillId = Convert.ToInt32(transferBillId),
                    CheckGradeCode = Convert.ToInt32(CheckGradeCode),
                    CostCenter = CostCenter,
                    DeleteFlag = deleteFlag,
                    DemondsDate = DemondsDate,
                    Department = Department,
                    Dummy1 = Dummy1,
                    Dummy2 = Dummy2,
                    Dummy3 = Dummy3,
                    Dummy4 = Dummy4,
                    InterfaceUpdateTime = DateTime.Now,
                    MainState = 0,
                    MatCode = MatCode,
                    MaterialId = Convert.ToInt32(materialId),
                    MovType = MovType,
                    Order1 = Order1,
                    PlanAmount = Convert.ToInt32(planAmount),
                    PlantFrom = PlantFrom,
                    PlantTo = PlantTo,
                    Qty = Qty,
                    RecordTime = DateTime.Now,
                    RecordUserId = 0,
                    ReserItem = ReserItem,
                    ReserNo = ReserNo,
                    StorLocFrom = StorLocFromName,
                    StorLocTo = StorLocToName,
                    TransferAmount = 0,
                    Unit = Unit,
                    UpdateTime = DateTime.Now,
                    UpdateUserId = 0,
                });
                #endregion 插入调拨主数据记录 end
            }
            else
            {
                #region 更新调拨主数据记录
                // 更新调拨主数据记录
                entityTransferMain = lstTransferMain[0];
                entityTransferMain.Batch = Batch;
                entityTransferMain.BillId = Convert.ToInt32(transferBillId);
                entityTransferMain.CheckGradeCode = Convert.ToInt32(CheckGradeCode);
                entityTransferMain.CostCenter = CostCenter;
                entityTransferMain.DeleteFlag = deleteFlag;
                entityTransferMain.DemondsDate = DemondsDate;
                entityTransferMain.Department = Department;
                entityTransferMain.Dummy1 = Dummy1;
                entityTransferMain.Dummy2 = Dummy2;
                entityTransferMain.Dummy3 = Dummy3;
                entityTransferMain.Dummy4 = Dummy4;
                entityTransferMain.InterfaceUpdateTime = DateTime.Now;
                entityTransferMain.MainState = 0;
                entityTransferMain.MatCode = MatCode;
                entityTransferMain.MaterialId = Convert.ToInt32(materialId);
                entityTransferMain.MovType = MovType;
                entityTransferMain.Order1 = Order1;
                entityTransferMain.PlanAmount = Convert.ToInt32(planAmount);
                entityTransferMain.PlantFrom = PlantFrom;
                entityTransferMain.PlantTo = PlantTo;
                entityTransferMain.Qty = Qty;
                entityTransferMain.RecordTime = DateTime.Now;
                entityTransferMain.RecordUserId = 0;
                entityTransferMain.ReserItem = ReserItem;
                entityTransferMain.ReserNo = ReserNo;
                entityTransferMain.StorLocFrom = StorLocFromName;
                entityTransferMain.StorLocTo = StorLocToName;
                entityTransferMain.Unit = Unit;
                entityTransferMain.UpdateTime = DateTime.Now;
                entityTransferMain.UpdateUserId = 0;

                UpdateTransferMainByObjId(entityTransferMain.ObjId.ToString(), entityTransferMain);
                #endregion 更新调拨主数据记录 end

            }

            return "";
        }
        #endregion 调拨单行项目数据处理

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


        public string GetSapXmlData_PlanDNs(MT_DZECC_outPlanDN[] PlanDNs)
        {
            log.Debug("GetSapXmlData_PlanDNs(MT_DZECC_outPlanDN[] PlanDNs)");

            string s_PlanDNs = getJsonByObject(PlanDNs);
            log.Debug(s_PlanDNs);

            SaveSapLog(new SiiSapLog()
            { 
                DeleteFlag = 0,
                MethodContent = s_PlanDNs,
                MethodMemo = "MesMethod.GetSapXmlData_PlanDNs",
                MethodName = "GetSapXmlData_PlanDNs",
            });
            
            foreach (MT_DZECC_outPlanDN PlanDN in PlanDNs)
            {
                try
                {
                    GetSapXmlData_PlanDN(PlanDN);
                }
                catch (Exception ex)
                {
                    log.Warn(ex.Message, ex);
                    string No = string.Empty;
                    if (PlanDN.DNHeader.Length == 1)
                    {
                        No = PlanDN.DNHeader[0].SNNo;
                    }
                    SaveSapLog(new SiiSapLog()
                    {
                        DeleteFlag = 0,
                        MethodContent = ex.Message,

                        MethodMemo = "出货单下传,单个单子错误，单号：" + No,
                        MethodName = "GetSapXmlData_PlanDNs",
                        Dummy1 = "Error",
                    });
                }
            }

            return "";
        }

        public string GetSapXmlData_PlanDN(MT_DZECC_outPlanDN PlanDN)
        {
            log.Debug("调用方法：GetSapXmlData_PlanDN(MT_DZECC_outPlanDN PlanDN)");
            var manager = new Mesnac.Interface.Business.Implements.PsbCustomerManager();

            try
            {
                // SAP业务数据校验
                if (PlanDN.DNHeader.Length == 0)
                {
                    throw new Exception("计划出货抬头少于1条");
                }
                else if (PlanDN.DNHeader.Length > 1)
                {
                    throw new Exception("计划出货抬头多于1条");
                }
                MT_DZECC_outPlanDNDNHeader DNHeader = PlanDN.DNHeader[0];
                try
                {
                    string DocDate = DNHeader.DocDate;
                    string OutDate = DateTime.Parse(DocDate.Substring(0, 4) + '-' + DocDate.Substring(4, 2) + "-" + DocDate.Substring(6, 2)).ToString("yyyy-MM-dd");
                }
                catch (Exception ex)
                {
                    throw new Exception("凭证日期格式错误", ex);
                }

                foreach (MT_DZECC_outPlanDNDNItem DNItem in PlanDN.DNItem)
                {
                    try
                    {
                        string Qty = DNItem.Qty;
                        int PlanAmount = (int)Convert.ToDouble(Qty);
                    }
                    catch (Exception ex)
                    {
                        throw new Exception("发货数量格式错误", ex);
                    }
                    string StorageLoc = DNItem.StorageLoc;
                    string StorageLocName = GetStorageLocName(StorageLoc);
                    if (string.IsNullOrEmpty(StorageLocName))
                    {
                        throw new Exception("未找到库区名称" + ",StorageLoc=" + StorageLoc);
                    }
                }

                var q =
                    from p in PlanDN.DNItem
                    group p by p.LineItemNo into g
                    select new
                    {
                        g.Key,
                        numproducts = g.Count()
                    };
                
                if (q.Where(m=>m.numproducts > 1).Count() > 0)
                {
                    throw new Exception("行项目编号重复" + ",LineItemNo=" + q.Where(m => m.numproducts > 1).First().Key);
                }
            }
            catch (Exception ex)
            {
                log.Warn(ex.Message, ex);
                SaveSapLog(new SiiSapLog()
                {
                    DeleteFlag = 0,
                    MethodContent = ex.Message,
                    MethodMemo = "出货单下传,检验数据",
                    MethodName = "GetSapXmlData_PlanDN",
                    Dummy1 = "Error",
                });
                if (ex.InnerException != null)
                {
                    throw new Exception(ex.Message, ex.InnerException);
                }
                throw ex;
            }

            try
            {
                manager.BeginTransaction();

                MT_DZECC_outPlanDNDNHeader DNHeader = PlanDN.DNHeader[0];
                string DocDate = DNHeader.DocDate;
                string CustomerID = DNHeader.CustomerID;
                string SNNo = DNHeader.SNNo;
                string Dummy1 = DNHeader.Dummy1;
                string Dummy2 = DNHeader.Dummy2;
                string Dummy3 = DNHeader.Dummy3;
                string Dummy4 = DNHeader.Dummy4;
                string SRFlag = string.IsNullOrEmpty(DNHeader.SRFlag) ? " " : DNHeader.SRFlag;

                string OutDate = DateTime.Parse(DocDate.Substring(0, 4) + '-' + DocDate.Substring(4, 2) + "-" + DocDate.Substring(6, 2)).ToString("yyyy-MM-dd");

                string CustomerObjid = "";
                IList<PsbCustomer> lstCustomer = GetCustomerList(new PsbCustomer()
                {
                    DeleteFlag = 0,
                    CustomerId = CustomerID,
                }, "");
                if (lstCustomer.Count == 0)
                {
                    throw new Exception("未找到客户记录" + ",CustomerID=" + CustomerID);
                }
                else if (lstCustomer.Count > 1)
                {
                    throw new Exception("客户记录多于1条" + ",CustomerID=" + CustomerID);
                }
                CustomerObjid = lstCustomer[0].ObjId.ToString();

                IList<PsmOutStockBill> lstOutStockBill = GetOutStockBillList(new PsmOutStockBill()
                {
                    DeleteFlag = 0,
                    SNNo = SNNo,
                }, "");
                if (lstOutStockBill.Count > 1)
                {
                    throw new Exception("出库单记录多于1条" + ",SNNo=" + SNNo);
                }
                string BillId = "";
                PsmOutStockBill entityOutStockBill = null;
                if (lstOutStockBill.Count == 0)
                {
                    #region 创建出库单
                    // 创建出库单
                    entityOutStockBill = InsertOutStockBill(new PsmOutStockBill()
                    {
                        BillState = 0,
                        CustomerId = CustomerID,
                        CustomerObjid = Convert.ToInt32(CustomerObjid),
                        DeleteFlag = 0,
                        DocDate = DocDate,
                        Dummy1 = Dummy1,
                        Dummy2 = Dummy2,
                        Dummy3 = Dummy3,
                        Dummy4 = Dummy4,
                        InterfaceUpdateTime = DateTime.Now,
                        OutDate = DateTime.Parse(OutDate),
                        RecordTime = DateTime.Now,
                        RecordUserId = 0,
                        SNNo = SNNo,
                        SRFlag = SRFlag,
                        UpdateTime = DateTime.Now,
                        UpdateUserId = 0,
                    });
                    BillId = entityOutStockBill.ObjId.ToString();
                    IList<PsmOutStockMain> lstOutStockMain = new List<PsmOutStockMain>();
                    foreach (MT_DZECC_outPlanDNDNItem DNItem in PlanDN.DNItem)
                    {
                        string Batch = DNItem.Batch;
                        string MaterialCode = DNItem.MaterialCode;
                        string StorageLoc = DNItem.StorageLoc;
                        string CheckGradeCode = GetCheckGradeCode(Batch);
                        string LineItemNo = DNItem.LineItemNo;
                        string Qty = DNItem.Qty;
                        string Plant = DNItem.Plant;
                        var lstMaterial = GetMaterialList(new SbmMaterial()
                        {
                            DeleteFlag = 0,
                            SapCode = MaterialCode,
                        }, "");
                        if (lstMaterial.Count == 0)
                        {
                            if (!string.IsNullOrEmpty(MaterialCode)
                                && MaterialCode.Length >= 9
                                && MaterialCode.Substring(2, 1) != "1")
                            {
                                // 不处理
                                SaveSapLog(new SiiSapLog() { 
                                    DeleteFlag = 0,
                                    Dummy1 = "Warn",
                                    MethodContent= "物料不是外胎,不保留该条数据",
                                    MethodMemo = "MaterialCode=" + MaterialCode,
                                    MethodName = "GetSapXmlData_PlanDN",
                                });
                                continue;
                            }
                            else
                            {
                                throw new Exception("未找到物料" + ",MaterialCode=" + MaterialCode);
                            }
                        }
                        if (lstMaterial.Count > 1)
                        {
                            throw new Exception("物料记录多于1条" + ",MaterialCode=" + MaterialCode);
                        }
                        if (string.IsNullOrEmpty(CheckGradeCode))
                        {
                            throw new Exception("未找到品级" + ",Batch=" + Batch);
                        }
                        SbmMaterial entityMaterial = lstMaterial[0];
                        string MaterialId = entityMaterial.ObjId.ToString();
                        string StoreId = GetStoreId(StorageLoc);
                        string StorageLocName = GetStorageLocName(StorageLoc);

                        PsmOutStockMain entityOutStockMain = InsertOutStockMain(new PsmOutStockMain()
                        {
                            BillId = Convert.ToInt32(BillId),
                            Batch = DNItem.Batch,
                            CheckGradeCode = Convert.ToInt32(CheckGradeCode),
                            DeleteFlag = 0,
                            Dummy1 = DNItem.Dummy1,
                            Dummy2 = DNItem.Dummy2,
                            Dummy3 = DNItem.Dummy3,
                            Dummy4 = DNItem.Dummy4,
                            InterfaceUpdateTime = DateTime.Now,
                            LineItemNo = LineItemNo,
                            MainState = 0,
                            MaterialCode = MaterialCode,
                            MaterialId = Convert.ToInt32(MaterialId),
                            OutAmount = 0,
                            PlanAmount = (int)Convert.ToDouble(Qty),
                            Plant = Plant,
                            Qty = Qty,
                            RecordTime = DateTime.Now,
                            RecordUserId = 0,
                            Remark = null,
                            StorageLoc = StorageLocName,
                            StoreId = string.IsNullOrEmpty(StoreId) ? (int?)null : Convert.ToInt32(StoreId),
                            UpdateTime = DateTime.Now,
                            UpdateUserId = 0,
                        });
                    }
                    #endregion 创建出库单 end
                }
                else
                {
                    #region 更新出库单
                    entityOutStockBill = lstOutStockBill[0];
                    BillId = entityOutStockBill.ObjId.ToString();
                    // 更新
                    UpdateOutStockBillByObjId(new PsmOutStockBill()
                    {
                        CustomerId = CustomerID,
                        CustomerObjid = Convert.ToInt32(CustomerObjid),
                        DocDate = DocDate,
                        Dummy1 = Dummy1,
                        Dummy2 = Dummy2,
                        Dummy3 = Dummy3,
                        Dummy4 = Dummy4,
                        InterfaceUpdateTime = DateTime.Now,
                        OutDate = DateTime.Parse(OutDate),
                        SRFlag = SRFlag,
                        UpdateTime = DateTime.Now,
                        UpdateUserId = 0,
                    }, BillId);

                    IList<PsmOutStockMain> lstOutStockMain = GetOutStockMainList(new PsmOutStockMain()
                    {
                        DeleteFlag = 0,
                        BillId = Convert.ToInt32(BillId),
                    }, "");

                    foreach (MT_DZECC_outPlanDNDNItem DNItem in PlanDN.DNItem)
                    {
                        string Batch = DNItem.Batch;
                        string MaterialCode = DNItem.MaterialCode;
                        string StorageLoc = DNItem.StorageLoc;
                        string CheckGradeCode = GetCheckGradeCode(Batch);
                        string LineItemNo = DNItem.LineItemNo;
                        string Qty = ((int)Convert.ToDouble(DNItem.Qty)).ToString();
                        string Plant = DNItem.Plant;
                        var lstMaterial = GetMaterialList(new SbmMaterial()
                        {
                            DeleteFlag = 0,
                            SapCode = MaterialCode,
                        }, "");
                        if (lstMaterial.Count == 0)
                        {
                            if (!string.IsNullOrEmpty(MaterialCode)
                                && MaterialCode.Length >= 9
                                && MaterialCode.Substring(2, 1) != "1")
                            {
                                // 不处理
                                SaveSapLog(new SiiSapLog()
                                {
                                    DeleteFlag = 0,
                                    Dummy1 = "Warn",
                                    MethodContent = "物料不是外胎,不保留该条数据",
                                    MethodMemo = "MaterialCode=" + MaterialCode,
                                    MethodName = "GetSapXmlData_PlanDN",
                                });
                                continue;
                            }
                            else
                            {
                                throw new Exception("未找到物料" + ",MaterialCode=" + MaterialCode);
                            }
                        }
                        if (lstMaterial.Count > 1)
                        {
                            throw new Exception("物料记录多于1条" + ",MaterialCode=" + MaterialCode);
                        }
                        if (string.IsNullOrEmpty(CheckGradeCode))
                        {
                            throw new Exception("未找到品级" + ",Batch=" + Batch);
                        }
                        SbmMaterial entityMaterial = lstMaterial[0];
                        string MaterialId = entityMaterial.ObjId.ToString();
                        string StoreId = GetStoreId(StorageLoc);
                        string StorageLocName = GetStorageLocName(StorageLoc);

                        var entityOutStockMains = lstOutStockMain.Where(m => m.LineItemNo == LineItemNo);
                        if (entityOutStockMains.Count() > 1)
                        {
                            throw new Exception("行项目多于1条" + ",LineItemNo=" + LineItemNo);
                        }
                        if (entityOutStockMains.Count() == 0)
                        {
                            // 添加
                            PsmOutStockMain entityOutStockMain = InsertOutStockMain(new PsmOutStockMain()
                            {
                                Batch = DNItem.Batch,
                                BillId = Convert.ToInt32(BillId),
                                CheckGradeCode = Convert.ToInt32(CheckGradeCode),
                                DeleteFlag = 0,
                                Dummy1 = DNItem.Dummy1,
                                Dummy2 = DNItem.Dummy2,
                                Dummy3 = DNItem.Dummy3,
                                Dummy4 = DNItem.Dummy4,
                                InterfaceUpdateTime = DateTime.Now,
                                LineItemNo = LineItemNo,
                                MainState = 0,
                                MaterialCode = MaterialCode,
                                MaterialId = Convert.ToInt32(MaterialId),
                                OutAmount = 0,
                                PlanAmount = Convert.ToInt32(Qty),
                                Plant = Plant,
                                Qty = Qty,
                                RecordTime = DateTime.Now,
                                RecordUserId = 0,
                                Remark = null,
                                StorageLoc = StorageLocName,
                                StoreId = string.IsNullOrEmpty(StoreId) ? (int?)null : Convert.ToInt32(StoreId),
                                UpdateTime = DateTime.Now,
                                UpdateUserId = 0,
                            });
                        }
                        else
                        {
                            string MainId = entityOutStockMains.Single().ObjId.ToString();
                            // 更新
                            UpdateOutStockMainByObjId(new PsmOutStockMain()
                            {
                                InterfaceUpdateTime = DateTime.Now,
                                PlanAmount = Convert.ToInt32(Qty),
                                Qty = Qty,
                                StorageLoc = StorageLocName,
                                UpdateTime = DateTime.Now,
                                UpdateUserId = 0,
                            }, MainId);
                        }
                    }
                    #endregion 更新出库单 end
                }

                manager.CompleteTransaction();
            }
            catch (Exception ex)
            {
                manager.RollbackTransaction();
                log.Warn(ex.Message, ex);
                SaveSapLog(new SiiSapLog()
                { 
                    DeleteFlag = 0,
                    MethodContent = ex.Message,
                    MethodMemo = "出货单下传,更新数据",
                    MethodName = "GetSapXmlData_PlanDN",
                    Dummy1 = "Error",
                });
                if (ex.InnerException != null)
                {
                    throw new Exception(ex.Message, ex.InnerException);
                }
                throw ex;
            }


            return "";
        }

        public string GetSapXmlData_MatDocs(MT_DZECC_outMatDoc[] MatDocs)
        {
            return "";
        }

        public string GetSapXmlData_MatDoc(MT_DZECC_outMatDoc MatDoc)
        {
            return "";
        }

        /// <summary>
        /// 获取客户记录集合
        /// </summary>
        /// <param name="entity"></param>
        /// <param name="orderby"></param>
        /// <returns></returns>
        private IList<PsbCustomer> GetCustomerList(PsbCustomer entity, string orderby)
        {
            IPsbCustomerManager manager = new PsbCustomerManager();
            return manager.GetEntityList(entity, string.IsNullOrEmpty(orderby) ? "OBJID" : orderby);
        }

        /// <summary>
        /// 获取成品出库单记录集合
        /// </summary>
        /// <param name="entity"></param>
        /// <param name="orderby"></param>
        /// <returns></returns>
        private IList<PsmOutStockBill> GetOutStockBillList(PsmOutStockBill entity, string orderby)
        {
            IPsmOutStockBillManager manager = new PsmOutStockBillManager();
            return manager.GetEntityList(entity, string.IsNullOrEmpty(orderby) ? "OBJID" : orderby);
        }

        /// <summary>
        /// 插入成品出库单记录
        /// </summary>
        /// <param name="entity"></param>
        /// <returns></returns>
        private PsmOutStockBill InsertOutStockBill(PsmOutStockBill entity)
        {
            IPsmOutStockBillManager manager = new PsmOutStockBillManager();
            if (entity.ObjId == null)
            {
                int objId = manager.GetSeqNextVal("SEQ_PSM_OUT_STOCK_BILL");
                entity.ObjId = Convert.ToInt32(objId);
            }
            manager.Insert(entity);

            return entity;
        }

        /// <summary>
        /// 更新成品出库单记录
        /// </summary>
        /// <param name="entity"></param>
        /// <param name="objId"></param>
        /// <returns></returns>
        private int UpdateOutStockBillByObjId(PsmOutStockBill entity, string objId)
        {
            IPsmOutStockBillManager manager = new PsmOutStockBillManager();
            return manager.UpdateByObjId(entity, Convert.ToInt32(objId));
        }

        /// <summary>
        /// 插入成品出库主数据记录
        /// </summary>
        /// <param name="entity"></param>
        /// <returns></returns>
        private PsmOutStockMain InsertOutStockMain(PsmOutStockMain entity)
        {
            IPsmOutStockMainManager manager = new PsmOutStockMainManager();
            if (entity.ObjId == null)
            {
                int objId = manager.GetSeqNextVal("SEQ_PSM_OUT_STOCK_MAIN");
                entity.ObjId = Convert.ToInt32(objId);
            }
            manager.Insert(entity);

            return entity;
        }

        /// <summary>
        /// 更新成品出库主数据记录
        /// </summary>
        /// <param name="entity"></param>
        /// <param name="objId"></param>
        /// <returns></returns>
        private int UpdateOutStockMainByObjId(PsmOutStockMain entity, string objId)
        {
            IPsmOutStockMainManager manager = new PsmOutStockMainManager();
            return manager.UpdateByObjId(entity, Convert.ToInt32(objId));
        }

        private IList<PsmOutStockMain> GetOutStockMainList(PsmOutStockMain entity, string orderby)
        {
            IPsmOutStockMainManager manager = new PsmOutStockMainManager();
            return manager.GetEntityList(entity, string.IsNullOrEmpty(orderby) ? "OBJID" : orderby);
        }

        /// <summary>
        /// 获取品级
        /// </summary>
        /// <param name="Batch"></param>
        /// <returns></returns>
        private string GetCheckGradeCode(string Batch)
        {
            Batch = string.IsNullOrEmpty(Batch) ? "" : Batch;
            string checkGradeCode = "";
            switch (Batch.Trim().ToUpper())
            {
                case "A":
                    checkGradeCode = "1";
                    break;
                case "C":
                    checkGradeCode = "2";
                    break;
                case "F":
                    checkGradeCode = "3";
                    break;
                case "TF":
                    checkGradeCode = "4";
                    break;
                case "A-CQ":
                    checkGradeCode = "1";
                    break;
                default:
                    break;
            }
            return checkGradeCode;
        }

        /// <summary>
        /// 获取物料记录集合
        /// </summary>
        /// <param name="entity"></param>
        /// <param name="orderby"></param>
        /// <returns></returns>
        private IList<SbmMaterial> GetMaterialList(SbmMaterial entity, string orderby)
        {
            ISbmMaterialManager manager = new SbmMaterialManager();
            return manager.GetEntityList(entity, string.IsNullOrEmpty(orderby) ? "OBJID" : orderby);
        }

        private string GetStorageLocName(string StorageLoc)
        {
            string StorageLocName = "";
            switch (StorageLoc)
            {
                case "8005":
                    StorageLocName = "8005德州国内营销库";
                    break;
                case "8007":
                    StorageLocName = "8007德州国内配套库";
                    break;
                case "8009":
                    StorageLocName = "8009德州海外营销库";
                    break;
                case "8011":
                    StorageLocName = "8011德州海外配套库";
                    break;
                case "8017":
                    StorageLocName = "8017德州海外巴西库";
                    break;
                case "6021":
                    StorageLocName = "6021德州中转库";
                    break;
                case "8100":
                    StorageLocName = "8100德州虚拟库";
                    break;
                case "8035":
                    StorageLocName = "8035德州集团库";
                    break;
                default:
                    StorageLocName = StorageLoc;
                    break;
            }
            return StorageLocName;
        }

        /// <summary>
        /// 获取仓库
        /// </summary>
        /// <param name="StorageLoc"></param>
        /// <returns></returns>
        private string GetStoreId(string StorageLoc)
        {
            string storeId = "";
            switch (StorageLoc)
            {
                case "A":
                    storeId = "5";
                    break;
                case "B":
                    storeId = "6";
                    break;
                case "C":
                    storeId = "7";
                    break;
                case "D":
                    storeId = "8";
                    break;
                case "E":
                    storeId = "9";
                    break;
            }
            return storeId;
        }

        #endregion 下传接口处理 end
    }
}