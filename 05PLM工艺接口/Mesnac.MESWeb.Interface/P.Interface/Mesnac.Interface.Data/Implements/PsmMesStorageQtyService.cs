using System;
using System.Collections.Generic;
using System.Text;
using Mesnac.DbAccess;

namespace Mesnac.Interface.Data.Implements
{
    using Mesnac.Interface.Entity.BasicEntity;
    using Mesnac.Interface.Data.Interface;
    public class PsmMesStorageQtyService : BaseService<PsmMesStorageQty>, IPsmMesStorageQtyService
    {
        #region 构造方法

        public PsmMesStorageQtyService() : base() { }

        public PsmMesStorageQtyService(string dbName) : base(dbName) { }

        #endregion
    }
}
