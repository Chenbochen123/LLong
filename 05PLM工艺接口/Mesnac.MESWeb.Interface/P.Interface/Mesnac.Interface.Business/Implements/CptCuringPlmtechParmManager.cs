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
