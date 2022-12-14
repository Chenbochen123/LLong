using System;
using System.Collections.Generic;
using System.Reflection;
using System.Xml;


namespace Mesnac.Utility.Xml
{
    /// <summary>
    /// Xml读取解析
    /// </summary>
    /// <typeparam name="T"></typeparam>
    public class XRead<T>
    {
        /// <summary>
        /// 读取操作
        /// </summary>
        private XReader _reader = null;
        /// <summary>
        /// 符合类T的XmlNode列表
        /// </summary>
        private List<XmlNode> TNodeList = new List<XmlNode>();

        #region Xml 节点操作
        /// <summary>
        /// 判断字符串相等，不区分大小写
        /// </summary>
        /// <param name="a"></param>
        /// <param name="b"></param>
        /// <returns></returns>
        private bool stringIsEqual(string a, string b)
        {
            if (a == null || b == null)
            {
                if (a == null && b == null)
                {
                    return true;
                }
                return false;
            }
            return a.Equals(b, StringComparison.CurrentCultureIgnoreCase);
        }
        /// <summary>
        /// 判断节点是否为当前类
        /// </summary>
        /// <param name="node"></param>
        /// <returns></returns>
        private bool isClassTXmlNode(XmlNode node)
        {
            string nodeName = _reader.TRename.Trim();
            if (nodeName.Contains("\\"))
            {
                string[] names = nodeName.Split('\\');
                XmlNode thisNode = node;
                bool result = true;
                for (int i = names.Length; i > 0; i--)
                {
                    string thisName = names[i - 1];
                    result = (stringIsEqual(thisNode.Name, thisName));
                    if (!result)
                    {
                        return result;
                    }
                    thisNode = thisNode.ParentNode;
                }
                return result;
            }
            else
            {
                return (stringIsEqual(node.Name, nodeName));
            }
        }
        /// <summary>
        /// 获取类T的XmlNode列表
        /// </summary>
        /// <param name="parNode"></param>
        private void getClassTNode(XmlNode parNode)
        {
            if (isClassTXmlNode(parNode))
            {
                TNodeList.Add(parNode);
            }
            if (TNodeList.Count > 0)
            {
                return;
            }
            foreach (XmlNode node in parNode.ChildNodes)
            {
                getClassTNode(node);
            }
        }
        #endregion

        #region 类属性解析赋值
        /// <summary>
        /// 数据类型转化
        /// </summary>
        /// <param name="value"></param>
        /// <param name="type"></param>
        /// <returns></returns>
        private object changeType(object value, Type type)
        {
            if (value == null && type.IsGenericType) return Activator.CreateInstance(type);
            if (value == null) return null;
            if (type == value.GetType()) return value;
            if (type.IsEnum)
            {
                if (value is string)
                    return Enum.Parse(type, value as string);
                else
                    return Enum.ToObject(type, Convert.ToInt32(value));
            }
            if (!type.IsInterface && type.IsGenericType)
            {
                Type innerType = type.GetGenericArguments()[0];
                object innerValue = changeType(value, innerType);
                return Activator.CreateInstance(type, new object[] { innerValue });
            }
            if (value is string && type == typeof(Guid)) return new Guid(value as string);
            if (value is string && type == typeof(Version)) return new Version(value as string);
            if (!(value is IConvertible)) return value;
            return Convert.ChangeType(value, type);
        }
        /// <summary>
        /// 是否为基本类型或字符串
        /// </summary>
        /// <param name="type"></param>
        /// <returns></returns>
        private bool TypeIsPrimitive(Type type)
        {
            return type.IsPrimitive || type == typeof(String);
        }
        /// <summary>
        /// 是否为基本类型或字符串
        /// </summary>
        /// <param name="type"></param>
        /// <returns></returns>
        private object getPrimitiveTypeValue(string value, Type type)
        {
            object result = null;
            if (value == null)
            {
                if (type == typeof(String))
                {
                    result = string.Empty;
                }
            }
            else
            {
                result = changeType(value, type);
            }
            return result;
        }
        /// <summary>
        /// 设定属性值
        /// </summary>
        /// <param name="obj"></param>
        /// <param name="pi"></param>
        /// <param name="value"></param>
        private void setValue(ref object obj, PropertyInfo pi, string value)
        {
            try
            {
                Type type = typeof(T);
                if (TypeIsPrimitive(type))
                {
                    obj = getPrimitiveTypeValue(value, type);
                    return;
                }
                object setvalue = changeType(value, pi.PropertyType);
                if (setvalue != null)
                {
                    pi.SetValue(obj, setvalue, null);
                }
            }
            catch { }
        }
        private bool setValue(ref object obj, XmlAttribute attribute, PropertyInfo pi)
        {
            string value = attribute.Value;
            if ((typeof(T) == typeof(String))
                || (stringIsEqual(attribute.Name, pi.Name)))
            {
                setValue(ref obj, pi, value);
                return true;
            }
            return false;
        }
        private bool setValue(ref object obj, XmlNode piNode, PropertyInfo pi)
        {
            if (piNode.HasChildNodes)
            {
                if ((typeof(T) == typeof(String))
                    || (stringIsEqual(piNode.Name, pi.Name)))
                {
                    string value = piNode.FirstChild.Value;
                    if (value!=null)
                    {
                        value = value.Trim();
                    }
                    setValue(ref obj, pi, value);
                    return true;
                }
            }
            else
            {
                if (piNode.Attributes==null)
                {
                    if ((pi.Name.ToLower() == "value") 
                        && (pi.PropertyType == typeof(string)))
                    {
                        string value = piNode.Value;
                        if (value != null)
                        {
                            value = value.Trim();
                            setValue(ref obj, pi, value);
                            return true;
                        }
                    }
                    return false;
                }
                foreach (XmlAttribute attribute in piNode.Attributes)
                {
                    if (stringIsEqual(attribute.Name, "value"))
                    {
                        if ((typeof(T) == typeof(String))
                            || (stringIsEqual(piNode.Name, pi.Name)))
                        {
                            string value = attribute.Value;
                            setValue(ref obj, pi, value);
                            return true;
                        }
                    }
                }
            }
            return false;
        }


