using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Runtime.Serialization;

namespace MESReceivePLMService
{
    [DataContract(Name = "MoldingProcesses", Namespace = Constants.Namespace)]
    public class MoldingProcesses
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
        [DataMember(Name = "MoldingProcess", IsRequired = false, Order = 6)]
        public MoldingProcess[] MoldingProcess;
    }
    [DataContract(Name = "MoldingProcess", Namespace = Constants.Namespace)]
    public class MoldingProcess
    {
        [DataMember(Name = "CREATEUSER", IsRequired = false, Order = 1)]
        public string CREATEUSER = "";  //创建人      
        [DataMember(Name = "MODIFIER", IsRequired = false, Order = 2)]
        public string MODIFIER = "";  //修改人    
        [DataMember(Name = "CREATEDATE", IsRequired = false, Order = 3)]
        public string CREATEDATE = "";  //生效时间  
        [DataMember(Name = "ExpiredDATE", IsRequired = false, Order = 4)]
        public string ExpiredDATE = "";  //失效时间  
        [DataMember(Name = "EQUIPMENTCODE", IsRequired = false, Order = 5)]//EQUIPMENTCODE 设备代码
        public string EQUIPMENTCODE = "";  //设备代码      
        [DataMember(Name = "EQUIPMENTTYPECODE", IsRequired = false, Order = 6)]//EQUIPMENTTYPECODE 设备类型代码
        public string EQUIPMENTTYPECODE = "";  //设备类型代码
        [DataMember(Name = "PDMMAT", IsRequired = false, Order = 7)]
        public string PDMMAT = "";  //PDM物料编码     
        [DataMember(Name = "VERSION", IsRequired = false, Order = 8)]
        public string VERSION = "";  //版本号      
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
        [DataMember(Name = "MoldingParameters", IsRequired = false, Order = 15)]
        public MoldingParameters MoldingParameters; //参数项 
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

    [DataContract(Name = "MoldingParameters", Namespace = Constants.Namespace)]
    public class MoldingParameters
    {
        [DataMember(Name = "MoldingParameter", IsRequired = false, Order = 1)]
        public MoldingParameter[] MoldingParameter;         //参数数组
    }

    [DataContract(Name = "MoldingParameter", Namespace = Constants.Namespace)]
    public class MoldingParameter
    {
        [DataMember(Name = "PARMCODE", IsRequired = false, Order = 1)]
        public string PARMCODE = "";         //参数ID
        [DataMember(Name = "PARMNAME", IsRequired = false, Order = 2)]
        public string PARMNAME = "";          //参数中文名称
        //[DataMember(Name = "PARMNAME_EN", IsRequired = false, Order =3)]
        //public string PARMNAME_EN = "";          //参数英文名称
        [DataMember(Name = "PARMTYPECODE", IsRequired = false, Order = 4)]
        public string PARMTYPECODE = "";          //参数类型代码
        [DataMember(Name = "PARMTYPENAME", IsRequired = false, Order = 5)]
        public string PARMTYPENAME = "";          //参数类型名称
        [DataMember(Name = "VALUE", IsRequired = false, Order = 6)]
        public string VALUE = "";         //参数值
        [DataMember(Name = "VALUEMAX", IsRequired = false, Order = 7)]
        public string VALUEMAX = "";          //参数最大值
        [DataMember(Name = "VALUEMIN", IsRequired = false, Order =8)]
        public string VALUEMIN = "";         //参数最小值
        [DataMember(Name = "VALUEMAXSIGN", IsRequired = false, Order = 9)]
        public string VALUEMAXSIGN = "";          //参数最大值操作符 0 不包含、1包含
        [DataMember(Name = "VALUEMINSIGN", IsRequired = false, Order = 10)]
        public string VALUEMINSIGN = "";         //参数最小值操作符
        [DataMember(Name = "Dummy1", IsRequired = false, Order = 11)]
        public string Dummy1 = "";         //Dummy1
        [DataMember(Name = "Dummy2", IsRequired = false, Order =12)]
        public string Dummy2 = "";          //Dummy2
        [DataMember(Name = "Dummy3", IsRequired = false, Order = 13)]
        public string Dummy3 = "";          //Dummy3
        [DataMember(Name = "Dummy4", IsRequired = false, Order = 14)]
        public string Dummy4 = "";          //Dummy4
        [DataMember(Name = "Dummy5", IsRequired = false, Order = 15)]
        public string Dummy5 = "";         //Dummy5
        internal readonly string ParmName_en;
    }
}
