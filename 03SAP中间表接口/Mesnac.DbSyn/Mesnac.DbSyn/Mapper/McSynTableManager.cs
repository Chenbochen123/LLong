using System;
using System.Collections.Generic;
using System.Text;
using Mesnac.DbAccess;

namespace Mesnac.DbSyn.Business.Implements
{
    using Mesnac.DbSyn.Entity.BasicEntity;
    using Mesnac.DbSyn.Data.Interface;
    using Mesnac.DbSyn.Data.Implements;
    using Mesnac.DbSyn.Business.Interface;
    public class McSynTableManager : BaseManager<McSynTable>, IMcSynTableManager
    {
		#region 属性注入与构造方法
		
        private IMcSynTableService service;

        public McSynTableManager()
        {
            this.service = new McSynTableService();
            base.BaseService = this.service;
        }

        public McSynTableManager(string dbName)
        {
            this.service = new McSynTableService(dbName);
            base.BaseService = this.service;
        }
        
        #endregion
    }
}
