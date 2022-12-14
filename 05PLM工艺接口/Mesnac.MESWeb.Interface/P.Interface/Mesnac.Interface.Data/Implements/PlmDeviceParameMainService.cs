using System;
using System.Collections.Generic;
using System.Text;
using Mesnac.DbAccess;

namespace Mesnac.Interface.Data.Implements
{
    using Mesnac.Interface.Entity.BasicEntity;
    using Mesnac.Interface.Data.Interface;
    public class PlmDeviceParameMainService : BaseService<PlmDeviceParameMain>, IPlmDeviceParameMainService
    {
        #region 构造方法

        public PlmDeviceParameMainService() : base() { }

        public PlmDeviceParameMainService(string dbName) : base(dbName) { }

        #endregion
    }
}
