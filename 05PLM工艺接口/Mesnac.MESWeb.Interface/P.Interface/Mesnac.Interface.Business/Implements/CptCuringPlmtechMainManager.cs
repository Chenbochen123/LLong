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
