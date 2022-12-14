/************************************************************************************
 *      All contents © copyright MESNAC. All rights reserved
 *      File:
 *				SbmBom.cs
 *      Description:
 *		
 *      Author:
 *				曲世峰
 *				QUSF@MESNAC.COM
 *				HTTP://WWWW.MESNAC.COM
 *      Finish DateTime:
 *				2018年05月17日
 *      History:
 ***********************************************************************************/
using System;
using System.Collections.Generic;
using System.Text;

namespace Mesnac.Interface.Entity.BasicEntity
{
    /// <summary>
    /// SBM_BOM-实体类
    /// </summary>
    [Serializable]
    public partial class SbmBom
    {
        #region 公有属性
        /// <summary>
        /// OBJID
        /// </summary>
        public int? ObjId { get; set; }
        /// <summary>
        /// 最后修改日期
        /// </summary>
        public DateTime? LastmodifyDate { get; set; }
        /// <summary>
        /// 物料号
        /// </summary>
        public int? MaterialId { get; set; }
        /// <summary>
        /// 单位
        /// </summary>
        public int? UnitId { get; set; }
        /// <summary>
        /// 组成数量
        /// </summary>
        public double? GroupNum { get; set; }
        /// <summary>
        /// 胎胚版本号
        /// </summary>
        public string GreentyreVersion { get; set; }
        /// <summary>
        /// 产品所属阶段
        /// </summary>
        public string BomType { get; set; }
        /// <summary>
        /// BOM所属分厂
        /// </summary>
        public string BomFactroy { get; set; }
        /// <summary>
        /// BOM版本
        /// </summary>
        public string BomVersion { get; set; }
        /// <summary>
        /// 计划生效时间
        /// </summary>
        public DateTime? EffectDate { get; set; }
        /// <summary>
        /// 计划失效时间
        /// </summary>
        public DateTime? LoseEffectDate { get; set; }
        /// <summary>
        /// PDM编码
        /// </summary>
        public string PdmCode { get; set; }
        /// <summary>
        /// 废弃标示
        /// </summary>
        public string DropFlag { get; set; }
        /// <summary>
        /// 所属胎胚标识
        /// </summary>
        public int? GreentyreMaterialId { get; set; }
        /// <summary>
        /// 父项物料编码
        /// </summary>
        public int? MaterialParentId { get; set; }
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
        /// 组成单数量用量
        /// </summary>
        public decimal? GroupUnitNum { get; set; }
        /// <summary>
        /// 空 为历史版本 1 为plm版本
        /// </summary>
        public int? Historyedition { get; set; }
        /// <summary>
        /// 超期日期
        /// </summary>
        public string ExpiredDate { get; set; }
        #endregion	
    }
}
