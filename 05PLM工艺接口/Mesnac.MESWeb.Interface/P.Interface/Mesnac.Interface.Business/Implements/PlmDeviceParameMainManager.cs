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
