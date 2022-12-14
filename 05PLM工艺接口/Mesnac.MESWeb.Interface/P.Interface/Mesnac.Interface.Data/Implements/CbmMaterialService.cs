using System;
using System.Collections.Generic;
using System.Text;
using Mesnac.DbAccess;

namespace Mesnac.Interface.Data.Implements
{
    using Mesnac.Interface.Entity.BasicEntity;
    using Mesnac.Interface.Data.Interface;
    public class CbmMaterialService : BaseService<CbmMaterial>, ICbmMaterialService
    {
        #region 构造方法

        public CbmMaterialService() : base() { }

        public CbmMaterialService(string dbName) : base(dbName) { }

        #endregion
    }
}
