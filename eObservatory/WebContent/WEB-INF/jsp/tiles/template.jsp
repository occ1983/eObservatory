<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
   "http://www.w3.org/TR/html4/loose.dtd">

<%@page contentType="text/html" pageEncoding="UTF-8" %>
<%@taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="security" uri="http://www.springframework.org/security/tags" %>

<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        
        <title><tiles:insertAttribute name="title" /></title>

        <link rel="stylesheet" href="<c:url value="/resources/js/jquery-ui-1.10.2.custom/css/flick/jquery-ui-1.10.2.custom.min.css" />" />
        <link rel="stylesheet" href="<c:url value="/resources/css/style.galaxy.css" />" />
        <link rel="stylesheet" href="<c:url value="/resources/css/jquery.dataTables.css" />" />
        <link rel="stylesheet" href="<c:url value="/resources/css/ui.jqgrid.css" />" />
        <link rel="stylesheet" href="<c:url value="/resources/css/jquery.fileupload-ui.css" />" />
        
        <script type="text/javascript" src="<c:url value="/resources/js/jquery-ui-1.10.2.custom/js/jquery-1.9.1.js" />"></script>
        <script type="text/javascript" src="<c:url value="/resources/js/jquery-ui-1.10.2.custom/js/jquery-ui-1.10.2.custom.min.js" />"></script>
        <script type="text/javascript" src="<c:url value="/resources/js/jquery.dataTables.min.js" />"></script>
        <script type="text/javascript" src="<c:url value="/resources/js/reloadAjax.js" />"></script>
        <script type="text/javascript" src="<c:url value="/resources/js/jquery.jqGrid.min.js" />"></script>
        <script type="text/javascript" src="<c:url value="/resources/js/jquery.form.js" />"></script>
        <script type="text/javascript" src="<c:url value="/resources/js/load-image.min.js" />"></script>
        <script type="text/javascript" src="<c:url value="/resources/js/jquery.fileupload.js" />"></script>
        <script type="text/javascript" src="<c:url value="/resources/js/jquery.fileupload-fp.js" />"></script>
        <script type="text/javascript" src="<c:url value="/resources/js/jquery.fileupload-ui.js" />"></script>
        <script type="text/javascript" src="<c:url value="/resources/js/jquery.iframe-transport.js" />"></script>
        
        <script type="text/javascript">
            var userName = "<security:authentication property="principal.username" />";
            //var rootUrl = "<c:url value="/" />";
            var rootUrl = "/eobservatory/";
        </script>
        
        <style type="text/css">
        	.menuoption
        	{
        		border-style: outset;
        		border-radius: 5px;
        		padding: 5px;
        		background-color: #acd;
        	}
        	
        	.comment
        	{
        		background-color: #ccc;
        		padding: 7px;
        		border-style: solid;
        		border-width: 1px;
        		border-color: #000;
        	}
        </style>

    </head>
    <body>

        <script type="text/javascript">
            
            $(document).ready(function()
            {
                $('button').button();
                $('.button').button();

                jQuery.ajaxSetup({
                    cache: false,
                    beforeSend: function() {
                        //$('#loader').dialog('open');
                        //$('#loader').show();
                    },
                    complete: function(){
                        //$('#loader').dialog('close');
                        //$('#loader').hide();
                    },
                    success: function() {},
                    error: function(xhr, status, error)
                    {
                        alert($.parseJSON(xhr.responseText).message);
                    }
                });
            });
    </script>
	<div id="container_wrapper1">
	  <div id="container_wrapper2">
	    <div id="container">
	      <div id="header">

            <tiles:insertAttribute name="header" />
          </div>

        <div id="menu">
            <tiles:insertAttribute name="menu" />
        </div>
                   
        <div id="content">
        	<div id="postbody">
            	<tiles:insertAttribute name="content" />
            </div>
        </div>

        <div id="footer">
            <tiles:insertAttribute name="footer" />
        </div>
        
        </div>
        </div>
        </div>
    </body>
</html>
