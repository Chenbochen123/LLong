using System;
using System.Collections.Generic;
using System.Text;
using Mesnac.DbAccess;

namespace Mesnac.InterfaceBG.Data.Implements
{
    using Mesnac.InterfaceBG.Entity.BasicEntity;
    using Mesnac.InterfaceBG.Data.Interface;
    public class PlmHalfMainService : BaseService<PlmHalfMain>, IPlmHalfMainService
    {
        #region 构造方法

        public PlmHalfMainService() : base() { }

        public PlmHalfMainService(string dbName) : base(dbName) { }

        #endregion
    }
}
