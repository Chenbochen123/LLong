/************************************************************************************
 *      All contents © copyright MESNAC. All rights reserved
 *      File:
 *				ItfSapProductionRecords.cs
 *      Description:
 *		
 *      Author:
 *				孙本强
 *				SunBQ@MESNAC.COM
 *				HTTP://WWWW.MESNAC.COM
 *      Finish DateTime:
 *				2015年12月18日
 *      History:
 ***********************************************************************************/
using System;
using System.Collections.Generic;
using System.Text;

namespace Mesnac.Interface.Entity.BasicEntity
{
    /// <summary>
    /// ITF_SAP_PRODUCTION_RECORDS-实体类
    /// </summary>
    [Serializable]
    public partial class ItfSapProductionRecords
    {
        #region 公有属性
        /// <summary>
        /// ID
        /// </summary>
        public long? ObjId { get; set; }
        /// <summary>
        /// 序号
        /// </summary>
        public string Serid { get; set; }
        /// <summary>
        /// 报产方式（01报产,02冲产）
        /// </summary>
        public string Producttype { get; set; }
        /// <summary>
        /// 工厂号
        /// </summary>
        public string Plant { get; set; }
        /// <summary>
        /// SAP物料号
        /// </summary>
        public string Materialcode { get; set; }
        /// <summary>
        /// BOM版本号
        /// </summary>
        public string Proversion { get; set; }
        /// <summary>
        /// 合格数量
        /// </summary>
        public string Qty { get; set; }
        /// <summary>
        /// 废品数量
        /// </summary>
        public string Rejectqty { get; set; }
        /// <summary>
        /// 废品物料编码
        /// </summary>
        public string Rejectmatcode { get; set; }
        /// <summary>
        /// 过账日期
        /// </summary>
        public string Postdate { get; set; }
        /// <summary>
        /// 凭证日期
        /// </summary>
        public string Docdate { get; set; }
        /// <summary>
        /// 下线库位（胎胚D250,成品胎D290）
        /// </summary>
        public string Storageloc { get; set; }
        /// <summary>
        /// 下线批次
        /// </summary>
        public string Batch { get; set; }
        /// <summary>
        /// 抬头凭证文本
        /// </summary>
        public string Headtxt { get; set; }
        /// <summary>
        /// 信息段备用字段1
        /// </summary>
        public string Dummy1 { get; set; }
        /// <summary>
        /// 信息段备用字段2
        /// </summary>
        public string Dummy2 { get; set; }
        /// <summary>
        /// 信息段备用字段3
        /// </summary>
        public string Dummy3 { get; set; }
        /// <summary>
        /// 信息段备用字段4
        /// </summary>
        public string Dummy4 { get; set; }
        /// <summary>
        /// 明细ID
        /// </summary>
        public long? MproductionDetailId { get; set; }
        /// <summary>
        /// 生产日期
        /// </summary>
        public DateTime? ShiftDate { get; set; }
        /// <summary>
        /// 班次
        /// </summary>
        public long? ShiftId { get; set; }
        /// <summary>
        /// 记录人
        /// </summary>
        public long? RecordUserId { get; set; }
        /// <summary>
        /// RECORD_TIME
        /// </summary>
        public DateTime? RecordTime { get; set; }
        /// <summary>
        /// 信息头ID
        /// </summary>
        public long? HeadId { get; set; }
        #endregion	
    }
}
