<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>

<%
	try {
		Class.forName("oracle.jdbc.OracleDriver");
		Connection conn = DriverManager.getConnection("jdbc:oracle:thin:@//localhost:1521/xe", "system", "1234");
%>

<script>
	function submit_form() {
        if (document.input_form.sale_code.value === '') {
            alert("매출전표번호를 입력해야 합니다")
            document.input_form.sale_code.focus();
            return
        }
        if (document.input_form.shop_code.value === '') {
            alert("지점코드를 입력해야 합니다")
            document.input_form.shop_code.focus();
            return
        }
        if (document.input_form.pcode.selectedIndex === 0) {
            alert("피자코드를 입력해야 합니다")
            document.input_form.pcode.focus();
            return
        }
        if (document.input_form.sale_date.value === '') {
            alert("판매일자를 입력해야 합니다")
            document.input_form.sale_date.focus();
            return
        }
        if(document.input_form.sale_amount.value === '') {
            alert("판매수량을 입력해야 합니다")
            document.input_form.sale_amount.focus();
            return
        }
        alert("매출전표가 정상적으로 등록되었습니다")
        document.input_form.submit();
    }

    function reset_form() {
        document.input_form.reset()
    }
</script>
<form action="action/action.jsp" method="post" name="input_form">
    <table border="1">
        <tr>
            <td>매출전표번호</td>
            <td><input type="text" name="sale_code" /></td>
        </tr>
        <tr>
            <td>지점코드</td>
            <td><input type="text" name="shop_code" /></td>
        </tr>
        <tr>
            <td>판매 일자</td>
            <td><input type="date" name="sale_date" /></td>
        </tr>
        <tr>
            <td>피자코드</td>
            <td>
                <select name="pcode">
                	<option value="0">피자선택</option>
                    <%
						Statement stmt = conn.createStatement();
						ResultSet rs = stmt.executeQuery("SELECT PCODE, PNAME FROM TBL_PIZZA_01");
						while (rs.next()) {
					%>
                    	<option value="<%=rs.getString(1) %>"> <%= String.format("[%s] %s", rs.getString(1), rs.getString(2)) %></option>
                    <%
						}
					%>
                </select>
            </td>
        </tr>
        <tr>
            <td>판매 수량</td>
            <td><input type="number" name="sale_amount" /></td>
        </tr>
        <tr>
            <td colspan="2">
                <input type="button" value="전표 등록" onclick="submit_form()">
                <input type="button" value="다시 쓰기" onclick="reset_form()">
            </td>
        </tr>
    </table>
</form>

<%
		stmt.close();
		conn.close();
	}
	catch (Exception e) {
		e.printStackTrace();
    }
%>