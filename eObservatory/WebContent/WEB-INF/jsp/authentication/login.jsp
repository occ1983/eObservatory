<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<div>
	<form id="frmUserLogin" method="post" action="<c:url value="/j_spring_security_check" />">
	<table>
		<tr>
			<td>
				User
			</td>
			<td>
				<input id="txtUserName" name="j_username" type="text" />
			</td>
		</tr>
		<tr>
			<td>
				Password
			</td>
			<td>
				<input id="txtUserName" name="j_password" type="password" />
			</td>
		</tr>
	</table>
	<br />
	
	<div style="width: 300px; text-align: right">
		<input type="submit" value="Login" />
	</div>
	<br />
	<br />
	New to E-Observatory? <a href="<c:url value="/user/preparesignup" />">Sign Up</a>
	</form>
	
</div>