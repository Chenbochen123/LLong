using System;
using System.Collections.Generic;
using System.Text;
using Mesnac.DbAccess;

namespace Mesnac.Interface.Data.Implements
{
    using Mesnac.Interface.Entity.BasicEntity;
    using Mesnac.Interface.Data.Interface;
    public class SiiSapLogService : BaseService<SiiSapLog>, ISiiSapLogService
    {
        #region 构造方法

        public SiiSapLogService() : base() { }

        public SiiSapLogService(string dbName) : base(dbName) { }

        #endregion
    }
}
