using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Runtime.Serialization;

namespace MESReceivePLMService
{
    [DataContract(Name = "VulcanizationProcesses", Namespace = Constants.Namespace)]
    public class VulcanizationProcesses
    {
        [DataMember(Name = "Dummy1", IsRequired = false, Order = 1)]
        public string Dummy1 = "";         //Dummy1
        [DataMember(Name = "Dummy2", IsRequired = false, Order = 2)]
        public string Dummy2 = "";          //Dummy2
        [DataMember(Name = "Dummy3", IsRequired = false, Order = 3)]
        public string Dummy3 = "";          //Dummy3
        [DataMember(Name = "Dummy4", IsRequired = false, Order = 4)]
        public string Dummy4 = "";          //Dummy4
        [DataMember(Name = "Dummy5", IsRequired = false, Order = 5)]
        public string Dummy5 = "";         //Dummy5
        [DataMember(Name = "VulcanizationProcess", IsRequired = false, Order = 6)]
        public VulcanizationProcess[] VulcanizationProcess;
    }
    [DataContract(Name = "VulcanizationProcess", Namespace = Constants.Namespace)]
    public class VulcanizationProcess
    {
        [DataMember(Name = "CREATEUSER", IsRequired = false, Order = 1)]
        public string CREATEUSER = "";  //创建人      
        [DataMember(Name = "MODIFIER", IsRequired = false, Order = 2)]
        public string MODIFIER = "";  //修改人    
        [DataMember(Name = "CREATEDATE", IsRequired = false, Order = 3)]
        public string CREATEDATE = "";  //生效时间  
        [DataMember(Name = "ExpiredDATE", IsRequired = false, Order = 4)]
        public string ExpiredDATE = "";  //失效时间  
        [DataMember(Name = "PDMMAT", IsRequired = false, Order = 5)]
        public string PDMMAT = "";  //胎胚规格代码       
        [DataMember(Name = "VERSION", IsRequired = false, Order = 8)]
        public string VERSION = "";  //胎胚版本号      
        [DataMember(Name = "SAPMAT", IsRequired = false, Order = 9)]
        public string SAPMAT = "";  //SAP品号      
        [DataMember(Name = "STAGE", IsRequired = false, Order = 10)]
        public string STAGE = "";  //产品阶段      
        [DataMember(Name = "PROCESSROUTE", IsRequired = false, Order = 11)]
        public string PROCESSROUTE = "";  //工艺路线名称      
        [DataMember(Name = "PROCESSVERSION", IsRequired = false, Order = 12)]
        public string PROCESSVERSION = "";  //工艺版本号     
        [DataMember(Name = "WERKS", IsRequired = false, Order = 13)]
        public string WERKS = "";  //工厂     
        [DataMember(Name = "FACTORY", IsRequired = false, Order = 14)]
        public string FACTORY = "";  //分厂     
        [DataMember(Name = "VulcanizationParameters", IsRequired = false, Order = 15)]
        public VulcanizationParameters VulcanizationParameters; //参数项 
        [DataMember(Name = "Dummy1", IsRequired = false, Order = 16)]
        public string Dummy1 = "";         //Dummy1
        [DataMember(Name = "Dummy2", IsRequired = false, Order = 17)]
        public string Dummy2 = "";          //Dummy2
        [DataMember(Name = "Dummy3", IsRequired = false, Order = 18)]
        public string Dummy3 = "";          //Dummy3
        [DataMember(Name = "Dummy4", IsRequired = false, Order = 19)]
        public string Dummy4 = "";          //Dummy4
        [DataMember(Name = "Dummy5", IsRequired = false, Order = 20)]
        public string Dummy5 = "";         //Dummy5
    }

    [DataContract(Name = "VulcanizationParameters", Namespace = Constants.Namespace)]
    public class VulcanizationParameters
    {
        [DataMember(Name = "VulcanizationParameter", IsRequired = false, Order = 1)]
        public VulcanizationParameter[] VulcanizationParameter;         //参数数组
    }

    [DataContract(Name = "VulcanizationParameter", Namespace = Constants.Namespace)]
    public class VulcanizationParameter
    {
       // [DataMember(Name = "PARMCODE", IsRequired = false, Order = 1)]
       // public string PARMCODE = "";         //参数ID
       // [DataMember(Name = "PARMNAME", IsRequired = false, Order = 2)]
       // public string PARMNAME = "";          //参数中文名称
       // [DataMember(Name = "PARMNAME_EN", IsRequired = false, Order =3)]
       // public string PARMNAME_EN = "";          //参数英文名称
        [DataMember(Name = "PARMTYPECODE", IsRequired = false, Order = 1)]
        public string PARMTYPECODE = "";          //参数类型ID
        [DataMember(Name = "PARMINDX", IsRequired = false, Order = 2)]
        public string PARMINDX = "";          //参数附表的ID
       // [DataMember(Name = "PARMTYPENAME", IsRequired = false, Order = 5)]
       // public string PARMTYPENAME = "";          //参数类型名称
       // [DataMember(Name = "VALUE", IsRequired = false, Order = 5)]
       // public string VALUE = "";         //参数值
        [DataMember(Name = "Dummy1", IsRequired = false, Order = 5)]
        public string Dummy1 = "";         //Dummy1
        [DataMember(Name = "Dummy2", IsRequired = false, Order =6)]
        public string Dummy2 = "";          //Dummy2
        [DataMember(Name = "Dummy3", IsRequired = false, Order = 7)]
        public string Dummy3 = "";          //Dummy3
        [DataMember(Name = "Dummy4", IsRequired = false, Order = 8)]
        public string Dummy4 = "";          //Dummy4
        [DataMember(Name = "Dummy5", IsRequired = false, Order = 9)]
        public string Dummy5 = "";         //Dummy5
    }
}
