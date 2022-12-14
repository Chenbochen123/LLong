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
    public class PsmOutStockMainManager : BaseManager<PsmOutStockMain>, IPsmOutStockMainManager
    {
		#region 属性注入与构造方法
		
        private IPsmOutStockMainService service;

        public PsmOutStockMainManager()
        {
            this.service = new PsmOutStockMainService();
            base.BaseService = this.service;
        }

        public PsmOutStockMainManager(string language)
        {
            this.service = new PsmOutStockMainService(language);
            base.BaseService = this.service;
        }
        
        #endregion
    }
}
