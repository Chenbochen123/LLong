using System;
using System.Collections.Generic;
using System.Text;
using Mesnac.DbAccess;

namespace Mesnac.InterfaceBG.Data.Implements
{
    using Mesnac.InterfaceBG.Entity.BasicEntity;
    using Mesnac.InterfaceBG.Data.Interface;
    public class PlmVulcanizationMainService : BaseService<PlmVulcanizationMain>, IPlmVulcanizationMainService
    {
        #region 构造方法

        public PlmVulcanizationMainService() : base() { }

        public PlmVulcanizationMainService(string dbName) : base(dbName) { }

        #endregion
    }
}
