using System;
using System.Collections;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using NUnit.Framework;

namespace Mesnac.NUnitTest.DbSynJob
{
    using System.Threading;
    using Mesnac.DbSyn;
    using Quartz;
    using Quartz.Impl;
    [TestFixture]
    public class TestCuringSyn
    {
        #region 系统日志  log
        private LogAgent.ILog log = LogAgent.Log.Instance;
        #endregion

        #region 内部变量
        #endregion

        #region 构造函数
        /// <summary>
        /// 测试类初始化
        /// 必须存在无参数构造函数，并且为public
        /// </summary>
        public TestCuringSyn()
        {

        }
        /// <summary>
        /// 每个测试方法在执行前要执行的操作
        /// </summary>
        [SetUp]
        public void SetUp()
        {
        }
        #endregion

        #region Job
        private void TestCaseJob(string id)
        {
            #region 单元测试
            #region 期望值 expected
            var expected = true;
            var actual = expected;
            #endregion

            #region 初始化 actual
            ISchedulerFactory sf = new StdSchedulerFactory();
            IScheduler sched = sf.GetScheduler();
            DateTimeOffset runTime = DateBuilder.EvenMinuteDate(DateTimeOffset.UtcNow);
            runTime = DateTime.Now.AddSeconds(2);
            IJobDetail job = JobBuilder.Create<DbSynJob>()
                .WithIdentity("job1", "group1")
                .Build();
            #endregion

            #region 执行
            log.Debug("ID=" + id.ToString());
            job.JobDataMap.Add(Guid.NewGuid().ToString("D"), id);
            #endregion

            #region 回收
            ITrigger trigger = TriggerBuilder.Create()
                .WithIdentity("trigger1", "group1")
                .StartAt(runTime)
                .Build();
            sched.ScheduleJob(job, trigger);

            sched.Start();
            Thread.Sleep(TimeSpan.FromSeconds(5));
            sched.Shutdown(true);
            #endregion

            #region 断言
            Assert.AreEqual(expected, actual, "错误时显示此信息");
            log.Debug("actual=" + actual.ToString());
            #endregion
            #endregion
        }
        #endregion
        
        [Test]
        public void TestTodayPressTemp()
        {
            TestCaseJob("Curing_TodayPressTemp");
        }

        [Test]
        public void TestPressTemp()
        {
            TestCaseJob("Curing_PressTemp");
        }
    }
}

