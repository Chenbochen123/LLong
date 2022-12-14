﻿using System;
using System.Collections.Generic;
using System.Text;
using Mesnac.DbAccess;

namespace Mesnac.Interface.Business.Implements
{
    using Mesnac.Interface.Entity.BasicEntity;
    using Mesnac.Interface.Data.Interface;
    using Mesnac.Interface.Data.Implements;
    using Mesnac.Interface.Business.Interface;
    public class PsmTransferMainManager : BaseManager<PsmTransferMain>, IPsmTransferMainManager
    {
		#region 属性注入与构造方法
		
        private IPsmTransferMainService service;

        public PsmTransferMainManager()
        {
            this.service = new PsmTransferMainService();
            base.BaseService = this.service;
        }

        public PsmTransferMainManager(string language)
        {
            this.service = new PsmTransferMainService(language);
            base.BaseService = this.service;
        }
        
        #endregion
    }
}
