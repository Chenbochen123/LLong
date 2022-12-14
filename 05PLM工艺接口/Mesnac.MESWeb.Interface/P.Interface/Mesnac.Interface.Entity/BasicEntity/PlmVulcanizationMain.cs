/************************************************************************************
 *      All contents © copyright MESNAC. All rights reserved
 *      File:
 *				PlmVulcanizationMain.cs
 *      Description:
 *		
 *      Author:
 *				曲世峰
 *				QUSF@MESNAC.COM
 *				HTTP://WWWW.MESNAC.COM
 *      Finish DateTime:
 *				2018年04月17日
 *      History:
 ***********************************************************************************/
using System;
using System.Collections.Generic;
using System.Text;

namespace Mesnac.Interface.Entity.BasicEntity
{
    /// <summary>
    /// PLM_VULCANIZATION_MAIN-实体类
    /// </summary>
    [Serializable]
    public partial class PlmVulcanizationMain
    {
        #region 公有属性
        /// <summary>
        /// OBJID
        /// </summary>
        public long? ObjId { get; set; }
        /// <summary>
        /// SAPMAT
        /// </summary>
        public string Sapmat { get; set; }
        /// <summary>
        /// MATNAME
        /// </summary>
        public string Matname { get; set; }
        /// <summary>
        /// PARMTYPECODE
        /// </summary>
        public string Parmtypecode { get; set; }
        /// <summary>
        /// PARMTYPENAME
        /// </summary>
        public string Parmtypename { get; set; }
        /// <summary>
        /// PARMCODE
        /// </summary>
        public string Parmcode { get; set; }
        /// <summary>
        /// PARMNAME
        /// </summary>
        public string Parmname { get; set; }
        /// <summary>
        /// FACTORY
        /// </summary>
        public string Factory { get; set; }
        /// <summary>
        /// VALUE
        /// </summary>
        public string Value { get; set; }
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
        /// DELETE_FLAG
        /// </summary>
        public long? DeleteFlag { get; set; }
        /// <summary>
        /// BACKUP_FLAG
        /// </summary>
        public string BackupFlag { get; set; }
        /// <summary>
        /// BACKUP_TIME
        /// </summary>
        public DateTime? BackupTime { get; set; }
        /// <summary>
        /// RECORD_TIME
        /// </summary>
        public DateTime? RecordTime { get; set; }
        /// <summary>
        /// OBJECTCODE
        /// </summary>
        public string Objectcode { get; set; }
        #endregion	
    }
}
