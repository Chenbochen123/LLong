using System;
using System.Collections.Generic;
using System.Text;
using Mesnac.DbAccess;

namespace Mesnac.Interface.Business.Implements
{
    using Mesnac.Interface.Entity.BasicEntity;
    using Mesnac.Interface.Data.Interface;
    using Mesnac.Interface.Data.Implements;
    using Mesnac.Interface.Business.Interface;
    public class ItfSapProductionRecordsManager : BaseManager<ItfSapProductionRecords>, IItfSapProductionRecordsManager
    {
		#region 属性注入与构造方法
		
        private IItfSapProductionRecordsService service;

        public ItfSapProductionRecordsManager()
        {
            this.service = new ItfSapProductionRecordsService();
            base.BaseService = this.service;
        }

        public ItfSapProductionRecordsManager(string language)
        {
            this.service = new ItfSapProductionRecordsService(language);
            base.BaseService = this.service;
        }
        
        #endregion
    }
}
