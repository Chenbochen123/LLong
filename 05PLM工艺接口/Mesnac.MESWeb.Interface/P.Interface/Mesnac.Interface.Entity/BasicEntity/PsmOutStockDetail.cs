/************************************************************************************
 *      All contents © copyright MESNAC. All rights reserved
 *      File:
 *				PsmOutStockDetail.cs
 *      Description:
 *		
 *      Author:
 *				孙本强
 *				SunBQ@MESNAC.COM
 *				HTTP://WWWW.MESNAC.COM
 *      Finish DateTime:
 *				2017年04月27日
 *      History:
 ***********************************************************************************/
using System;
using System.Collections.Generic;
using System.Text;

namespace Mesnac.Interface.Entity.BasicEntity
{
    /// <summary>
    /// 成品库车间-库存模块-出库明细 非自增-实体类
    /// </summary>
    [Serializable]
    public partial class PsmOutStockDetail
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
        /// 单据Id
        /// </summary>
        public int? BillId { get; set; }
        /// <summary>
        /// 主数据Id
        /// </summary>
        public int? MainId { get; set; }
        /// <summary>
        /// 汇总Id
        /// </summary>
        public int? SummaryId { get; set; }
        /// <summary>
        /// 成型条码
        /// </summary>
        public string GreenTyreNo { get; set; }
        /// <summary>
        /// 硫化条码
        /// </summary>
        public string TyreNo { get; set; }
        /// <summary>
        /// 品级编号
        /// </summary>
        public int? CheckGradeCode { get; set; }
        /// <summary>
        /// 更新时间
        /// </summary>
        public DateTime? UpdateTime { get; set; }
        /// <summary>
        /// 更新操作人
        /// </summary>
        public int? UpdateUserId { get; set; }
        /// <summary>
        /// 明细状态
        /// </summary>
        public int? DetailState { get; set; }
        /// <summary>
        /// 明细批次
        /// </summary>
        public string DetailBatch { get; set; }
        #endregion	
    }
}
