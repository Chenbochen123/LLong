using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using Mesnac.Utility.FileIO;
using Mesnac.Utility.FilePath;

namespace Mesnac.DbSyn.LLERP.Materials
{
    /// <summary>
    /// 可保存 配置文件
    /// </summary>
    [Serializable]
    public class McConfig
    {
        private const string fileName = "Mesnac.DbSyn.LLERP.Materials.xml";
        #region Instance
        private static McConfig _this = null;
        public static McConfig Instance
        {
            get
            {
                if (_this != null)
                {
                    return _this;
                }
                try
                {
                    _this = Read();
                }
                catch
                {
                }
                if (_this == null)
                {
                    _this = new McConfig();
                }
                return _this;
            }
        }
        public McConfig()
        {
        }
        #endregion
        #region 读取、保存
        /// <summary>
        /// 读取
        /// </summary>
        /// <returns></returns>
        private static McConfig Read()
        {
            var serializer = new Serializer<McConfig>();
            return serializer.GetFromXmlFile(Path.Combine(new FilePathInfo().AppPath, fileName));
        }
        /// <summary>
        /// 保存
        /// </summary>
        public void Save()
        {
            var serializer = new Serializer<McConfig>();
            serializer.SaveToXmlFile(this, Path.Combine(new FilePathInfo().AppPath, fileName));
        }
        #endregion
        #region 属性
        /// <summary>
        /// 最后更新日期
        /// </summary>
        public string LastUpDate { get; set; }
        /// <summary>
        /// 最后更新时间
        /// </summary>
        public string LastUpTime { get; set; }
        #endregion

    }
}
