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
