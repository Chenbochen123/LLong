using System;
using System.Collections.Generic;
using System.Text;

namespace Utility
{
    public class CommonUtility
    {
        /// <summary>
        /// 公司通用加解密算法
        /// </summary>
        /// <param name="src">加解密字符串</param>
        /// <param name="key">密钥</param>
        /// <param name="Encrypt">bool类型，1为加密，否则为解密</param>
        /// <returns></returns>
        public static string EncryptionEngine(string src, string key, Boolean Encrypt)
        {
            int KeyLen;
            int KeyPos;
            int offset;
            string dest;
            int SrcPos;
            int SrcAsc;
            int TmpSrcAsc;
            int Range;

            KeyLen = key.Length;
            if (KeyLen == 0)
            {
                key = "Mesnac";
            }
            KeyPos = 0;
            SrcPos = 0;
            SrcAsc = 0;
            Range = 256;
            if (Encrypt)   //加密
            {
                //System.Random r = new Random(Range);
                //offset = r.Next(Range);
                System.Random r = new Random();
                offset = r.Next() % 256 + 1;
                dest = string.Format("{0:X}", offset);
                if (dest.Length == 1)
                {
                    dest = "0" + dest;
                }
                for (SrcPos = 0; SrcPos < src.Length; SrcPos++)
                {
                    SrcAsc = ((int)src[SrcPos] + offset) % 255;
                    if (KeyPos < KeyLen)
                    {
                        KeyPos = KeyPos + 1;
                    }
                    else { KeyPos = 0; }

                    SrcAsc = SrcAsc ^ (int)key[KeyPos]; //异或

                    string tempSrcAsc = string.Format("{0:X}", SrcAsc);
                    if (tempSrcAsc.Length == 1)
                    {
                        tempSrcAsc = "0" + tempSrcAsc;
                    }
                    dest = dest + tempSrcAsc;
                    offset = SrcAsc;
                }

                return dest;

            }
            else   //解密
            {
                if (src.Length <= 2)
                {
                    return "";
                }
                dest = "";
                //offset = (int)("0x" + src.Substring(1, 2));
                offset = Convert.ToInt32(src.Substring(0, 2), 16);
                SrcPos = 2;
                while (SrcPos < src.Length)
                {
                    SrcAsc = Convert.ToInt32(src.Substring(SrcPos, 2), 16);
                    if (KeyPos < KeyLen)
                    {
                        KeyPos = KeyPos + 1;
                    }
                    else { KeyPos = 0; }

                    TmpSrcAsc = SrcAsc ^ (int)key[KeyPos]; //异或
                    if (TmpSrcAsc <= offset)
                    {
                        TmpSrcAsc = 255 + TmpSrcAsc - offset;
                    }
                    else
                    {
                        TmpSrcAsc = TmpSrcAsc - offset;
                    }
                    dest = dest + (char)TmpSrcAsc;
                    offset = SrcAsc;
                    SrcPos = SrcPos + 2;

                }
            }

            return dest;
        }

    }
}
