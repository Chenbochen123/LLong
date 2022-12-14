using System;
using System.Collections.Generic;
using System.Text;
using Mesnac.DbAccess;

namespace Mesnac.InterfaceBG.Data.Implements
{
    using Mesnac.InterfaceBG.Entity.BasicEntity;
    using Mesnac.InterfaceBG.Data.Interface;
    public class BptMoldingTechService : BaseService<BptMoldingTech>, IBptMoldingTechService
    {
        #region 构造方法

        public BptMoldingTechService() : base() { }

        public BptMoldingTechService(string dbName) : base(dbName) { }

        #endregion
    }
}
