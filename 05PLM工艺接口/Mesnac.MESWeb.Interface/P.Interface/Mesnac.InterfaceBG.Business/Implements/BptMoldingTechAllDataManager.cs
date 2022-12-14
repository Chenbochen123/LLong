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
    public class BptMoldingTechAllDataManager : BaseManager<BptMoldingTechAllData>, IBptMoldingTechAllDataManager
    {
		#region 属性注入与构造方法
		
        private IBptMoldingTechAllDataService service;

        public BptMoldingTechAllDataManager()
        {
            this.service = new BptMoldingTechAllDataService();
            base.BaseService = this.service;
        }

        public BptMoldingTechAllDataManager(string language)
        {
            this.service = new BptMoldingTechAllDataService(language);
            base.BaseService = this.service;
        }
        
        #endregion
    }
}
