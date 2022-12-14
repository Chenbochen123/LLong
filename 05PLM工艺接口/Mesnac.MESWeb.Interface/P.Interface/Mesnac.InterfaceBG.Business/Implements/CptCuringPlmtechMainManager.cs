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
    public class CptCuringPlmtechMainManager : BaseManager<CptCuringPlmtechMain>, ICptCuringPlmtechMainManager
    {
		#region 属性注入与构造方法
		
        private ICptCuringPlmtechMainService service;

        public CptCuringPlmtechMainManager()
        {
            this.service = new CptCuringPlmtechMainService();
            base.BaseService = this.service;
        }

        public CptCuringPlmtechMainManager(string language)
        {
            this.service = new CptCuringPlmtechMainService(language);
            base.BaseService = this.service;
        }
        
        #endregion
    }
}
