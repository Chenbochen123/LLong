using System;
using System.Collections.Generic;
using System.Data;

namespace Mesnac.DbSyn
{
    #region TableInfo
    /// <summary>
    /// 唯一键
    /// </summary>
    public class Unique
    {
        public Unique()
        {
            this.FieldList = new string[0];
        }
        private string _field = string.Empty;
        private void Ini()
        {
            if (!string.IsNullOrWhiteSpace(_field))
            {
                this.FieldList = _field.Split(',');
            }
        }
        /// <summary>
        /// 字段列表
        /// </summary>
        public string Fields
        {
            get
            {
                return _field;
            }
            set
            {
                this._field = value;
                Ini();
            }
        }
        /// <summary>
        /// 字段列表
        /// </summary>
        public string[] FieldList { get; set; }
    }
    /// <summary>
    /// 字段 序列
    /// </summary>
    public class SeqField
    {
        /// <summary>
        /// 主键名称
        /// </summary>
        public string FieldName { get; set; }
        /// <summary>
        /// 序列名称
        /// </summary>
        public string SeqName { get; set; }
    }
    /// <summary>
    /// 主键
    /// </summary>
    public class Primarykey
    {
        /// <summary>
        /// 主键名称
        /// </summary>
        public string FieldName { get; set; }
        /// <summary>
        /// 是否为自增 非自增取最大值+1
        /// </summary>
        public bool Identity { get; set; }
    }
    /// <summary>
    /// 字段信息
    /// </summary>
    public class FieldInfo
    {
        /// <summary>
        /// 表
        /// </summary>
        public TableInfo Table { get; set; }
        /// <summary>
        /// 字段名称
        /// </summary>
        public string FieldName { get; set; }
        /// <summary>
        /// 字段类型
        /// </summary>
        public DbType DbType { get; set; }
        /// <summary>
        /// 字段长度
        /// </summary>
        public int Length { get; set; }
    }
    /// <summary>
    /// 表信息
    /// </summary>
    public class TableInfo
    {
        #region 构造函数
        public TableInfo()
        {
            this.Uniques = new List<Unique>();
            this.SeqFields = new List<SeqField>();
            this.FieldInfos = new List<FieldInfo>();
        }
        #endregion
        /// <summary>
        /// 名称
        /// </summary>
        public string Name { get; set; }
        /// <summary>
        /// 数据连接名
        /// </summary>
        public string DbSourceName { get; set; }
        /// <summary>
        /// 表名
        /// </summary>
        public string TableName { get; set; }
        /// <summary>
        /// 主键
        /// </summary>
        public Primarykey Primarykey { get; set; }
        /// <summary>
        /// 外键
        /// </summary>
        public string Foreignkey { get; set; }
        /// <summary>
        /// 唯一键
        /// </summary>
        public List<Unique> Uniques { get; set; }
        /// <summary>
        /// 字段 序列
        /// </summary>
        public List<SeqField> SeqFields { get; set; }
        /// <summary>
        /// 字段名
        /// </summary>
        public List<FieldInfo> FieldInfos { get; set; }
    }
    #endregion

