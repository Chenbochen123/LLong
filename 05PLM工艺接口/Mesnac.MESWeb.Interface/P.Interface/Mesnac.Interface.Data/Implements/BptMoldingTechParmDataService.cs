using System;
using System.Collections.Generic;
using System.Text;
using Mesnac.DbAccess;

namespace Mesnac.Interface.Data.Implements
{
    using Mesnac.Interface.Entity.BasicEntity;
    using Mesnac.Interface.Data.Interface;
    public class BptMoldingTechParmDataService : BaseService<BptMoldingTechParmData>, IBptMoldingTechParmDataService
    {
        #region 构造方法

        public BptMoldingTechParmDataService() : base() { }

        public BptMoldingTechParmDataService(string dbName) : base(dbName) { }

        #endregion
    }
}
