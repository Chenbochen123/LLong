using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Runtime.Serialization;

namespace MESReceivePLMService
{
    [DataContract(Name = "VulcanizationParams", Namespace = Constants.Namespace)]
    public class VulcanizationParams
    {
        /// <summary>
        /// 备用1
        /// </summary>
        [DataMember(Name = "Dummy1", IsRequired = false, Order = 1)]
        public string Dummy1 { get; set; }

        /// <summary>
        /// 备用2
        /// </summary>
        [DataMember(Name = "Dummy2", IsRequired = false, Order = 2)]
        public string Dummy2 { get; set; }

        /// <summary>
        /// 备用3
        /// </summary>
        [DataMember(Name = "Dummy3", IsRequired = false, Order = 3)]
        public string Dummy3 { get; set; }

        /// <summary>
        /// 备用4
        /// </summary>
        [DataMember(Name = "Dummy4", IsRequired = false, Order = 4)]
        public string Dummy4 { get; set; }

        /// <summary>
        /// 备用5
        /// </summary>
        [DataMember(Name = "Dummy5", IsRequired = false, Order = 5)]
        public string Dummy5 { get; set; }

        /// <summary>
        /// 参数对象ID
        /// </summary>
        [DataMember(Name = "OBJECTID", IsRequired = false, Order = 6)]
        public string OBJECTID { get; set; }

        /// <summary>
        /// 参数对象CODE
        /// </summary>
        [DataMember(Name = "OBJECTCODE", IsRequired = false, Order = 7)]
        public string OBJECTCODE { get; set; }

        /// <summary>
        /// 参数对象类型代码
        /// </summary>
        [DataMember(Name = "PARMTYPECODE", IsRequired = false, Order = 8)]
        public string PARMTYPECODE { get; set; }

        /// <summary>
        /// 参数对象类型名称
        /// </summary>
        [DataMember(Name = "PARMTYPENAME", IsRequired = false, Order = 9)]
        public string PARMTYPENAME { get; set; }


        /// <summary>
        /// 分厂
        /// </summary>
        [DataMember(Name = "FACTORY", IsRequired = false, Order = 10)]
        public string FACTORY { get; set; }

        /// <summary>
        /// 工厂
        /// </summary>
        [DataMember(Name = "WERKS", IsRequired = false, Order = 11)]
        public string WERKS { get; set; }

        /// <summary>
        /// 硫化基础参数列表
        /// </summary>
        [DataMember(Name = "VulcanizationParam", IsRequired = false, Order = 12)]
        public VulcanizationParam[] VulcanizationParam { get; set; }
    }

    [DataContract(Name = "VulcanizationParam", Namespace = Constants.Namespace)]
    public class VulcanizationParam
    {
        /// <summary>
        /// 备用1
        /// </summary>
        [DataMember(Name = "Dummy1", IsRequired = false, Order = 1)]
        public string Dummy1 { get; set; }

        /// <summary>
        /// 备用2
        /// </summary>
        [DataMember(Name = "Dummy2", IsRequired = false, Order = 2)]
        public string Dummy2 { get; set; }

        /// <summary>
        /// 备用3
        /// </summary>
        [DataMember(Name = "Dummy3", IsRequired = false, Order = 3)]
        public string Dummy3 { get; set; }

        /// <summary>
        /// 备用4
        /// </summary>
        [DataMember(Name = "Dummy4", IsRequired = false, Order = 4)]
        public string Dummy4 { get; set; }

        /// <summary>
        /// 备用5
        /// </summary>
        [DataMember(Name = "Dummy5", IsRequired = false, Order = 5)]
        public string Dummy5 { get; set; }

        /// <summary>
        /// 硫化基础参数列表
        /// </summary>
        [DataMember(Name = "VulcanizationPara", IsRequired = false, Order = 6)]
        public VulcanizationPara[] VulcanizationPara { get; set; }
    }

    [DataContract(Name = "VulcanizationPara", Namespace = Constants.Namespace)]
    public class VulcanizationPara
    {
        /// <summary>
        /// 参数ID
        /// </summary>
        [DataMember(Name = "PARMCODE", IsRequired = false, Order = 1)]
        public string PARMCODE { get; set; }

        /// <summary>
        /// 参数中文名称
        /// </summary>
        [DataMember(Name = "PARMNAME", IsRequired = false, Order = 2)]
        public string PARMNAME { get; set; }

        ///// <summary>
        ///// 参数英文名称
        ///// </summary>
        //[DataMember(Name = "PARMNAME_EN", IsRequired = false, Order = 3)]
        //public string PARMNAME_EN = "";

        ///// <summary>
        ///// 参数类型
        ///// </summary>
        //[DataMember(Name = "PARMTYPECODE", IsRequired = false, Order = 4)]
        //public string PARMTYPECODE = ""; 
        ///// <summary>
        ///// 参数类型名称
        ///// </summary>
        //[DataMember(Name = "PARMTYPENAME", IsRequired = false, Order = 5)]
        //public string PARMTYPENAME = "";

        /// <summary>
        /// 参数值
        /// </summary>
        [DataMember(Name = "VALUE", IsRequired = false, Order = 6)]
        public string VALUE { get; set; }

        /// <summary>
        /// 备用1
        /// </summary>
        [DataMember(Name = "Dummy1", IsRequired = false, Order = 7)]
        public string Dummy1 { get; set; }

        /// <summary>
        /// 备用2
        /// </summary>
        [DataMember(Name = "Dummy2", IsRequired = false, Order = 8)]
        public string Dummy2 { get; set; }

        /// <summary>
        /// 备用3
        /// </summary>
        [DataMember(Name = "Dummy3", IsRequired = false, Order = 9)]
        public string Dummy3 { get; set; }

        /// <summary>
        /// 备用4
        /// </summary>
        [DataMember(Name = "Dummy4", IsRequired = false, Order = 10)]
        public string Dummy4 { get; set; }

        /// <summary>
        /// 备用5
        /// </summary>
        [DataMember(Name = "Dummy5", IsRequired = false, Order = 11)]
        public string Dummy5 { get; set; }
    }
}
