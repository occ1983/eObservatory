<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<script type="text/javascript">
        
	var oTable;

	function loadNeoList() {
		oTable.fnReloadAjax();
	}

	function showNeoDialog(id) {
		$('#neoViewContent').html('');

		$.ajax({
			url : rootUrl + 'nearearthobject/neoview',
			type : 'POST',
			data : {
				id : id
			},
			success : function(res) {
				$('#neoViewContent').html(res);
				$('#dlgNeoView').dialog('open');
			}
		});
	}

	$(function() {
		$(':button').button();
		$('#dlgNeoView').dialog({
			title : 'Near Earth Object View',
			width : 800,
			height : 630,
			resizable : false,
			modal : true,
			autoOpen : false
		});

		$('#txtFromDate').datepicker({
            showOn: "button",
            buttonImage: rootUrl + "resources/images/calendar.gif",
            buttonImageOnly: true
        });

		$('#txtToDate').datepicker({
            showOn: "button",
            buttonImage: rootUrl + "resources/images/calendar.gif",
            buttonImageOnly: true
        });

		oTable = $('#lstNearEarthObject')
				.dataTable(
						{
							bProcessing : true,
							aoColumns : [
									{
										mDataProp : 'title',
										sTitle : 'Title',
										bSortable : false
									},
									{
										mDataProp : 'longitude',
										sTitle : 'Longitude',
										bSortable : false
									},
									{
										mDataProp : 'latitude',
										sTitle : 'Latitude',
										bSortable : false
									},
									{
										mDataProp : 'altitude',
										sTitle : 'Altitude',
										bSortable : false
									},
									{
										mDataProp : 'v',
										sTitle : 'V',
										bSortable : false
									},
									{
										mDataProp : 'h',
										sTitle : 'H',
										bSortable : false
									},
									{
										mDataProp : 'userId',
										sTitle : 'Reported By',
										bSortable : false
									},
									{
										mDataProp : 'discoveryDate',
										sTitle : 'Discovery Date',
										bSortable : false
									},
									{
										mDataProp : 'id',
										sTitle : 'Operation.',
										bSortable : false,
										mRender : function(id) {
											return '<td><a href="' + rootUrl + 'nearearthobject/neoview?id=' + id + '">View</a></td>';
										}
									} ],
							bServerSide : true,
							bFilter: false,
							bInfo: false,
							bPaginate: false,
							sAjaxSource : rootUrl + 'nearearthobject/list',
							fnServerData : function(sSource, aoData, fnCallback) {
								$.ajax({
									url : sSource,
									dataType : 'json',
									type : 'POST',
									contentType : 'application/json',
									data : JSON.stringify({
										userId : $('#txtUser').val(),
										discoveryFrom: ($('#txtFromDate').val() != '') ? $('#txtFromDate').val() : null
									}),
									success : fnCallback
								});
							}
						});
	});
</script>
<div>
    <table>
    	<tr>
    		<td>
    			Discoveries By User
    		</td>
    		<td>
    			<input id="txtUser" type="text" />    		
    	    </td>
    	</tr>
    	<tr>
    		<td>
    			Discovery from date
    		</td>
    		<td>
    			<input id="txtFromDate" type="text" />
    		</td>
    		
    	</tr>
    </table>
    
    <div>
    	<input id="btSearch" type="button" value="Search" onclick="loadNeoList()" />
    </div>
    
    <table id="lstNearEarthObject">
        <thead>
        	<!-- <tr>
        		<th>
        		    Id
        		</th>
        		<th>
        		    Title
        		</th>
        	</tr> -->
        </thead>
        <tbody>
        </tbody>
        <tfoot>
        	
        </tfoot>
    </table>
    
    <div id="dlgNeoView">
    	<div id="neoViewContent"></div>
    </div>
</div>