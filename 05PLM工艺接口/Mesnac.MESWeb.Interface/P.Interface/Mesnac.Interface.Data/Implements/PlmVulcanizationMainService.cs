using System;
using System.Collections.Generic;
using System.Text;
using Mesnac.DbAccess;

namespace Mesnac.Interface.Data.Implements
{
    using Mesnac.Interface.Entity.BasicEntity;
    using Mesnac.Interface.Data.Interface;
    public class PlmVulcanizationMainService : BaseService<PlmVulcanizationMain>, IPlmVulcanizationMainService
    {
        #region 构造方法

        public PlmVulcanizationMainService() : base() { }

        public PlmVulcanizationMainService(string dbName) : base(dbName) { }

        #endregion
    }
}
