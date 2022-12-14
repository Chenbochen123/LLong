using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace Mesnac.DbSyn
{
    public class KVSQL : Dictionary<string, object>
    {
        private static int keyIdx = 0;
        private string getTPKey(DbSqlHelper dbHelper,string key)
        {
            if (keyIdx > 999)
            {
                keyIdx = 0;
            }
            keyIdx++;
            var prefix = dbHelper.ParameterPrefix;
            var result = prefix + key + keyIdx.ToString("D3");
            result = result.Replace(".", string.Empty);
            return result;
        }
        public void ToUpdate(DbSqlHelper dbHelper, StringBuilder sqlsb)
        {
            foreach (var kv in this)
            {
                var tfieldName = kv.Key;
                var value = kv.Value;
                var tpkey = getTPKey(dbHelper, tfieldName);
                sqlsb.Append(tfieldName).Append("=").Append(tpkey).AppendLine(",");
                dbHelper.AddParameter(tpkey, value);
            }
            this.Clear();
        }


        public void ToInsert(DbSqlHelper dbHelper,
                            StringBuilder sqlsb_fields,
                            StringBuilder sqlsb_values)
        {
            foreach (var kv in this)
            {
                var tfieldName = kv.Key;
                var value = kv.Value;
                var tpkey = getTPKey(dbHelper, tfieldName);
                sqlsb_fields.Append(tfieldName).AppendLine(",");
                sqlsb_values.Append(tpkey).AppendLine(",");
                dbHelper.AddParameter(tpkey, value);
            }
            this.Clear();
        }


        public void ToWhere(DbSqlHelper dbHelper, StringBuilder sqlsb)
        {
            foreach (var kv in this)
            {
                var tfieldName = kv.Key;
                var value = kv.Value;
                var tpkey = getTPKey(dbHelper, tfieldName);
                if (value == null || value == DBNull.Value || string.IsNullOrWhiteSpace(value.ToString()))
                {

                    sqlsb.Append(" and (").Append(tfieldName).Append(" is null )").AppendLine(string.Empty);
                    continue;
                }
                sqlsb.Append(" and ").Append(tfieldName).Append("=").Append(tpkey).AppendLine(string.Empty);
                dbHelper.AddParameter(tpkey, value);
            }
            dbHelper.CommandText = sqlsb.ToString();
            this.Clear();
        }

        public StringBuilder RemoveLastChar(StringBuilder sb)
        {
            if (sb == null || sb.ToString().Trim().Length == 0)
            {
                sb = new StringBuilder();
                return sb;
            }
            var s = sb.ToString().Trim();
            sb = sb.Remove(s.Length - 1, 1);
            return sb;
        }
    }
}
