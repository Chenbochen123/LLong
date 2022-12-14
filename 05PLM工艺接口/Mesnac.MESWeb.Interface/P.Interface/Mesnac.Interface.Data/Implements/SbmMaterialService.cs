using System;
using System.Collections.Generic;
using System.Text;
using Mesnac.DbAccess;

namespace Mesnac.Interface.Data.Implements
{
    using Mesnac.Interface.Entity.BasicEntity;
    using Mesnac.Interface.Data.Interface;
    public class SbmMaterialService : BaseService<SbmMaterial>, ISbmMaterialService
    {
        #region 构造方法

        public SbmMaterialService() : base() { }

        public SbmMaterialService(string dbName) : base(dbName) { }

        #endregion
    }
}
