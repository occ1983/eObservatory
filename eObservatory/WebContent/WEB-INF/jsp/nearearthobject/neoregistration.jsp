<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<script type="text/javascript">
	var nearEarthObject = {};
	var typing = false;
	var observationIndex = 0;
	var attachmentIndex = 0;

	function saveNeo()
	{
		nearEarthObject.title = $('#txtNeoTitle').val();
		nearEarthObject.discoveryDate = $('#txtNeoDiscoveryDate').val();
		nearEarthObject.tags = $('#txtNeoTags').val();
		nearEarthObject.longitude = $('#txtNeoLongitude').val();
		nearEarthObject.latitude = $('#txtNeoLatitude').val();
		nearEarthObject.altitude = $('#txtNeoAltitude').val();
		nearEarthObject.v = $('#txtNeoV').val();
		nearEarthObject.h = $('#txtNeoH').val();
		nearEarthObject.arc = $('#txtNeoArc').val();
		nearEarthObject.description = $('#txtNeoDescription').val();

		nearEarthObject.categories = new Array();
		nearEarthObject.observations = new Array();
		nearEarthObject.attachments = new Array();
		
		var ids = $('#lstCategories').jqGrid('getDataIDs'), i, index = 0;

		for (i = 0; i < ids.length; i++)
		{
			if ($('#' + ids[i] + '_checked').is(':checked'))
			{
				nearEarthObject.categories[index++] = $('#lstCategories').jqGrid('getRowData', ids[i]).id;								
			}
		}

		ids = $('#lstObservations').jqGrid('getDataIDs');
		index = 0;

		for (i = 0; i < ids.length; i++)
		{
			nearEarthObject.observations[index++] = {
						obsLongitude: $('#' + ids[i] + '_obsLongitude').val(),
						obsLatitude: $('#' + ids[i] + '_obsLatitude').val(),
						obsAltitude: $('#' + ids[i] + '_obsAltitude').val(),
						obsV: $('#' + ids[i] + '_obsV').val(),
						obsH: $('#' + ids[i] + '_obsH').val(),
						obsArc: $('#' + ids[i] + '_obsArc').val()
					};
		}

		ids = $('#lstAttachments').jqGrid('getDataIDs');
		index = 0;

		for (i = 0; i < ids.length; i++)
		{
			nearEarthObject.attachments[index++] = $('#lstAttachments').jqGrid('getRowData', ids[i]).id;
		}
		
		$.ajax({
			url: rootUrl + 'nearearthobject/save',
			type: 'PUT',
			dataType: 'json',
			data: JSON.stringify(nearEarthObject),
			contentType: 'application/json',
			success: function(result)
			{
				loadNeoList();
				nearEarthObject = result;
				alert('NEO registered or updated successfully.');	
			}
		});
	}

	function closeNeoRegDialog()
	{
		$('#dlgNeoEdit').dialog('close');
	}

	function listCategories()
	{
		$('#lstCategories').jqGrid('setGridParam', {postData: {category: $('#txtCategoryNew').val()}})
						   .trigger('reloadGrid');
	}

	function addObservation()
	{
		var id = observationIndex++;
		$('#lstObservations').addRowData(id, {});
		$('#lstObservations').editRow(id);
	}

	function deleteSelectedObservation()
	{
		var id = $('#lstObservations').jqGrid('getGridParam', 'selrow');
		var ids = $('#lstObservations').jqGrid('getDataIDs'), i;

		if (id)
		{
			for (i = 0; i < ids.length; i++)
			{
				if (ids[i] == id)
				{
					nearEarthObject.observations.splice(i, 1);
					break;
				}				
			}
		}

		$('#lstObservations').jqGrid('clearGridData')
						     .jqGrid('setGridParam', {data: nearEarthObject.observations})
							 .trigger('reloadGrid');
	}

	function deleteSelectedAttachment()
	{
		var id = $('#lstAttachments').jqGrid('getGridParam', 'selrow');
		var ids = $('#lstAttachments').jqGrid('getDataIDs'), i;

		if (id)
		{
			for (i = 0; i < ids.length; i++)
			{
				if (ids[i] == id)
				{
					
					$.ajax({
						url: rootUrl + 'attachment/delete?id=' + ids[i],
						type: 'DELETE',
						//data: {id : ids[i]},
						success: function(result)
						{
							nearEarthObject.attachmentObjects.splice(i, 1);
							//nearEarthObject.attachments.splice(i, 1);
							$('#dlgConfirmDelete').dialog('close');
							$('#lstAttachments').jqGrid('clearGridData')
						     .jqGrid('setGridParam', {data: nearEarthObject.observationObjects})
							 .trigger('reloadGrid');
						}
					});
					
					break;
				}				
			}
		}

		
	}

	function openImageManager(id)
	{
		$('#dlgImageManager').dialog('open');

		$.ajax(
		{
			url: rootUrl + 'attachment/imagemanager',
			type: 'GET',
			data: {attachmentId: id},
			success: function(result)
			{
				$('#pnlImageManager').html('');
				$('#pnlImageManager').html(result);
			}
		});
		
	}

	function addAttachment()
	{
		$('#frmFileUpload').ajaxSubmit({
			success: function(result)
			{
				var id = attachmentIndex++;
				$('#lstAttachments').addRowData(id, {id: result.id, fileName: result.fileName});
				$('#lstAttachments').setRowData(id, {thumbnail: '<img src="' + rootUrl + 'attachment/getfilebyattachmentid?id=' + result.id + '" width=50px height=40px />', manager: '<input type="button" value="Image Manager" onclick=openImageManager("' + result.id + '") />' });
				//alert('File transferred successfully.');
			}
		});
	}

	function addCategory()
	{
		$.ajax({
			url: rootUrl + 'category/save',
			type: 'PUT',
			dataType: 'json',
			contentType: 'application/json',
			data: JSON.stringify({
				category: $('#txtCategoryNew').val()	
			}),
			success: function(result)
			{
				$('#lstCategories').trigger('reloadGrid');
			}
		});
	}

	$(function()
	{
		$('#txtNeoDiscoveryDate').datepicker({
            showOn: "button",
            buttonImage: rootUrl + "resources/images/calendar.gif",
            buttonImageOnly: true
        });

        $('#dlgImageManager').dialog({title: 'Image Manager', modal: true, width: 800, height: 600, resizable: false, autoOpen: false});
        $('#dlgConfirmDelete').dialog({title: 'Confirm', modal: true, width: 400, height: 300, resizable: false, autoOpen: false});
		
		if ($('#hdnId').val())
		{
			$.ajax({
				url: rootUrl + 'nearearthobject/detail/' + $('#hdnId').val(),
				type: 'GET',
				success: function(result)
				{
					firstTimeLoading = false;
					nearEarthObject = result;
					$('#txtNeoTitle').val(result.title);
					$('#txtNeoDiscoveryDate').val(result.discoveryDate);
					$('#txtNeoTags').val(result.tags);
					$('#txtNeoLongitude').val(result.longitude);
					$('#txtNeoLatitude').val(result.latitude);
					$('#txtNeoAltitude').val(result.altitude);
					$('#txtNeoDescription').val(result.description);
					$('#txtNeoV').val(result.v);
					$('#txtNeoH').val(result.h);
					$('#txtNeoArc').val(result.arc);
	
					if ($('#lstCategories').length > 0)
					{
						$('#lstCategories').trigger('reloadGrid');
					}
	
					if (result.observations)
					{
						$('#lstObservations').jqGrid('clearGridData')
											 .jqGrid('setGridParam', {data: result.observations})
											 .trigger('reloadGrid');
					}
	
					if (result.attachments)
					{
						$('#lstAttachments').jqGrid('clearGridData')
						 				     .jqGrid('setGridParam', {data: result.attachmentObjects})
						 			         .trigger('reloadGrid');

	 			        var ids = $('#lstAttachments').jqGrid('getDataIDs'), i;

						for (i = 0; i < ids.length; i++)
						{
							$('#lstAttachments').jqGrid('setRowData', ids[i], {thumbnail: '<img src="' + rootUrl + 'attachment/getfilebyattachmentid?id=' + ids[i] + '" width=50px height=40px />', manager: '<input type="button" value="Image Manager" onclick=openImageManager("' + ids[i] + '") />' });
						}	 			        
					}
				}	
			});
		}
		else
		{
			firstTimeLoading = false;
			$('#txtNeoTitle').focus();
		}
	
		$('#lstCategories').jqGrid({
			url: rootUrl + 'category/list',
			postData: {category: ''},
			datatype: 'json',
			mtype: 'POST',
			width: 400,
			height: 80,
			colNames: ['', '', 'Category'],
			colModel: [
				{name: 'id', index: 'id', hidden: true},
				{name: 'checked', index: 'checked', width: 10, editable: true, edittype: 'checkbox', editoptions: {value: "True:False"}},
				{name: 'category', index: 'category', width: 100}
			],
			rowNum: 1000000,
			toolbar: [true, 'top'],
	        jsonReader: {
	                page: function()
	                {
	                    return 1;
	                },
	                total: function(res)
	                {
	                    return res;
	                },
	                records: function()
	                {
	                    return 1;
	                },
	                root: function(root)
	                {
	                    return root;
	                },
	                repeatitems: false,
	                id: "categoryId"
	         },
	         loadComplete: function()
	         {
		         var ids = $('#lstCategories').jqGrid('getDataIDs');
		         var k, j;

		         for (k = ids.length - 1; k >= 0; k--)
			     {
				     $('#lstCategories').jqGrid('editRow', ids[k]);		     
				 }

		         if (nearEarthObject.categories)
			     {
		        	 for (k = 0; k < nearEarthObject.categories.length; k++)
					 {
						 for (j = 0; j < ids.length; j++)
					     {
						     if (nearEarthObject.categories[k] == $('#lstCategories').jqGrid('getRowData', ids[j]).id)
							 {
								 $('#' + ids[j] + '_checked').attr("checked", true);
							 }
						     
						 }
					 }
				 }

		         if (typing)
			     {
		        	 $('#txtCategoryNew').focus();
		        	 typing = false;
				 }
		         else
			     {
				     $('#txtNeoTitle').focus();
				 }
		     }
		});

		$('#t_lstCategories').html('Category: <input id="txtCategoryNew" type="text" style="width: 200px" onKeyUp="typing=true;listCategories()" />&nbsp;<input id="bAdd" type="button" onclick="addCategory()" value="Add to list" />');
		
		$('#lstObservations').jqGrid({
			datatype: 'local',
			width: 400,
			height: 80,
			toolbar: [true, 'top'],
			colNames: ['','Longitude','Latitude','Altitude','V','H','Arc'],
			colModel: [
			    {name: 'blank', width:7, editable: false, sortable: false},
				{name: 'obsLongitude', index: 'obsLongitude', width: 20, editable: true, edittype: 'text'},
				{name: 'obsLatitude', index: 'obsLatitude', width: 20, width: 20, editable: true, edittype: 'text'},
				{name: 'obsAltitude', index: 'obsAltitude', width: 20, width: 20, editable: true, edittype: 'text'},
				{name: 'obsV', index: 'obsV', width: 20, width: 20, editable: true, edittype: 'text'},
				{name: 'obsH', index: 'obsH', width: 20, width: 20, editable: true, edittype: 'text'},
				{name: 'obsArc', index: 'obsArc', width: 20, width: 20, editable: true, edittype: 'text'}
			],
			rowNum: 1000000,
	        jsonReader: {
	                page: function()
	                {
	                    return 1;
	                },
	                total: function(res)
	                {
	                    return res;
	                },
	                records: function()
	                {
	                    return 1;
	                },
	                root: function(root)
	                {
	                    return root;
	                },
	                repeatitems: false,
	                id: "categoryId"
	         },
	         loadComplete: function()
	         {
		         var ids = $('#lstObservations').jqGrid('getDataIDs'), i;

		         for (i = ids.length - 1; i >= 0; i--)
			     {
				     $('#lstObservations').editRow(ids[i]);
				 }
		     }
		});

		$('#t_lstObservations').html('<input id="btnObsAdd" type="button" onclick="addObservation()" value="Add Observation" />&nbsp;<input id="btnObsDel" type="button" onclick="deleteSelectedObservation()" value="Delete" />');

		$('#lstAttachments').jqGrid({
			datatype: 'local',
			width: 400,
			height: 100,
			toolbar: [true, 'top'],
			colNames: ['', 'File Name','Thumbnail', ''],
			colModel: [
				{name: 'id', index: 'id', hidden: true},
				{name: 'fileName', index: 'fileName', width: 50},
				{name: 'thumbnail', index: 'thumbnail', width: 50},
				{name: 'manager', index: 'manager', width: 50}
			],
			rowNum: 1000000,
	        jsonReader: {
	                page: function()
	                {
	                    return 1;
	                },
	                total: function(res)
	                {
	                    return res;
	                },
	                records: function()
	                {
	                    return 1;
	                },
	                root: function(root)
	                {
	                    return root;
	                },
	                repeatitems: false,
	                id: "categoryId"
	         }
		});

		$('#t_lstAttachments').html('<form id="frmFileUpload" action="' + rootUrl + 'attachment/uploadfile" method="post" enctype="multipart/form-data"><input id="btnAttachmentsAdd" type="file" name="file" onchange="addAttachment()" />&nbsp;<input id="btnAttachmentDel" type="button" onclick="$(\'#dlgConfirmDelete\').dialog(\'open\')" value="Delete" /></form>');
		$('#frmFileUpload').fileupload({
			url: rootUrl + 'attachment/uploadfile'
		});
		
		$('#frmFileUpload').fileupload('option', {
			maxFileSize: 100000,
			acceptFileTypes: /(\.|\/)(gif|jpe?g|png)$/i,
			process: [
				{
					action: 'load',
					fileTypes: /^image\/(gif|jpeg|png)$/
				}
			]
		});

		$(':button').button();
	});
