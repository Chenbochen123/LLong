/************************************************************************************
 *      All contents © copyright MESNAC. All rights reserved
 *      File:
 *				BptMoldingTechAllData.cs
 *      Description:
 *		
 *      Author:
 *				lqk
 *				COM
 *				HTTP://WWWW.WonGoing.COM
 *      Finish DateTime:
 *				2020年12月28日
 *      History:
 ***********************************************************************************/
using System;
using System.Collections.Generic;
using System.Text;

namespace Mesnac.Interface.Entity.BasicEntity
{
    /// <summary>
    /// BPT_MOLDING_TECH_ALL_DATA-实体类
    /// </summary>
    [Serializable]
    public partial class BptMoldingTechAllData
    {
        #region 公有属性
        /// <summary>
        /// 工艺线路版本号
        /// </summary>
        public string ProcessVersion { get; set; }
        /// <summary>
        /// SAP品号
        /// </summary>
        public string SapCode { get; set; }
        /// <summary>
        /// 工艺版本号
        /// </summary>
        public string TechVersion { get; set; }
        /// <summary>
        /// 参数ID
        /// </summary>
        public string ParmCode { get; set; }
        /// <summary>
        /// 参数中文名称
        /// </summary>
        public string ParmName { get; set; }
        /// <summary>
        /// 参数类型代码
        /// </summary>
        public string ParmTypeCode { get; set; }
        /// <summary>
        /// 参数类型名称
        /// </summary>
        public string ParmTypeName { get; set; }
        /// <summary>
        /// 参数值
        /// </summary>
        public string ParmValue { get; set; }
        /// <summary>
        /// 最大值
        /// </summary>
        public string ParmValueMax { get; set; }
        /// <summary>
        /// 最小值
        /// </summary>
        public string ParmValueMin { get; set; }
        /// <summary>
        /// 删除标志
        /// </summary>
        public int? DeleteFlag { get; set; }
        /// <summary>
        /// 修改时间
        /// </summary>
        public DateTime? RecordTime { get; set; }
        #endregion	
    }
}
