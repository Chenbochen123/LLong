using System;
using System.Collections.Generic;
using System.Text;
using Mesnac.DbAccess;

namespace Mesnac.Interface.Data.Implements
{
    using Mesnac.Interface.Entity.BasicEntity;
    using Mesnac.Interface.Data.Interface;
    public class CptCuringMasService : BaseService<CptCuringMas>, ICptCuringMasService
    {
        #region 构造方法

        public CptCuringMasService() : base() { }

        public CptCuringMasService(string dbName) : base(dbName) { }

        #endregion
    }
}
