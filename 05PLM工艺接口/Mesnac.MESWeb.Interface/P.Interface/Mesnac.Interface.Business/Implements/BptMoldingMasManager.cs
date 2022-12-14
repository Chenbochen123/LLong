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
