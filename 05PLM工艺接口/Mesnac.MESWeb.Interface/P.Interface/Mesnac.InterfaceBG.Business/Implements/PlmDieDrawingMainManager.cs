using System;
using System.Collections.Generic;
using System.Text;
using Mesnac.DbAccess;

namespace Mesnac.InterfaceBG.Business.Implements
{
    using Mesnac.InterfaceBG.Entity.BasicEntity;
    using Mesnac.InterfaceBG.Data.Interface;
    using Mesnac.InterfaceBG.Data.Implements;
    using Mesnac.InterfaceBG.Business.Interface;
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
