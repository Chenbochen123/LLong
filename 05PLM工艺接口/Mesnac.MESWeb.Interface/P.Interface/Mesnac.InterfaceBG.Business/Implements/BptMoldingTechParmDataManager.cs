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
    public class BptMoldingTechParmDataManager : BaseManager<BptMoldingTechParmData>, IBptMoldingTechParmDataManager
    {
		#region 属性注入与构造方法
		
        private IBptMoldingTechParmDataService service;

        public BptMoldingTechParmDataManager()
        {
            this.service = new BptMoldingTechParmDataService();
            base.BaseService = this.service;
        }

        public BptMoldingTechParmDataManager(string language)
        {
            this.service = new BptMoldingTechParmDataService(language);
            base.BaseService = this.service;
        }
        
        #endregion
    }
}
