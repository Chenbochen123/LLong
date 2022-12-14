using System;
using System.Collections.Generic;
using System.Text;
using Mesnac.DbAccess;

namespace Mesnac.Interface.Data.Implements
{
    using Mesnac.Interface.Entity.BasicEntity;
    using Mesnac.Interface.Data.Interface;
    public class PlmHalfMainService : BaseService<PlmHalfMain>, IPlmHalfMainService
    {
        #region 构造方法

        public PlmHalfMainService() : base() { }

        public PlmHalfMainService(string dbName) : base(dbName) { }

        #endregion
    }
}
