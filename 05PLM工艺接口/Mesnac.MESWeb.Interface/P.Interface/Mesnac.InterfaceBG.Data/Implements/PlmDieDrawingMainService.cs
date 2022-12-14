using System;
using System.Collections.Generic;
using System.Text;
using Mesnac.DbAccess;

namespace Mesnac.InterfaceBG.Data.Implements
{
    using Mesnac.InterfaceBG.Entity.BasicEntity;
    using Mesnac.InterfaceBG.Data.Interface;
    public class PlmDieDrawingMainService : BaseService<PlmDieDrawingMain>, IPlmDieDrawingMainService
    {
        #region 构造方法

        public PlmDieDrawingMainService() : base() { }

        public PlmDieDrawingMainService(string dbName) : base(dbName) { }

        #endregion
    }
}
