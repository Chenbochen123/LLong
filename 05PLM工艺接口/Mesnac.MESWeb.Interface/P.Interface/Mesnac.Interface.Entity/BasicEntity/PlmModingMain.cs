/************************************************************************************
 *      All contents © copyright MESNAC. All rights reserved
 *      File:
 *				PlmModingMain.cs
 *      Description:
 *		
 *      Author:
 *				曲世峰
 *				QUSF@MESNAC.COM
 *				HTTP://WWWW.MESNAC.COM
 *      Finish DateTime:
 *				2018年03月27日
 *      History:
 ***********************************************************************************/
using System;
using System.Collections.Generic;
using System.Text;

namespace Mesnac.Interface.Entity.BasicEntity
{
    /// <summary>
    /// PLM_MODING_MAIN-实体类
    /// </summary>
    [Serializable]
    public partial class PlmModingMain
    {
        #region 公有属性
        /// <summary>
        /// OBJID
        /// </summary>
        public long? ObjId { get; set; }
        /// <summary>
        /// CREATE_USER
        /// </summary>
        public string CreateUser { get; set; }
        /// <summary>
        /// MODIFIER
        /// </summary>
        public string Modifier { get; set; }
        /// <summary>
        /// CREATE_DATE
        /// </summary>
        public DateTime? CreateDate { get; set; }
        /// <summary>
        /// EXPIRED_DATE
        /// </summary>
        public DateTime? ExpiredDate { get; set; }
        /// <summary>
        /// EQUIPMENT_CODE
        /// </summary>
        public string EquipmentCode { get; set; }
        /// <summary>
        /// EQUIPMENTTYPECODE
        /// </summary>
        public string Equipmenttypecode { get; set; }
        /// <summary>
        /// PDMMAT
        /// </summary>
        public string Pdmmat { get; set; }
        /// <summary>
        /// VERSION
        /// </summary>
        public string Version { get; set; }
        /// <summary>
        /// SAPMAT
        /// </summary>
        public string Sapmat { get; set; }
        /// <summary>
        /// STAGE
        /// </summary>
        public string Stage { get; set; }
        /// <summary>
        /// PROCESS_ROUTE
        /// </summary>
        public string ProcessRoute { get; set; }
        /// <summary>
        /// PROCESS_VERSION
        /// </summary>
        public string ProcessVersion { get; set; }
        /// <summary>
        /// FACTORY
        /// </summary>
        public string Factory { get; set; }
        /// <summary>
        /// PARMCODE
        /// </summary>
        public string Parmcode { get; set; }
        /// <summary>
        /// PARMNAME
        /// </summary>
        public string Parmname { get; set; }
        /// <summary>
        /// PARMNAME_EN
        /// </summary>
        public string ParmnameEn { get; set; }
        /// <summary>
        /// PARMTYPE_CODE
        /// </summary>
        public string ParmtypeCode { get; set; }
        /// <summary>
        /// PARMTYPE_NAME
        /// </summary>
        public string ParmtypeName { get; set; }
        /// <summary>
        /// VALUE
        /// </summary>
        public string Value { get; set; }
        /// <summary>
        /// VALUEMAX
        /// </summary>
        public string Valuemax { get; set; }
        /// <summary>
        /// VALUEMIN
        /// </summary>
        public string Valuemin { get; set; }
        /// <summary>
        /// VALUEMAX_SIGN
        /// </summary>
        public string ValuemaxSign { get; set; }
        /// <summary>
        /// VALUEMIN_SIGN
        /// </summary>
        public string ValueminSign { get; set; }
        /// <summary>
        /// DELETE_FLAG
        /// </summary>
        public long? DeleteFlag { get; set; }
        /// <summary>
        /// RECORDDATE
        /// </summary>
        public DateTime? Recorddate { get; set; }
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
        /// DUMMY6
        /// </summary>
        public string Dummy6 { get; set; }
        /// <summary>
        /// DUMMY7
        /// </summary>
        public string Dummy7 { get; set; }
        /// <summary>
        /// DUMMY8
        /// </summary>
        public string Dummy8 { get; set; }
        /// <summary>
        /// DUMMY9
        /// </summary>
        public string Dummy9 { get; set; }
        /// <summary>
        /// DUMMY10
        /// </summary>
        public string Dummy10 { get; set; }
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
