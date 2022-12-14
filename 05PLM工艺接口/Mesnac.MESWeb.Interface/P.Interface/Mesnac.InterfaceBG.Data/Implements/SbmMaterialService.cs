using System;
using System.Collections.Generic;
using System.Text;
using Mesnac.DbAccess;

namespace Mesnac.InterfaceBG.Data.Implements
{
    using Mesnac.InterfaceBG.Entity.BasicEntity;
    using Mesnac.InterfaceBG.Data.Interface;
    public class SbmMaterialService : BaseService<SbmMaterial>, ISbmMaterialService
    {
        #region 构造方法

        public SbmMaterialService() : base() { }

        public SbmMaterialService(string dbName) : base(dbName) { }

        #endregion
    }
}
