using System;
using System.Collections.Generic;
using System.Text;

using System.Reflection;
using System.IO;
using System.Configuration;

namespace DataAccess.Config
{
    /// <summary>
    /// �������ڻ�ȡDLL�������ļ�����Ӧ�ó���Ŀ¼�еģ�
    /// </summary>
    class DLLConfig
    {
        /// <summary>
        /// ��ȡ���������ļ�·������Ӧ�ó�������ģ�����������·����
        /// Ӧ�ó���ʹ�ø�DLLʱ����Ҫ��DLL�������ļ�������Ӧ�ó���Ŀ¼��
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
