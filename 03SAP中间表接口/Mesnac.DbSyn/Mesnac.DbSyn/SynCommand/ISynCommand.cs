using System;
using System.Collections.Generic;
using System.Data;
using Mesnac.DbSyn.Business.Implements;
namespace Mesnac.DbSyn
{
    /// <summary>
    /// 同步命令接口
    /// </summary>
    public interface ISynCommand
    {
        /// <summary>
        /// 开始同步
        /// </summary>
        /// <param name="dbSyn"></param>
        /// <returns></returns>
        int BeginSyn(DbSynResult dbSyn);
        /// <summary>
        /// 获取主键
        /// </summary>
        /// <param name="dbSyn"></param>
        /// <returns></returns>
        string PKValue(DbSynResult dbSyn);
        /// <summary>
        /// 校验数据
        /// </summary>
        /// <param name="dbSyn"></param>
        /// <returns></returns>
        int VerifyRow(DbSynResult dbSyn);
        /// <summary>
        /// 执行同步
        /// </summary>
        /// <param name="dbSyn"></param>
        /// <returns></returns>
        int ExcuteRowSyn(DbSynResult dbSyn);
        /// <summary>
        /// 单条执行完成
        /// </summary>
        /// <param name="dbSyn"></param>
        /// <returns></returns>
        int FinishRowSyn(DbSynResult dbSyn);
        /// <summary>
        /// 批量执行完成
        /// </summary>
        /// <param name="dbSyn"></param>
        /// <returns></returns>
        int FinishSyn(DbSynResult dbSyn);
    }
    /// <summary>
    /// 源数据 命令接口
    /// </summary>
    public interface ISynSourceCommand : ISynCommand
    {
        /// <summary>
        /// 查询数据
        /// </summary>
        /// <param name="dbSyn"></param>
        /// <returns></returns>
        DataTable SelectData(DbSynResult dbSyn);
    }
    /// <summary>
    /// 目标数据 命令接口
    /// </summary>
    public interface ISynTargetCommand : ISynCommand
    {
    }
    /// <summary>
    /// 数据同步 结果
    /// </summary>
    public class DbSynResult
    {
        public DbSynResult(SynData synTable)
        {
            this.SynTable = synTable;
            this.Source = new DbSynCommandResult();
            this.Target = new DbSynCommandResult();
        }
        /// <summary>
        /// 数据同步配置
        /// </summary>
        public SynData SynTable { get; private set; }
        /// <summary>
        ///  源  数据同步 结果
        /// </summary>
        public DbSynCommandResult Source { get; private set; }
        /// <summary>
        /// 目标 数据同步 结果
        /// </summary>
        public DbSynCommandResult Target { get; private set; }
    }
    /// <summary>
    /// 数据同步 结果
    /// </summary>
    public class DbSynCommandResult
    {
        public DbSynCommandResult()
        {
            this.RowResults = new List<DbSynCommandRowResult>();
        }

        /// <summary>
        /// 开始同步 结果
        /// </summary>
        public int BeginSyn { get; set; }
        /// <summary>
        /// 查询数据 结果
        /// </summary>
        public DataTable SelectData { get; set; }

        #region 行结果
        /// <summary>
        /// 当前行结果
        /// </summary>
        public DbSynCommandRowResult CurrentRow { get; private set; }
        /// <summary>
        /// 所有行结果
        /// </summary>
        public List<DbSynCommandRowResult> RowResults { get; set; }
        /// <summary>
        /// 添加行结果
        /// </summary>
        public void NewRowResult(DataRow row)
        {
            var rowResult = new DbSynCommandRowResult();
            this.CurrentRow = rowResult;
            this.CurrentRow.DataRow = row;
            this.RowResults.Add(rowResult);
        }
        #endregion
        /// <summary>
        /// 批量执行完成 结果
        /// </summary>
        public int FinishSyn { get; set; }
    }
    /// <summary>
    /// 行数据同步 结果
    /// </summary>
    public class DbSynCommandRowResult
    {
        /// <summary>
        /// 行数据
        /// </summary>
        public DataRow DataRow { get; set; }
        /// <summary>
        /// 校验数据 结果
        /// </summary>
        public int VerifyRow { get; set; }
        /// <summary>
        /// 获取主键 结果
        /// </summary>
        public string PKValue { get; set; }
        /// <summary>
        /// 执行同步 结果
        /// </summary>
        public int ExcuteRowSyn { get; set; }
        /// <summary>
        /// 单条执行完成 结果
        /// </summary>
        public int FinishRowSyn { get; set; }
    }

