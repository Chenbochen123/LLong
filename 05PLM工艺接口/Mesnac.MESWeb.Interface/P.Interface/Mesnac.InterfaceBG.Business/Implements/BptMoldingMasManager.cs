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
    public class BptMoldingMasManager : BaseManager<BptMoldingMas>, IBptMoldingMasManager
    {
		#region 属性注入与构造方法
		
        private IBptMoldingMasService service;

        public BptMoldingMasManager()
        {
            this.service = new BptMoldingMasService();
            base.BaseService = this.service;
        }

        public BptMoldingMasManager(string language)
        {
            this.service = new BptMoldingMasService(language);
            base.BaseService = this.service;
        }
        
        #endregion
    }
}
