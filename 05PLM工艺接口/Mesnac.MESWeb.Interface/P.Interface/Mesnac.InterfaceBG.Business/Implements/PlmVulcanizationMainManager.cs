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
    public class PlmVulcanizationMainManager : BaseManager<PlmVulcanizationMain>, IPlmVulcanizationMainManager
    {
		#region 属性注入与构造方法
		
        private IPlmVulcanizationMainService service;

        public PlmVulcanizationMainManager()
        {
            this.service = new PlmVulcanizationMainService();
            base.BaseService = this.service;
        }

        public PlmVulcanizationMainManager(string language)
        {
            this.service = new PlmVulcanizationMainService(language);
            base.BaseService = this.service;
        }
        
        #endregion
    }
}
