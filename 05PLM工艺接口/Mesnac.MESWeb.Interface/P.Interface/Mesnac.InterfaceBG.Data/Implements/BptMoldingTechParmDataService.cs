using System;
using System.Collections.Generic;
using System.Text;
using Mesnac.DbAccess;

namespace Mesnac.InterfaceBG.Data.Implements
{
    using Mesnac.InterfaceBG.Entity.BasicEntity;
    using Mesnac.InterfaceBG.Data.Interface;
    public class BptMoldingTechParmDataService : BaseService<BptMoldingTechParmData>, IBptMoldingTechParmDataService
    {
        #region 构造方法

        public BptMoldingTechParmDataService() : base() { }

        public BptMoldingTechParmDataService(string dbName) : base(dbName) { }

        #endregion
    }
}
