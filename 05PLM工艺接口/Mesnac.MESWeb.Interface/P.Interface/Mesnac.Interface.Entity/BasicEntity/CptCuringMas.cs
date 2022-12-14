/************************************************************************************
 *      All contents © copyright MESNAC. All rights reserved
 *      File:
 *				CptCuringMas.cs
 *      Description:
 *		
 *      Author:
 *				董博
 *				
 *				
 *      Finish DateTime:
 *				2018年04月20日
 *      History:
 ***********************************************************************************/
using System;
using System.Collections.Generic;
using System.Text;

namespace Mesnac.Interface.Entity.BasicEntity
{
    /// <summary>
    /// CPT_CURING_MAS-实体类
    /// </summary>
    [Serializable]
    public partial class CptCuringMas
    {
        #region 公有属性
        /// <summary>
        /// 编号
        /// </summary>
        public int? ObjId { get; set; }
        /// <summary>
        /// 装胎高度
        /// </summary>
        public int? LoaderHeight { get; set; }
        /// <summary>
        /// 定型高度
        /// </summary>
        public int? ShapingHeight { get; set; }
        /// <summary>
        /// 二次定型压力(0-100次)
        /// </summary>
        public int? SecondShapingPress1 { get; set; }
        /// <summary>
        /// 二次定型压力(100-200次)
        /// </summary>
        public int? SecondShapingPress2 { get; set; }
        /// <summary>
        /// 二次定型压力(200次以上)
        /// </summary>
        public int? SecondShapingPress3 { get; set; }
        /// <summary>
        /// 一次定型压力(0-100次)
        /// </summary>
        public int? FirstShapingPress1 { get; set; }
        /// <summary>
        /// 一次定型压力(100-200次)
        /// </summary>
        public int? FirstShapingPress2 { get; set; }
        /// <summary>
        /// 一次定型压力(200次以上)
        /// </summary>
        public int? FirstShapingPress3 { get; set; }
        /// <summary>
        /// 合模力
        /// </summary>
        public int? ClampingPress { get; set; }
        /// <summary>
        /// 拉伸高度
        /// </summary>
        public int? BladderTensileHeight { get; set; }
        /// <summary>
        /// 上限次数
        /// </summary>
        public int? TopLimitAmount { get; set; }
        /// <summary>
        /// 胶囊型号
        /// </summary>
        public int? BladderSize { get; set; }
        /// <summary>
        /// 胶囊ERP品号
        /// </summary>
        public int? BladderCode { get; set; }
        /// <summary>
        /// 硫化总时间
        /// </summary>
        public int? AllCuringTime { get; set; }
        /// <summary>
        /// 模温低限
        /// </summary>
        public int? ModelTempLow { get; set; }
        /// <summary>
        /// 模温高限
        /// </summary>
        public int? ModelTempHigh { get; set; }
        /// <summary>
        /// 模温设定
        /// </summary>
        public int? ModelTempSet { get; set; }
        /// <summary>
        /// 热环设定
        /// </summary>
        public int? HotRingSet { get; set; }
        /// <summary>
        /// 板温设定
        /// </summary>
        public int? PlateTempSet { get; set; }
        /// <summary>
        /// 板温高限
        /// </summary>
        public int? PlateTempHigh { get; set; }
        /// <summary>
        /// 板温低限
        /// </summary>
        public int? PlateTempLow { get; set; }
        /// <summary>
        /// 步01时间设定
        /// </summary>
        public int? CuringTime01 { get; set; }
        /// <summary>
        /// CURING_TIME_02
        /// </summary>
        public int? CuringTime02 { get; set; }
        /// <summary>
        /// CURING_TIME_03
        /// </summary>
        public int? CuringTime03 { get; set; }
        /// <summary>
        /// CURING_TIME_04
        /// </summary>
        public int? CuringTime04 { get; set; }
        /// <summary>
        /// CURING_TIME_05
        /// </summary>
        public int? CuringTime05 { get; set; }
        /// <summary>
        /// CURING_TIME_06
        /// </summary>
        public int? CuringTime06 { get; set; }
        /// <summary>
        /// CURING_TIME_07
        /// </summary>
        public int? CuringTime07 { get; set; }
        /// <summary>
        /// CURING_TIME_08
        /// </summary>
        public int? CuringTime08 { get; set; }
        /// <summary>
        /// CURING_TIME_09
        /// </summary>
        public int? CuringTime09 { get; set; }
        /// <summary>
        /// CURING_TIME_10
        /// </summary>
        public int? CuringTime10 { get; set; }
        /// <summary>
        /// CURING_TIME_11
        /// </summary>
        public int? CuringTime11 { get; set; }
        /// <summary>
        /// CURING_TIME_12
        /// </summary>
        public int? CuringTime12 { get; set; }
        /// <summary>
        /// CURING_TIME_13
        /// </summary>
        public int? CuringTime13 { get; set; }
        /// <summary>
        /// CURING_TIME_14
        /// </summary>
        public int? CuringTime14 { get; set; }
        /// <summary>
        /// CURING_TIME_15
        /// </summary>
        public int? CuringTime15 { get; set; }
        /// <summary>
        /// CURING_TIME_16
        /// </summary>
        public int? CuringTime16 { get; set; }
        /// <summary>
        /// CURING_TIME_17
        /// </summary>
        public int? CuringTime17 { get; set; }
        /// <summary>
        /// CURING_TIME_18
        /// </summary>
        public int? CuringTime18 { get; set; }
        /// <summary>
        /// CURING_TIME_19
        /// </summary>
        public int? CuringTime19 { get; set; }
        /// <summary>
        /// CURING_TIME_20
        /// </summary>
        public int? CuringTime20 { get; set; }
        /// <summary>
        /// CURING_TIME_21
        /// </summary>
        public int? CuringTime21 { get; set; }
        /// <summary>
        /// CURING_TIME_22
        /// </summary>
        public int? CuringTime22 { get; set; }
        /// <summary>
        /// CURING_TIME_23
        /// </summary>
        public int? CuringTime23 { get; set; }
        /// <summary>
        /// CURING_TIME_24
        /// </summary>
        public int? CuringTime24 { get; set; }
        /// <summary>
        /// CURING_TIME_25
        /// </summary>
        public int? CuringTime25 { get; set; }
        /// <summary>
        /// CURING_TIME_26
        /// </summary>
        public int? CuringTime26 { get; set; }
        /// <summary>
        /// CURING_TIME_27
        /// </summary>
        public int? CuringTime27 { get; set; }
        /// <summary>
        /// CURING_TIME_28
        /// </summary>
        public int? CuringTime28 { get; set; }
        /// <summary>
        /// CURING_TIME_29
        /// </summary>
        public int? CuringTime29 { get; set; }
        /// <summary>
        /// 步30时间设定
        /// </summary>
        public int? CuringTime30 { get; set; }
        /// <summary>
        /// 记录人
        /// </summary>
        public int? RecordUserId { get; set; }
        /// <summary>
        /// 记录时间
        /// </summary>
        public DateTime? RecordTime { get; set; }
        /// <summary>
        /// 删除标志
        /// </summary>
        public int? DeleteFlag { get; set; }
        /// <summary>
        /// 物料
        /// </summary>
        public int? MaterialId { get; set; }
        /// <summary>
        /// 版本
        /// </summary>
        public string PdmVersion { get; set; }
        /// <summary>
        /// 参数类型
        /// </summary>
        public int? ParmType { get; set; }
        /// <summary>
        /// 最后修改人
        /// </summary>
        public int? Lastmodifier { get; set; }
        /// <summary>
        /// 最后修改时间
        /// </summary>
        public DateTime? LastmodifyDate { get; set; }
        /// <summary>
        /// 有效期起
        /// </summary>
        public DateTime? EffectDate { get; set; }
        /// <summary>
        /// 有效期止
        /// </summary>
        public DateTime? LoseEffectDate { get; set; }
        /// <summary>
        /// 工艺阶段   -实验、试制等阶段
        /// </summary>
        public int? TechType { get; set; }
        /// <summary>
        /// 是否为第一条数据
        /// </summary>
        public int? IsNewRow { get; set; }
        /// <summary>
        /// SIZE_MARK_LINE_U1
        /// </summary>
        public int? SizeMarkLineU1 { get; set; }
        /// <summary>
        /// SIZE_MARK_LINE_U2
        /// </summary>
        public int? SizeMarkLineU2 { get; set; }
        /// <summary>
        /// SIZE_MARK_LINE_U3
        /// </summary>
        public int? SizeMarkLineU3 { get; set; }
        /// <summary>
        /// SIZE_MARK_LINE_U4
        /// </summary>
        public int? SizeMarkLineU4 { get; set; }
        /// <summary>
        /// SIZE_MARK_LINE_U5
        /// </summary>
        public int? SizeMarkLineU5 { get; set; }
        /// <summary>
        /// SIZE_MARK_LINE_D1
        /// </summary>
        public int? SizeMarkLineD1 { get; set; }
        /// <summary>
        /// SIZE_MARK_LINE_D2
        /// </summary>
        public int? SizeMarkLineD2 { get; set; }
        /// <summary>
        /// SIZE_MARK_LINE_D3
        /// </summary>
        public int? SizeMarkLineD3 { get; set; }
        /// <summary>
        /// SIZE_MARK_LINE_D4
        /// </summary>
        public int? SizeMarkLineD4 { get; set; }
        /// <summary>
        /// SIZE_MARK_LINE_D5
        /// </summary>
        public int? SizeMarkLineD5 { get; set; }
        /// <summary>
        /// 拉伸高度上限
        /// </summary>
        public int? BladderTensileHeightMax { get; set; }
        /// <summary>
        /// DUMMY1
        /// </summary>
        public int? Dummy1 { get; set; }
        /// <summary>
        /// DUMMY2
        /// </summary>
        public int? Dummy2 { get; set; }
        /// <summary>
        /// DUMMY3
        /// </summary>
        public int? Dummy3 { get; set; }
        /// <summary>
        /// DUMMY4
        /// </summary>
        public int? Dummy4 { get; set; }
        /// <summary>
        /// DUMMY5
        /// </summary>
        public int? Dummy5 { get; set; }
        /// <summary>
        /// DUMMY6
        /// </summary>
        public int? Dummy6 { get; set; }
        /// <summary>
        /// DUMMY7
        /// </summary>
        public int? Dummy7 { get; set; }
        /// <summary>
        /// DUMMY8
        /// </summary>
        public int? Dummy8 { get; set; }
        /// <summary>
        /// DUMMY9
        /// </summary>
        public int? Dummy9 { get; set; }
        /// <summary>
        /// DUMMY10
        /// </summary>
        public int? Dummy10 { get; set; }
        /// <summary>
        /// 拉伸高度（拉伸高度（0-100）
        /// </summary>
        public int? BladderTensileHeight1 { get; set; }
        /// <summary>
        /// 拉伸高度（拉伸高度（100-200）
        /// </summary>
        public int? BladderTensileHeight2 { get; set; }
        /// <summary>
        /// 拉伸高度（拉伸高度（200-）
        /// </summary>
        public int? BladderTensileHeight3 { get; set; }
        #endregion	
    }
}
