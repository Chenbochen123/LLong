/************************************************************************************
 *      All contents © copyright MESNAC. All rights reserved
 *      File:
 *				SbmMaterial.cs
 *      Description:
 *		
 *      Author:
 *				董博
 *				
 *				
 *      Finish DateTime:
 *				2018年10月22日
 *      History:
 ***********************************************************************************/
using System;
using System.Collections.Generic;
using System.Text;

namespace Mesnac.InterfaceBG.Entity.BasicEntity
{
    /// <summary>
    /// 全厂-基础资料-物料信息-实体类
    /// </summary>
    [Serializable]
    public partial class SbmMaterial
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
        /// 物料名称
        /// </summary>
        public string MaterialName { get; set; }
        /// <summary>
        /// 物料代码
        /// </summary>
        public string MaterialCode { get; set; }
        /// <summary>
        /// 物料大类
        /// </summary>
        public int? MajorTypeId { get; set; }
        /// <summary>
        /// 物料细类
        /// </summary>
        public int? MinorTypeId { get; set; }
        /// <summary>
        /// 备注
        /// </summary>
        public string Remark { get; set; }
        /// <summary>
        /// SAP编号
        /// </summary>
        public string SapCode { get; set; }
        /// <summary>
        /// SAP的编号
        /// </summary>
        public string SapFullCode { get; set; }
        /// <summary>
        /// PDM编号
        /// </summary>
        public string PdmCode { get; set; }
        /// <summary>
        /// 物料完整名称
        /// </summary>
        public string MaterialFullName { get; set; }
        /// <summary>
        /// 物料短号
        /// </summary>
        public string MaterialShort { get; set; }
        /// <summary>
        /// 跨工厂物料状态
        /// </summary>
        public string Status { get; set; }
        /// <summary>
        /// 特定工厂物料状态
        /// </summary>
        public string Matstatus { get; set; }
        #endregion	
    }
}
