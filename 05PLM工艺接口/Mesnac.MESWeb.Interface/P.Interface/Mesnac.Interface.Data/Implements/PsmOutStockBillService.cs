using System;
using System.Collections.Generic;
using System.Text;
using Mesnac.DbAccess;

namespace Mesnac.Interface.Data.Implements
{
    using Mesnac.Interface.Entity.BasicEntity;
    using Mesnac.Interface.Data.Interface;
    public class PsmOutStockBillService : BaseService<PsmOutStockBill>, IPsmOutStockBillService
    {
        #region 构造方法

        public PsmOutStockBillService() : base() { }

        public PsmOutStockBillService(string dbName) : base(dbName) { }

        #endregion
    }
}
