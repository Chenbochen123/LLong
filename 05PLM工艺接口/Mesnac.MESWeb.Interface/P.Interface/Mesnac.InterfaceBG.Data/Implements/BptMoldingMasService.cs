using System;
using System.Collections.Generic;
using System.Text;
using Mesnac.DbAccess;

namespace Mesnac.InterfaceBG.Data.Implements
{
    using Mesnac.InterfaceBG.Entity.BasicEntity;
    using Mesnac.InterfaceBG.Data.Interface;
    public class BptMoldingMasService : BaseService<BptMoldingMas>, IBptMoldingMasService
    {
        #region 构造方法

        public BptMoldingMasService() : base() { }

        public BptMoldingMasService(string dbName) : base(dbName) { }

        #endregion
    }
}
