/************************************************************************************
 *      All contents © copyright MESNAC. All rights reserved
 *      File:
 *				PsmTransferBill.cs
 *      Description:
 *		
 *      Author:
 *				孙本强
 *				SunBQ@MESNAC.COM
 *				HTTP://WWWW.MESNAC.COM
 *      Finish DateTime:
 *				2015年09月11日
 *      History:
 ***********************************************************************************/
using System;
using System.Collections.Generic;
using System.Text;

namespace Mesnac.Interface.Entity.BasicEntity
{
    /// <summary>
    /// 成品库车间-库存模块-调拨单 非自增-实体类
    /// </summary>
    [Serializable]
    public partial class PsmTransferBill
    {
        #region 公有属性
        /// <summary>
        /// 接口更新时间
        /// </summary>
        public DateTime? InterfaceUpdateTime { get; set; }
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
        /// 预留单号
        /// </summary>
        public string ReserNo { get; set; }
        /// <summary>
        /// 预留单行号
        /// </summary>
        public string ReserItem { get; set; }
        /// <summary>
        /// 移动类型
        /// </summary>
        public string MovType { get; set; }
        /// <summary>
        /// 物料号
        /// </summary>
        public string MatCode { get; set; }
        /// <summary>
        /// 计量单位
        /// </summary>
        public string Unit { get; set; }
        /// <summary>
        /// 需求部门
        /// </summary>
        public string Department { get; set; }
        /// <summary>
        /// 转入数量
        /// </summary>
        public string Qty { get; set; }
        /// <summary>
        /// 发出工厂
        /// </summary>
        public string PlantFrom { get; set; }
        /// <summary>
        /// 发出库存地点
        /// </summary>
        public string StorLocFrom { get; set; }
        /// <summary>
        /// 接收工厂
        /// </summary>
        public string PlantTo { get; set; }
        /// <summary>
        /// 收货库存地点
        /// </summary>
        public string StorLocTo { get; set; }
        /// <summary>
        /// 成本中心
        /// </summary>
        public string CostCenter { get; set; }
        /// <summary>
        /// 订单（财务）
        /// </summary>
        public string Order1 { get; set; }
        /// <summary>
        /// 需求日期
        /// </summary>
        public string DemondsDate { get; set; }
        /// <summary>
        /// 批次号
        /// </summary>
        public string Batch { get; set; }
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
        /// 调拨日期
        /// </summary>
        public DateTime? TransferDate { get; set; }
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
        #endregion	
    }
}