</script>
<div>
     <input id="hdnId" type="hidden" value="${id}" />
     <table>
     	<tr>
     		<td rowspan="4" style="vertical-align: top">
     		    Near Earth Object data
     		    <br />
     			<table>
			     	<tr>
			     		<td>
			     		    Title:
			     		</td>
			     		<td>
			     			<input id="txtNeoTitle" type="text" />
			     		</td>
			     	</tr>
			     	<tr>
			     		<td>
			     			Discovery date:
			     		</td>
			     		<td>
			     			<input id="txtNeoDiscoveryDate" type="text" />
			     		</td>
			     	</tr>
			     	<tr>
			     		<td>
			     			Tags:
			     		</td>
			     		<td>
			     			<input id="txtNeoTags" type="text" />
			     		</td>
			     	</tr>
			     	<tr>
			     		<td>
			     			Longitude:
			     		</td>
			     		<td>
			     			<input id="txtNeoLongitude" type="text" />
			     		</td>
			     	</tr>
			     	<tr>
			     		<td>
			     			Latitude:
			     		</td>
			     		<td>
			     			<input id="txtNeoLatitude" type="text" />
			     		</td>
			     	</tr>
			     	<tr>
			     		<td>
			     			Altitude:
			     		</td>
			     		<td>
			     			<input id="txtNeoAltitude" type="text" />
			     		</td>
			     	</tr>
			     	<tr>
			     		<td>
			     			V:
			     		</td>
			     		<td>
			     			<input id="txtNeoV" type="text" />
			     		</td>
			     	</tr>
			     	<tr>
			     		<td>
			     			H:
			     		</td>
			     		<td>
			     			<input id="txtNeoH" type="text" />
			     		</td>
			     	</tr>
			     	<tr>
			     		<td>
			     			Arc:
			     		</td>
			     		<td>
			     			<input id="txtNeoArc" type="text" />
			     		</td>
			     	</tr>
			     	<tr>
			     		<td>
			     			Description:
			     		</td>
			     		<td>
			     			<textarea id="txtNeoDescription" style="width: 217px; height: 100px"></textarea>
			     		</td>
			     	</tr>
			     </table>
     		</td>
     	</tr>
     	<tr>
     		<td style="vertical-align: top; padding-left: 10px">
     			Categories
     			<br />
     			<table id="lstCategories">
     			</table>
     		</td>
     	</tr>
     	<tr>
     		<td style="vertical-align: top; padding-left: 10px">
     			Observation Records
     			<table id="lstObservations">
     			</table>
     		</td>
     	</tr>
     	<tr>
     		<td style="vertical-align: top; padding-left: 10px">
     			Attachments
     			<table id="lstAttachments">
     			</table>
     		</td>
     	</tr>
     </table>
     
     <br />
     <div style="text-align: right">
     	<input id="bSubmit" type="button" onclick="saveNeo()" value="Register/Update Info" />
     	&nbsp;
     	<input id="bClose" type="button" onclick="closeNeoRegDialog()" value="Close" />
     </div>
     
     <div id="dlgImageManager">
     	<div id="pnlImageManager">
     	</div>
     </div>
     
     <div id="dlgConfirmDelete">
     	This operation is also going to delete the image from the server. Do you want to continue?
     	<div style="text-align: right">
     		<input id="btnDeleteYes" type="button" value="Yes" onclick="deleteSelectedAttachment()" />
     		<input id="btnDeleteNo" type="button" value="No" onclick="$('#dlgConfirmDelete').dialog('close')" />
     	</div>
     </div>
</div>