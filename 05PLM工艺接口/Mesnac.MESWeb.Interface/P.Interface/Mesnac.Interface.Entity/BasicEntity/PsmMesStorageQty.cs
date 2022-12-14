/************************************************************************************
 *      All contents © copyright MESNAC. All rights reserved
 *      File:
 *				PsmMesStorageQty.cs
 *      Description:
 *		
 *      Author:
 *				孙本强
 *				SunBQ@MESNAC.COM
 *				HTTP://WWWW.MESNAC.COM
 *      Finish DateTime:
 *				2015年12月28日
 *      History:
 ***********************************************************************************/
using System;
using System.Collections.Generic;
using System.Text;

namespace Mesnac.Interface.Entity.BasicEntity
{
    /// <summary>
    /// PSM_MES_STORAGE_QTY-实体类
    /// </summary>
    [Serializable]
    public partial class PsmMesStorageQty
    {
        #region 公有属性
        /// <summary>
        /// OBJID
        /// </summary>
        public int? ObjId { get; set; }
        /// <summary>
        /// SHIFT_DATE
        /// </summary>
        public DateTime? ShiftDate { get; set; }
        /// <summary>
        /// SHIFT_ID
        /// </summary>
        public int? ShiftId { get; set; }
        /// <summary>
        /// MATERIAL_ID
        /// </summary>
        public int? MaterialId { get; set; }
        /// <summary>
        /// MES_QTY
        /// </summary>
        public int? MesQty { get; set; }
        /// <summary>
        /// QTY
        /// </summary>
        public int? Qty { get; set; }
        /// <summary>
        /// DOC_DATE
        /// </summary>
        public string DocDate { get; set; }
        /// <summary>
        /// POST_DATE
        /// </summary>
        public string PostDate { get; set; }
        /// <summary>
        /// HEAD_TXT
        /// </summary>
        public string HeadTxt { get; set; }
        /// <summary>
        /// PLANT_FROM
        /// </summary>
        public string PlantFrom { get; set; }
        /// <summary>
        /// STORAGELOC
        /// </summary>
        public string Storageloc { get; set; }
        /// <summary>
        /// BATCH
        /// </summary>
        public string Batch { get; set; }
        /// <summary>
        /// REC_PLANT
        /// </summary>
        public string RecPlant { get; set; }
        /// <summary>
        /// REC_STOLOC
        /// </summary>
        public string RecStoloc { get; set; }
        /// <summary>
        /// REC_BATCH
        /// </summary>
        public string RecBatch { get; set; }
        /// <summary>
        /// RECIEVER
        /// </summary>
        public string Reciever { get; set; }
        /// <summary>
        /// STATE_FLAG
        /// </summary>
        public int? StateFlag { get; set; }
        /// <summary>
        /// RECORD_TIME
        /// </summary>
        public DateTime? RecordTime { get; set; }
        /// <summary>
        /// RECORD_USER_ID
        /// </summary>
        public int? RecordUserId { get; set; }
        /// <summary>
        /// DELETE_FLAG
        /// </summary>
        public int? DeleteFlag { get; set; }
        /// <summary>
        /// REMARK
        /// </summary>
        public string Remark { get; set; }
        /// <summary>
        /// SUCCESS_FLAG
        /// </summary>
        public int? SuccessFlag { get; set; }
        /// <summary>
        /// RETURN_MSG
        /// </summary>
        public string ReturnMsg { get; set; }
        /// <summary>
        /// MOV_TYPE
        /// </summary>
        public string MovType { get; set; }
        #endregion	
    }
}
