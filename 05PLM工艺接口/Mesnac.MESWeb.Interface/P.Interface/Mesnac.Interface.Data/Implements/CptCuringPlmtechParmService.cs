using System;
using System.Collections.Generic;
using System.Text;
using Mesnac.DbAccess;

namespace Mesnac.Interface.Data.Implements
{
    using Mesnac.Interface.Entity.BasicEntity;
    using Mesnac.Interface.Data.Interface;
    public class CptCuringPlmtechParmService : BaseService<CptCuringPlmtechParm>, ICptCuringPlmtechParmService
    {
        #region 构造方法

        public CptCuringPlmtechParmService() : base() { }

        public CptCuringPlmtechParmService(string dbName) : base(dbName) { }

        #endregion
    }
}
