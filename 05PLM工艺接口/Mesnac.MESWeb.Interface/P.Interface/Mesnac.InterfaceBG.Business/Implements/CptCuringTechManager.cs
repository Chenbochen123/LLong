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
