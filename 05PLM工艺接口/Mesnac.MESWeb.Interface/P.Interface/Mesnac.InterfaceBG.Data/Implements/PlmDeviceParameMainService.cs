using System;
using System.Collections.Generic;
using System.Text;
using Mesnac.DbAccess;

namespace Mesnac.InterfaceBG.Data.Implements
{
    using Mesnac.InterfaceBG.Entity.BasicEntity;
    using Mesnac.InterfaceBG.Data.Interface;
    public class PlmDeviceParameMainService : BaseService<PlmDeviceParameMain>, IPlmDeviceParameMainService
    {
        #region 构造方法

        public PlmDeviceParameMainService() : base() { }

        public PlmDeviceParameMainService(string dbName) : base(dbName) { }

        #endregion
    }
}
