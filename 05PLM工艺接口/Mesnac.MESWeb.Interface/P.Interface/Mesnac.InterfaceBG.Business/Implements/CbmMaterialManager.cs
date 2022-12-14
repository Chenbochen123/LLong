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
