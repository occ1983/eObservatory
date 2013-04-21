<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<script type="text/javascript">
	var polygons = [];
	var canvas, ctx;

	function addSurroundingArea()
	{
		$('#spMessage').html('Please draw lines around the area you wish to identify.');
		ctx.beginPath();
	}

	function endSurroundingArea()
	{
		ctx.fill();
	}

	/*function setVertex(event)
	{
		var pointX = event.clientX - Math.floor($('#imageCanvas').offset().left);
		var pointY = event.clientY - Math.floor($('#imageCanvas').offset().top);
		ctx.lineTo(pointX, pointY);
	}*/

	function discardSurroundingArea()
	{

	}

	function managerSave()
	{
		$('#dlgAreaProperties').dialog('show');
	}

	function managerClose()
	{
		$('#dlgImageManager').dialog('close');
	}

	$(function()
	{
		$('#dlgAreaProperties').dialog({title: 'Area Properties', width: 400, height: 300, modal: true, resizable: false, autoOpen: false});
		$('#imgAttachment').attr('src', rootUrl + 'attachment/getfilebyattachmentid?id=${attachmentId}');
		$(':button').button();
		//$('#imgAttachment').attr('src', rootUrl + '')

		/*parentContainer = document.getElementById('dlgImageManager');
		var img = $('<img>');
		canvas = $('<canvas>');
		ctx = canvas[0].getContext('2d');

		img.load(function()
		{
			//$('#imageCanvas').width(img[0].width); 
			//$('#imageCanvas').height(img[0].height);
			canvas.width(img[0].width); 
			canvas.height(img[0].height);
			ctx.drawImage(this, 0, 0, img[0].width, img[0].height);
			$('#pnlAttachment').append(canvas[0]);
			//$('#imageCanvas').append(img);
			//alert(img[0].width + ' ' + img.height());
			//$('#imageCanvas').attr('class', 'width:' + img[0].width + ';height:' + img[0].height);
			
			//$('#imageCanvas').height(img.attr('height'));
									
		});

		img.attr('src', rootUrl + 'attachment/getfilebyattachmentid?id=${attachmentId}');
		*/
	});
</script>

<div>
	<div id="pnlAttachment" style="width: 760px; height: 480px; overflow: auto">
		<img id="imgAttachment" />
		<!--<canvas id="imageCanvas" width="100%" height="100%" onclick="setVertex(event)">
		</canvas>-->
	</div>
	<div id="pnlManagerToolbar" style="text-align: right;">
		<span id="spMessage"></span>
		<!-- <input id="bNewPolygon" type="button" value="Add Area" onclick="addSurroundingArea()" />
		<input id="bNewPolygon" type="button" value="Confirm Area Path" onclick="endSurroundingArea()" />
		<input id="bDiscardPolygon" type="button" value="Discard Area" onclick="discardSurroundingArea()" />
		<input id="bManSave" type="button" value="Save" onclick="managerSave()" />-->
		<input id="bManClose" type="button" value="Close" onclick="managerClose()" />
	</div>
 	<div id="dlgAreaProperties"></div>
</div>