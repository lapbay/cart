<?php echo '<?xml version="1.0" encoding="UTF-8"?>' . "\n"; ?>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" dir="ltr" lang="en" xml:lang="en">
<head>
<title><?php echo $title; ?></title>
<base href="<?php echo $base; ?>" />
<script type="text/javascript" src="view/javascript/jquery/jquery-1.6.1.min.js"></script>
<script type="text/javascript" src="view/javascript/jquery/ui/jquery-ui-1.8.16.custom.min.js"></script>
<link rel="stylesheet" type="text/css" href="view/javascript/jquery/ui/themes/ui-lightness/jquery-ui-1.8.16.custom.css" />
<script type="text/javascript" src="view/javascript/jquery/ui/external/jquery.bgiframe-2.1.2.js"></script>
<script type="text/javascript" src="view/javascript/jquery/jstree/jquery.tree.min.js"></script>
<script type="text/javascript" src="view/javascript/jquery/ajaxupload.js"></script>
<script type="text/javascript" src="view/javascript/swfupload/swfupload.js"></script>
<script type="text/javascript" src="view/javascript/swfupload/jquery.swfupload.js"></script>
<style type="text/css">
body {
	padding: 0;
	margin: 0;
	background: #F7F7F7;
	font-family: Verdana, Arial, Helvetica, sans-serif;
	font-size: 11px;
}
img {
	border: 0;
}
#container {
	padding: 0px 10px 7px 10px;
	height: 340px;
}
#menu {
	clear: both;
	height: 29px;
	margin-bottom: 3px;
}
#column-left {
	background: #FFF;
	border: 1px solid #CCC;
	float: left;
	width: 20%;
	height: 500px;
	overflow: auto;
}
#column-right {
	background: #FFF;
	border: 1px solid #CCC;
	float: right;
	width: 78%;
	height: 500px;
	overflow: auto;
	text-align: center;
}
#column-right div {
	text-align: left;
	padding: 5px;
}
#column-right a {
	display: inline-block;
	text-align: center;
	border: 1px solid #EEEEEE;
	cursor: pointer;
	margin: 5px;
	padding: 5px;
}
#column-right a.selected {
	border: 1px solid #7DA2CE;
	background: #EBF4FD;
}
#column-right input {
	display: none;
}
#dialog {
	display: none;
}
.button {
	display: block;
	float: left;
	padding: 8px 5px 8px 25px;
	margin-right: 5px;
	background-position: 5px 6px;
	background-repeat: no-repeat;
	cursor: pointer;
}
.button:hover {
	background-color: #EEEEEE;
}
.thumb {
	padding: 5px;
	width: 105px;
	height: 105px;
	background: #F7F7F7;
	border: 1px solid #CCCCCC;
	cursor: pointer;
	cursor: move;
	position: relative;
}
</style>
</head>
<body>
<div id="container">
  <div id="menu"><a id="create" class="button" style="background-image: url('view/image/filemanager/folder.png');"><?php echo $button_folder; ?></a><a id="delete" class="button" style="background-image: url('view/image/filemanager/edit-delete.png');"><?php echo $button_delete; ?></a><a id="move" class="button" style="background-image: url('view/image/filemanager/edit-cut.png');"><?php echo $button_move; ?></a><a id="copy" class="button" style="background-image: url('view/image/filemanager/edit-copy.png');"><?php echo $button_copy; ?></a><a id="rename" class="button" style="background-image: url('view/image/filemanager/edit-rename.png');"><?php echo $button_rename; ?></a><a id="upload" class="button" style="background-image: url('view/image/filemanager/upload.png');"><?php echo $button_upload; ?></a><a id="refresh" class="button" style="background-image: url('view/image/filemanager/refresh.png');"><?php echo $button_refresh; ?></a><a id="multi_upload" class="button" style="background-image: url('view/image/filemanager/upload.png');">批量上传</a><a id="multi_delete" class="button" style="background-image: url('view/image/filemanager/edit-delete.png');">批量删除</a><a id="multi_image" class="button" style="background-image: url('view/image/filemanager/refresh.png');">确定</a></div>
  <div style="clear:both;"></div>
  <div id="column-left"></div>
  <div id="column-right"></div>
