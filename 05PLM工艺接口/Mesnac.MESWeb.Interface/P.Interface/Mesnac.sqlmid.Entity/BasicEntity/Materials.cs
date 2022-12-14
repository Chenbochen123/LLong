/************************************************************************************
 *      All contents © copyright MESNAC. All rights reserved
 *      File:
 *				Materials.cs
 *      Description:
 *		
 *      Author:
 *				孙本强
 *				SunBQ@MESNAC.COM
 *				HTTP://WWWW.MESNAC.COM
 *      Finish DateTime:
 *				2018年10月22日
 *      History:
 ***********************************************************************************/
using System;
using System.Collections.Generic;
using System.Text;

namespace Mesnac.sqlmid.Entity.BasicEntity
{
    /// <summary>
    /// Materials-实体类
    /// </summary>
    [Serializable]
    public partial class Materials
    {
        #region 公有属性
        /// <summary>
        /// MaterialPure
        /// </summary>
        public string Materialpure { get; set; }
        /// <summary>
        /// MaterialCode
        /// </summary>
        public string Materialcode { get; set; }
        /// <summary>
        /// MaterialDesc
        /// </summary>
        public string Materialdesc { get; set; }
        /// <summary>
        /// MaterialShort
        /// </summary>
        public string Materialshort { get; set; }
        /// <summary>
        /// MatDescFull
        /// </summary>
        public string Matdescfull { get; set; }
        /// <summary>
        /// MaterialDesc_EN
        /// </summary>
        public string MaterialdescEn { get; set; }
        /// <summary>
        /// MatDescFull_EN
        /// </summary>
        public string MatdescfullEn { get; set; }
        /// <summary>
        /// MaterialDesc_TH
        /// </summary>
        public string MaterialdescTh { get; set; }
        /// <summary>
        /// MatDescFull_TH
        /// </summary>
        public string MatdescfullTh { get; set; }
        /// <summary>
        /// MatGrp
        /// </summary>
        public string Matgrp { get; set; }
        /// <summary>
        /// MatTyp
        /// </summary>
        public string Mattyp { get; set; }
        /// <summary>
        /// BaseUnit
        /// </summary>
        public string Baseunit { get; set; }
        /// <summary>
        /// StockUnit
        /// </summary>
        public string Stockunit { get; set; }
        /// <summary>
        /// RateSt2b
        /// </summary>
        public string Ratest2b { get; set; }
        /// <summary>
        /// SalesUnit
        /// </summary>
        public string Salesunit { get; set; }
        /// <summary>
        /// RateSo2b
        /// </summary>
        public string Rateso2b { get; set; }
        /// <summary>
        /// GIssueUnit
        /// </summary>
        public string Gissueunit { get; set; }
        /// <summary>
        /// RateGI2b
        /// </summary>
        public string Rategi2b { get; set; }
        /// <summary>
        /// ProductUnit
        /// </summary>
        public string Productunit { get; set; }
        /// <summary>
        /// RatePp2b
        /// </summary>
        public string Ratepp2b { get; set; }
        /// <summary>
        /// PurchaseUnit
        /// </summary>
        public string Purchaseunit { get; set; }
        /// <summary>
        /// RatePr2b
        /// </summary>
        public string Ratepr2b { get; set; }
        /// <summary>
        /// MaterialSpec
        /// </summary>
        public string Materialspec { get; set; }
        /// <summary>
        /// OverDeliveryRate
        /// </summary>
        public decimal? Overdeliveryrate { get; set; }
        /// <summary>
        /// Status
        /// </summary>
        public string Status { get; set; }
        /// <summary>
        /// StatusZ1
        /// </summary>
        public string Statusz1 { get; set; }
        /// <summary>
        /// LotName
        /// </summary>
        public string Lotname { get; set; }
        /// <summary>
        /// NetHeavy
        /// </summary>
        public decimal? Netheavy { get; set; }
        /// <summary>
        /// MaterialGroup
        /// </summary>
        public string Materialgroup { get; set; }
        /// <summary>
        /// Division
        /// </summary>
        public string Division { get; set; }
        /// <summary>
        /// TPNo
        /// </summary>
        public string Tpno { get; set; }
        /// <summary>
        /// CompanyCode
        /// </summary>
        public string Companycode { get; set; }
        /// <summary>
        /// Plant
        /// </summary>
        public string Plant { get; set; }
        /// <summary>
        /// SubPlant
        /// </summary>
        public string Subplant { get; set; }
        /// <summary>
        /// CTIME
        /// </summary>
        public string Ctime { get; set; }
        /// <summary>
        /// Cdate
        /// </summary>
        public string Cdate { get; set; }
        /// <summary>
        /// Udate
        /// </summary>
        public string Udate { get; set; }
        /// <summary>
        /// UTIME
        /// </summary>
        public string Utime { get; set; }
        /// <summary>
        /// OldMatCode
        /// </summary>
        public string Oldmatcode { get; set; }
        /// <summary>
        /// MatStatus
        /// </summary>
        public string Matstatus { get; set; }
        /// <summary>
        /// Brand
        /// </summary>
        public string Brand { get; set; }
        /// <summary>
        /// CJ
        /// </summary>
        public string Cj { get; set; }
        /// <summary>
        /// THSpec
        /// </summary>
        public string Thspec { get; set; }
        /// <summary>
        /// EXTWG
        /// </summary>
        public string Extwg { get; set; }
        /// <summary>
        /// EWBEZ
        /// </summary>
        public string Ewbez { get; set; }
        /// <summary>
        /// ZBYZ1
        /// </summary>
        public string Zbyz1 { get; set; }
        /// <summary>
        /// ZCS01
        /// </summary>
        public string Zcs01 { get; set; }
        /// <summary>
        /// ZCS02
        /// </summary>
        public string Zcs02 { get; set; }
        /// <summary>
        /// ZCS03
        /// </summary>
        public string Zcs03 { get; set; }
        /// <summary>
        /// ZCS04
        /// </summary>
        public string Zcs04 { get; set; }
        /// <summary>
        /// ZCS05
        /// </summary>
        public string Zcs05 { get; set; }
        /// <summary>
        /// ZCS06
        /// </summary>
        public string Zcs06 { get; set; }
        /// <summary>
        /// ZCS07
        /// </summary>
        public string Zcs07 { get; set; }
        /// <summary>
        /// ZCS08
        /// </summary>
        public string Zcs08 { get; set; }
        /// <summary>
        /// ZCS09
        /// </summary>
        public string Zcs09 { get; set; }
        /// <summary>
        /// ZCS10
        /// </summary>
        public string Zcs10 { get; set; }
        /// <summary>
        /// ZCS11
        /// </summary>
        public string Zcs11 { get; set; }
        /// <summary>
        /// ZCS12
        /// </summary>
        public string Zcs12 { get; set; }
        /// <summary>
        /// LBMC
        /// </summary>
        public string Lbmc { get; set; }
        /// <summary>
        /// SPMC
        /// </summary>
        public string Spmc { get; set; }
        /// <summary>
        /// ZCS13
        /// </summary>
        public string Zcs13 { get; set; }
        /// <summary>
        /// HH
        /// </summary>
        public string Hh { get; set; }
        /// <summary>
        /// HS
        /// </summary>
        public string Hs { get; set; }
        /// <summary>
        /// ZCS15
        /// </summary>
        public string Zcs15 { get; set; }
        /// <summary>
        /// ZCS16
        /// </summary>
        public string Zcs16 { get; set; }
        /// <summary>
        /// ZCS17
        /// </summary>
        public string Zcs17 { get; set; }
        /// <summary>
        /// Dummy1
        /// </summary>
        public string Dummy1 { get; set; }
        /// <summary>
        /// Dummy2
        /// </summary>
        public string Dummy2 { get; set; }
        /// <summary>
        /// Dummy3
        /// </summary>
        public string Dummy3 { get; set; }
        /// <summary>
        /// Dummy4
        /// </summary>
        public string Dummy4 { get; set; }
        /// <summary>
        /// MaterialName
        /// </summary>
        public string Materialname { get; set; }
        /// <summary>
        /// Pattern
        /// </summary>
        public string Pattern { get; set; }
        /// <summary>
        /// ZML3
        /// </summary>
        public string Zml3 { get; set; }
        /// <summary>
        /// ZML4
        /// </summary>
        public string Zml4 { get; set; }
        /// <summary>
        /// ZPOS
        /// </summary>
        public string Zpos { get; set; }
        /// <summary>
        /// ZPEL
        /// </summary>
        public string Zpel { get; set; }
        /// <summary>
        /// ZTIC
        /// </summary>
        public string Ztic { get; set; }
        /// <summary>
        /// ZWBM
        /// </summary>
        public string Zwbm { get; set; }
        /// <summary>
        /// SOBSL
        /// </summary>
        public string Sobsl { get; set; }
        #endregion	
    }
}
