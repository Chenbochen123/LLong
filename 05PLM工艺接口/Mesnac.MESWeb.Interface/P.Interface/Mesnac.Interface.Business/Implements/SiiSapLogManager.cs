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
    public class SiiSapLogManager : BaseManager<SiiSapLog>, ISiiSapLogManager
    {
		#region 属性注入与构造方法
		
        private ISiiSapLogService service;

        public SiiSapLogManager()
        {
            this.service = new SiiSapLogService();
            base.BaseService = this.service;
        }

        public SiiSapLogManager(string language)
        {
            this.service = new SiiSapLogService(language);
            base.BaseService = this.service;
        }
        
        #endregion
    }
}
