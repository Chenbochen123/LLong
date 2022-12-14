using System;
using System.Collections.Generic;
using System.Text;
using Mesnac.DbAccess;

namespace Mesnac.InterfaceBG.Data.Implements
{
    using Mesnac.InterfaceBG.Entity.BasicEntity;
    using Mesnac.InterfaceBG.Data.Interface;
    public class CptCuringPlmtechParmService : BaseService<CptCuringPlmtechParm>, ICptCuringPlmtechParmService
    {
        #region 构造方法

        public CptCuringPlmtechParmService() : base() { }

        public CptCuringPlmtechParmService(string dbName) : base(dbName) { }

        #endregion
    }
}
