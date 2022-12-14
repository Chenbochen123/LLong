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
    public class PlmDieDrawingMainManager : BaseManager<PlmDieDrawingMain>, IPlmDieDrawingMainManager
    {
		#region 属性注入与构造方法
		
        private IPlmDieDrawingMainService service;

        public PlmDieDrawingMainManager()
        {
            this.service = new PlmDieDrawingMainService();
            base.BaseService = this.service;
        }

        public PlmDieDrawingMainManager(string language)
        {
            this.service = new PlmDieDrawingMainService(language);
            base.BaseService = this.service;
        }
        
        #endregion
    }
}
