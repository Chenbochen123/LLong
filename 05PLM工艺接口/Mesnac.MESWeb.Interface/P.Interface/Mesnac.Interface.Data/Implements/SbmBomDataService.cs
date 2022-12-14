using System;
using System.Collections.Generic;
using System.Text;
using Mesnac.DbAccess;

namespace Mesnac.Interface.Data.Implements
{
    using Mesnac.Interface.Entity.BasicEntity;
    using Mesnac.Interface.Data.Interface;
    public class SbmBomDataService : BaseService<SbmBomData>, ISbmBomDataService
    {
        #region 构造方法

        public SbmBomDataService() : base() { }

        public SbmBomDataService(string dbName) : base(dbName) { }

        #endregion
    }
}
