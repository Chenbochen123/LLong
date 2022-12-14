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
