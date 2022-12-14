using System;
using System.Collections.Generic;
using System.Text;
using Mesnac.DbAccess;

namespace Mesnac.Interface.Data.Implements
{
    using Mesnac.Interface.Entity.BasicEntity;
    using Mesnac.Interface.Data.Interface;
    public class BptMoldingMasService : BaseService<BptMoldingMas>, IBptMoldingMasService
    {
        #region 构造方法

        public BptMoldingMasService() : base() { }

        public BptMoldingMasService(string dbName) : base(dbName) { }

        #endregion
    }
}
