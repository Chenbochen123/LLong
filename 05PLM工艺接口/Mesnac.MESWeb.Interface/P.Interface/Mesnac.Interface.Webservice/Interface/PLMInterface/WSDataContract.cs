using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Runtime.Serialization;
using System.Collections;

namespace MESReceivePLMService
{
    public class Constants
    {
        // Ensures consistency in the namespace declarations across services
        public const string Namespace = "http://tempuri.org/";
    }


    [DataContract(Name = "ReturnObject", Namespace = Constants.Namespace)]
    public class ReturnObject
    {
        public ReturnObject(string i, string s)
        {
            r_retcode = i;
            r_retmsg = s;
        }
        [DataMember(Name = "r_retcode", IsRequired = false, Order = 1)]
        public string r_retcode;
        [DataMember(Name = "r_retmsg", IsRequired = false, Order = 2)]
        public string r_retmsg = "";

       
    }

    [DataContract(Name = "BOMS", Namespace =  Constants.Namespace)]
    public class BOMS
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
        [DataMember(Name = "bom", IsRequired = false, Order = 6)]
        public BOM[] bom;
    }
    [DataContract(Name = "BOM", Namespace = Constants.Namespace)]
    public class BOM
    {
        [DataMember(Name = "BOMTYPE", IsRequired = false, Order = 1)]
        public string BOMTYPE="" ;  //BOM类型 
        [DataMember(Name = "MATERTYPE", IsRequired = false, Order = 2)]//Materialtype 物料类型
        public string MATERTYPE = "";  //物料类型
        [DataMember(Name = "CREATEUSER", IsRequired = false,  Order = 3)]
        public string CREATEUSER = "";  //创建人 
        [DataMember(Name = "MODIFIER", IsRequired = false, Order = 4)]  
        public string MODIFIER = "";  //修改人   
        [DataMember(Name = "CREATEDATE", IsRequired = false, Order = 5)]
        public string CREATEDATE = "";  //生效日期         
        [DataMember(Name = "ExpiredDATE", IsRequired = false, Order = 6)]
        public string ExpiredDATE = "";  //失效日期         
        [DataMember(Name = "MASTERSAP", IsRequired = false, Order = 7)]
        public string MASTERSAP = "";  //父SAP品号        
        [DataMember(Name = "MASTERREVISION", IsRequired = false, Order = 8)]
        public string MASTERREVISION = "";  //父物料版本号 
        [DataMember(Name = "SUBITEMSAP", IsRequired = false, Order = 9)]
        public string SUBITEMSAP = "";  //子SAP品号   
        [DataMember(Name = "SUBITEMREVISION", IsRequired = false, Order = 10)]
        public string SUBITEMREVISION = "";  //子物料版本号
        [DataMember(Name = "SUBITEMDESC", IsRequired = false, Order = 11)]
        public string SUBITEMDESC = "";  //子描述名称            
        [DataMember(Name = "SPEC", IsRequired = false, Order = 12)]
        public string SPEC = "";  //规格             
        [DataMember(Name = "UNIT", IsRequired = false, Order = 13)]
        public string UNIT = "";  //单位             
        [DataMember(Name = "MAKEUSE", IsRequired = false, Order = 14)]
        public string MAKEUSE = "";  //单位用量         
        [DataMember(Name = "BASENUM", IsRequired = false, Order = 15)]
        public string BASENUM = "";  //底数                
        [DataMember(Name = "PROPHASE", IsRequired = false, Order = 16)]
        public string PROPHASE = "";  //产品所属阶段     
        [DataMember(Name = "FACTORY", IsRequired = false, Order = 17)]
        public string FACTORY = "";  //BOM所属分厂      
        [DataMember(Name = "REPLACEBOM", IsRequired = false, Order = 18)]
        public string REPLACEBOM = "";  //BOM替代号        
        [DataMember(Name = "TYRESIZENUM", IsRequired = false, Order = 19)]
        public string TYRESIZENUM = "";  //父项规格代码
        [DataMember(Name = "WERKS", IsRequired = false, Order = 20)]
        public string WERKS = "";  //工厂             
        [DataMember(Name = "RECIPETYPE", IsRequired = false, Order = 21)]
        public string RECIPETYPE = "";  //终炼胶类型       
        [DataMember(Name = "SUPPLYCODE", IsRequired = false, Order = 22)]
        public string SUPPLYCODE = "";  //供应商代码       
        [DataMember(Name = "Dummy1", IsRequired = false, Order = 23)]
        public string Dummy1 = "";         //Dummy1
        [DataMember(Name = "Dummy2", IsRequired = false, Order = 24)]
        public string Dummy2 = "";          //Dummy2
        [DataMember(Name = "Dummy3", IsRequired = false, Order = 25)]
        public string Dummy3 = "";          //Dummy3
        [DataMember(Name = "Dummy4", IsRequired = false, Order = 26)]
        public string Dummy4 = "";          //Dummy4
        [DataMember(Name = "Dummy5", IsRequired = false, Order = 27)]
        public string Dummy5 = "";         //Dummy5
       
    }
    //public enum DeviceName
    //{
    //    A1, A2, A3, A4, A5, A6, A7, A8, A9, A10,A11, A12, A13,
    //    B1, B2, B3, B4, B5, B6, B7, B8, B9, B10, B11, B12, B13,
    //    C1, C2, C3, C4, C5, C6, C7, C8, C9, C10, C11, C12, C13,
    //    D1, D2, D3, D4, D5, D6, D7, D8, D9, D10, D11, D12, D13,
    //}

    [DataContract(Name = "ObsoleteBOMs", Namespace = Constants.Namespace)]
    public class ObsoleteBOMs
    {

        [DataMember(Name = "ObsoleteBOM", IsRequired = false, Order = 1)]
        public ObsoleteBOM[] ObsoleteBOM;

    }

    [DataContract(Name = "ObsoleteBOM", Namespace = Constants.Namespace)]
    public class ObsoleteBOM
    {

        [DataMember(Name = "MASTERSAP", IsRequired = false, Order = 1)]
        public string MASTERSAP = "";  //外胎SAP品号      
        [DataMember(Name = "MASTERREVISION", IsRequired = false, Order = 2)]
        public string MASTERREVISION = "";  //父类版本号      
        [DataMember(Name = "SUBITEMSAP", IsRequired = false, Order = 3)]
        public string SUBITEMSAP = "";  //胎胚SAP品号      
        [DataMember(Name = "SUBITEMREVISION", IsRequired = false, Order = 4)]
        public string SUBITEMREVISION = "";  //胎胚版本      
        [DataMember(Name = "ExpiredDATE", IsRequired = false, Order = 5)]
        public string ExpiredDATE = "";  //失效时间      
        [DataMember(Name = "PROPHASE", IsRequired = false, Order = 6)]
        public string PROPHASE = "";  //阶段      
        [DataMember(Name = "WERKS", IsRequired = false, Order = 7)]
        public string WERKS = "";  //工厂     
        [DataMember(Name = "FACTORY", IsRequired = false, Order = 8)]
        public string FACTORY = "";  //分厂     

    }

    [DataContract(Name = "ObsoleteBOMDate", Namespace = Constants.Namespace)]
    public class ObsoleteBOMDate
    {

        [DataMember(Name = "MODIFIER", IsRequired = false, Order = 1)]
        public string MODIFIER = "";  //修改人  
        [DataMember(Name = "MODIFYDATE", IsRequired = false, Order = 2)]
        public string MODIFYDATE = "";  //修改时间
        [DataMember(Name = "ExpiredDATE", IsRequired = false, Order = 3)]
        public string ExpiredDATE = "";  //失效时
        [DataMember(Name = "TYRESIZENUM", IsRequired = false, Order = 4)]
        public string TYRESIZENUM = "";  //父项规格代码
        [DataMember(Name = "MASTERREVISION", IsRequired = false, Order = 5)]
        public string MASTERREVISION = "";  //父项版本
        [DataMember(Name = "MASTERSAP", IsRequired = false, Order = 6)]
        public string MASTERSAP = "";  //父项SAP品号 
        [DataMember(Name = "REPLACEBOM", IsRequired = false, Order = 7)]
        public string REPLACEBOM = "";  //BOM替代号  
        [DataMember(Name = "PROPHASE", IsRequired = false, Order = 8)]
        public string PROPHASE = "";  //阶段      
        [DataMember(Name = "WERKS", IsRequired = false, Order = 9)]
        public string WERKS = "";  //工厂     
        [DataMember(Name = "FACTORY", IsRequired = false, Order = 10)]
        public string FACTORY = "";  //分厂  
        [DataMember(Name = "Subitemsap", IsRequired = false, Order = 11)]
        public string Subitemsap = "";  //子物料SAP品号  
        [DataMember(Name = "Subitemrevision", IsRequired = false, Order = 10)]
        public string Subitemrevision = "";  //子物料版本 
        [DataMember(Name = "Dummy1", IsRequired = false, Order = 12)]
        public string Dummy1 = "";  //预留1
        [DataMember(Name = "Dummy2", IsRequired = false, Order = 13)]
        public string Dummy2 = "";  //预留2
        [DataMember(Name = "Dummy3", IsRequired = false, Order = 14)]
        public string Dummy3 = "";  //预留3  
        [DataMember(Name = "Dummy4", IsRequired = false, Order = 15)]
        public string Dummy4 = "";  //预留4  
        [DataMember(Name = "Dummy5", IsRequired = false, Order = 15)]
        public string Dummy5 = "";  //预留5 

    }


}
