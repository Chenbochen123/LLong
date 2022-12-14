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
    public class CptCuringMasManager : BaseManager<CptCuringMas>, ICptCuringMasManager
    {
		#region 属性注入与构造方法
		
        private ICptCuringMasService service;

        public CptCuringMasManager()
        {
            this.service = new CptCuringMasService();
            base.BaseService = this.service;
        }

        public CptCuringMasManager(string language)
        {
            this.service = new CptCuringMasService(language);
            base.BaseService = this.service;
        }
        
        #endregion
    }
}
