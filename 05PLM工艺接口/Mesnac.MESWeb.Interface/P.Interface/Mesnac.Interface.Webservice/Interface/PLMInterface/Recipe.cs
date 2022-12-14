using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Runtime.Serialization;

namespace MESReceivePLMService
{

    [DataContract(Name = "PlmRecipe", Namespace = Constants.Namespace)]
    public class PlmRecipe
    {
        [DataMember(Name = "Mater_code", IsRequired = false, Order = 1)]
        public string Mater_code = "";         //父物料SAP品号
        [DataMember(Name = "Mater_Type", IsRequired = false, Order = 2)]
        public string Mater_Type = "";          //父物料类型
        [DataMember(Name = "B_Version", IsRequired = false, Order = 4)]
        public string B_Version = "";          //父物料PLM版本
        [DataMember(Name = "R_Version", IsRequired = false, Order = 6)]
        public string R_Version = "";         //父物料工艺PLM版本
        [DataMember(Name = "Plant", IsRequired = false, Order = 7)]
        public string Plant = "";          //工厂代码
        [DataMember(Name = "IsMixed", IsRequired = false, Order = 8)]
        public string IsMixed = "";         //是否掺胶
        [DataMember(Name = "PrescriptionStage", IsRequired = false, Order = 9)]
        public string PrescriptionStage = "";          //配方阶段
        [DataMember(Name = "SAP_Version", IsRequired = false, Order = 9)]
        public string SAP_Version = "";          //sap版本号
        [DataMember(Name = "Equip_code", IsRequired = false, Order = 13)]
        public string Equip_code = "";          //机台代码
        [DataMember(Name = "Routing_type", IsRequired = false, Order = 10)]
        public string Routing_type = "";         //工艺类型
        [DataMember(Name = "Shelf_num", IsRequired = false, Order = 11)]
        public int Shelf_num ;         //架子数
        [DataMember(Name = "Set_weigh", IsRequired = false, Order = 12)]
        public decimal Set_weigh ;          //设定重量
        [DataMember(Name = "CB_RecycleType", IsRequired = false, Order = 14)]
        public string CB_RecycleType = "";          //炭黑回收类型
        [DataMember(Name = "CB_RecycleTime", IsRequired = false, Order = 15)]
        public int CB_RecycleTime ;         //炭黑回收时间
        [DataMember(Name = "OverTemp_MinTime", IsRequired = false, Order = 12)]
        public int OverTemp_MinTime ;          //超温最短时间
        [DataMember(Name = "OverTime_Time", IsRequired = false, Order = 13)]
        public int OverTime_Time ;          //超时排胶时间
        [DataMember(Name = "OverTemp_Temp", IsRequired = false, Order = 14)]
        public int OverTemp_Temp ;          //紧急排胶时间
        [DataMember(Name = "Max_InPloyTemp", IsRequired = false, Order = 15)]
        public int Max_InPloyTemp ;         //最高进胶温度
        [DataMember(Name = "Min_InPloyTemp", IsRequired = false, Order = 12)]
        public int Min_InPloyTemp ;          //最低进胶温度
        [DataMember(Name = "MakeUp_Temp", IsRequired = false, Order = 13)]
        public int MakeUp_Temp ;          //补偿温度
        [DataMember(Name = "Is_UseAreaTemp", IsRequired = false, Order = 14)]
        public string Is_UseAreaTemp = "";          //是否使用三区温度
        [DataMember(Name = "Side_Temp", IsRequired = false, Order = 15)]
        public int Side_Temp ;         //侧壁温度
        [DataMember(Name = "Roll_Temp", IsRequired = false, Order = 15)]
        public int Roll_Temp ;         //转子温度
        [DataMember(Name = "Ddoor_Temp", IsRequired = false, Order = 15)]
        public int Ddoor_Temp ;         //卸料门温度
        [DataMember(Name = "Dischangetime", IsRequired = false, Order = 15)]
        public int Dischangetime ;         //加硫限制
        [DataMember(Name = "Edt_Code", IsRequired = false, Order = 5)]
        public int Edt_Code ;          //配方替代号
        [DataMember(Name = "Mater_Name", IsRequired = false, Order = 3)]
        public string Mater_Name = "";          //父物料名称
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

    }

    [DataContract(Name = "Weight", Namespace = Constants.Namespace)]
    public class Weight
    {
        [DataMember(Name = "PlmRecipeWeight", IsRequired = false, Order = 6)]
        public PlmRecipeWeight[] PlmRecipeWeight;
    }

