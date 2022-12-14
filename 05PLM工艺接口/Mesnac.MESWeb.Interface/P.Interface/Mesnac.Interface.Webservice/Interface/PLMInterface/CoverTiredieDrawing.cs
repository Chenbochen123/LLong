using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Runtime.Serialization;

namespace MESReceivePLMService
{
    [DataContract(Name = "CoverTireDieDrawing", Namespace = Constants.Namespace)]
    public class CoverTireDieDrawing
    {
        [DataMember(Name = "COVERSAP", IsRequired = false, Order = 1)]
        public string COVERSAP = "";         //外胎SAP品号
        [DataMember(Name = "FileName", IsRequired = false, Order = 2)]
        public string FileName = "";          //文件名
        [DataMember(Name = "FILE", IsRequired = false, Order = 3)]
        public string FILE = "";          //模具标示图文件
      
    }

   
}
