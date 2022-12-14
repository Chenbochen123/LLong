using System;
using System.Collections.Generic;
using System.Text;
using Mesnac.DbAccess;

namespace Mesnac.sqlmid.Business.Implements
{
    using Mesnac.sqlmid.Entity.BasicEntity;
    using Mesnac.sqlmid.Data.Interface;
    using Mesnac.sqlmid.Data.Implements;
    using Mesnac.sqlmid.Business.Interface;
    public class MaterialsManager : BaseManager<Materials>, IMaterialsManager
    {
		#region 属性注入与构造方法
		
        private IMaterialsService service;

        public MaterialsManager()
        {
            this.service = new MaterialsService();
            base.BaseService = this.service;
        }

        public MaterialsManager(string language)
        {
            this.service = new MaterialsService(language);
            base.BaseService = this.service;
        }
        
        #endregion
    }
}