    [DataContract(Name = "PlmRecipeWeight", Namespace = Constants.Namespace)]
    public class PlmRecipeWeight
    {
        [DataMember(Name = "Into_routing", IsRequired = false, Order = 3)]
        public string Into_routing = "";          //投料母胶工艺类型
        [DataMember(Name = "Child_matercode", IsRequired = false, Order = 5)]
        public string Child_matercode = "";         //子物料SAP品号
        [DataMember(Name = "ChildIsMixed", IsRequired = false, Order = 1)]
        public string ChildIsMixed = "";         //是否掺胶
        [DataMember(Name = "ChildPrescriptionStage", IsRequired = false, Order = 2)]
        public string ChildPrescriptionStage = "";          //配方阶段
        [DataMember(Name = "ViscosityStandard", IsRequired = false, Order = 4)]
        public string ViscosityStandard = "";          //子物料粘度标准
        [DataMember(Name = "BC_Version", IsRequired = false, Order = 2)]
        public string BC_Version = "";          //子物料版本
        [DataMember(Name = "Error_Allow", IsRequired = false, Order = 1)]
        public decimal Error_Allow ;         //允许误差
        [DataMember(Name = "Supply_code", IsRequired = false, Order = 3)]
        public string Supply_code = "";          //子物料供应商代码
        [DataMember(Name = "Weight_type", IsRequired = false, Order = 4)]
        public int Weight_type ;          //称量类型
        [DataMember(Name = "Weight_Prop", IsRequired = false, Order = 2)]
        public string Weight_Prop = "";          //小料分类属性
        [DataMember(Name = "Set_weight", IsRequired = false, Order = 3)]
        public decimal Set_weight ;          //设定重量
        [DataMember(Name = "Child_MaterName", IsRequired = false, Order = 1)]
        public string Child_MaterName = "";         //子物料名称
        [DataMember(Name = "Weight_id", IsRequired = false, Order = 5)]
        public int Weight_id ;         //称量序号
        [DataMember(Name = "Into_type", IsRequired = false, Order = 1)]
        public string Into_type = "";          //投入母胶类型
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
    }
    [DataContract(Name = "Mix", Namespace = Constants.Namespace)]
    public class Mix
    {
       
        [DataMember(Name = "PlmRecipeMix", IsRequired = false, Order = 6)]
        public PlmRecipeMix[] PlmRecipeMix;
    }

    [DataContract(Name = "PlmRecipeMix", Namespace = Constants.Namespace)]
    public class PlmRecipeMix
    {
        [DataMember(Name = "OpenEquip_ID", IsRequired = false, Order = 1)]
        public string OpenEquip_ID = "";         //开炼机序号
        [DataMember(Name = "Mix_id", IsRequired = false, Order = 2)]
        public int Mix_id ;          //步序
        [DataMember(Name = "Act_Code", IsRequired = false, Order = 3)]
        public int Act_Code ;          //动作代码
        [DataMember(Name = "Term_Code", IsRequired = false, Order = 4)]
        public int Term_Code ;          //条件代码
        [DataMember(Name = "Set_time", IsRequired = false, Order = 5)]
        public int Set_time ;         //持续时间
        [DataMember(Name = "Set_temp", IsRequired = false, Order = 1)]
        public decimal Set_temp ;         //温度
        [DataMember(Name = "Set_power", IsRequired = false, Order = 2)]
        public decimal Set_power ;          //功率
        [DataMember(Name = "Set_enter", IsRequired = false, Order = 3)]
        public decimal Set_enter ;          //能量
        [DataMember(Name = "Set_Press", IsRequired = false, Order = 4)]
        public decimal Set_Press ;          //压力
        [DataMember(Name = "Set_Rota", IsRequired = false, Order = 5)]
        public decimal Set_Rota ;         //转速
        [DataMember(Name = "CoolSpeed_Mix", IsRequired = false, Order = 1)]
        public decimal CoolSpeed_Mix ;         //冷却鼓速度
        [DataMember(Name = "OpenMixSpeed_Mix", IsRequired = false, Order = 2)]
        public decimal OpenMixSpeed_Mix ;          //开炼机速度
        [DataMember(Name = "Rollor_Mix", IsRequired = false, Order = 3)]
        public decimal Rollor_Mix ;          //辊距
        [DataMember(Name = "WatrTemp_Mix", IsRequired = false, Order = 1)]
        public decimal WatrTemp_Mix ;          //水温
        [DataMember(Name = "RubTemp_Mix", IsRequired = false, Order = 1)]
        public decimal RubTemp_Mix ;         //胶温
        [DataMember(Name = "SpeedDiff_Mix", IsRequired = false, Order = 2)]
        public decimal SpeedDiff_Mix ;          //速差比
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
    }
}
