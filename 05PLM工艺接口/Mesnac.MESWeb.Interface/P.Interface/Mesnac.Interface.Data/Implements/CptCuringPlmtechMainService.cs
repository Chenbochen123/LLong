using System;
using System.Collections.Generic;
using System.Text;
using Mesnac.DbAccess;

namespace Mesnac.Interface.Data.Implements
{
    using Mesnac.Interface.Entity.BasicEntity;
    using Mesnac.Interface.Data.Interface;
    public class CptCuringPlmtechMainService : BaseService<CptCuringPlmtechMain>, ICptCuringPlmtechMainService
    {
        #region 构造方法

        public CptCuringPlmtechMainService() : base() { }

        public CptCuringPlmtechMainService(string dbName) : base(dbName) { }

        #endregion
    }
}
