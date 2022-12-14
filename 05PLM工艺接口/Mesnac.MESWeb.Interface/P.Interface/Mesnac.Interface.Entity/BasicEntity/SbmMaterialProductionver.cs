/************************************************************************************
 *      All contents © copyright MESNAC. All rights reserved
 *      File:
 *				SbmMaterialProductionver.cs
 *      Description:
 *		
 *      Author:
 *				曲世峰
 *				QUSF@MESNAC.COM
 *				HTTP://WWWW.MESNAC.COM
 *      Finish DateTime:
 *				2017年11月30日
 *      History:
 ***********************************************************************************/
using System;
using System.Collections.Generic;
using System.Text;

namespace Mesnac.Interface.Entity.BasicEntity
{
    /// <summary>
    /// 全厂-基础资料-物料信息-实体类
    /// </summary>
    [Serializable]
    public partial class SbmMaterialProductionver
    {
        #region 公有属性
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
        /// SAP编号
        /// </summary>
        public string SapCode { get; set; }
        /// <summary>
        /// 生产版本号
        /// </summary>
        public string ProductionVer { get; set; }
        /// <summary>
        /// 版本描述
        /// </summary>
        public string VerDesc { get; set; }
        /// <summary>
        /// 工厂号
        /// </summary>
        public string Plant { get; set; }
        /// <summary>
        /// 成本收集器状态:KA
        /// </summary>
        public string CostcolStatus { get; set; }
        /// <summary>
        /// 物料状态:冻结状态Z1、Z2
        /// </summary>
        public string MatStatus { get; set; }
        /// <summary>
        /// 锁定的产品版本:1代表锁定
        /// </summary>
        public string MKsp { get; set; }
        /// <summary>
        /// 预留1
        /// </summary>
        public string Dummy1 { get; set; }
        /// <summary>
        /// 预留2
        /// </summary>
        public string Dummy2 { get; set; }
        /// <summary>
        /// 预留3
        /// </summary>
        public string Dummy3 { get; set; }
        /// <summary>
        /// 预留4
        /// </summary>
        public string Dummy4 { get; set; }
        #endregion	
    }
}
