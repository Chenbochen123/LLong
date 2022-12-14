using System;
using System.Collections.Generic;
using System.Text;
using Mesnac.DbAccess;

namespace Mesnac.Interface.Data.Implements
{
    using Mesnac.Interface.Entity.BasicEntity;
    using Mesnac.Interface.Data.Interface;
    public class BptMoldingTechService : BaseService<BptMoldingTech>, IBptMoldingTechService
    {
        #region 构造方法

        public BptMoldingTechService() : base() { }

        public BptMoldingTechService(string dbName) : base(dbName) { }

        #endregion
    }
}
