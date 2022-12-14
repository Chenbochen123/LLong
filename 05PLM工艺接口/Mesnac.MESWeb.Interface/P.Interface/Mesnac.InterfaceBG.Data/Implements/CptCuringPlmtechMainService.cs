using System;
using System.Collections.Generic;
using System.Text;
using Mesnac.DbAccess;

namespace Mesnac.InterfaceBG.Data.Implements
{
    using Mesnac.InterfaceBG.Entity.BasicEntity;
    using Mesnac.InterfaceBG.Data.Interface;
    public class CptCuringPlmtechMainService : BaseService<CptCuringPlmtechMain>, ICptCuringPlmtechMainService
    {
        #region 构造方法

        public CptCuringPlmtechMainService() : base() { }

        public CptCuringPlmtechMainService(string dbName) : base(dbName) { }

        #endregion
    }
}
