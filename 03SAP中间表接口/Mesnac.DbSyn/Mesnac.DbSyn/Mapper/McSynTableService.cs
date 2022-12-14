using System;
using System.Collections.Generic;
using System.Text;
using Mesnac.DbAccess;

namespace Mesnac.DbSyn.Data.Implements
{
    using Mesnac.DbSyn.Entity.BasicEntity;
    using Mesnac.DbSyn.Data.Interface;
    public class McSynTableService : BaseService<McSynTable>, IMcSynTableService
    {
        #region 构造方法

        public McSynTableService() : base() { }

        public McSynTableService(string dbName) : base(dbName) { }

        #endregion
    }
}
