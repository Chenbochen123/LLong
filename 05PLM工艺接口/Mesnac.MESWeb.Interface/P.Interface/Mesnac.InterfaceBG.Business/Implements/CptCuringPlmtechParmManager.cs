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
    public class CptCuringPlmtechParmManager : BaseManager<CptCuringPlmtechParm>, ICptCuringPlmtechParmManager
    {
		#region 属性注入与构造方法
		
        private ICptCuringPlmtechParmService service;

        public CptCuringPlmtechParmManager()
        {
            this.service = new CptCuringPlmtechParmService();
            base.BaseService = this.service;
        }

        public CptCuringPlmtechParmManager(string language)
        {
            this.service = new CptCuringPlmtechParmService(language);
            base.BaseService = this.service;
        }
        
        #endregion
    }
}
