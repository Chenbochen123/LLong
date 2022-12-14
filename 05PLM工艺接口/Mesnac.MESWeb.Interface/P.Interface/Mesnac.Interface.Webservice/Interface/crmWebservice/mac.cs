using Castle.DynamicProxy.Generators;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Runtime.Serialization;
using System.Web;

namespace Mesnac.Interface.Webservice.Interface.SapWebservice
{
    public class mac
    {
        public class datas
        {
            public data[] data;

            public string code="";
            public string msg = "";
        }

        public class data
        {

            [DataMember(Name = "tire_code", IsRequired = false, Order = 1)]
            public string tire_code = "";    
            [DataMember(Name = "doc_number", IsRequired = false, Order = 2)]
            public string doc_number = "";       
            [DataMember(Name = "account_code", IsRequired = false, Order = 3)]
            public string account_code = "";   
            [DataMember(Name = "product_code", IsRequired = false, Order = 4)]
            public string product_code = "";
            [DataMember(Name = "production_spec", IsRequired = false, Order = 4)]
            public string production_spec = "";
            [DataMember(Name = "manufacture_date", IsRequired = false, Order = 5)]
            public string manufacture_date = "";
            [DataMember(Name = "outage_spec", IsRequired = false, Order = 5)]
            public string outage_spec = "";
            [DataMember(Name = "outage_time", IsRequired = false, Order = 6)]
            public string outage_time = "";
            [DataMember(Name = "outage_date", IsRequired = false, Order = 6)]
            public string outage_date = "";
            [DataMember(Name = "outage_grade", IsRequired = false, Order = 7)]
            public string outage_grade = "";      
            [DataMember(Name = "remark", IsRequired = false, Order = 8)]
            public string remark = "";
            [DataMember(Name = "group_name", IsRequired = false, Order = 8)]
            public string group_name = "";          

        }

    }
}