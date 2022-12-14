using System;
using System.Collections.Generic;
using System.Text;
using System.IO;
using System.Reflection;
using System.Runtime.Serialization;
using System.Runtime.Serialization.Formatters.Binary;
using System.Data;
using System.Xml.Serialization;

namespace Mesnac.Utility.FileIO
{
    public class Serializer<T>
    {
        #region 对象序列化
        /// <summary>
        /// 把对象序列化到指定的文件中
        /// </summary>
        /// <param name="obj">要序列化的对象</param>
        /// <param name="file">要保存序列化数据的文件</param>
        public void SaveToXmlFile(T obj, string file)
        {
            XmlSerializer fmt = new XmlSerializer(typeof(T));
            FileStream fs = new FileStream(file, FileMode.Create);
            fmt.Serialize(fs, obj);
            fs.Close();
        }
        /// <summary>
        /// 从指定的文件中反序列化对象
        /// </summary>
        /// <param name="file">要从此文件中反序列化数据</param>
        /// <returns>返回反序列化的对象</returns>
        public T GetFromXmlFile(string file)
        {
            FileInfo fi = new FileInfo(file);
            if (!fi.Exists)
            {
                return default(T);
            }
            XmlSerializer fmt = new XmlSerializer(typeof(T));
            FileStream fs = new FileStream(file, FileMode.Open);
            T obj = (T)fmt.Deserialize(fs);
            fs.Close();
            return obj;
        }
        #endregion
        #region 对象序列化
        /// <summary>
        /// 把对象序列化到指定的文件中
        /// </summary>
        /// <param name="obj">要序列化的对象</param>
        /// <param name="file">要保存序列化数据的文件</param>
        public void SaveToBinFile(T obj, string file)
        {
            BinaryFormatter fmt = new BinaryFormatter();
            FileStream fs = new FileStream(file, FileMode.Create);
            fmt.Serialize(fs, obj);
            fs.Close();
        }
        /// <summary>
        /// 从指定的文件中反序列化对象
        /// </summary>
        /// <param name="file">要从此文件中反序列化数据</param>
        /// <returns>返回反序列化的对象</returns>
        public T GetFromBinFile(string file)
        {
            BinaryFormatter fmt = new BinaryFormatter();
            FileStream fs = new FileStream(file, FileMode.Open);
            T obj = (T)fmt.Deserialize(fs);
            fs.Close();
            return obj;
        }
        #endregion

    }
}