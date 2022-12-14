/************************************************************************************
 *      All contents © copyright MESNAC. All rights reserved
 *      File:
 *				CptCuringPlmtechParm.cs
 *      Description:
 *		
 *      Author:
 *				孙本强
 *				SunBQ@MESNAC.COM
 *				HTTP://WWWW.MESNAC.COM
 *      Finish DateTime:
 *				2017年12月08日
 *      History:
 ***********************************************************************************/
using System;
using System.Collections.Generic;
using System.Text;

namespace Mesnac.InterfaceBG.Entity.BasicEntity
{
    /// <summary>
    /// CPT_CURING_PLMTECH_PARM-实体类
    /// </summary>
    [Serializable]
    public partial class CptCuringPlmtechParm
    {
        #region 公有属性
        /// <summary>
        /// OBJID
        /// </summary>
        public int? ObjId { get; set; }
        /// <summary>
        /// RECORD_TIME
        /// </summary>
        public DateTime? RecordTime { get; set; }
        /// <summary>
        /// SAPMAT
        /// </summary>
        public string Sapmat { get; set; }
        /// <summary>
        /// MATNAME
        /// </summary>
        public string Matname { get; set; }
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
        /// PARM_CODE
        /// </summary>
        public string ParmCode { get; set; }
        /// <summary>
        /// PARM_NAME
        /// </summary>
        public string ParmName { get; set; }
        /// <summary>
        /// PARM_NAME_EN
        /// </summary>
        public string ParmNameEn { get; set; }
        /// <summary>
        /// PARM_TYPE_CODE
        /// </summary>
        public string ParmTypeCode { get; set; }
        /// <summary>
        /// PARM_TYPE_NAME
        /// </summary>
        public string ParmTypeName { get; set; }
        /// <summary>
        /// VALUE
        /// </summary>
        public string Value { get; set; }
        /// <summary>
        /// DELETE_FLAG
        /// </summary>
        public int? DeleteFlag { get; set; }
        /// <summary>
        /// BACKUP_FLAG
        /// </summary>
        public int? BackupFlag { get; set; }
        /// <summary>
        /// BACKUP_TIME
        /// </summary>
        public DateTime? BackupTime { get; set; }
        #endregion	
    }
}
