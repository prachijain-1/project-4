<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<%@page import="in.co.rays.proj4.ctl.StudentListCtl"%>
<%@page import="in.co.rays.proj4.bean.*"%>
<%@page import="in.co.rays.proj4.ctl.TimeTableListCtl"%>
<%@page import="java.util.Iterator"%>
<%@page import="in.co.rays.proj4.util.DataUtility"%>
<%@page import="in.co.rays.proj4.util.ServletUtility"%>
<%@page import="in.co.rays.proj4.util.HTMLUtility"%>
<%@page import="java.util.List"%>
<%@include file="Header.jsp"%>
<%@page import="java.text.SimpleDateFormat" %>
 

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Time Table List</title>
</head>

<body>

	<div align="center"  style="height: 620px;">

		<form action="<%=ORSView.TIME_TABLE_LIST_CTL%>" method="post"
			name="frm">

			<jsp:useBean id="bean" class="in.co.rays.proj4.bean.TimeTableBean"
				scope="request"></jsp:useBean>
			<jsp:useBean id="model" class="in.co.rays.proj4.model.TimeTableModel"
				scope="request"></jsp:useBean>
				
			<%
				List courseList = (List) request.getAttribute("courseList");
				List subjectList = (List) request.getAttribute("subjectList");
			%>

			<h1>Time Table List</h1>
			<H2>
				<font color="green"> <%=ServletUtility.getSuccessMessage(request)%></font>
			</H2>
			<H2>
				<font color="red"> <%=ServletUtility.getErrorMessage(request)%></font>
			</H2>
			<%
					int pageNo = ServletUtility.getPageNo(request);
					int pageSize = ServletUtility.getPageSize(request);
					int index = ((pageNo - 1) * pageSize) + 1;
					 List list = ServletUtility.getList(request);
					Iterator<TimeTableBean> it = list.iterator();
					 if(list.size() !=0){
					%>

			<input type="hidden" name="id" value="<%=bean.getId()%>">


			<table width="100%">
				<tr>
					<td align="center"><label>Course Name :</label> <%=HTMLUtility.getList("courseId", String.valueOf(bean.getCourseId()), courseList)%>
						&emsp;<label>Subject Name :</label> <%=HTMLUtility.getList("subjectId", String.valueOf(bean.getSubjectId()), subjectList)%>
						&emsp; &emsp; 
						<%
							SimpleDateFormat sdf = new SimpleDateFormat("dd-MM-yyyy");
							if (bean.getExamDate() != null) {
								String ss = sdf.format(bean.getExamDate());
						%>
						<label>Exam Date : </label> <input type="text" 
						name="examDate"  id="datesun" readonly="readonly" placeholder="Must be a Date"
						value=" <%=ss%>"
						> &emsp; 
						
						<%
							} else {
						%>
						
						   <label style="font-weight: bold;">Exam Date :</label>
							<input type="text" name="examDate" id="datesun"
								readonly="readonly" 
								placeholder="Select exam date"
								value="<%=DataUtility.getStringData(bean.getExamDate())%>">
								
						<%
							}
						%>
						
						<input type="submit" name="operation"
						value="<%=TimeTableListCtl.OP_SEARCH%>"> &emsp; <input
						type="submit" name="operation"
						value="<%=TimeTableListCtl.OP_RESET%>"></td>
				</tr>
			</table>

			
			<br>
			
			
			<table class="tbl">
				<tr>
					<th><input type="checkbox" id="mainbox"
						onchange="selectAll(this)">Select All</th>
					<th>S.No</th>
					<th>Course Name</th>
					<th>Subject Name</th>
			        <th>Semester</th>
					
					<th>Exam Date</th>
					<th>Exam Time</th>
					<th>Edit</th>
				</tr>

				<%
					

				
					while (it.hasNext()) {
						bean = it.next();
				%>
				<tr align="center">
					<td><input type="checkbox" name="ids" id="mainbox"
						onchange="selectone(this)" value="<%=bean.getId()%>"
						<%=((userBean.getRoleId() == RoleBean.ADMIN)) ? "" : "disabled"%>></td>			
					<td><%=index++%></td>
					<td><%=bean.getCourseName()%></td>
					<td><%=bean.getSubjectName()%></td>
	              <td><%=bean.getSemester()%></td>
					
					<td><%=bean.getExamDate()%></td>
					<td><%=bean.getExamTime()%></td>
					<%
						if (userBean.getRoleId() == 1) {
					%>
						<td><a href="TimeTableCtl?id=<%=bean.getId()%>">Edit</a></td>
					
					
				</tr>
				<%} %>
				<%
						}
					%>
			</table>

			<br>

			

			<table style="width: 100%">

				<colgroup>
					<col style="width: 30%">
					<col style="width: 35%">
					<col style="width: 10%">
					<col style="width: 25%">
				</colgroup>

				<tr>
					<td align="left"><input type="submit" name="operation"
						value="<%=TimeTableListCtl.OP_PREVIOUS%>"
						<%=(pageNo == 1) ? "disabled" : ""%>></td>
					<%
						if (userBean.getRoleId() == RoleBean.ADMIN || userBean.getRoleId() == RoleBean.FACULTY) {
					%>

					<td><input type="submit" name="operation"
						value="<%=TimeTableListCtl.OP_NEW%>"></td>

					<td><input type="submit" name="operation"
						value="<%=TimeTableListCtl.OP_DELETE%>"></td>
					<%
						}
					%>

					<td align="right"><input type="submit" name="operation"
						value="<%=TimeTableListCtl.OP_NEXT%>"
						<%=((list.size() < pageSize) || model.nextPk() - 1 == bean.getId()) ? "disabled" : ""%>></td>
				</tr>
			</table>
			 <%}if(list.size() == 0){ %>
               <br><input type="submit" name="operation" value="<%=TimeTableListCtl.OP_BACK%>"> 
        
            <% } %>
			  
			
			<input type="hidden" name="pageNo" value="<%=pageNo%>"> 
			<input type="hidden" name="pageSize" value="<%=pageSize%>">
			 
		</form>
	</div>
</body>
</html>
<%@include file="Footer.jsp"%>