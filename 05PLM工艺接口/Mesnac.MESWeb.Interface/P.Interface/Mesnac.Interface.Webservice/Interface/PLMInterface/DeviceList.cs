using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Runtime.Serialization;

namespace MESReceivePLMService
{
    [DataContract(Name = "DeviceList", Namespace = Constants.Namespace)]
    public class DeviceList
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
      
    }

   
}
