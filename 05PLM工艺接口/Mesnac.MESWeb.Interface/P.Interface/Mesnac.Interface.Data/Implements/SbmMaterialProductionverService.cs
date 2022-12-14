using System;
using System.Collections.Generic;
using System.Text;
using Mesnac.DbAccess;

namespace Mesnac.Interface.Data.Implements
{
    using Mesnac.Interface.Entity.BasicEntity;
    using Mesnac.Interface.Data.Interface;
    public class SbmMaterialProductionverService : BaseService<SbmMaterialProductionver>, ISbmMaterialProductionverService
    {
        #region 构造方法

        public SbmMaterialProductionverService() : base() { }

        public SbmMaterialProductionverService(string dbName) : base(dbName) { }

        #endregion
    }
}
