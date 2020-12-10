<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>

<head>
	<meta charset="UTF-8">
	<title>Insert title here</title>
	<link rel="stylesheet" href="css/css.css">
</head>

<body>
	<%
		String section = request.getParameter("section") != null ? request.getParameter("section") : "";
	%>
	<%@ include file="static/header.jsp" %>
	<%@ include file="static/nav.jsp" %>
	<%
		switch(section) {
		case "insert":
			%> <%@include file="page/insert.jsp" %> <%
			break;
		case "pizza_list":
			%> <%@include file="page/pizza_list.jsp" %> <%
			break;
		case "sale_list":
			%> <%@include file="page/sale_list.jsp" %> <%
			break;
		case "shop_list":
			%> <%@include file="page/shop_list.jsp" %> <%
			break;
		default:
			%> <%@include file="static/index.jsp" %> <%
		}
	%>
	<%@ include file="static/footer.jsp" %>
</body>

</html>