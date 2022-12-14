using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Runtime.Serialization;
using System.Collections;

namespace MESReceivePLMService
{
    /// <summary>
    /// 公差参数
    /// </summary>
    [DataContract(Name = "ToleranceParameters", Namespace = Constants.Namespace)]
    public class ToleranceParameters
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

        [DataMember(Name = "ToleranceParameter", IsRequired = false, Order = 6)]
        public ToleranceParameter[] ToleranceParameter { get; set; }
    }

    [DataContract(Name = "ToleranceParameter", Namespace = Constants.Namespace)]
    public class ToleranceParameter
    {
        /// <summary>
        /// 创建人
        /// </summary>
        [DataMember(Name = "CREATEUSER", IsRequired = false, Order = 1)]
        public string CREATEUSER { get; set; }
        /// <summary>
        /// 修改人
        /// </summary>
        [DataMember(Name = "MODIFIER", IsRequired = false, Order = 2)]
        public string MODIFIER { get; set; }

        /// <summary>
        /// 创建日期
        /// </summary>
        [DataMember(Name = "CREATEDATE", IsRequired = false, Order = 3)]
        public string CREATEDATE { get; set; }

        /// <summary>
        /// 部门
        /// </summary>
        [DataMember(Name = "SECTION", IsRequired = false, Order = 4)]
        public string SECTION { get; set; }

        /// <summary>
        /// 类别
        /// </summary>
        [DataMember(Name = "CLASSIFICATION", IsRequired = false, Order = 5)]
        public string CLASSIFICATION { get; set; }

        /// <summary>
        /// 工序名称
        /// </summary>
        [DataMember(Name = "PROCESSNAME", IsRequired = false, Order = 6)]
        public string PROCESSNAME { get; set; }

        /// <summary>
        /// 工厂
        /// </summary>
        [DataMember(Name = "WERKS", IsRequired = false, Order = 7)]
        public string WERKS { get; set; }

        /// <summary>
        /// 分厂
        /// </summary>
        [DataMember(Name = "FACTORY", IsRequired = false, Order = 8)]
        public string FACTORY { get; set; }

        /// <summary>
        /// Dummy1
        /// </summary>
        [DataMember(Name = "Dummy1", IsRequired = false, Order = 9)]
        public string Dummy1 { get; set; }
        /// <summary>
        /// Dummy2
        /// </summary>
        [DataMember(Name = "Dummy2", IsRequired = false, Order = 10)]
        public string Dummy2 { get; set; }
        /// <summary>
        /// Dummy3
        /// </summary>
        [DataMember(Name = "Dummy3", IsRequired = false, Order = 11)]
        public string Dummy3 { get; set; }
        /// <summary>
        /// Dummy4
        /// </summary>
        [DataMember(Name = "Dummy4", IsRequired = false, Order = 12)]
        public string Dummy4 { get; set; }
        /// <summary>
        /// Dummy5
        /// </summary>
        [DataMember(Name = "Dummy5", IsRequired = false, Order = 13)]
        public string Dummy5 { get; set; }

        [DataMember(Name = "TolerancePara", IsRequired = false, Order = 14)]
        public TolerancePara[] TolerancePara { get; set; }
    }

    [DataContract(Name = "TolerancePara", Namespace = Constants.Namespace)]
    public class TolerancePara
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
        /// 参数名称
        /// </summary>
        [DataMember(Name = "PARMNAME", IsRequired = false, Order = 6)]
        public string PARMNAME { get; set; }

        /// <summary>
        /// 参数最大值
        /// </summary>
        [DataMember(Name = "VALUEMAX", IsRequired = false, Order = 7)]
        public string VALUEMAX { get; set; }

        /// <summary>
        /// 参数最小值
        /// </summary>
        [DataMember(Name = "VALUEMIN", IsRequired = false, Order = 8)]
        public string VALUEMIN { get; set; }

        /// <summary>
        /// 参数最大值操作符
        /// 0：不包含
        /// 1：包含
        /// </summary>
        [DataMember(Name = "VALUEMAXSIGN", IsRequired = false, Order = 9)]
        public string VALUEMAXSIGN { get; set; }
        /// <summary>
        /// 参数最小值操作符
        /// 0：不包含
        /// 1：包含
        /// </summary>
        [DataMember(Name = "VALUEMINSIGN", IsRequired = false, Order = 10)]
        public string VALUEMINSIGN { get; set; }

        /// <summary>
        /// 标准值代码
        /// </summary>
        [DataMember(Name = "PARMCODE", IsRequired = false, Order = 11)]
        public string PARMCODE { get; set; }
    }
}