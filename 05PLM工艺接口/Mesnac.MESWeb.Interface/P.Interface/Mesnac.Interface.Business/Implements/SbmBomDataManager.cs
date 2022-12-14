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
    public class SbmBomDataManager : BaseManager<SbmBomData>, ISbmBomDataManager
    {
		#region 属性注入与构造方法
		
        private ISbmBomDataService service;

        public SbmBomDataManager()
        {
            this.service = new SbmBomDataService();
            base.BaseService = this.service;
        }

        public SbmBomDataManager(string language)
        {
            this.service = new SbmBomDataService(language);
            base.BaseService = this.service;
        }
        
        #endregion
    }
}
