using System;
using System.Collections.Generic;
using System.Xml;

namespace Mesnac.Utility.Xml
{
    public class XHelper<T>
    {
        #region 反序列化 Deserialize
        /// <summary>
        /// 提取 Mapper 中的实例
        /// </summary>
        /// <param name="xmlFile"></param>
        /// <returns></returns>
        private List<T> getInstanceOfTarget(List<XTarget<T>> lst)
        {
            List<T> result = new List<T>();
            foreach (XTarget<T> mapper in lst)
            {
                result.Add(mapper.Instance);
            }
            return result;
        }
        /// <summary>
        /// 将Xml文件反序列化为类
        /// </summary>
        /// <param name="xmlFile"></param>
        /// <returns></returns>
        public List<XTarget<T>> DeserializeToTargets(XReader reader)
        {
            var result = new List<XTarget<T>>();
            try
            {
                if (reader.Node == null && (!string.IsNullOrWhiteSpace(reader.XmlFile)))
                {
                    XmlDocument doc = new XmlDocument();
                    doc.Load(reader.XmlFile);
                    reader.Node = doc;
                }
                if (string.IsNullOrWhiteSpace(reader.TRename))
                {
                    reader.TRename = typeof(T).Name;
                }
                result =  new XRead<T>().Read(reader);
            }
            catch
            {
            }
            return result;
        }

        /// <summary>
        /// 提取 Mapper 中的实例
        /// </summary>
        /// <param name="xmlFile"></param>
        /// <returns></returns>
        public List<T> DeserializeToInstances(XReader reader)
        {
            return getInstanceOfTarget(DeserializeToTargets(reader));
        }
        #endregion
    }
}
