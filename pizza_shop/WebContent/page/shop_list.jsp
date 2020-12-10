<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>

<table border="1">
	<tr>
		<td>피자 코드</td>
		<td>피자 명</td>
		<td>총매출액</td>
	</tr>
	<%
	try {
		Class.forName("oracle.jdbc.OracleDriver");
		Connection conn = DriverManager.getConnection("jdbc:oracle:thin:@//localhost:1521/xe", "system", "1234");
		
		Statement stmt = conn.createStatement();
		String query = "SELECT " +
			    "pizza.pcode, PIZZA.PNAME, " +
			    "SUM(PIZZA.COST * SALELIST.AMOUNT)  AS TOTAL_COST " +
			"FROM " +
			    "TBL_SALELIST_01 SALELIST, " +
			    "TBL_SHOP_01 SHOP, " +
			    "TBL_PIZZA_01 PIZZA " +
			"WHERE " +
			    "SALELIST.SCODE = SHOP.SCODE " +
			    "AND SALELIST.PCODE = PIZZA.PCODE " +
			"GROUP BY " +
			    "PIZZA.PCODE, PIZZA.PNAME " +
			"ORDER BY TOTAL_COST DESC";

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