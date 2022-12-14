using System;
using System.Collections.Generic;
using System.Text;
using System.IO;
using System.Reflection;


namespace Mesnac.Utility.FilePath
{
    /// <summary>
    /// 文件路径
    /// </summary>
    public class FilePathInfo
    {
        /// <summary>
        /// WinCE路径
        /// </summary>
        /// <returns></returns>
        private string getAppPathWinCE()
        {
            string result = string.Empty;
            result = Path.GetDirectoryName(Assembly.GetExecutingAssembly().GetName().CodeBase);
            if (!result.EndsWith("\\"))
            {
                result = result + "\\";
            }
            return result;

        }
        /// <summary>
        /// Win32路径
        /// </summary>
        /// <returns></returns>
        private string getAppPathWin32()
        {
            string result = string.Empty;
            result = System.IO.Path.GetDirectoryName(Assembly.GetExecutingAssembly().ManifestModule.FullyQualifiedName);
            if (!result.EndsWith("\\"))
            {
                result = result + "\\";
            }
            return result;
        }
        /// <summary>
        /// 文件路径
        /// </summary>
        /// <param name="fileName"></param>
        /// <returns></returns>
        private string getFilePath(string fileName)
        {
            if (fileName.IndexOf("\\") >= 0)
            {
                return fileName;
            }
            return this.AppPath + fileName;
        }

        /// <summary>
        /// 应用程序路径
        /// </summary>
        /// <returns></returns>
        public string AppPath
        {
            get
            {
                if (Environment.OSVersion.Platform == PlatformID.WinCE)
                {
                    return getAppPathWinCE();
                }
                else
                {
                    return getAppPathWin32();
                }
            }
        }
        /// <summary>
        /// 文件路径
        /// </summary>
        /// <param name="file"></param>
        /// <returns></returns>
        public string GetFilePath(string file)
        {
            return getFilePath(file);
        }
        /// <summary>
        /// 文件信息
        /// </summary>
        /// <param name="file"></param>
        /// <returns></returns>
        public FileInfo GetFileInfo(string file)
        {
            string path = getFilePath(file);
            return new FileInfo(path);
        }
    }
}
