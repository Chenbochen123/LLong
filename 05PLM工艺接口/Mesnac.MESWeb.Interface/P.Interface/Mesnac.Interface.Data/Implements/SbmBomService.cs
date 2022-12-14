using System;
using System.Collections.Generic;
using System.Text;
using Mesnac.DbAccess;

namespace Mesnac.Interface.Data.Implements
{
    using Mesnac.Interface.Entity.BasicEntity;
    using Mesnac.Interface.Data.Interface;
    public class SbmBomService : BaseService<SbmBom>, ISbmBomService
    {
        #region 构造方法

        public SbmBomService() : base() { }

        public SbmBomService(string dbName) : base(dbName) { }

        #endregion
    }
}
