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
