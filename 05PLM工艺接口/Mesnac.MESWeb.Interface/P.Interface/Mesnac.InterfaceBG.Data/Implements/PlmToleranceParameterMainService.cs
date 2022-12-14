using System;
using System.Collections.Generic;
using System.Text;
using Mesnac.DbAccess;

namespace Mesnac.InterfaceBG.Data.Implements
{
    using Mesnac.InterfaceBG.Entity.BasicEntity;
    using Mesnac.InterfaceBG.Data.Interface;
    public class PlmToleranceParameterMainService : BaseService<PlmToleranceParameterMain>, IPlmToleranceParameterMainService
    {
        #region 构造方法

        public PlmToleranceParameterMainService() : base() { }

        public PlmToleranceParameterMainService(string dbName) : base(dbName) { }

        #endregion
    }
}
