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
    public class PsmOutStockDetailManager : BaseManager<PsmOutStockDetail>, IPsmOutStockDetailManager
    {
		#region 属性注入与构造方法
		
        private IPsmOutStockDetailService service;

        public PsmOutStockDetailManager()
        {
            this.service = new PsmOutStockDetailService();
            base.BaseService = this.service;
        }

        public PsmOutStockDetailManager(string language)
        {
            this.service = new PsmOutStockDetailService(language);
            base.BaseService = this.service;
        }
        
        #endregion
    }
}