</div>
<script type="text/javascript"><!--
$(document).ready(function () { 
	$('#column-left').tree({
		data: { 
			type: 'json',
			async: true, 
			opts: { 
				method: 'POST', 
				url: 'index.php?route=common/filemanager/directory&token=<?php echo $token; ?>'
			} 
		},
		selected: 'top',
		ui: {		
			theme_name: 'classic',
			animation: 700
		},	
		types: { 
			'default': {
				clickable: true,
				creatable: false,
				renameable: false,
				deletable: false,
				draggable: false,
				max_children: -1,
				max_depth: -1,
				valid_children: 'all'
			}
		},
		callback: {
			beforedata: function(NODE, TREE_OBJ) { 
				if (NODE == false) {
					TREE_OBJ.settings.data.opts.static = [ 
						{
							data: 'image',
							attributes: { 
								'id': 'top',
								'directory': ''
							}, 
							state: 'closed'
						}
					];
					
					return { 'directory': '' } 
				} else {
					TREE_OBJ.settings.data.opts.static = false;  
					
					return { 'directory': $(NODE).attr('directory') } 
				}
			},		
			onselect: function (NODE, TREE_OBJ) {
				$.ajax({
					url: 'index.php?route=common/filemanager/files&token=<?php echo $token; ?>',
					type: 'POST',
					data: 'directory=' + encodeURIComponent($(NODE).attr('directory')),
					dataType: 'json',
					success: function(json) {
						html = '<div>';
						
						if (json) {
							for (i = 0; i < json.length; i++) {
								
								name = '';
								
								filename = json[i]['filename'];
								
								for (j = 0; j < filename.length; j = j + 15) {
									name += filename.substr(j, 15) + '<br />';
								}
								
								name += json[i]['size'];
								
								html += '<a file="' + json[i]['file'] + '"><img src="' + json[i]['thumb'] + '" title="' + json[i]['filename'] + '" /><br />' + name + '</a>';
							}
						}
						
						html += '</div>';
						
						$('#column-right').html(html);
					}
				});
			}
		}
	});	
	
	$('#column-right a').live('click', function () {
		if ($(this).attr('class') == 'selected') {
			$(this).removeAttr('class');
		} else {
			//$('#column-right a').removeAttr('class');
			
			$(this).attr('class', 'selected');
		}
	});
	$('#multi_image').bind('click', function () {
		$('#column-right>div>a.selected').each(function(data){
//			//$(this).attr('file')
			parent.addMultiImage($(this).attr('file'));
				
			});
		parent.$('#dialog').dialog('close');
		
		parent.$('#dialog').remove();
		
	});
	
	$('#column-right a').live('dblclick', function () {
		<?php if ($fckeditor) { ?>
		window.opener.CKEDITOR.tools.callFunction(<?php echo $fckeditor; ?>, '<?php echo $directory; ?>' + $(this).attr('file'));
		
		self.close();	
		<?php } else { ?>
		parent.$('#<?php echo $field; ?>').attr('value', 'data/' + $(this).attr('file'));
		parent.$('#dialog').dialog('close');
		
		parent.$('#dialog').remove();	
		<?php } ?>
	});		
						
	$('#create').bind('click', function () {
		var tree = $.tree.focused();
		
		if (tree.selected) {
			$('#dialog').remove();
			
			html  = '<div id="dialog">';
			html += '<?php echo $entry_folder; ?> <input type="text" name="name" value="" /> <input type="button" value="Submit" />';
			html += '</div>';
			
			$('#column-right').prepend(html);
			
			$('#dialog').dialog({
				title: '<?php echo $button_folder; ?>',
				resizable: false
			});	
			
			$('#dialog input[type=\'button\']').bind('click', function () {
				$.ajax({
					url: 'index.php?route=common/filemanager/create&token=<?php echo $token; ?>',
					type: 'POST',
					data: 'directory=' + encodeURIComponent($(tree.selected).attr('directory')) + '&name=' + encodeURIComponent($('#dialog input[name=\'name\']').val()),
					dataType: 'json',
					success: function(json) {
						if (json.success) {
							$('#dialog').remove();
							
							tree.refresh(tree.selected);
							
							alert(json.success);
						} else {
							alert(json.error);
						}
					}
				});
			});
		} else {
			alert('<?php echo $error_directory; ?>');	
		}
	});
	
	$('#multi_delete').bind('click', function () {
		$('#column-right>div>a.selected').each(function(data){
			
			path = $(this).attr('file');
							 
			if (path) {
				$.ajax({
					url: 'index.php?route=common/filemanager/delete&token=<?php echo $token; ?>',
					type: 'POST',
					data: 'path=' + path,
					dataType: 'json',
					success: function(json) {
						if (json.success) {
							var tree = $.tree.focused();
						
							tree.select_branch(tree.selected);
							
							//alert(json.success);
						}
						
						if (json.error) {
							alert(json.error);
						}
					}
				});				
			} else {
				var tree = $.tree.focused();
				
				if (tree.selected) {
					$.ajax({
						url: 'index.php?route=common/filemanager/delete&token=<?php echo $token; ?>',
						type: 'POST',
						data: 'path=' + encodeURIComponent($(tree.selected).attr('directory')),
						dataType: 'json',
						success: function(json) {
							if (json.success) {
								tree.select_branch(tree.parent(tree.selected));
								
								tree.refresh(tree.selected);
								
								//alert(json.success);
							} 
							
							if (json.error) {
								alert(json.error);
							}
						}
					});			
				} else {
					alert('<?php echo $error_select; ?>');
				}			
			}
			
		});
		
		
	});
	
	
	$('#delete').bind('click', function () {
		path = $('#column-right a.selected').attr('file');
							 
		if (path) {
			$.ajax({
				url: 'index.php?route=common/filemanager/delete&token=<?php echo $token; ?>',
				type: 'POST',
				data: 'path=' + path,
				dataType: 'json',
				success: function(json) {
					if (json.success) {
						var tree = $.tree.focused();
					
						tree.select_branch(tree.selected);
						
						alert(json.success);
					}
					
					if (json.error) {
						alert(json.error);
					}
				}
			});				
		} else {
			var tree = $.tree.focused();
			
			if (tree.selected) {
				$.ajax({
					url: 'index.php?route=common/filemanager/delete&token=<?php echo $token; ?>',
					type: 'POST',
					data: 'path=' + encodeURIComponent($(tree.selected).attr('directory')),
					dataType: 'json',
					success: function(json) {
						if (json.success) {
							tree.select_branch(tree.parent(tree.selected));
							
							tree.refresh(tree.selected);
							
							alert(json.success);
						} 
						
						if (json.error) {
							alert(json.error);
						}
					}
				});			
			} else {
				alert('<?php echo $error_select; ?>');
			}			
		}
	});
	
	$('#move').bind('click', function () {
		$('#dialog').remove();
		
		html  = '<div id="dialog">';
		html += '<?php echo $entry_move; ?> <select name="to"></select> <input type="button" value="Submit" />';
		html += '</div>';

		$('#column-right').prepend(html);
		
		$('#dialog').dialog({
			title: '<?php echo $button_move; ?>',
			resizable: false
		});

		$('#dialog select[name=\'to\']').load('index.php?route=common/filemanager/folders&token=<?php echo $token; ?>');
		
		$('#dialog input[type=\'button\']').bind('click', function () {
			path = $('#column-right a.selected').attr('file');
							 
			if (path) {																
				$.ajax({
					url: 'index.php?route=common/filemanager/move&token=<?php echo $token; ?>',
					type: 'POST',
					data: 'from=' + encodeURIComponent(path) + '&to=' + encodeURIComponent($('#dialog select[name=\'to\']').val()),
					dataType: 'json',
					success: function(json) {
						if (json.success) {
							$('#dialog').remove();
							
							var tree = $.tree.focused();
							
							tree.select_branch(tree.selected);
							
							alert(json.success);
						}
						
						if (json.error) {
							alert(json.error);
						}
					}
				});
			} else {
				var tree = $.tree.focused();
				
				$.ajax({
					url: 'index.php?route=common/filemanager/move&token=<?php echo $token; ?>',
					type: 'POST',
					data: 'from=' + encodeURIComponent($(tree.selected).attr('directory')) + '&to=' + encodeURIComponent($('#dialog select[name=\'to\']').val()),
					dataType: 'json',
					success: function(json) {
						if (json.success) {
							$('#dialog').remove();
							
							tree.select_branch('#top');
								
							tree.refresh(tree.selected);
							
							alert(json.success);
						}						
						
						if (json.error) {
							alert(json.error);
						}
					}
				});				
			}
		});
	});

	$('#copy').bind('click', function () {
		$('#dialog').remove();
		
		html  = '<div id="dialog">';
		html += '<?php echo $entry_copy; ?> <input type="text" name="name" value="" /> <input type="button" value="Submit" />';
		html += '</div>';

		$('#column-right').prepend(html);
		
		$('#dialog').dialog({
			title: '<?php echo $button_copy; ?>',
			resizable: false
		});
		
		$('#dialog select[name=\'to\']').load('index.php?route=common/filemanager/folders&token=<?php echo $token; ?>');
		
		$('#dialog input[type=\'button\']').bind('click', function () {
			path = $('#column-right a.selected').attr('file');
							 
			if (path) {																
				$.ajax({
					url: 'index.php?route=common/filemanager/copy&token=<?php echo $token; ?>',
					type: 'POST',
					data: 'path=' + encodeURIComponent(path) + '&name=' + encodeURIComponent($('#dialog input[name=\'name\']').val()),
					dataType: 'json',
					success: function(json) {
						if (json.success) {
							$('#dialog').remove();
							
							var tree = $.tree.focused();
							
							tree.select_branch(tree.selected);
							
							alert(json.success);
						}						
						
						if (json.error) {
							alert(json.error);
						}
					}
				});
			} else {
				var tree = $.tree.focused();
				
				$.ajax({
					url: 'index.php?route=common/filemanager/copy&token=<?php echo $token; ?>',
					type: 'POST',
					data: 'path=' + encodeURIComponent($(tree.selected).attr('directory')) + '&name=' + encodeURIComponent($('#dialog input[name=\'name\']').val()),
					dataType: 'json',
					success: function(json) {
						if (json.success) {
							$('#dialog').remove();
							
							tree.select_branch(tree.parent(tree.selected));
							
							tree.refresh(tree.selected);
							
							alert(json.success);
						} 						
						
						if (json.error) {
							alert(json.error);
						}
					}
				});				
			}
		});	
	});
	
	$('#rename').bind('click', function () {
		$('#dialog').remove();
		
		html  = '<div id="dialog">';
		html += '<?php echo $entry_rename; ?> <input type="text" name="name" value="" /> <input type="button" value="Submit" />';
		html += '</div>';

		$('#column-right').prepend(html);
		
		$('#dialog').dialog({
			title: '<?php echo $button_rename; ?>',
			resizable: false
		});
		
		$('#dialog input[type=\'button\']').bind('click', function () {
			path = $('#column-right a.selected').attr('file');
							 
			if (path) {		
				$.ajax({
					url: 'index.php?route=common/filemanager/rename&token=<?php echo $token; ?>',
					type: 'POST',
					data: 'path=' + encodeURIComponent(path) + '&name=' + encodeURIComponent($('#dialog input[name=\'name\']').val()),
					dataType: 'json',
					success: function(json) {
						if (json.success) {
							$('#dialog').remove();
							
							var tree = $.tree.focused();
					
							tree.select_branch(tree.selected);
							
							alert(json.success);
						} 
						
						if (json.error) {
							alert(json.error);
						}
					}
				});			
			} else {
				var tree = $.tree.focused();
				
				$.ajax({ 
					url: 'index.php?route=common/filemanager/rename&token=<?php echo $token; ?>',
					type: 'POST',
					data: 'path=' + encodeURIComponent($(tree.selected).attr('directory')) + '&name=' + encodeURIComponent($('#dialog input[name=\'name\']').val()),
					dataType: 'json',
					success: function(json) {
						if (json.success) {
							$('#dialog').remove();
								
							tree.select_branch(tree.parent(tree.selected));
							
							tree.refresh(tree.selected);
							
							alert(json.success);
						} 
						
						if (json.error) {
							alert(json.error);
						}
					}
				});
			}
		});		
	});
	$('#multi_upload').bind('click', function () {
		swfupdiv = $("#swfupload-control");
		if(swfupdiv.length){
			dsp = swfupdiv.css('display');
			if(dsp=='none') dsp = '';
			else dsp = 'none';
			swfupdiv.css('display',dsp);
			return;
		}
		$("#menu").after('<div style="clear:both;"></div><div id="swfupload-control"><p>请选择多张图片(jpg, png, gif)<input type="button" value="上传完成" onclick="$(\'#swfupload-control\').css(\'display\',\'none\');" id="btncl" /></p><input type="button"  id="button" /><p id="queuestatus" ></p><ol id="log"></ol></div>');
			$('#swfupload-control').swfupload({
				upload_url: 'view/javascript/swfupload/upload-file.php?token=<?php echo $token; ?>&PHPSESSID=<?=session_id()?>',
				file_post_name: 'image',
				file_size_limit : "1024",
				file_types : "*.jpg;*.png;*.gif",
				file_types_description : "Image files",
				file_upload_limit : 1000,
				flash_url : "view/javascript/swfupload/swfupload.swf",
				button_image_url : 'view/javascript/swfupload/wdp_buttons_upload_114x29.png',
				button_width : 114,
				button_height : 29,
				button_placeholder : $('#button')[0],
				debug: false,
				post_params : {
				    token : "<?php echo $token; ?>",
				    directory:"test/",
				    PHPSESSID:"<?=session_id()?>"
				}
			})
				.bind('fileQueued', function(event, file){
					var listitem='<li id="'+file.id+'" >'+
						'File: <em>'+file.name+'</em> ('+Math.round(file.size/1024)+' KB) <span class="progressvalue" ></span>'+
						'<div class="progressbar" ><div class="progress" ></div></div>'+
						'<p class="status" >Pending</p>'+
						'<span class="cancel" >&nbsp;</span>'+
						'</li>';
					$('#log').append(listitem);
					$('li#'+file.id+' .cancel').bind('click', function(){
						var swfu = $.swfupload.getInstance('#swfupload-control');
						swfu.cancelUpload(file.id);
						$('li#'+file.id).slideUp('fast');
					});
					swfu = $.swfupload.getInstance('#swfupload-control');
					var tree = $.tree.focused();
					swfu.setPostParams({'directory': $(tree.selected).attr('directory')});
					// start the upload since it's queued
					$(this).swfupload('startUpload');
				})
				.bind('fileQueueError', function(event, file, errorCode, message){
					alert('Size of the file '+file.name+' is greater than limit');
				})
				.bind('fileDialogComplete', function(event, numFilesSelected, numFilesQueued){
					$('#queuestatus').text('Files Selected: '+numFilesSelected+' / Queued Files: '+numFilesQueued);
				})
				.bind('uploadStart', function(event, file){
					$('#log li#'+file.id).find('p.status').text('Uploading...');
					$('#log li#'+file.id).find('span.progressvalue').text('0%');
					$('#log li#'+file.id).find('span.cancel').hide();
				})
				.bind('uploadProgress', function(event, file, bytesLoaded){
					//Show Progress
					var percentage=Math.round((bytesLoaded/file.size)*100);
					$('#log li#'+file.id).find('div.progress').css('width', percentage+'%');
					$('#log li#'+file.id).find('span.progressvalue').text(percentage+'%');
				})
				.bind('uploadSuccess', function(event, file, serverData){
					var item=$('#log li#'+file.id);
					item.find('div.progress').css('width', '100%');
					item.find('span.progressvalue').text('100%');					
					item.addClass('success').find('p.status').html('Done!!! | ');
					$("li#"+file.id).remove();
				})
				.bind('uploadComplete', function(event, file){
					// upload has completed, try the next one in the queue
						var tree = $.tree.focused();
						tree.select_branch(tree.selected);
						$(this).swfupload('startUpload');
				});
		
	});
	new AjaxUpload('#upload', {
		action: 'index.php?route=common/filemanager/upload&token=<?php echo $token; ?>',
		name: 'image',
		autoSubmit: false,
		responseType: 'json',
		onChange: function(file, extension) {
			var tree = $.tree.focused();
			
			if (tree.selected) {
				this.setData({'directory': $(tree.selected).attr('directory')});
			} else {
				this.setData({'directory': ''});
			}
			
			this.submit();
		},
		onSubmit: function(file, extension) {
			$('#upload').append('<img src="view/image/loading.gif" id="loading" style="padding-left: 5px;" />');
		},
		onComplete: function(file, json) {
			if (json.success) {
				var tree = $.tree.focused();
					
				tree.select_branch(tree.selected);
				
				alert(json.success);
			}
			
			if (json.error) {
				alert(json.error);
			}
			
			$('#loading').remove();	
		}
	});
	
	$('#refresh').bind('click', function () {
		var tree = $.tree.focused();
		
		tree.refresh(tree.selected);
	});	
});
//--></script>
</body>
</html>