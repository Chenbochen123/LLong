using System;
using System.Collections.Generic;
using System.Text;
using Mesnac.DbAccess;

namespace Mesnac.InterfaceBG.Business.Implements
{
    using Mesnac.InterfaceBG.Entity.BasicEntity;
    using Mesnac.InterfaceBG.Data.Interface;
    using Mesnac.InterfaceBG.Data.Implements;
    using Mesnac.InterfaceBG.Business.Interface;
    public class PsmOutStockBillManager : BaseManager<PsmOutStockBill>, IPsmOutStockBillManager
    {
		#region 属性注入与构造方法
		
        private IPsmOutStockBillService service;

        public PsmOutStockBillManager()
        {
            this.service = new PsmOutStockBillService();
            base.BaseService = this.service;
        }

        public PsmOutStockBillManager(string language)
        {
            this.service = new PsmOutStockBillService(language);
            base.BaseService = this.service;
        }
        
        #endregion
    }
}
