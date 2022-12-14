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
    public class SbmMaterialProductionverManager : BaseManager<SbmMaterialProductionver>, ISbmMaterialProductionverManager
    {
		#region 属性注入与构造方法
		
        private ISbmMaterialProductionverService service;

        public SbmMaterialProductionverManager()
        {
            this.service = new SbmMaterialProductionverService();
            base.BaseService = this.service;
        }

        public SbmMaterialProductionverManager(string language)
        {
            this.service = new SbmMaterialProductionverService(language);
            base.BaseService = this.service;
        }
        
        #endregion
    }
}
