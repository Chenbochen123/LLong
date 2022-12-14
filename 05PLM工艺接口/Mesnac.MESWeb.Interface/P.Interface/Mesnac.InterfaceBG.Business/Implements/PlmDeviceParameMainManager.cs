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
    public class PlmDeviceParameMainManager : BaseManager<PlmDeviceParameMain>, IPlmDeviceParameMainManager
    {
		#region 属性注入与构造方法
		
        private IPlmDeviceParameMainService service;

        public PlmDeviceParameMainManager()
        {
            this.service = new PlmDeviceParameMainService();
            base.BaseService = this.service;
        }

        public PlmDeviceParameMainManager(string language)
        {
            this.service = new PlmDeviceParameMainService(language);
            base.BaseService = this.service;
        }
        
        #endregion
    }
}
