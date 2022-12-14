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
