/************************************************************************************
 *      All contents © copyright MESNAC. All rights reserved
 *      File:
 *				PlmDieDrawingMain.cs
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

namespace Mesnac.Interface.Entity.BasicEntity
{
    /// <summary>
    /// PLM_DIE_DRAWING_MAIN-实体类
    /// </summary>
    [Serializable]
    public partial class PlmDieDrawingMain
    {
        #region 公有属性
        /// <summary>
        /// OBJID
        /// </summary>
        public long? ObjId { get; set; }
        /// <summary>
        /// COVERSAP
        /// </summary>
        public string Coversap { get; set; }
        /// <summary>
        /// FILENAME
        /// </summary>
        public string Filename { get; set; }
        /// <summary>
        /// file
        /// </summary>
        public string File { get; set; }
        /// <summary>
        /// RECORD_TIME
        /// </summary>
        public DateTime? RecordTime { get; set; }
        /// <summary>
        /// DELETE_FLAG
        /// </summary>
        public long? DeleteFlag { get; set; }
        /// <summary>
        /// BACKUP_FLAG
        /// </summary>
        public long? BackupFlag { get; set; }
        /// <summary>
        /// BACKUP_TIME
        /// </summary>
        public DateTime? BackupTime { get; set; }
        /// <summary>
        /// OBJECTCODE
        /// </summary>
        public string Objectcode { get; set; }
        #endregion	
    }
}
