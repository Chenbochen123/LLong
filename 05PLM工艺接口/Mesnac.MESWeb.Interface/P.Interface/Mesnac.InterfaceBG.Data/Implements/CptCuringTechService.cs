using System;
using System.Collections.Generic;
using System.Text;
using Mesnac.DbAccess;

namespace Mesnac.InterfaceBG.Data.Implements
{
    using Mesnac.InterfaceBG.Entity.BasicEntity;
    using Mesnac.InterfaceBG.Data.Interface;
    public class CptCuringTechService : BaseService<CptCuringTech>, ICptCuringTechService
    {
        #region 构造方法

        public CptCuringTechService() : base() { }

        public CptCuringTechService(string dbName) : base(dbName) { }

        #endregion
    }
}
