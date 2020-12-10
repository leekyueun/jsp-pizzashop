<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>

<%
	String sale_code = request.getParameter("sale_code");
	String shop_code = request.getParameter("shop_code");
	String sale_date = request.getParameter("sale_date");
	String pcode = request.getParameter("pcode");
	int sale_amount = Integer.parseInt(request.getParameter("sale_amount"));
	
	try {
		Class.forName("oracle.jdbc.OracleDriver");
		Connection conn = DriverManager.getConnection("jdbc:oracle:thin:@//localhost:1521/xe", "system", "1234");
		
		Statement stmt = conn.createStatement();
		String query = "INSERT INTO TBL_SALELIST_01(SALENO, SCODE, SALEDATE, PCODE, AMOUNT)" +
						"VALUES('%s', '%s', '%S', '%S', '%d')";

		ResultSet rs = stmt.executeQuery(String.format(query, sale_code, shop_code, sale_date, pcode, sale_amount));

		conn.commit();
		stmt.close();
		conn.close();
	}
	catch (Exception e) {
		e.printStackTrace();
	}
%>