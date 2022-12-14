using System;
using System.Collections.Generic;
using System.Text;
using Mesnac.DbAccess;

namespace Mesnac.InterfaceBG.Data.Implements
{
    using Mesnac.InterfaceBG.Entity.BasicEntity;
    using Mesnac.InterfaceBG.Data.Interface;
    public class CbmMaterialService : BaseService<CbmMaterial>, ICbmMaterialService
    {
        #region 构造方法

        public CbmMaterialService() : base() { }

        public CbmMaterialService(string dbName) : base(dbName) { }

        #endregion
    }
}
