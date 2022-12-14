using System;
using System.Collections.Generic;
using System.Text;
using Mesnac.DbAccess;

namespace Mesnac.InterfaceBG.Data.Implements
{
    using Mesnac.InterfaceBG.Entity.BasicEntity;
    using Mesnac.InterfaceBG.Data.Interface;
    public class PsmOutStockBillService : BaseService<PsmOutStockBill>, IPsmOutStockBillService
    {
        #region 构造方法

        public PsmOutStockBillService() : base() { }

        public PsmOutStockBillService(string dbName) : base(dbName) { }

        #endregion
    }
}
