/************************************************************************************
 *      All contents © copyright MESNAC. All rights reserved
 *      File:
 *				PageResult.cs
 *      Description:
 *				 分页类
 *      Author:
 *				孙本强
 *				SunBQ@MESNAC.COM
 *				HTTP://WWWW.MESNAC.COM
 *      Finish DateTime:
 *				2013年11月14日
 *      History:
 ***********************************************************************************/
using System;
using System.Data;

namespace Mesnac.DbAccess
{
    /// <summary>
    /// 分页类封装分页信息
    /// </summary>
    /// <typeparam name="T"></typeparam>
    [Serializable]
    public class PageResult
    {
        #region 内部属性
        private string _statementId = string.Empty;
        private string _orderString = string.Empty;
        private string _totalFields = string.Empty;
        private object _parameterObject = null;
        private int _pageIndex = 1;
        private int _pageSize = 10;
        private int _recordCount = 0;
        private DataSet _resultDataSet = new DataSet();
        #endregion
        public PageResult()
        {
            this._statementId = string.Empty;
            this._parameterObject = null;
            this._orderString = string.Empty;
            this._totalFields = string.Empty;
            this._pageIndex = 1;
            this._pageSize = 10;
            this._recordCount = 0;
            this._resultDataSet = new DataSet();
        }

        #region Properties
        /// <summary>
        /// 查询语句对象Id
        /// </summary>
        public string StatementId { get { return _statementId; } set { _statementId = value; } }
        /// <summary>
        /// 排序字段
        /// </summary>
        public string OrderString { get { return _orderString; } set { _orderString = value; } }
        /// <summary>
        /// 查询条件类
        /// </summary>
        public object ParameterObject { get { return _parameterObject; } set { _parameterObject = value; } }
        /// <summary>
        /// 当前页的索引
        /// </summary>
        public int PageIndex { get { return _pageIndex; } set { if (value > 1) { _pageIndex = value; } } }
        /// <summary>
        /// 每页记录数
        /// </summary>
        public int PageSize { get { return _pageSize; } set { _pageSize = value; } }
        /// <summary>
        /// 排序字段
        /// </summary>
        public string TotalFields { get { return _totalFields; } set { _totalFields = value; } }
        /// <summary>
        /// 总页数
        /// </summary>
        public int PageCount
        {
            get
            {
                return this._recordCount % this._pageSize == 0 ? this._recordCount / this._pageSize : this._recordCount / this._pageSize + 1;
            }
        }
        /// <summary>
        /// 总记录数
        /// </summary>
        public int RecordCount { get { return _recordCount; } set { _recordCount = value; } }
        /// <summary>
        /// 查询返回值DataSet
        /// </summary>
        public DataSet ResultDataSet { get { return _resultDataSet; } set { _resultDataSet = value; } }
        #endregion
    }
}
