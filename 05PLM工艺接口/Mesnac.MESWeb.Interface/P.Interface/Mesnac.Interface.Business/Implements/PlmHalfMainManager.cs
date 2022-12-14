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
    public class PlmHalfMainManager : BaseManager<PlmHalfMain>, IPlmHalfMainManager
    {
		#region 属性注入与构造方法
		
        private IPlmHalfMainService service;

        public PlmHalfMainManager()
        {
            this.service = new PlmHalfMainService();
            base.BaseService = this.service;
        }

        public PlmHalfMainManager(string language)
        {
            this.service = new PlmHalfMainService(language);
            base.BaseService = this.service;
        }
        
        #endregion
    }
}
