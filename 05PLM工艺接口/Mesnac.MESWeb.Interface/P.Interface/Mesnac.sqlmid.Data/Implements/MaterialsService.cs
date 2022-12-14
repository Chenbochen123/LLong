using System;
using System.Collections.Generic;
using System.Text;
using Mesnac.DbAccess;

namespace Mesnac.sqlmid.Data.Implements
{
    using Mesnac.sqlmid.Entity.BasicEntity;
    using Mesnac.sqlmid.Data.Interface;
    public class MaterialsService : BaseService<Materials>, IMaterialsService
    {
        #region 构造方法

        public MaterialsService() : base() { }

        public MaterialsService(string dbName) : base(dbName) { }

        #endregion
    }
}
