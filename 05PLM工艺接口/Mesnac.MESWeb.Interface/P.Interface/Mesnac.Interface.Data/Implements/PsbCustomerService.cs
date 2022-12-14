using System;
using System.Collections.Generic;
using System.Text;
using Mesnac.DbAccess;

namespace Mesnac.Interface.Data.Implements
{
    using Mesnac.Interface.Entity.BasicEntity;
    using Mesnac.Interface.Data.Interface;
    public class PsbCustomerService : BaseService<PsbCustomer>, IPsbCustomerService
    {
        #region 构造方法

        public PsbCustomerService() : base() { }

        public PsbCustomerService(string dbName) : base(dbName) { }

        #endregion
    }
}
