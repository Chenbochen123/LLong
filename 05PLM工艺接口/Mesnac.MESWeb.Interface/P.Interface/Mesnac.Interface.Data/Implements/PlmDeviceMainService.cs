using System;
using System.Collections.Generic;
using System.Text;
using Mesnac.DbAccess;

namespace Mesnac.Interface.Data.Implements
{
    using Mesnac.Interface.Entity.BasicEntity;
    using Mesnac.Interface.Data.Interface;
    public class PlmDeviceMainService : BaseService<PlmDeviceMain>, IPlmDeviceMainService
    {
        #region 构造方法

        public PlmDeviceMainService() : base() { }

        public PlmDeviceMainService(string dbName) : base(dbName) { }

        #endregion
    }
}
