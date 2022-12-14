using System;
using System.Collections.Generic;
using System.Text;
using Mesnac.DbAccess;

namespace Mesnac.Interface.Data.Implements
{
    using Mesnac.Interface.Entity.BasicEntity;
    using Mesnac.Interface.Data.Interface;
    public class PlmToleranceParameterMainService : BaseService<PlmToleranceParameterMain>, IPlmToleranceParameterMainService
    {
        #region 构造方法

        public PlmToleranceParameterMainService() : base() { }

        public PlmToleranceParameterMainService(string dbName) : base(dbName) { }

        #endregion
    }
}
