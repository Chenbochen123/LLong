<%@ Page Language="C#" AutoEventWireup="true" CodeFile="PlanScroll.aspx.cs" Inherits="Plugins_Semis_SemisPlan_PlanScroll" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>库存信息自动滚屏</title>
        <style type="text/css">
        .body
        {
         width: 98%;
        }
        .blk_02 
        { 
          margin-top: 0px; 
        } 
        .blk_02 .table_title table 
        { 
          border-left: 1px solid #b3d3ec; 
          border-top: 1px solid #b3d3ec; 
          background: #e0f0fd; 
          color: #5198cc; 
        } 
        .blk_02 .table_title table th 
        { 
          border-right: 1px solid #b3d3ec; 
          border-bottom: 1px solid #b3d3ec; 
          height: 30px; 
          font-weight: inherit; 
          font-size: x-large;
          text-align: center; 
        } 
        .blk_02 .table_data 
        { 
          height: 610px; 
          overflow: auto; 
        } 
        .blk_02 .table_data table 
        { 
          border-left: 1px solid #b3d3ec; 
        } 
        .blk_02 .table_data table td 
        { 
          border-right: 1px solid #b3d3ec; 
          border-bottom: 1px solid #b3d3ec; 
          height: 30px; 
          font-weight: inherit;
          font-size: large;
          <%--text-align: center;--%>
        } 
      </style>
      <script type="text/javascript">
          var prev = null;
          function selectx(row) {
              c = this.style.backgroundColor;
              if (prev != null) {
                  prev.style.backgroundColor = '#FFFFFF';
              }
              row.style.backgroundColor = c;

              prev = row;
          }

          var timerID = null
          var timerRunning = false
          function MakeArray(size) {
              this.length = size;
              for (var i = 1; i <= size; i++) {
                  this[i] = "";
              }
              return this;
          }

          function stopclock() {
              if (timerRunning)
                  clearTimeout(timerID);
              timerRunning = false
          }

          function showtime() {
              var now = new Date();
              var year = now.getFullYear();
              var month = now.getMonth() + 1;
              var date = now.getDate();
              var hours = now.getHours();
              var minutes = now.getMinutes();
              var seconds = now.getSeconds();
              var day = now.getDay();
              Day = new MakeArray(7);
              Day[0] = "星期天";
              Day[1] = "星期一";
              Day[2] = "星期二";
              Day[3] = "星期三";
              Day[4] = "星期四";
              Day[5] = "星期五";
              Day[6] = "星期六";
              var timeValue = "";
              timeValue += year + "年";
              timeValue += ((month < 10) ? "0" : "") + month + "月";
              timeValue += date + "日 ";
              timeValue += (Day[day]) + " ";
              timeValue += (hours < 12) ? "上午" : "下午";
              timeValue += ((hours <= 12) ? hours : hours - 12);
              timeValue += ((minutes < 10) ? ":0" : ":") + minutes;
              timeValue += ((seconds < 10) ? ":0" : ":") + seconds;
              document.all.txtCurrTime.innerText = timeValue;
              timerID = setTimeout("showtime()", 1000);
              timerRunning = true;
          }

          function startclock() {
              stopclock();
              showtime();
              if (document.getElementById("detailScroll").offsetHeight - document.getElementById("materScroll").offsetHeight >= document.body.clientHeight)
                  document.getElementById("tbWidthSet").width = document.body.clientWidth - 17;  //设置表头宽度与屏幕宽度一致
              else
                  document.getElementById("tbWidthSet").width = document.body.clientWidth;
          }
      </script>
