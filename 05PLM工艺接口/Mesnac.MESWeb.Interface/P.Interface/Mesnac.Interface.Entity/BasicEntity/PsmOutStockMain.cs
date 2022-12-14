/************************************************************************************
 *      All contents © copyright MESNAC. All rights reserved
 *      File:
 *				PsmOutStockMain.cs
 *      Description:
 *		
 *      Author:
 *				孙本强
 *				SunBQ@MESNAC.COM
 *				HTTP://WWWW.MESNAC.COM
 *      Finish DateTime:
 *				2015年08月28日
 *      History:
 ***********************************************************************************/
using System;
using System.Collections.Generic;
using System.Text;

namespace Mesnac.Interface.Entity.BasicEntity
{
    /// <summary>
    /// 成品库车间-库存模块-出库主数据 非自增-实体类
    /// </summary>
    [Serializable]
    public partial class PsmOutStockMain
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
        /// 行项目编号
        /// </summary>
        public string LineItemNo { get; set; }
        /// <summary>
        /// 物料号（9位）
        /// </summary>
        public string MaterialCode { get; set; }
        /// <summary>
        /// 工厂
        /// </summary>
        public string Plant { get; set; }
        /// <summary>
        /// 库位
        /// </summary>
        public string StorageLoc { get; set; }
        /// <summary>
        /// 发货数量
        /// </summary>
        public string Qty { get; set; }
        /// <summary>
        /// 质量等级（批次） 代表质量等级
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
        /// 接口更新时间
        /// </summary>
        public DateTime? InterfaceUpdateTime { get; set; }
        /// <summary>
        /// 出库单Id
        /// </summary>
        public int? BillId { get; set; }
        /// <summary>
        /// 物料Id
        /// </summary>
        public int? MaterialId { get; set; }
        /// <summary>
        /// 仓库Id
        /// </summary>
        public int? StoreId { get; set; }
        /// <summary>
        /// 品级编号
        /// </summary>
        public int? CheckGradeCode { get; set; }
        /// <summary>
        /// 计划数量
        /// </summary>
        public int? PlanAmount { get; set; }
        /// <summary>
        /// 出库数量
        /// </summary>
        public int? OutAmount { get; set; }
        /// <summary>
        /// 主数据状态
        /// </summary>
        public int? MainState { get; set; }
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
        #endregion	
    }
}
