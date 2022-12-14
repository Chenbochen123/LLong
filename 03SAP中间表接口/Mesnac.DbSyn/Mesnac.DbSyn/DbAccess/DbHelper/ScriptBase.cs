/************************************************************************************
 *      All contents © copyright MESNAC. All rights reserved
 *      File:
 *				ScriptBase.cs
 *      Description:
 *				 执行SQL脚本的基础抽象类
 *      Author:
 *				孙本强
 *				SunBQ@MESNAC.COM
 *				HTTP://WWWW.MESNAC.COM
 *      Finish DateTime:
 *				2013年11月13日
 *      History:
 *      
 ***********************************************************************************/
using System.IO;
using MyBatis.Common.Data;
using MyBatis.Common.Resources;
using MyBatis.Common.Utilities;

namespace Mesnac.DbAccess
{
    /// <summary>
    /// 执行SQL脚本的基础抽象类
    /// </summary>
    public abstract class ScriptBase
    {
        //指定SQL脚本目录
        protected string scriptDirectory = Path.Combine(Path.Combine(Path.Combine(Resources.ApplicationBase, ".."), ".."), "Scripts") + Path.DirectorySeparatorChar;

        /// <summary>
        /// 运行SQL批处理
        /// </summary>
        /// <param name="datasource">运行SQL批处理时对应的数据源</param>
        /// <param name="script">SQL批处理脚本</param>
        public void InitScript(IDataSource datasource, string script)
        {
            InitScript(datasource, script, true);
        }

        /// <summary>
        /// 运行SQL批处理
        /// </summary>
        /// <param name="datasource">运行SQL批处理时对应的数据源</param>
        /// <param name="script">SQL批处理脚本</param>
        /// <param name="doParse">是否从SQL脚本文件中解析出语句</param>
        private void InitScript(IDataSource datasource, string script, bool doParse)
        {
            ScriptRunner runner = new ScriptRunner();
            runner.RunScript(datasource, script, doParse);
        }
    }
}
