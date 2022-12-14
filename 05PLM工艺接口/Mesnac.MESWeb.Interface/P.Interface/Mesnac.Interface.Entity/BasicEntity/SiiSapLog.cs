/************************************************************************************
 *      All contents © copyright MESNAC. All rights reserved
 *      File:
 *				SiiSapLog.cs
 *      Description:
 *		
 *      Author:
 *				孙本强
 *				SunBQ@MESNAC.COM
 *				HTTP://WWWW.MESNAC.COM
 *      Finish DateTime:
 *				2015年09月07日
 *      History:
 ***********************************************************************************/
using System;
using System.Collections.Generic;
using System.Text;

namespace Mesnac.Interface.Entity.BasicEntity
{
    /// <summary>
    /// 全厂-接口模块-SAP接口日志 非自增-实体类
    /// </summary>
    [Serializable]
    public partial class SiiSapLog
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
        /// 方法名称
        /// </summary>
        public string MethodName { get; set; }
        /// <summary>
        /// 方法说明
        /// </summary>
        public string MethodMemo { get; set; }
        /// <summary>
        /// 方法内容
        /// </summary>
        public string MethodContent { get; set; }
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
        #endregion	
    }
}
