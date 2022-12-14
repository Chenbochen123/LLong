using System;
using System.Collections.Generic;
using System.Text;
using System.Xml;

namespace XMLHandler
{
    public class TXmlConfigHandler
    {
        XmlDocument xmldoc;
        string m_filepath;


        /// <summary>
        /// ���졣��ʼ�������ļ���
        /// </summary>
        /// <param name="filepath"></param>
        public TXmlConfigHandler( string filepath )
        {
            this.m_filepath = filepath;
            xmldoc = new XmlDocument();
            xmldoc.Load( filepath );
        }

        /// <summary>
        /// ��ȡ����ֵ
        /// </summary>
        /// <param name="key"></param>
        /// <returns></returns>
        public string ReadValue( string key )
        {
            try
            {
                if( xmldoc != null )
                {
                    XmlNode node = xmldoc.SelectSingleNode( "//Item[@Key='" + key + "']" );
                    return node.InnerText;
                }
                throw new Exception( "Read system config file error!" );
            }
            catch( Exception ex )
            {
                throw new Exception ("Error009"+ ex.Message );
            }
        }

        /// <summary>
        /// д��������
        /// </summary>
        /// <param name="key"></param>
        /// <param name="value"></param>
        public bool WriteValue( string key , string value )
        {
            try
            {
                if( xmldoc != null )
                {
                    XmlNode node = xmldoc.SelectSingleNode( "//Item[@Key='" + key + "']" );
                    node.InnerText = value;
                    xmldoc.Save( FilePath );
                    return true;
                }
                else
                    return false;
            }
            catch( Exception ex )
            {
                throw ex;
            }
        }

        /// <summary>
        /// 
        /// </summary>
        public string FilePath
        {
            get
            {
                return m_filepath;
            }
        }


    }

}