using System;
using System.Collections.Generic;
using System.Text;
using Mesnac.DbAccess;

namespace Mesnac.Interface.Data.Implements
{
    using Mesnac.Interface.Entity.BasicEntity;
    using Mesnac.Interface.Data.Interface;
    public class PsmOutStockDetailService : BaseService<PsmOutStockDetail>, IPsmOutStockDetailService
    {
        #region 构造方法

        public PsmOutStockDetailService() : base() { }

        public PsmOutStockDetailService(string dbName) : base(dbName) { }

        #endregion
    }
}
