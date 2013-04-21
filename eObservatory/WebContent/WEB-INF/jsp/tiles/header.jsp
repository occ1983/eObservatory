<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix='security' uri='http://www.springframework.org/security/tags' %>
<div id="banner" style="padding: 20px">
	<h1 style="font-family: Georgia; font-size: 45pt;">E-Observatory</h1>
	<h3 style="font-family: Arial; color: #fff">A NEO observatory made by yourself</h3>
	
	<div style="text-align: right; color: #fff; background: #000; padding: 10pt">
	    Welcome: <security:authentication property="principal.username" />
	    <a style="color: #ff5" href="<c:url value="/j_spring_security_logout" />">Logout</a>
	</div>
</div>