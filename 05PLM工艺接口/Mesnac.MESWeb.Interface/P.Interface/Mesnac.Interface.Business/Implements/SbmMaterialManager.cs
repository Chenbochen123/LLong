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
    public class SbmMaterialManager : BaseManager<SbmMaterial>, ISbmMaterialManager
    {
		#region 属性注入与构造方法
		
        private ISbmMaterialService service;

        public SbmMaterialManager()
        {
            this.service = new SbmMaterialService();
            base.BaseService = this.service;
        }

        public SbmMaterialManager(string language)
        {
            this.service = new SbmMaterialService(language);
            base.BaseService = this.service;
        }
        
        #endregion
    }
}
