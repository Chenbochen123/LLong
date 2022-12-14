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
    public class CptCuringTechParmDataManager : BaseManager<CptCuringTechParmData>, ICptCuringTechParmDataManager
    {
		#region 属性注入与构造方法
		
        private ICptCuringTechParmDataService service;

        public CptCuringTechParmDataManager()
        {
            this.service = new CptCuringTechParmDataService();
            base.BaseService = this.service;
        }

        public CptCuringTechParmDataManager(string language)
        {
            this.service = new CptCuringTechParmDataService(language);
            base.BaseService = this.service;
        }
        
        #endregion
    }
}
