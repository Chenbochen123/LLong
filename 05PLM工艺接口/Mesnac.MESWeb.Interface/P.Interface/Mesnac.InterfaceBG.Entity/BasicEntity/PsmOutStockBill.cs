/************************************************************************************
 *      All contents © copyright MESNAC. All rights reserved
 *      File:
 *				PsmOutStockBill.cs
 *      Description:
 *		
 *      Author:
 *				董博
 *				
 *				
 *      Finish DateTime:
 *				2018年11月21日
 *      History:
 ***********************************************************************************/
using System;
using System.Collections.Generic;
using System.Text;

namespace Mesnac.InterfaceBG.Entity.BasicEntity
{
    /// <summary>
    /// 成品库车间-库存模块-出库单 非自增-实体类
    /// </summary>
    [Serializable]
    public partial class PsmOutStockBill
    {
        #region 公有属性
        /// <summary>
        /// ObjId
        /// </summary>
        public int? ObjId { get; set; }
        /// <summary>
        /// 记录人
        /// </summary>
        public int? RecordUserId { get; set; }
        /// <summary>
        /// 记录时间
        /// </summary>
        public DateTime? RecordTime { get; set; }
        /// <summary>
        /// 备份标志
        /// </summary>
        public int? BackupFlag { get; set; }
        /// <summary>
        /// 备份时间
        /// </summary>
        public DateTime? BackupTime { get; set; }
        /// <summary>
        /// 删除标志
        /// </summary>
        public int? DeleteFlag { get; set; }
        /// <summary>
        /// 工厂ID
        /// </summary>
        public int? FactoryId { get; set; }
        /// <summary>
        /// 排序列
        /// </summary>
        public int? SeqIndex { get; set; }
        /// <summary>
        /// 备注
        /// </summary>
        public string Remark { get; set; }
        /// <summary>
        /// 发货单号
        /// </summary>
        public string SNNo { get; set; }
        /// <summary>
        /// 退货标识 'X':退货 ,' '非退货
        /// </summary>
        public string SRFlag { get; set; }
        /// <summary>
        /// 凭证日期 （格式：YYYYmmdd）
        /// </summary>
        public string DocDate { get; set; }
        /// <summary>
        /// 客户编码 （售达方）
        /// </summary>
        public string CustomerId { get; set; }
        /// <summary>
        /// 预留字段1
        /// </summary>
        public string Dummy1 { get; set; }
        /// <summary>
        /// 预留字段2
        /// </summary>
        public string Dummy2 { get; set; }
        /// <summary>
        /// 预留字段3
        /// </summary>
        public string Dummy3 { get; set; }
        /// <summary>
        /// 预留字段4
        /// </summary>
        public string Dummy4 { get; set; }
        /// <summary>
        /// 单据编号
        /// </summary>
        public string BillCode { get; set; }
        /// <summary>
        /// 出库日期
        /// </summary>
        public DateTime? OutDate { get; set; }
        /// <summary>
        /// 更新时间
        /// </summary>
        public DateTime? UpdateTime { get; set; }
        /// <summary>
        /// 更新操作人
        /// </summary>
        public int? UpdateUserId { get; set; }
        /// <summary>
        /// 确认时间
        /// </summary>
        public DateTime? AffirmTime { get; set; }
        /// <summary>
        /// 确认操作人
        /// </summary>
        public int? AffirmUserId { get; set; }
        /// <summary>
        /// 单据状态 0:新建 1:已确认
        /// </summary>
        public int? BillState { get; set; }
        /// <summary>
        /// 接口更新时间
        /// </summary>
        public DateTime? InterfaceUpdateTime { get; set; }
        /// <summary>
        /// 客户Id
        /// </summary>
        public int? CustomerObjid { get; set; }
        #endregion	
    }
}
