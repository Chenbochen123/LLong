using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Runtime.Serialization;

namespace MESReceivePLMService
{
    [DataContract(Name = "DeviceParameters", Namespace = Constants.Namespace)]
    public class DeviceParameters
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
        [DataMember(Name = "EQUIPMENTCODE", IsRequired = false, Order = 6)]
        public string EQUIPMENTCODE = "";         //设备代码
        [DataMember(Name = "EQUIPMENTNAME", IsRequired = false, Order = 7)]
        public string EQUIPMENTNAME = "";         //设备名称
        [DataMember(Name = "EQUIPMENTTYPECODE", IsRequired = false, Order = 8)]
        public string EQUIPMENTTYPECODE = "";         //设备类型代码
        [DataMember(Name = "EQUIPMENTTYPENAME", IsRequired = false, Order = 9)]
        public string EQUIPMENTTYPENAME = "";         //设备类型名称
        [DataMember(Name = "FACTORY", IsRequired = false, Order = 10)]
        public string FACTORY = "";         //分厂
        [DataMember(Name = "WERKS", IsRequired = false, Order = 11)]
        public string WERKS = "";  //工厂 
        [DataMember(Name = "DeviceParameter", IsRequired = false, Order = 12)]
        public DeviceParameter[] DeviceParameter;
      
    }
    [DataContract(Name = "DeviceParameter", Namespace = Constants.Namespace)]
    public class DeviceParameter
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
        [DataMember(Name = "DevicePara", IsRequired = false, Order = 6)]
        public DevicePara[] DevicePara;
    }
    [DataContract(Name = "DevicePara", Namespace = Constants.Namespace)]
    public class DevicePara
    {
        [DataMember(Name = "PARMCODE", IsRequired = false, Order = 1)]
        public string PARMCODE = "";         //参数ID
        [DataMember(Name = "PARMNAME", IsRequired = false, Order = 2)]
        public string PARMNAME = "";          //参数中文名称
        [DataMember(Name = "PARMNAME_EN", IsRequired = false, Order = 3)]
        public string PARMNAME_EN = "";          //参数英文名称
        [DataMember(Name = "PARMTYPECODE", IsRequired = false, Order = 4)]
        public string PARMTYPECODE = "";          //参数类型
        [DataMember(Name = "PARMTYPENAME", IsRequired = false, Order = 5)]
        public string PARMTYPENAME = "";          //参数类型名称
        [DataMember(Name = "VALUE", IsRequired = false, Order = 6)]
        public string VALUE = "";         //参数值
        [DataMember(Name = "VALUEMAX", IsRequired = false, Order = 7)]
        public string VALUEMAX = "";          //参数最大值
        [DataMember(Name = "VALUEMIN", IsRequired = false, Order = 8)]
        public string VALUEMIN = "";         //参数最小值
        [DataMember(Name = "VALUEMAXSIGN", IsRequired = false, Order = 9)]
        public string VALUEMAXSIGN = "";          //参数最大值操作符
        [DataMember(Name = "VALUEMINSIGN", IsRequired = false, Order = 10)]
        public string VALUEMINSIGN = "";         //参数最小值操作符
        [DataMember(Name = "Dummy1", IsRequired = false, Order = 11)]
        public string Dummy1 = "";         //Dummy1
        [DataMember(Name = "Dummy2", IsRequired = false, Order = 12)]
        public string Dummy2 = "";          //Dummy2
        [DataMember(Name = "Dummy3", IsRequired = false, Order = 13)]
        public string Dummy3 = "";          //Dummy3
        [DataMember(Name = "Dummy4", IsRequired = false, Order = 14)]
        public string Dummy4 = "";          //Dummy4
        [DataMember(Name = "Dummy5", IsRequired = false, Order = 15)]
        public string Dummy5 = "";         //Dummy5
    }
}
