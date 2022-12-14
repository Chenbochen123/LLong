/************************************************************************************
 *      All contents © copyright MESNAC. All rights reserved
 *      File:
 *				PsbCustomer.cs
 *      Description:
 *		
 *      Author:
 *				孙本强
 *				SunBQ@MESNAC.COM
 *				HTTP://WWWW.MESNAC.COM
 *      Finish DateTime:
 *				2015年08月28日
 *      History:
 ***********************************************************************************/
using System;
using System.Collections.Generic;
using System.Text;

namespace Mesnac.Interface.Entity.BasicEntity
{
    /// <summary>
    /// 成品库车间-基础模块-客户 非自增-实体类
    /// </summary>
    [Serializable]
    public partial class PsbCustomer
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
        /// 公司代码
        /// </summary>
        public string CompArea { get; set; }
        /// <summary>
        /// 客户编码
        /// </summary>
        public string CustomerId { get; set; }
        /// <summary>
        /// 渠道
        /// </summary>
        public string Pass { get; set; }
        /// <summary>
        /// 品牌
        /// </summary>
        public string Mark { get; set; }
        /// <summary>
        /// 客户名称
        /// </summary>
        public string CustomeName { get; set; }
        /// <summary>
        /// 客户简称
        /// </summary>
        public string CustomeNick { get; set; }
        /// <summary>
        /// 客户名称英文
        /// </summary>
        public string CustomeNameEn { get; set; }
        /// <summary>
        /// 客户简称英文
        /// </summary>
        public string CustomeNickEn { get; set; }
        /// <summary>
        /// 客户名称泰文
        /// </summary>
        public string CustomeNameTh { get; set; }
        /// <summary>
        /// 客户简称泰文
        /// </summary>
        public string CustomeNickTh { get; set; }
        /// <summary>
        /// 税号
        /// </summary>
        public string TaxId { get; set; }
        /// <summary>
        /// 联系人
        /// </summary>
        public string Contactor { get; set; }
        /// <summary>
        /// 渠道描述
        /// </summary>
        public string PassDesc { get; set; }
        /// <summary>
        /// 地区编号
        /// </summary>
        public string AreaId { get; set; }
        /// <summary>
        /// 地区描述
        /// </summary>
        public string Area { get; set; }
        /// <summary>
        /// 国家编号
        /// </summary>
        public string CountryId { get; set; }
        /// <summary>
        /// 国家描述
        /// </summary>
        public string CountryDesc { get; set; }
        /// <summary>
        /// 部门编号
        /// </summary>
        public string DeptId { get; set; }
        /// <summary>
        /// 部门描述
        /// </summary>
        public string DeptDesc { get; set; }
        /// <summary>
        /// 品牌描述
        /// </summary>
        public string MarkDesc { get; set; }
        /// <summary>
        /// 总公司编号
        /// </summary>
        public string HeadComId { get; set; }
        /// <summary>
        /// 总公司名称
        /// </summary>
        public string HeadCom { get; set; }
        /// <summary>
        /// 备注,地址注释
        /// </summary>
        public string Remark { get; set; }
        /// <summary>
        /// 核准情况
        /// </summary>
        public string Authorize { get; set; }
        /// <summary>
        /// 业务人员
        /// </summary>
        public string SalesId { get; set; }
        /// <summary>
        /// 业务人员名
        /// </summary>
        public string SalesName { get; set; }
        /// <summary>
        /// 创建时间
        /// </summary>
        public string CTime { get; set; }
        /// <summary>
        /// 创建日期
        /// </summary>
        public string CDate { get; set; }
        /// <summary>
        /// 最后修改日期
        /// </summary>
        public string UDate { get; set; }
        /// <summary>
        /// 最后修改时间
        /// </summary>
        public string UTime { get; set; }
        /// <summary>
        /// 客户的删除标记
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
