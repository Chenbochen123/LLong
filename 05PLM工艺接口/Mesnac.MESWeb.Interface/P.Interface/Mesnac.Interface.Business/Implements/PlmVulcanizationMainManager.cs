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
