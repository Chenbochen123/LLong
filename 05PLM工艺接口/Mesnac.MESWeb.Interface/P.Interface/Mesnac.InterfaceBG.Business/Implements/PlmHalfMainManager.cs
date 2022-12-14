﻿using System;
using System.Collections.Generic;
using System.Text;
using Mesnac.DbAccess;

namespace Mesnac.InterfaceBG.Business.Implements
{
    using Mesnac.InterfaceBG.Entity.BasicEntity;
    using Mesnac.InterfaceBG.Data.Interface;
    using Mesnac.InterfaceBG.Data.Implements;
    using Mesnac.InterfaceBG.Business.Interface;
    public class PlmHalfMainManager : BaseManager<PlmHalfMain>, IPlmHalfMainManager
    {
		#region 属性注入与构造方法
		
        private IPlmHalfMainService service;

        public PlmHalfMainManager()
        {
            this.service = new PlmHalfMainService();
            base.BaseService = this.service;
        }

        public PlmHalfMainManager(string language)
        {
            this.service = new PlmHalfMainService(language);
            base.BaseService = this.service;
        }
        
        #endregion
    }
}
