using System;
using System.Collections.Generic;
using System.Text;
using Mesnac.DbAccess;

namespace Mesnac.Interface.Data.Implements
{
    using Mesnac.Interface.Entity.BasicEntity;
    using Mesnac.Interface.Data.Interface;
    public class PsmOutStockMainService : BaseService<PsmOutStockMain>, IPsmOutStockMainService
    {
        #region 构造方法

        public PsmOutStockMainService() : base() { }

        public PsmOutStockMainService(string dbName) : base(dbName) { }

        #endregion
    }
}