        /// <summary>
        /// 序列化类T
        /// </summary>
        /// <param name="node"></param>
        /// <returns></returns>
        private T DeserializeT(XmlNode node)
        {
            Type type = typeof(T);
            object result = default(T);
            if (!TypeIsPrimitive(type))
            {
                result = (T)type.Assembly.CreateInstance(type.FullName);
            }
            if (isClassTXmlNode(node))
            {
                foreach (PropertyInfo pi in type.GetProperties())
                {
                    bool HasPiValue = false;
                    #region 基本类属性赋值
                    #region 通过  XmlAttribute  初始化值
                    foreach (XmlAttribute attribute in node.Attributes)
                    {
                        if (setValue(ref result, attribute, pi))
                        {
                            HasPiValue = true;
                            break;
                        }
                    }
                    if (HasPiValue)
                    {
                        continue;
                    }
                    #endregion

                    #region 通过 XmlNode 初始化值
                    foreach (XmlNode piNode in node.ChildNodes)
                    {
                        if (setValue(ref result, piNode, pi))
                        {
                            HasPiValue = true;
                            break;
                        }
                    }
                    if (HasPiValue)
                    {
                        continue;
                    }
                    #endregion
                    #endregion
                }
            }
            return (T)result;
        }
        #endregion

        #region 解析 Read
        /// <summary>
        /// 序列化类型T的Xml列表
        /// </summary>
        /// <param name="parNode"></param>
        /// <returns></returns>
        public List<XTarget<T>> Read(XReader reader)
        {
            this._reader = reader;
            List<XTarget<T>> result = new List<XTarget<T>>();
            foreach (XmlNode node in reader.Node.ChildNodes)
            {
                getClassTNode(node);
            }
            foreach (XmlNode node in TNodeList)
            {
                T t = DeserializeT(node);
                if (t != null)
                {
                    XTarget<T> targer = new XTarget<T>();
                    targer.Instance = t;
                    targer.Node = node;
                    targer.Reader = reader;
                    result.Add(targer);
                }
            }
            return result;
        }
        #endregion

    }


    /// <summary>
    /// Xml读取结果
    /// </summary>
    /// <typeparam name="T"></typeparam>
    public class XTarget<T>
    {
        /// <summary>
        /// Xml映射实体类
        /// </summary>
        public T Instance { get; set; }
        /// <summary>
        /// Xml节点
        /// </summary>
        public XmlNode Node { get; set; }
        /// <summary>
        /// Xml读取参数
        /// </summary>
        public XReader Reader { get; set; }
    }
    /// <summary>
    /// Xml读取参数
    /// </summary>
    public class XReader
    {
        /// <summary>
        /// Xml读取文件名
        /// </summary>
        public string XmlFile { get; set; }
        /// <summary>
        /// Xml读取节点
        /// </summary>
        public XmlNode Node { get; set; }
        /// <summary>
        /// Xml映射实体类别名
        /// </summary>
        public string TRename { get; set; }
    }
}
