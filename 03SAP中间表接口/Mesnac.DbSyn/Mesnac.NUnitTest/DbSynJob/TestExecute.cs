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
    public class TestExecute
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
        public TestExecute()
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

        #region 部门、人员
        [Test]
        public void TestCase_01_HR_ORG()
        {
            TestCaseJob("HR_ORG");
        }
        [Test]
        public void TestCase_0101MesDept()
        {
            TestCaseJob("MesDept");
        }
        [Test]
        public void TestCase_02_HR_PERSON()
        {
            TestCaseJob("HR_PERSON");
        }
        [Test]
        public void TestCase_0201_MesUser()
        {
            TestCaseJob("MesUser");
        }
        [Test]
        public void TestCase_0202_HR_PERSON_NEW()
        {
            TestCaseJob("HR_PERSON_NEW");
        }
        #endregion

        #region 权限
        [Test]
        public void TestCase_0801_PageMenu()
        {
            TestCaseJob("PageMenu");
        }
        [Test]
        public void TestCase_0802_PageAction()
        {
            TestCaseJob("PageAction");
        }
        #endregion

        #region 物料、BOM
        [Test]
        public void TestCase_10_Materials()
        {
            TestCaseJob("Materials");
        }
        [Test]
        public void TestCase_21_PDMMESQ()
        {
            TestCaseJob("PDMMESQ");
        }
        [Test]
        public void TestCase_21_PDMMESASSEM()
        {
            TestCaseJob("PDMMESASSEM");
        }
        [Test]
        public void TestCase_22_SBM_BOM()
        {
            TestCaseJob("SBM_BOM");
        }
        #endregion

        #region 硫化工艺
        [Test]
        public void TestCase_31_CPT_PDM_MES_PARMMAIN()
        {
            TestCaseJob("CPT_PDM_MES_PARMMAIN");
        }
        [Test]
        public void TestCase_32_CPT_PDM_MES_PARMC()
        {
            TestCaseJob("CPT_PDM_MES_PARMC");
        }
        [Test]
        public void TestCase_32_CPT_PDM_MES_PARMB()
        {
            TestCaseJob("CPT_PDM_MES_PARMB");
        }
        [Test]
        public void TestCase_33_CPT_TECH_MAT()
        {
            TestCaseJob("CPT_TECH_MAT");
        }
        [Test]
        public void TestCase_34_CPT_TECH_DATA()
        {
            TestCaseJob("CPT_TECH_DATA");
        }
        #endregion


        #region 成型工艺
        [Test]
        public void TestCase_41_BPT_PDM_MES_PARMMAIN()
        {
            TestCaseJob("BPT_PDM_MES_PARMMAIN");
        }
        [Test]
        public void TestCase_42_BPT_PDM_MES_PARMB()
        {
            TestCaseJob("BPT_PDM_MES_PARMB");
        }
        [Test]
        public void TestCase_43_BPT_TECH_MAT()
        {
            TestCaseJob("BPT_TECH_MAT");
        }
        [Test]
        public void TestCase_44_BPT_TECH_DATA()
        {
            TestCaseJob("BPT_TECH_DATA");
        }
        #endregion

        #region 库存
        [Test]
        public void TestCase_45_SAP_CUSTOMER()
        {
            TestCaseJob("SAPCustomer");
        }
        #endregion
    }
}

