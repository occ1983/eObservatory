<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@taglib prefix="security" uri="http://www.springframework.org/security/tags" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<style type="text/css">
	.datablock
	{
		border: outset; 
		border-width: 2px; 
		border-radius: 5px
	}
</style>
<script type="text/javascript">
	var nearEarthObject;
	var typing;

	function addComment()
	{
		$.ajax({
			url: rootUrl + 'nearearthobject/addcomment',
			type: 'PUT',
			dataType: 'json',
			contentType: 'application/json',
			data: JSON.stringify({
				neoId: $('#hdnId').val(),
				rating: $('#txtRating').val(),
				comment: $('#txtComment').val()
			}),
			success: function(result)
			{
				$('#txtRating').val('');
				$('#txtComment').val('');
				loadNeoInformation();
			}
		});
	}

	function showRatingForm()
	{
		
	}

	function closeNeoViewDialog()
	{
		$('#dlgNeoView').dialog('close');
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

	function listCategories() {
		$('#lstViewCategories').jqGrid('setGridParam', {
			postData : {
				category : $('#txtViewCategoryNew').val()
			}
		}).trigger('reloadGrid');
	}

	function loadNeoInformation()
	{
		if ($('#hdnId').val()) {
			$.ajax({
						url : rootUrl + 'nearearthobject/detail/' + $('#hdnId').val(),
						type : 'GET',
						success : function(result) {
							firstTimeLoading = false;
							nearEarthObject = result;
							$('#sNeoTitle').html(result.title);
							$('#sNeoDiscoveryDate').html(result.discoveryDate);
							$('#sNeoTags').html(result.tags);
							$('#sNeoLongitude').html(result.longitude);
							$('#sNeoLatitude').html(result.latitude);
							$('#sNeoAltitude').html(result.altitude);
							$('#sNeoDescription').html(result.description);
							$('#sNeoV').html(result.v);
							$('#sNeoH').html(result.h);
							$('#sNeoArc').html(result.arc);

							if ($('#lstViewCategories').length > 0) {
								$('#lstViewCategories').trigger('reloadGrid');
							}

							if (result.categories)
							{
								$.ajax(
								{
									url: rootUrl + 'nearearthobject/categorydetails',
									type: 'GET',
									data: {neoId: result.id},
									success: function(result)
									{
										var i;
										$('#ulCategories').html('');

										for (i = 0; i < result.length; i ++)
										{
											$('#ulCategories').append('<li>' + result[i].category + '</li>');											
										}
									}
								});
							}

							if (result.comments)
							{
								var j;
								$('#lstComments').html('');

								for (j = 0; j < result.comments.length; j++)
								{
									$('#lstComments').append('<tr><td style="padding: 5px;border-style:solid;border-width:1px;border-color:#bbb;width:100%">' +
											'<h4>User: ' + result.comments[j].userId + '</h4>' +
											'<i>Rating: ' + result.comments[j].rating + '</i><br />' +
											'<i>Date: ' + result.comments[j].commentDate + '</i>' +
											'<p class="comment">' + result.comments[j].comment + '</p>' +
											'</td></tr>');
								}
							}

							if (result.observations) {
								$('#lstViewObservations').jqGrid(
										'clearGridData').jqGrid('setGridParam',
										{
											data : result.observations
										}).trigger('reloadGrid');
							}

							if (result.attachments) {
								$('#lstViewAttachments')
										.jqGrid('clearGridData')
										.jqGrid('setGridParam', {
											data : result.attachmentObjects
										}).trigger('reloadGrid');

								var ids = $('#lstViewAttachments').jqGrid(
										'getDataIDs'), i;

								for (i = 0; i < ids.length; i++) {
									$('#lstViewAttachments')
											.jqGrid(
													'setRowData',
													ids[i],
													{
														thumbnail : '<img src="'
																+ rootUrl
																+ 'attachment/getfilebyattachmentid?id='
																+ ids[i]
																+ '" width=50px height=40px />',
														manager : '<input type="button" value="Image Manager" onclick=openImageManager("'
																+ ids[i]
																+ '") />'
													});
								}
							}
						}
					});
		} else {
			//firstTimeLoading = false;
			//$('#txtNeoTitle').focus();
		}
	}

	$(function() {
		$('#dlgImageManager').dialog({title: 'Image Manager', modal: true, width: 800, height: 600, resizable: false, autoOpen: false});
		loadNeoInformation();

		$('#lstViewObservations').jqGrid(
				{
					datatype : 'local',
					width : 400,
					height : 80,
					toolbar : [ true, 'top' ],
					colNames : [ '', 'Longitude', 'Latitude', 'Altitude', 'V',
							'H', 'Arc' ],
					colModel : [ {
						name : 'blank',
						width : 7,
						editable : false,
						sortable : false
					}, {
						name : 'obsLongitude',
						index : 'obsLongitude',
						width : 20,
						editable : true,
						edittype : 'text'
					}, {
						name : 'obsLatitude',
						index : 'obsLatitude',
						width : 20,
						width : 20,
						editable : true,
						edittype : 'text'
					}, {
						name : 'obsAltitude',
						index : 'obsAltitude',
						width : 20,
						width : 20,
						editable : true,
						edittype : 'text'
					}, {
						name : 'obsV',
						index : 'obsV',
						width : 20,
						width : 20,
						editable : true,
						edittype : 'text'
					}, {
						name : 'obsH',
						index : 'obsH',
						width : 20,
						width : 20,
						editable : true,
						edittype : 'text'
					}, {
						name : 'obsArc',
						index : 'obsArc',
						width : 20,
						width : 20,
						editable : true,
						edittype : 'text'
					} ],
					rowNum : 1000000,
					jsonReader : {
						page : function() {
							return 1;
						},
						total : function(res) {
							return res;
						},
						records : function() {
							return 1;
						},
						root : function(root) {
							return root;
						},
						repeatitems : false,
						id : "categoryId"
					}
				/*,
					         loadComplete: function()
					         {
						         var ids = $('#lstObservations').jqGrid('getDataIDs'), i;

						         for (i = ids.length - 1; i >= 0; i--)
							     {
								     $('#lstObservations').editRow(ids[i]);
								 }
						     }*/
				});

		//$('#t_lstViewObservations').html('<input id="btnObsAdd" type="button" onclick="addObservation()" value="Add Observation" />&nbsp;<input id="btnObsDel" type="button" onclick="deleteSelectedObservation()" value="Delete" />');

		$('#lstViewAttachments').jqGrid({
			datatype : 'local',
			width : 400,
			height : 100,
			toolbar : [ true, 'top' ],
			colNames : [ '', 'File Name', 'Thumbnail', '' ],
			colModel : [ {
				name : 'id',
				index : 'id',
				hidden : true
			}, {
				name : 'fileName',
				index : 'fileName',
				width : 50
			}, {
				name : 'thumbnail',
				index : 'thumbnail',
				width : 50
			}, {
				name : 'manager',
				index : 'manager',
				width : 50
			} ],
			rowNum : 1000000,
			jsonReader : {
				page : function() {
					return 1;
				},
				total : function(res) {
					return res;
				},
				records : function() {
					return 1;
				},
				root : function(root) {
					return root;
				},
				repeatitems : false,
				id : "categoryId"
			}
		});

		$('#t_lstViewAttachments').html(
				'<input id="bViewAsGallery" value="View as Gallery" type="button" onclick="showGallery()" />');

		$(':button').button();
		$(':submit').button();
	});
</script>
<div style="padding: 5px">
     <input id="hdnId" type="hidden" value="${id}" />
     
     <b style="font-size: 12pt">Near Earth Object data</b>
     		    <br />
     		    
     		    <div class="datablock">
     			<table>
			     	<tr>
			     		<td>
			     		    Title:
			     		</td>
			     		<td>
			     			<span id="sNeoTitle"></span>
			     		</td>
			     	</tr>
			     	<tr>
			     		<td>
			     			Discovery date:
			     		</td>
			     		<td>
			     			<span id="sNeoDiscoveryDate"></span>
			     		</td>
			     	</tr>
			     	<tr>
			     		<td>
			     			Longitude:
			     		</td>
			     		<td>
			     			<span id="sNeoLongitude"></span>
			     		</td>
			     	</tr>
			     	<tr>
			     		<td>
			     			Latitude:
			     		</td>
			     		<td>
			     			<span id="sNeoLatitude"></span>
			     		</td>
			     	</tr>
			     	<tr>
			     		<td>
			     			Altitude:
			     		</td>
			     		<td>
			     			<span id="sNeoAltitude"></span>
			     		</td>
			     	</tr>
			     	<tr>
			     		<td>
			     			V:
			     		</td>
			     		<td>
			     			<span id="sNeoV"></span>
			     		</td>
			     	</tr>
			     	<tr>
			     		<td>
			     			H:
			     		</td>
			     		<td>
			     			<span id="sNeoH"></span>
			     		</td>
			     	</tr>
			     	<tr>
			     		<td>
			     			Arc:
			     		</td>
			     		<td>
			     			<span id="sNeoArc"></span>
			     		</td>
			     	</tr>
			     	<tr>
			     		<td>
			     			Description:
			     		</td>
			     		<td>
			     			<span id="sNeoDescription"></span>
			     		</td>
			     	</tr>
			    </table>
			    </div>
			    <div class="datablock">
			    <table style="800px">
			     	<tr>
			     		<td style="vertical-align: top; width: 200px">
			     			<b>Categories</b>
			     			<br />
			     			<ul id="ulCategories">
			     			</ul>
			     		</td>
			     		<td style="vertical-align: top">
			     			<b>Observation Records</b>
				     		<table id="lstViewObservations">
				     		</table>
			     		</td>
			     	</tr>
			     	<tr>
			     		<td>
			     		</td>
			     		<td>
			     			<b>Attachments</b>
			     			<table id="lstViewAttachments">
			     			</table>
			     		</td>
			     	</tr>
			     	
			     	
			     </table>
			     </div>
			    
			     <table style="width: 800px">
			     	<tr>
			     		<td colspan="2">
			     			<hr />
			     			<strong>Rate it Now!!!</strong>
			     			<br />
			     			<div id="pnlRatingForm">
			     				<table>
			     					<tr>
			     						<td>
			     							User:
			     						</td>
			     						<td>
			     							<span id="lblUser"><security:authentication property="principal.username" /> </span>
			     						</td>
			     					</tr>
			     					<tr>
			     						<td>
			     							Rating (Range 1 - 100): 
			     						</td>
			     						<td>
			     							<input id="txtRating" type="text"/>
			     						</td>
			     					</tr>
			     					<tr>
			     						<td>
			     							Comment:
			     						</td>
			     						<td>
			     							<textarea id="txtComment" style="width: 300px;height:50px"></textarea>
			     						</td>
			     					</tr>
			     					<tr>
			     						<td colspan="2" style="text-align: right">
			     							<input id="bAddComment" value="Add Rating" type="button" onclick="addComment()" />
			     						</td>
			     					</tr>
			     				</table>
			     			</div>
			     			<hr />
			     			<h1 style="color: #009">Comments and Ratings</h1>
			     			<div id="pnlComments">
			     				<table id="lstComments" style="width: 100%">
			     				</table>
			     			</div>
			     		</td>
			     	</tr>
			     </table>
     
     <div id="dlgImageManager">
     	<div id="pnlImageManager">
     	</div>
     </div>
     <br />
     <div style="text-align: right">
     	<a href="<c:url value="/nearearthobject/listdisplay" />">Return to List</a>
     </div>
</div>