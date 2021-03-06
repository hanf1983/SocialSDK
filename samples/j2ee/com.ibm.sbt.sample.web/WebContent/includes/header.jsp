<%@page import="java.net.URLEncoder"%>
<%@page import="com.ibm.sbt.sample.web.util.Util"%>
<%@page import="com.ibm.commons.runtime.Context"%>
<%@page import="com.ibm.commons.util.StringUtil"%>
<%
String homeClass = "";
String jsClass = "";
String javaClass = "";
String formStyle = "";

String headEnvironment = Context.get().getProperty("environment");
String headEnvParam = request.getParameter("env");
boolean headSmartcloud = false;
if(StringUtil.isEmpty(headEnvParam))
    headSmartcloud = headEnvironment != null && headEnvironment.equals("smartcloudEnvironment") ? true : false;
else
    headSmartcloud = headEnvParam.equals("smartcloudEnvironment") ? true : false;

String requestUrl = request.getRequestURL().toString();
if (requestUrl.indexOf("javascript.jsp") != -1) {
  jsClass = "active";
} else if (requestUrl.indexOf("java.jsp") != -1) {
  javaClass = "active";
  formStyle = "visibility:hidden";
} else {
  homeClass = "active";
  formStyle = "visibility:hidden";
}
%>
<!-- header start -->  
<script type="text/javascript">
function reload(url) {
  window.location.href = url;
}
</script>
   <%if(headSmartcloud){ %>
    <div id="smartcloudNavContainer" class="lotusui30 lotusui30_fonts scloud3" style="font-size:12px">
      <script src="https://apps.na.collabservtest.lotus.com/manage/navbar/banner/smartcloudExt?oneui=3"></script>
    </div>
    <%}%>
   <div class="navbar <%if(!headSmartcloud){%>navbar-fixed-top<%}%>">
     <div class="navbar-inner">
       <div class="container-fluid">
         <a class="btn btn-navbar" data-toggle="collapse" data-target=".nav-collapse">
           <span class="icon-bar"></span>
           <span class="icon-bar"></span>
           <span class="icon-bar"></span>
         </a>
         <a class="brand" href="#">Social Business Toolkit - Samples</a>
         <div class="nav-collapse collapse">
           <ul class="nav">
              <li class="<%=homeClass%>"><a href="home.jsp<%if(headSmartcloud){ %>?env=smartcloudEnvironment<%}%>">Home</a></li>
              <li class="<%=jsClass%>"><a href="javascript.jsp<%if(headSmartcloud){ %>?env=smartcloudEnvironment<%}%>">JavaScript</a></li>
            <li class="<%=javaClass%>"><a href="java.jsp<%if(headSmartcloud){ %>?env=smartcloudEnvironment<%}%>">Java</a></li>
         </ul>
         <form class="navbar-form pull-right" style="<%=formStyle%>">
          <span style="vertical-align:middle">JavaScript Library: </span>
          <select id="libChange">
          <%
          String[][] jsLibs = Util.getJavaScriptLibs(request);
      for (int i=0; i<jsLibs.length; i++) {
        String title = jsLibs[i][0];
        String id = jsLibs[i][1];
        String url = Util.getPageUrl(request, id, null);
        String selected = Util.getSelectedLibrary(request).equals(id) ? " selected='selected'" : "";
      %>
        <option value="<%=url%>"<%=selected%>><%=title%></option>
      <%
      }
      %>
      </select>
         </form>
         
         <form class="navbar-form pull-right" style="<%=formStyle%>">
          <span style="vertical-align:middle">Environment: </span>
          <select id="envChange">
          <%
          String[][] envs = Util.getEnvironments(request);
      for (int i=0; i<envs.length; i++) {
        String title = envs[i][0];
        String id = envs[i][1];
        String url = Util.getPageUrl(request, null, null, id);
        String selected = Util.getEnvironmentId(request).equals(id) ? " selected='selected'" : "";
      %>
        <option value="<%=url%>"<%=selected%>><%=title%></option>
      <%
      }
      %>
      </select>
         </form>
       </div>
     </div>
   </div>
 </div> 
 <!-- header ends -->
