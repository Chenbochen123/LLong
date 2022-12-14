/************************************************************************************
 *      All contents © copyright MESNAC. All rights reserved
 *      File:
 *				CptCuringTechParmData.cs
 *      Description:
 *		
 *      Author:
 *				董博
 *				
 *				
 *      Finish DateTime:
 *				2018年06月18日
 *      History:
 ***********************************************************************************/
using System;
using System.Collections.Generic;
using System.Text;

namespace Mesnac.InterfaceBG.Entity.BasicEntity
{
    /// <summary>
    /// 硫化车间-工艺模块-参数数据表-实体类
    /// </summary>
    [Serializable]
    public partial class CptCuringTechParmData
    {
        #region 公有属性
        /// <summary>
        /// 编号
        /// </summary>
        public int? ObjId { get; set; }
        /// <summary>
        /// PDM编号
        /// </summary>
        public string PdmCode { get; set; }
        /// <summary>
        /// 参数索引号
        /// </summary>
        public int? ParmGroupId { get; set; }
        /// <summary>
        /// 参数类型
        /// </summary>
        public int? ParmTypeId { get; set; }
        /// <summary>
        /// 参数信息
        /// </summary>
        public int? ParmInfoId { get; set; }
        /// <summary>
        /// 参数值
        /// </summary>
        public string ParmValue { get; set; }
        /// <summary>
        /// 参数最大值
        /// </summary>
        public string ParmValueMax { get; set; }
        /// <summary>
        /// 参数最小值
        /// </summary>
        public string ParmValueMin { get; set; }
        /// <summary>
        /// 版本
        /// </summary>
        public string PdmVersion { get; set; }
        /// <summary>
        /// 最后修改人
        /// </summary>
        public int? Lastmodifier { get; set; }
        /// <summary>
        /// 最后修改时间
        /// </summary>
        public DateTime? LastmodifyDate { get; set; }
        /// <summary>
        /// 创建人
        /// </summary>
        public int? RecordUserId { get; set; }
        /// <summary>
        /// 创建时间
        /// </summary>
        public DateTime? RecordTime { get; set; }
        /// <summary>
        /// 备份标示
        /// </summary>
        public int? BackupFlag { get; set; }
        /// <summary>
        /// 备份时间
        /// </summary>
        public DateTime? BackupTime { get; set; }
        /// <summary>
        /// 删除标示
        /// </summary>
        public int? DeleteFlag { get; set; }
        /// <summary>
        /// 参数是否已经组合
        /// </summary>
        public int? ParmCombine { get; set; }
        /// <summary>
        /// 参数对象CODE
        /// </summary>
        public string Objectcode { get; set; }
        /// <summary>
        /// 参数对象类型代码
        /// </summary>
        public string Parmtypecode { get; set; }
        /// <summary>
        /// 参数CODE
        /// </summary>
        public string Parmcode { get; set; }
        #endregion	
    }
}
