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
    public class PlmToleranceParameterMainManager : BaseManager<PlmToleranceParameterMain>, IPlmToleranceParameterMainManager
    {
		#region 属性注入与构造方法
		
        private IPlmToleranceParameterMainService service;

        public PlmToleranceParameterMainManager()
        {
            this.service = new PlmToleranceParameterMainService();
            base.BaseService = this.service;
        }

        public PlmToleranceParameterMainManager(string language)
        {
            this.service = new PlmToleranceParameterMainService(language);
            base.BaseService = this.service;
        }
        
        #endregion
    }
}
