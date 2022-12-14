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
