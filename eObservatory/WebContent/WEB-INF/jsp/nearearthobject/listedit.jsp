<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<script type="text/javascript">
        
	var oTable;

	function loadNeoList() {
		oTable.fnReloadAjax();
	}

	function showNeoDialog(id) {
		$('#neoEditContent').html('');

		$.ajax({
			url : rootUrl + 'nearearthobject/neoregistration',
			type : 'POST',
			data : {
				id : id ? id : null
			},
			success : function(res) {
				$('#neoEditContent').html(res);
				$('#dlgNeoEdit').dialog('open');
			}
		});
	}

	$(function() {
		$(':button').button();
		$('#dlgNeoEdit').dialog({
			title : 'Near Earth Object Registration',
			width : 900,
			height : 650,
			resizable : false,
			modal : true,
			autoOpen : false
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
										mDataProp : 'discoveryDate',
										sTitle : 'Discovery Date',
										bSortable : false
									},
									{
										mDataProp : 'id',
										sTitle : 'Operation.',
										bSortable : false,
										mRender : function(id) {
											return '<td><a href="#" onclick=showNeoDialog("'
													+ id + '")>Edit</a></td>';
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
										userId : userName
									}),
									success : fnCallback
								});
							}
						});
	});
</script>
<div>
    <h1 style="color: #009">My NEO Reports</h1>
    <br />
    <div>
    	
    	<input id="bReportNew" type="button" value="Report NEO" onclick="showNeoDialog()" />
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
    
    <div id="dlgNeoEdit">
    	<div id="neoEditContent"></div>
    </div>
</div>