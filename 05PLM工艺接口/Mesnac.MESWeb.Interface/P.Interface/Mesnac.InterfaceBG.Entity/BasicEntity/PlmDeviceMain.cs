/************************************************************************************
 *      All contents © copyright MESNAC. All rights reserved
 *      File:
 *				PlmDeviceMain.cs
 *      Description:
 *		
 *      Author:
 *				曲世峰
 *				QUSF@MESNAC.COM
 *				HTTP://WWWW.MESNAC.COM
 *      Finish DateTime:
 *				2018年01月30日
 *      History:
 ***********************************************************************************/
using System;
using System.Collections.Generic;
using System.Text;

namespace Mesnac.InterfaceBG.Entity.BasicEntity
{
    /// <summary>
    /// PLM_DEVICE_MAIN-实体类
    /// </summary>
    [Serializable]
    public partial class PlmDeviceMain
    {
        #region 公有属性
        /// <summary>
        /// OBJID
        /// </summary>
        public long? ObjId { get; set; }
        /// <summary>
        /// EQUIPMENTCODE
        /// </summary>
        public string Equipmentcode { get; set; }
        /// <summary>
        /// EQUIPMENTNAME
        /// </summary>
        public string Equipmentname { get; set; }
        /// <summary>
        /// EQUIPMENTTYPECODE
        /// </summary>
        public string Equipmenttypecode { get; set; }
        /// <summary>
        /// EQUIPMENTTYPENAME
        /// </summary>
        public string Equipmenttypename { get; set; }
        /// <summary>
        /// DELETE_FLAG
        /// </summary>
        public long? DeleteFlag { get; set; }
        /// <summary>
        /// RECORDDATE
        /// </summary>
        public DateTime? Recorddate { get; set; }
        /// <summary>
        /// FACTORY
        /// </summary>
        public string Factory { get; set; }
        /// <summary>
        /// DUMMY1
        /// </summary>
        public string Dummy1 { get; set; }
        /// <summary>
        /// DUMMY2
        /// </summary>
        public string Dummy2 { get; set; }
        /// <summary>
        /// DUMMY3
        /// </summary>
        public string Dummy3 { get; set; }
        /// <summary>
        /// DUMMY4
        /// </summary>
        public string Dummy4 { get; set; }
        /// <summary>
        /// DUMMY5
        /// </summary>
        public string Dummy5 { get; set; }
        /// <summary>
        /// BACKOP_FLAG
        /// </summary>
        public string BackopFlag { get; set; }
        /// <summary>
        /// BACKOP_TIME
        /// </summary>
        public DateTime? BackopTime { get; set; }
        #endregion	
    }
}
