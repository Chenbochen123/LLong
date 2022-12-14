using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.ServiceModel;
using System.ServiceModel.Channels;
using System.Runtime.Serialization;
using System.Data;

namespace MESReceivePLMService
{
    [ServiceContract(Namespace=Constants.Namespace)]
    public interface WSInterface
    {
        [OperationContract]
       // [WebGet(BodyStyle = WebMessageBodyStyle.Bare)]
        string sayHello(string text);

        //  MBOM的创建
        [OperationContract]
        string getMBOMCreateFromPLM(string user, string password, BOMS boms);

         //  MBOM的废弃
        [OperationContract]
        string getMBOMObsoleteFromPLM(string user, string password, ObsoleteBOMs ObsoleteBOMs);

          //  MBOM的有效期更新
        [OperationContract]
        string updateMBOMObsoleteDate(string user, string password, ObsoleteBOMDate ObsoleteBOMDate);

        //半部件工艺参数
        [OperationContract]
        string getHalfPartProcessFromPLM(string user, string password, HalfPartProcesses HalfPartProcesses);

         //成型工艺参数
        [OperationContract]
        string getMoldingProcessFromPLM(string user, string password, MoldingProcesses MoldingProcesses);

          //硫化工艺参数
        [OperationContract]
        string getVulcanizationProcessFromPLM(string user, string password, VulcanizationProcesses VulcanizationProcesses);

           //工艺参数废弃更新
        [OperationContract]
        string getProcessObsoleteFromPLM(string user, string password, ObsoleteProcesses ObsoleteProcesses);
   
        //模具标识图接口
        [OperationContract]
        string getDieDrawingFromPLM(string user, string password, CoverTireDieDrawing CoverTireDieDrawing);

          //设备基础参数
        [OperationContract]
        string getDeviceParameterFromPLM(string user, string password, DeviceParameters DeviceParameters);
    
          //硫化基础参数
        [OperationContract]
        string getVulcanizationParameterFromPLM(string user, string password, VulcanizationParams VulcanizationParams);

        //设备参数列表
        [OperationContract]
        string getDeviceListFromPLM(string user, string password, DeviceList DeviceList);

        //公差接口
        [OperationContract]
        string getMLPtoleranceparameFromPLM(string user, string password, ToleranceParameters ToleranceParameters);
        ////密炼配方接口
        // [OperationContract]
        // string reciveRecipeByPLM(string user, string password, Re Re, Weight Weight, Mix Mix);
    }

}
