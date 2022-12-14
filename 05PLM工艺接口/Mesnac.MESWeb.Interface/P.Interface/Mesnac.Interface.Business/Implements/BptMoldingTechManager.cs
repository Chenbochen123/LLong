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