    #region SynTable
    /// <summary>
    /// 字段对应关系
    /// </summary>
    public class SourceTargetField
    {
        /// <summary>
        /// 目标表
        /// </summary>
        public SynInfo TargetTable { get; set; }
        /// <summary>
        /// 原始字段 名称
        /// </summary>
        public string SourceFieldName { get; set; }
        /// <summary>
        /// 原始字段 名称
        /// </summary>
        public string SourceValue { get; set; }
        /// <summary>
        /// 原始字段
        /// </summary>
        public FieldInfo SourceField { get; set; }
        /// <summary>
        /// 目标字段 名称
        /// </summary>
        public string TargetFieldName { get; set; }
        /// <summary>
        /// 目标字段
        /// </summary>
        public FieldInfo TargetField { get; set; }
    }
    /// <summary>
    /// 同步数据
    /// </summary>
    public class SynData
    {
        #region 构造函数
        public SynData()
        {

        }
        #endregion
        /// <summary>
        /// 标示 名称
        /// </summary>
        public string Name { get; set; }
        /// <summary>
        /// 每次同步次数
        /// </summary>
        public int Count { get; set; }
        /// <summary>
        /// 同步 源信息
        /// </summary>
        public SynInfo Source { get; set; }
        /// <summary>
        /// 同步 目标信息
        /// </summary>
        public SynInfo Target { get; set; }
        /// <summary>
        /// 字段对应关系
        /// </summary>
        public List<SourceTargetField> Fields { get; set; }
    }
    /// <summary>
    /// 配置键值对
    /// </summary>
    public class KeyValue
    {
        /// <summary>
        /// 键
        /// </summary>
        public string Key { get; set; }
        /// <summary>
        /// 值
        /// </summary>
        public string Value { get; set; }
    }
    /// <summary>
    /// 命令行信息
    /// </summary>
    public class CommandInfo
    {
        /// <summary>
        /// 文件名
        /// </summary>
        public string FileName { get; set; }
        /// <summary>
        /// 类名
        /// </summary>
        public string ClassName { get; set; }
        /// <summary>
        /// 类
        /// </summary>
        public Type ClassType { get; set; }
    }
    /// <summary>
    /// 同步信息
    /// </summary>
    public class SynInfo
    {
        #region 构造函数
        public SynInfo()
        {
            this.BeginSyn = new List<KeyValue>();
            this.SelectData = new List<KeyValue>();
            this.VerifyRow = new List<KeyValue>();
            this.PKValue = new List<KeyValue>();
            this.ExcuteRowSyn = new List<KeyValue>();
            this.FinishRowSyn = new List<KeyValue>();
            this.FinishSyn = new List<KeyValue>();
        }
        #endregion
        /// <summary>
        /// 表名
        /// </summary>
        public string TableName { get; set; }
        /// <summary>
        /// 同步数据
        /// </summary>
        public SynData SynData { get; set; }
        /// <summary>
        /// 表信息
        /// </summary>
        public TableInfo TableInfo { get; set; }
        /// <summary>
        /// 命令信息
        /// </summary>
        public CommandInfo Command { get; set; }
        /// <summary>
        /// 开始同步 参数
        /// </summary>
        public List<KeyValue> BeginSyn { get; set; }
        /// <summary>
        /// 查询数据 参数
        /// </summary>
        public List<KeyValue> SelectData { get; set; }
        /// <summary>
        /// 校验数据 参数
        /// </summary>
        public List<KeyValue> VerifyRow { get; set; }
        /// <summary>
        /// 获取主键 参数
        /// </summary>
        public List<KeyValue> PKValue { get; set; }
        /// <summary>
        /// 执行同步 参数
        /// </summary>
        public List<KeyValue> ExcuteRowSyn { get; set; }
        /// <summary>
        /// 单条执行完成 参数
        /// </summary>
        public List<KeyValue> FinishRowSyn { get; set; }
        /// <summary>
        /// 批量执行完成 参数
        /// </summary>
        public List<KeyValue> FinishSyn { get; set; }
    }
    #endregion

    /// <summary>
    /// 同步信息
    /// </summary>
    public class McSyn
    {
        public McSyn()
        {
            this.Tables = new List<TableInfo>();
            this.SynTables = new List<SynData>();
        }
        /// <summary>
        /// 名称
        /// </summary>
        public string Name { get; set; }
        /// <summary>
        /// 参数
        /// </summary>
        public string Param { get; set; }
        /// <summary>
        /// 表信息
        /// </summary>
        public List<TableInfo> Tables { get; set; }
        /// <summary>
        /// 同步信息
        /// </summary>
        public List<SynData> SynTables { get; set; }
    }
}
