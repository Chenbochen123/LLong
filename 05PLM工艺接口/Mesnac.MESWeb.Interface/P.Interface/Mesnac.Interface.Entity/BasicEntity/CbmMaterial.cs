/************************************************************************************
 *      All contents © copyright MESNAC. All rights reserved
 *      File:
 *				CbmMaterial.cs
 *      Description:
 *		
 *      Author:
 *				董博
 *				
 *				
 *      Finish DateTime:
 *				2018年12月05日
 *      History:
 ***********************************************************************************/
using System;
using System.Collections.Generic;
using System.Text;

namespace Mesnac.Interface.Entity.BasicEntity
{
    /// <summary>
    /// 硫化车间-基础模块-成品胎物料信息-实体类
    /// </summary>
    [Serializable]
    public partial class CbmMaterial
    {
        #region 公有属性
        /// <summary>
        /// 物料编码
        /// </summary>
        public int? MaterialId { get; set; }
        /// <summary>
        /// 品牌编码
        /// </summary>
        public int? BrandId { get; set; }
        /// <summary>
        /// 规格编码
        /// </summary>
        public int? SizeId { get; set; }
        /// <summary>
        /// 层级编码
        /// </summary>
        public int? PlyratingId { get; set; }
        /// <summary>
        /// 花纹编码
        /// </summary>
        public int? PatternId { get; set; }
        /// <summary>
        /// 负荷指数编码
        /// </summary>
        public int? LoadIndexId { get; set; }
        /// <summary>
        /// 速度级别编码
        /// </summary>
        public int? SpeedLevelId { get; set; }
        /// <summary>
        /// 标准编码
        /// </summary>
        public int? StandardId { get; set; }
        /// <summary>
        /// 属性编码
        /// </summary>
        public int? AttributeId { get; set; }
        /// <summary>
        /// 最大库存
        /// </summary>
        public int? MaxStockAmount { get; set; }
        /// <summary>
        /// 最小库存
        /// </summary>
        public int? MinStockAmount { get; set; }
        /// <summary>
        /// 标准库存
        /// </summary>
        public int? StandardStockAmount { get; set; }
        /// <summary>
        /// 最大时间
        /// </summary>
        public decimal? MaxStockTime { get; set; }
        /// <summary>
        /// 最小时间
        /// </summary>
        public decimal? MinStockTime { get; set; }
        /// <summary>
        /// 标准重量
        /// </summary>
        public decimal? StandardWeight { get; set; }
        /// <summary>
        /// 重量偏差
        /// </summary>
        public decimal? WeightTolerance { get; set; }
        /// <summary>
        /// 拼音编码
        /// </summary>
        public string SpellCode { get; set; }
        /// <summary>
        /// 使用标志
        /// </summary>
        public int? UsedFlag { get; set; }
        /// <summary>
        /// 声音文件
        /// </summary>
        public string VoiceFilePath { get; set; }
        #endregion	
    }
}
