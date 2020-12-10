<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>

<h3>SELECT</h3>
<table border="1">
	<tr>
		<td>지점 코드</td>
		<td>지점 명</td>
		<td>총매출액</td>
	</tr>
	<%
	try {
		Class.forName("oracle.jdbc.OracleDriver");
		Connection conn = DriverManager.getConnection("jdbc:oracle:thin:@//localhost:1521/xe", "system", "1234");
		
		Statement stmt = conn.createStatement();
		String query = "SELECT " +
			    "SHOP.SCODE, SHOP.SNAME, " +
			    "SUM(PIZZA.COST * SALELIST.AMOUNT)  AS TOTAL_COST " +
			    "FROM " +
			    "TBL_SALELIST_01 SALELIST, " +
			    "TBL_SHOP_01 SHOP, " +
			    "TBL_PIZZA_01 PIZZA " +
			"WHERE " +
			    "SALELIST.SCODE = SHOP.SCODE " +
			    "AND SALELIST.PCODE = PIZZA.PCODE " +
			"GROUP BY " + 
			    "SHOP.SCODE, SHOP.SNAME " +
			"ORDER BY SCODE ASC";

		ResultSet rs = stmt.executeQuery(query);
		String won = "\\";
		
		while (rs.next()) {
			String money = String.format("%,d", rs.getInt(3));
	%>
		<tr>
			<td> <%= rs.getString(1) %></td>
			<td> <%= rs.getString(2) %></td>
			<td> <%= won %><%= money %></td>
		</tr>
	<%
		}
		stmt.close();
		conn.close();
	}
	catch (Exception e) {
		e.printStackTrace();
	}
%>
</table>