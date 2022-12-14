using System;
using System.Collections.Generic;
using System.Text;
using Mesnac.DbAccess;

namespace Mesnac.Interface.Data.Implements
{
    using Mesnac.Interface.Entity.BasicEntity;
    using Mesnac.Interface.Data.Interface;
    public class PsmTransferMainService : BaseService<PsmTransferMain>, IPsmTransferMainService
    {
        #region 构造方法

        public PsmTransferMainService() : base() { }

        public PsmTransferMainService(string dbName) : base(dbName) { }

        #endregion
    }
}
