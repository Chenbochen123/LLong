using System;
using System.Collections.Generic;
using System.Text;
using Mesnac.DbAccess;

namespace Mesnac.Interface.Data.Implements
{
    using Mesnac.Interface.Entity.BasicEntity;
    using Mesnac.Interface.Data.Interface;
    public class PlmModingMainService : BaseService<PlmModingMain>, IPlmModingMainService
    {
        #region 构造方法

        public PlmModingMainService() : base() { }

        public PlmModingMainService(string dbName) : base(dbName) { }

        #endregion
    }
}