    /// <summary>
    /// 命令接口 工厂
    /// </summary>
    public class DbSynCommandFactory
    {
        #region 系统日志  log
       private LogAgent.ILog log = LogAgent.Log.Instance;
        #endregion

        #region 单例实现
        private DbSynCommandFactory()
        {
        }
        private static DbSynCommandFactory _instance = null;
        public static DbSynCommandFactory Instance
        {
            get
            {
                if (_instance == null)
                {
                    lock (typeof(DbSynCommandFactory))
                    {
                        if (_instance == null)//double-check
                        {
                            _instance = new DbSynCommandFactory();
                        }
                    }
                }
                return _instance;
            }
        }
        #endregion


        private bool typeCodeBaseEqual(Type a, Type b)
        {
            return ((a.Assembly.CodeBase.ToLower() == b.Assembly.CodeBase.ToLower())
                && (a.FullName.ToLower() == b.FullName.ToLower()));
        }
        /// <summary>
        /// 源数据 命令接口
        /// </summary>
        /// <param name="synTable"></param>
        /// <returns></returns>
        public ISynSourceCommand GetSynSourceCommand(SynData synTable)
        {
            var command = synTable.Source.Command;
            ISynSourceCommand result = null;
            if (command != null && command.ClassType != null)
            {
                if (typeCodeBaseEqual(command.ClassType, typeof(TableSyn.Source)))
                {
                    result = new TableSyn.Source();
                }
                else
                {
                    result = (ISynSourceCommand)Activator.CreateInstance(command.ClassType);
                }
            }
            if (result == null && (command == null || string.IsNullOrWhiteSpace(command.FileName)))
            {
                result = new TableSyn.Source();
            }
            return result;
        }
        /// <summary>
        /// 目标数据
        /// </summary>
        /// <param name="synTable"></param>
        /// <returns></returns>
        public ISynTargetCommand GetSynTargetCommand(SynData synTable)
        {
            var command = synTable.Target.Command;
            ISynTargetCommand result = null;
            if (command!=null && command.ClassType != null)
            {
                if (typeCodeBaseEqual(command.ClassType, typeof(TableSyn.Target)))
                {
                    result = new TableSyn.Target();
                }
                else
                {
                    result = (ISynTargetCommand)Activator.CreateInstance(command.ClassType);
                }
            }
            if (result == null && (command==null || string.IsNullOrWhiteSpace(command.FileName)))
            {
                result = new TableSyn.Target();
            }
            return result;
        }

        #region KeyValue 2 Class
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
        /// 通过KeyValue获取类
        /// </summary>
        /// <typeparam name="T"></typeparam>
        /// <param name="kv"></param>
        /// <param name="t"></param>
        public T KV2Class<T>(List<KeyValue> kvs)
        {
            var type = typeof(T);
            var result = default(T);
            foreach (var pi in type.GetProperties())
            {
                if (!pi.CanWrite)
                {
                    continue;
                }
                string piName = pi.Name;
                piName = piName.Trim().ToLower();
                foreach (var kv in kvs)
                {
                    if (kv.Key.Trim().ToLower() != piName)
                    {
                        continue;
                    }
                    object value = changeType(kv.Value, pi.PropertyType);
                    if (value != null)
                    {
                        pi.SetValue(result, value, null);
                    }
                    break;
                }
            }
            return result;
        }
        #endregion
    }
}
