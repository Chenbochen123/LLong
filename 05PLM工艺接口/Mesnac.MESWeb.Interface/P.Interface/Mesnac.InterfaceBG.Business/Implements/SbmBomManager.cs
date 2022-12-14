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
    public class SbmBomManager : BaseManager<SbmBom>, ISbmBomManager
    {
		#region 属性注入与构造方法
		
        private ISbmBomService service;

        public SbmBomManager()
        {
            this.service = new SbmBomService();
            base.BaseService = this.service;
        }

        public SbmBomManager(string language)
        {
            this.service = new SbmBomService(language);
            base.BaseService = this.service;
        }
        
        #endregion
    }
}
