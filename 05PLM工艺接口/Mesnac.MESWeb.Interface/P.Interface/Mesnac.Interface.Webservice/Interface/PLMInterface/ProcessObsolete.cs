using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Runtime.Serialization;

namespace MESReceivePLMService
{
    [DataContract(Name = "ObsoleteProcesses", Namespace = Constants.Namespace)]
    public class ObsoleteProcesses
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
        [DataMember(Name = "ObsoleteProcess", IsRequired = false, Order = 6)]
        public ObsoleteProcess[] ObsoleteProcess;
    }
    [DataContract(Name = "ObsoleteProcess", Namespace = Constants.Namespace)]
    public class ObsoleteProcess
    {
        [DataMember(Name = "MATVERSION", IsRequired = false, Order = 1)]
        public string MATVERSION = "";  //物料版本号       
        [DataMember(Name = "SAPMAT", IsRequired = false, Order = 2)]
        public string SAPMAT = "";  //SAP品号
        [DataMember(Name = "STAGE", IsRequired = false, Order = 3)]
        public string STAGE = "";  //产品阶段   
        [DataMember(Name = "PROCESSROUTETYPE", IsRequired = false, Order =3)]
        public string PROCESSROUTETYPE = "";  //工艺路线类型      
        [DataMember(Name = "PROCESSROUTE", IsRequired = false, Order = 4)]
        public string PROCESSROUTE = "";  //工艺路线名称      
        [DataMember(Name = "PROCESSVERSION", IsRequired = false, Order =5)]
        public string PROCESSVERSION = "";  //工艺版本号     
        [DataMember(Name = "ExpiredDATE", IsRequired = false, Order = 6)]
        public string ExpiredDATE = "";  //失效时间  
        [DataMember(Name = "WERKS", IsRequired = false, Order = 7)]
        public string WERKS = "";  //工厂     
        [DataMember(Name = "FACTORY", IsRequired = false, Order =8)]
        public string FACTORY = "";  //分厂     
        [DataMember(Name = "Dummy1", IsRequired = false, Order = 9)]
        public string Dummy1 = "";         //Dummy1
        [DataMember(Name = "Dummy2", IsRequired = false, Order = 10)]
        public string Dummy2 = "";          //Dummy2
        [DataMember(Name = "Dummy3", IsRequired = false, Order = 11)]
        public string Dummy3 = "";          //Dummy3
        [DataMember(Name = "Dummy4", IsRequired = false, Order = 12)]
        public string Dummy4 = "";          //Dummy4
        [DataMember(Name = "Dummy5", IsRequired = false, Order = 13)]
        public string Dummy5 = "";         //Dummy5
    }

   
}
