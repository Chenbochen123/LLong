/************************************************************************************
 *      All contents © copyright MESNAC. All rights reserved
 *      File:
 *				IBaseService.cs
 *      Description:
 *				 数据访问基础接口
 *      Author:
 *				孙本强
 *				SunBQ@MESNAC.COM
 *				HTTP://WWWW.MESNAC.COM
 *      Finish DateTime:
 *				2013年11月14日
 *      History:
 ***********************************************************************************/
using System.Collections.Generic;
using System.Data;

namespace Mesnac.DbAccess
{
    public interface IBaseManager<T> : IBaseService<T> where T : new()
    {

    }
}
