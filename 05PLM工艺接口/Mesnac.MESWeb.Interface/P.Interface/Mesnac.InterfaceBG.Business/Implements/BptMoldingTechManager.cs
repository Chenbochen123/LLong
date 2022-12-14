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
    public class BptMoldingTechManager : BaseManager<BptMoldingTech>, IBptMoldingTechManager
    {
		#region 属性注入与构造方法
		
        private IBptMoldingTechService service;

        public BptMoldingTechManager()
        {
            this.service = new BptMoldingTechService();
            base.BaseService = this.service;
        }

        public BptMoldingTechManager(string language)
        {
            this.service = new BptMoldingTechService(language);
            base.BaseService = this.service;
        }
        
        #endregion
    }
}
