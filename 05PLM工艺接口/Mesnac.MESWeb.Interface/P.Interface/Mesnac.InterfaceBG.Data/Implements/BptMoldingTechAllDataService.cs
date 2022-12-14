using System;
using System.Collections.Generic;
using System.Text;
using Mesnac.DbAccess;

namespace Mesnac.InterfaceBG.Data.Implements
{
    using Mesnac.InterfaceBG.Entity.BasicEntity;
    using Mesnac.InterfaceBG.Data.Interface;
    public class BptMoldingTechAllDataService : BaseService<BptMoldingTechAllData>, IBptMoldingTechAllDataService
    {
        #region 构造方法

        public BptMoldingTechAllDataService() : base() { }

        public BptMoldingTechAllDataService(string dbName) : base(dbName) { }

        #endregion
    }
}
