<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<ul>
	<li>
    	<a href="<c:url value="/" />">Home</a>
    </li>
	<li>
    	<a href="<c:url value="/nearearthobject/listdisplay" />">List of Reported NEO's</a>
    </li>
    <li>
    	<a href="<c:url value="/nearearthobject/listedit" />">My NEO Reports</a>
    </li>
</ul>
