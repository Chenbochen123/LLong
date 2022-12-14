/************************************************************************************
 *      All contents © copyright MESNAC. All rights reserved
 *      File:
 *				PlmToleranceParameterMain.cs
 *      Description:
 *		
 *      Author:
 *				曲世峰
 *				QUSF@MESNAC.COM
 *				HTTP://WWWW.MESNAC.COM
 *      Finish DateTime:
 *				2018年04月11日
 *      History:
 ***********************************************************************************/
using System;
using System.Collections.Generic;
using System.Text;

namespace Mesnac.InterfaceBG.Entity.BasicEntity
{
    /// <summary>
    /// PLM_TOLERANCE_PARAMETER_MAIN-实体类
    /// </summary>
    [Serializable]
    public partial class PlmToleranceParameterMain
    {
        #region 公有属性
        /// <summary>
        /// CREATEUSER
        /// </summary>
        public string Createuser { get; set; }
        /// <summary>
        /// MODIFIER
        /// </summary>
        public string Modifier { get; set; }
        /// <summary>
        /// CREATEDATE
        /// </summary>
        public DateTime? Createdate { get; set; }
        /// <summary>
        /// SECTIONS
        /// </summary>
        public string Sections { get; set; }
        /// <summary>
        /// CLASSIFICATION
        /// </summary>
        public string Classification { get; set; }
        /// <summary>
        /// WERKS
        /// </summary>
        public string Werks { get; set; }
        /// <summary>
        /// FACTORY
        /// </summary>
        public string Factory { get; set; }
        /// <summary>
        /// PARMNAME
        /// </summary>
        public string Parmname { get; set; }
        /// <summary>
        /// PARCODE
        /// </summary>
        public string Parcode { get; set; }
        /// <summary>
        /// VALUEMAX
        /// </summary>
        public string Valuemax { get; set; }
        /// <summary>
        /// VALUEMIN
        /// </summary>
        public string Valuemin { get; set; }
        /// <summary>
        /// VALUEMAXSIGN
        /// </summary>
        public string Valuemaxsign { get; set; }
        /// <summary>
        /// VALUEMINSIGN
        /// </summary>
        public string Valueminsign { get; set; }
        /// <summary>
        /// DUMMY1
        /// </summary>
        public string Dummy1 { get; set; }
        /// <summary>
        /// DUMMY2
        /// </summary>
        public string Dummy2 { get; set; }
        /// <summary>
        /// DUMMY3
        /// </summary>
        public string Dummy3 { get; set; }
        /// <summary>
        /// DUMMY4
        /// </summary>
        public string Dummy4 { get; set; }
        /// <summary>
        /// DUMMY5
        /// </summary>
        public string Dummy5 { get; set; }
        /// <summary>
        /// DUMMY6
        /// </summary>
        public string Dummy6 { get; set; }
        /// <summary>
        /// DUMMY7
        /// </summary>
        public string Dummy7 { get; set; }
        /// <summary>
        /// DUMMY8
        /// </summary>
        public string Dummy8 { get; set; }
        /// <summary>
        /// DUMMY9
        /// </summary>
        public string Dummy9 { get; set; }
        /// <summary>
        /// DELETEFLAG
        /// </summary>
        public string Deleteflag { get; set; }
        /// <summary>
        /// PROCESSNAME
        /// </summary>
        public string Processname { get; set; }
        #endregion	
    }
}
