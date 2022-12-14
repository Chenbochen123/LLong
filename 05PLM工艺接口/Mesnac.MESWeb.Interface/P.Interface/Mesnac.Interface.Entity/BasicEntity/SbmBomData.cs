/************************************************************************************
 *      All contents © copyright MESNAC. All rights reserved
 *      File:
 *				SbmBomData.cs
 *      Description:
 *		
 *      Author:
 *				曲世峰
 *				QUSF@MESNAC.COM
 *				HTTP://WWWW.MESNAC.COM
 *      Finish DateTime:
 *				2021年08月11日
 *      History:
 ***********************************************************************************/
using System;
using System.Collections.Generic;
using System.Text;

namespace Mesnac.Interface.Entity.BasicEntity
{
    /// <summary>
    /// 全厂-基础模块-物料BOM-实体类
    /// </summary>
    [Serializable]
    public partial class SbmBomData
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
        public int? GroupNum { get; set; }
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
        /// PDM编码//PLM 更新为父项规格代码
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
        /// 物料类型
        /// </summary>
        public string MaterialTypeName { get; set; }
        /// <summary>
        /// EXPIRED_DATE
        /// </summary>
        public string ExpiredDate { get; set; }
        /// <summary>
        /// 子物料版本号
        /// </summary>
        public string SubItemRevision { get; set; }
        /// <summary>
        /// 描述
        /// </summary>
        public string Spec { get; set; }
        /// <summary>
        /// 供应商代码
        /// </summary>
        public string RecipeType { get; set; }
        /// <summary>
        /// 终练胶类型
        /// </summary>
        public string SupplyCode { get; set; }
        /// <summary>
        /// PROCESS_TYPE
        /// </summary>
        public string ProcessType { get; set; }
        /// <summary>
        /// PCR（半钢）\TBR （全钢）
        /// </summary>
        public string MaterialType { get; set; }
        /// <summary>
        /// 0 历史版本 1 plm版本
        /// </summary>
        public int? Historyedition { get; set; }
        /// <summary>
        /// 用途
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
        #endregion	
    }
}
