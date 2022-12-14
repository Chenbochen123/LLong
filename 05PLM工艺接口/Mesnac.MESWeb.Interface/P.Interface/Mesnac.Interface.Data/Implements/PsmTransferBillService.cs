using System;
using System.Collections.Generic;
using System.Text;
using Mesnac.DbAccess;

namespace Mesnac.Interface.Data.Implements
{
    using Mesnac.Interface.Entity.BasicEntity;
    using Mesnac.Interface.Data.Interface;
    public class PsmTransferBillService : BaseService<PsmTransferBill>, IPsmTransferBillService
    {
        #region 构造方法

        public PsmTransferBillService() : base() { }

        public PsmTransferBillService(string dbName) : base(dbName) { }

        #endregion
    }
}
