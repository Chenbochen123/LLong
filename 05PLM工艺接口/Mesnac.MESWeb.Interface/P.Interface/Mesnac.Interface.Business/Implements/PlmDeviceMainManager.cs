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
    public class PlmDeviceMainManager : BaseManager<PlmDeviceMain>, IPlmDeviceMainManager
    {
		#region 属性注入与构造方法
		
        private IPlmDeviceMainService service;

        public PlmDeviceMainManager()
        {
            this.service = new PlmDeviceMainService();
            base.BaseService = this.service;
        }

        public PlmDeviceMainManager(string language)
        {
            this.service = new PlmDeviceMainService(language);
            base.BaseService = this.service;
        }
        
        #endregion
    }
}
