using System;
using System.Collections.Generic;
using System.Text;
using Mesnac.DbAccess;

namespace Mesnac.Interface.Data.Implements
{
    using Mesnac.Interface.Entity.BasicEntity;
    using Mesnac.Interface.Data.Interface;
    public class ItfSapProductionRecordsService : BaseService<ItfSapProductionRecords>, IItfSapProductionRecordsService
    {
        #region 构造方法

        public ItfSapProductionRecordsService() : base() { }

        public ItfSapProductionRecordsService(string dbName) : base(dbName) { }

        #endregion
    }
}
