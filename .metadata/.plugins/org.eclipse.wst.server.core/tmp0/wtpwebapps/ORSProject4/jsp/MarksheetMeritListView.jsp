<%@page import="in.co.rays.proj4.util.DataUtility"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<%@page import="in.co.rays.proj4.ctl.MarksheetMeritListCtl"%>
<%@page import="in.co.rays.proj4.util.ServletUtility"%>
<%@page import="in.co.rays.proj4.bean.MarksheetBean"%>
<%@page import="java.util.List"%>
<%@page import="java.util.Iterator"%>
<%@include file="Header.jsp"%>

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Merit List</title>
</head>

<body>

	<div align="center" style="height: 585px;">

		<form action="<%=ORSView.MARKSHEET_MERIT_LIST_CTL%>" method="POST">
			
			<br>
			<h1>Marksheet Merit List </h1>
			<br>
			
			<table class="tbl">
				<tr>
					<th>S. No.</th>
					<th>Roll No</th>
					<th>Name</th>
					<th>Physics</th>
					<th>Chemistry</th>
					<th>Maths</th>
					<th>Total(Out of 300)</th>
					<th>Percentage(%)</th>
					
				</tr>

				<%
					int pageNo = ServletUtility.getPageNo(request);
					int pageSize = ServletUtility.getPageSize(request);
					int index = ((pageNo - 1) * pageSize) + 1;

					List list = ServletUtility.getList(request);
					Iterator<MarksheetBean> it = list.iterator();

					while (it.hasNext()) {

						MarksheetBean bean = it.next();
						String grade = null;
						String result = null;
						long phyMarks = DataUtility.getLong(bean.getPhysics());
						long chemMarks = DataUtility.getLong(bean.getChemistry());
						long MathMarks = DataUtility.getLong(bean.getMaths());
						long totalMarks = (phyMarks + chemMarks + MathMarks);
						long percentage = ((totalMarks) * 100) / 300;
						
				%>
				<tr align="center">
					<td><%=index++%></td>
					<td><%=bean.getRollNo()%></td>
					<td><%=bean.getName()%></td>
					<td><%=bean.getPhysics()%></td>
					<td><%=bean.getChemistry()%></td>
					<td><%=bean.getMaths()%></td>
					<td><%=totalMarks%></td>
					<td><%=percentage%>%</td>
					
					
				</tr>
				<%
					}
				%>
				
			</table>
			<br>
			<table>
				<tr>
					<td align="right"><input type="submit" name="operation"
						value="<%=MarksheetMeritListCtl.OP_BACK%>"></td>
				</tr>
			</table>
			<input type="hidden" name="pageNo" value="<%=pageNo%>"> <input
				type="hidden" name="pageSize" value="<%=pageSize%>">
		</form>
		</div>
</body>
</html>
<%@include file="Footer.jsp"%>