</head>
<body onload="startclock();">
    <form id="form1" runat="server">
    <asp:ScriptManager ID="sm" runat="server"></asp:ScriptManager>
        <div class="blk_02" id="chg" style="height:150px; width:100%;"> 
            <div class="table_title"> 
                <asp:Label ID="lblMessage" runat="server" Font-Size="X-Large" />
               <table id="tbWidthSet" cellspacing="0"> 
                  <tbody> 
                     <tr>  
                          <th width="6%">班次</th>
                        <th width="12%">机台</th>
                        <th width="20%">物料名称</th>
                        <th width="7%">计划数量</th>
                        <th width="7%">实际数量</th>
                        <th width="8%">完成率</th>
                     </tr> 
                  </tbody>
              </table>
            </div> 
            <div class="table_data" id="materScroll"> 
               <div id="detailScroll">
                
                <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                    <ContentTemplate>
                        <asp:GridView ID="gvStorage" runat="server" AutoGenerateColumns="false" ShowHeader="false" OnRowDataBound="gvStorage_RowDataBound"
                             Font-Size="12px" CellPadding="3" Width="100%"> 
                                <Columns> 
                                        <asp:TemplateField ItemStyle-Width="6%" ItemStyle-HorizontalAlign="Center"> 
                                   <ItemTemplate> 
                                      <%#Eval("SHIFT_NAME")%> 
                                   </ItemTemplate> 
                                </asp:TemplateField> 
                                <asp:TemplateField ItemStyle-Width="12%" ItemStyle-HorizontalAlign="Center"> 
                                   <ItemTemplate> 
                                      <%#Eval("EQUIP_NAME")%> 
                                   </ItemTemplate> 
                                </asp:TemplateField> 
                                <asp:TemplateField ItemStyle-Width="20%" ItemStyle-HorizontalAlign="Center"> 
                                   <ItemTemplate> 
                                      <%#Eval("MATERIAL_NAME")%>
                                   </ItemTemplate> 
                                </asp:TemplateField>
                                <asp:TemplateField ItemStyle-Width="7%" ItemStyle-HorizontalAlign="Center"> 
                                   <ItemTemplate> 
                                      <%#Eval("PLANAMOUNT")%>
                                   </ItemTemplate> 
                                </asp:TemplateField>
                                <asp:TemplateField ItemStyle-Width="7%" ItemStyle-HorizontalAlign="Center"> 
                                   <ItemTemplate> 
                                      <%#Eval("REALAMOUNT")%>
                                   </ItemTemplate> 
                                </asp:TemplateField>
                                <asp:TemplateField ItemStyle-Width="8%" ItemStyle-HorizontalAlign="Center"> 
                                   <ItemTemplate> 
                                      <%#Eval("RATE")%>
                                   </ItemTemplate> 
                                </asp:TemplateField>
                            </Columns> 
                         </asp:GridView>
                    </ContentTemplate>
                    <%--<Triggers>
                        <asp:AsyncPostBackTrigger ControlID="timer1" EventName="Tick" />
                    </Triggers>--%>
                </asp:UpdatePanel>    
               </div>
            </div>
              
                 当前时间：<span id="txtCurrTime"></span>
                <%--<asp:Button ID="btnSearch" runat="server" Text="查询" onclick="btnSearch_Click" Enabled="false" />--%>
                <asp:Button ID="btnSearch" runat="server" Text="刷新" Width="50" Height="25" OnClick="btnSearch_Click" />
            <%--<div id="dv" runat="server" onmouseover="alert('AAA');" style="width:20%; height:1; background-color:Gray">======</div> --%>
         </div>
         <%--<asp:Timer ID="timer1" runat="server" Interval="300000" OnTick="timer1_Tick" />--%>
         <script type="text/javascript">
             var speed = 30
             function Marquee() {
                 if (document.getElementById("detailScroll").offsetHeight - document.getElementById("materScroll").offsetHeight >= document.body.clientHeight && document.getElementById("materScroll").scrollTop >= document.getElementById("detailScroll").offsetHeight - document.getElementById("materScroll").offsetHeight) {
                     //此处添加滚动到最后页面刷新，重新加载新的数据后进行展示
                     document.getElementById("btnSearch").click();
                     document.getElementById("materScroll").scrollTop = 0;
                 } else {
                     document.getElementById("materScroll").scrollTop++
                 }
             }
             var MyMar = setInterval(Marquee, speed);
             document.getElementById("materScroll").onmouseover = function () {
                 clearInterval(MyMar);
             }
             document.getElementById("materScroll").onmouseout = function () {
                 MyMar = setInterval(Marquee, speed);
             }
      </script>
    </form>
</body>
</html>
