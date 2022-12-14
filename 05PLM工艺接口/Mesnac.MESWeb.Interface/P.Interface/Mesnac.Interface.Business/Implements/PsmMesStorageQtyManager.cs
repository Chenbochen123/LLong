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
    public class PsmMesStorageQtyManager : BaseManager<PsmMesStorageQty>, IPsmMesStorageQtyManager
    {
		#region 属性注入与构造方法
		
        private IPsmMesStorageQtyService service;

        public PsmMesStorageQtyManager()
        {
            this.service = new PsmMesStorageQtyService();
            base.BaseService = this.service;
        }

        public PsmMesStorageQtyManager(string language)
        {
            this.service = new PsmMesStorageQtyService(language);
            base.BaseService = this.service;
        }
        
        #endregion
    }
}
