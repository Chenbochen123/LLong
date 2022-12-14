using System;
using System.Collections.Generic;
using System.Text;
using Mesnac.DbAccess;

namespace Mesnac.Interface.Business.Implements
{
    using Mesnac.Interface.Entity.BasicEntity;
    using Mesnac.Interface.Data.Interface;
    using Mesnac.Interface.Data.Implements;
    using Mesnac.Interface.Business.Interface;
    public class PsmTransferBillManager : BaseManager<PsmTransferBill>, IPsmTransferBillManager
    {
		#region 属性注入与构造方法
		
        private IPsmTransferBillService service;

        public PsmTransferBillManager()
        {
            this.service = new PsmTransferBillService();
            base.BaseService = this.service;
        }

        public PsmTransferBillManager(string language)
        {
            this.service = new PsmTransferBillService(language);
            base.BaseService = this.service;
        }
        
        #endregion
    }
}
