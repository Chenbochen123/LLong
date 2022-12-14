using System;
using System.Collections.Generic;
using System.Text;
using Mesnac.DbAccess;

namespace Mesnac.Interface.Data.Implements
{
    using Mesnac.Interface.Entity.BasicEntity;
    using Mesnac.Interface.Data.Interface;
    public class CptCuringTechParmDataService : BaseService<CptCuringTechParmData>, ICptCuringTechParmDataService
    {
        #region 构造方法

        public CptCuringTechParmDataService() : base() { }

        public CptCuringTechParmDataService(string dbName) : base(dbName) { }

        #endregion
    }
}
