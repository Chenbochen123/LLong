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
    public class PlmModingMainManager : BaseManager<PlmModingMain>, IPlmModingMainManager
    {
		#region 属性注入与构造方法
		
        private IPlmModingMainService service;

        public PlmModingMainManager()
        {
            this.service = new PlmModingMainService();
            base.BaseService = this.service;
        }

        public PlmModingMainManager(string language)
        {
            this.service = new PlmModingMainService(language);
            base.BaseService = this.service;
        }
        
        #endregion
    }
}
