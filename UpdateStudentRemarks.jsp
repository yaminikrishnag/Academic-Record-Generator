<%
if(((String)session.getAttribute("role")).equals("student"))
{
 %>
<jsp:include flush="true" page="StudentHeader.jsp"></jsp:include>
<%
}

else
{
%>
<jsp:include flush="true" page="TeacherHeader.jsp"></jsp:include>
<%
}
 %>

<% 

 Connection con=null;
 PreparedStatement pstmt=null;
 ResultSet rs=null;
 
try
{	
	ServletContext sc=getServletContext();
	String driver=sc.getInitParameter("driver");
	String url=sc.getInitParameter("url");
	String uname=sc.getInitParameter("user");
	String pwd=sc.getInitParameter("dbpassword");
	Class.forName(driver);
	 System.out.println("...........3.......");
	 con=DriverManager.getConnection(url,uname,pwd);
       	  pstmt=con.prepareStatement("select distinct student_id from student_remarks where teacher_id=?");
       	  pstmt.setString(1,(String)session.getAttribute("userid"));
       	  rs=pstmt.executeQuery();
       	 
       
   	   
}
catch(Exception e)
{
	e.printStackTrace();
}
%>

<%@page import="java.sql.*" %>
<HTML>
<head>

<script language="javascript">
function examid()
{
window.alert(document.frm.search.value);
window.location.href="./UpdateStudentRemarks.jsp?search="+document.frm.search.value;


}
</script>


<script language="javascript" src="dateget.js">
</script>
</head>
<body bgcolor="silver"><center>
<form name="frm"  method="Post">
<font> <h4>MARKS DETAILS</h4></font><br>
<br><br>
<center>
 <table>
            <tr>
                <td style="width: 563px; height: 26px" align="center">
                    <strong>
                        Enter Exam Id:<select name="search" onchange="return examid();">
                        
                        <%
                        if(request.getParameter("search")!=null)
                        {
                        %>
                         <option value=<%=request.getParameter("search") %>><%=request.getParameter("search") %></option>
                         <%
                         }
                         
                         while(rs.next())
                         {
                         %>
                         <option value=<%=rs.getString(1)%>><%=rs.getString(1)%></option>
                         <%
                         
                         }
                        
                        %>
                        </select>
                        </strong>
                        </td>
                     </tr>
                     <tr></tr>
                     <tr></tr>
                         
                        
                        <tr><td style="width: 563px; height: 26px" align="center"><input type="submit" value="  GO  " name="go"></td></tr>
                        
                        
       
           
  </table>
        <br />
      
        &nbsp; &nbsp;&nbsp;
    </center>
<table border="1" bordercolor="black" cellspacing="0">
<%
if(request.getParameter("search")!=null)
 {
  System.out.println("executed"+request.getParameter("search"));
 %>
 
 <tr><td align="center"><b>Remarks</td><td align="center"><b>Date</td><td align="center"><b>Update</td>
</tr>
	<%
 try
 {
 System.out.println("executed"+request.getParameter("search"));
 int i=0;
  pstmt=con.prepareStatement("Select remarks,date,remark_id from student_remarks where student_id=? and teacher_id=?");
  
  pstmt.setString(1,request.getParameter("search"));
  pstmt.setString(2,(String)session.getAttribute("userid"));
    rs=pstmt.executeQuery();
    while(rs.next())
    {
    i=i+1;
 %>
     <tr><td><%=rs.getString(1)%></td><td align="center"><%=rs.getString(2) %></td><td align="center"><a href="./UpdateStudentRemarks1.jsp?rid=<%=rs.getString(3) %>">update</a></td></tr>
     
     	
<%
     }
    } 
    catch(Exception e)
    {
    e.printStackTrace();
    
    }
   } 
 %>
    
	
	
	

 
</table><br>
</body>

<jsp:include flush="true" page="footer.jsp"></jsp:include>
</html>
