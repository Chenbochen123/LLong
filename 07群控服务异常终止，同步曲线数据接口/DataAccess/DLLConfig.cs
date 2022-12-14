using System;
using System.Collections.Generic;
using System.Text;

using System.Reflection;
using System.IO;
using System.Configuration;

namespace DataAccess.Config
{
    /// <summary>
    /// 该类用于获取DLL的配置文件（在应用程序目录中的）
    /// </summary>
    class DLLConfig
    {
        /// <summary>
        /// 获取类库的配置文件路径（在应用程序下面的，不是类库输出路径）
        /// 应用程序使用该DLL时，需要将DLL的配置文件拷贝到应用程序目录。
        /// </summary>
        private static string DllConfigFilePath
        {
            get
            {
                Assembly t_assembly = Assembly.GetCallingAssembly();
                Uri t_uri = new Uri(Path.GetDirectoryName(t_assembly.CodeBase));
                return Path.Combine(t_uri.LocalPath, t_assembly.GetName().Name + ".dll.config");
            }
        }

        public static Configuration CurrentDllConfiguration
        {
            get
            {
                ExeConfigurationFileMap configFile = new ExeConfigurationFileMap();
                configFile.ExeConfigFilename = DllConfigFilePath;
                return ConfigurationManager.OpenMappedExeConfiguration(configFile, ConfigurationUserLevel.None);
            }
        }

    }
}
