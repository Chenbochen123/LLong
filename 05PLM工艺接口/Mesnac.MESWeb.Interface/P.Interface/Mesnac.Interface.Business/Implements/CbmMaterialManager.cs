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
    public class CbmMaterialManager : BaseManager<CbmMaterial>, ICbmMaterialManager
    {
		#region 属性注入与构造方法
		
        private ICbmMaterialService service;

        public CbmMaterialManager()
        {
            this.service = new CbmMaterialService();
            base.BaseService = this.service;
        }

        public CbmMaterialManager(string language)
        {
            this.service = new CbmMaterialService(language);
            base.BaseService = this.service;
        }
        
        #endregion
    }
}
