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
    public class PsbCustomerManager : BaseManager<PsbCustomer>, IPsbCustomerManager
    {
		#region 属性注入与构造方法
		
        private IPsbCustomerService service;

        public PsbCustomerManager()
        {
            this.service = new PsbCustomerService();
            base.BaseService = this.service;
        }

        public PsbCustomerManager(string language)
        {
            this.service = new PsbCustomerService(language);
            base.BaseService = this.service;
        }
        
        #endregion
    }
}
