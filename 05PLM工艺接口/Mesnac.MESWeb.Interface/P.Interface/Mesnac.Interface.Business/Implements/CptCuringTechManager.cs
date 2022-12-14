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
    public class CptCuringTechManager : BaseManager<CptCuringTech>, ICptCuringTechManager
    {
		#region 属性注入与构造方法
		
        private ICptCuringTechService service;

        public CptCuringTechManager()
        {
            this.service = new CptCuringTechService();
            base.BaseService = this.service;
        }

        public CptCuringTechManager(string language)
        {
            this.service = new CptCuringTechService(language);
            base.BaseService = this.service;
        }
        
        #endregion
    }
}
