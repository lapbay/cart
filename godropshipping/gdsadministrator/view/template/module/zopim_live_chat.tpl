<!-- 
 * @package Zopim Live Chat
 * @version 0.2.0
-->
<?php echo $header; ?>
<div
	id="content">
	<div class="breadcrumb">
	<?php foreach ($breadcrumbs as $breadcrumb) { ?>
	<?php echo $breadcrumb['separator']; ?>
		<a href="<?php echo $breadcrumb['href']; ?>"><?php echo $breadcrumb['text']; ?>
		</a>
		<?php } ?>
	</div>
	<?php if ($error_warning) { ?>
	<div class="warning">
	<?php echo $error_warning; ?>
	</div>
	<?php } ?>
	<div class="box">
		<div class="heading">
			<h1>
				<img src="view/image/module.png" alt="" />
				<?php echo $heading_title; ?>
			</h1>
			<div class="buttons">
				<a onclick="$('#form').submit();" class="button"><span><?php echo $button_save; ?>
				</span> </a><a onclick="location = '<?php echo $cancel; ?>';"
					class="button"><span><?php echo $button_cancel; ?> </span> </a>
			</div>
		</div>

		<div class="content">
			<form action="<?php echo $action; ?>" method="post"
				enctype="multipart/form-data" id="form">
				<table class="form">
					<tr>
						<td colspan="2"><strong><?php echo $text_account_setting; ?> </strong>
						<?php if ($error_account) { ?> <span class="error"><?php echo $error_account; ?>
						</span> <?php } ?> <input type="hidden" name="zopim_salt"
							value="<?php echo $zopim_salt; ?>" size="30" /> <input
							type="hidden" name="zopim_code"
							value="<?php echo $zopim_code; ?>" size="30" />
						</td>
					</tr>
					<tr>
						<td><span class="required">*</span> <?php echo $entry_username; ?>
						</td>
						<td><input type="text" name="zopim_username"
							value="<?php echo $zopim_username; ?>" size="30" /> <?php if ($error_username) { ?>
							<span class="error"><?php echo $error_username; ?> </span> <?php } ?>
						</td>
					</tr>
					<tr>
						<td><span class="required">*</span> <?php echo $entry_password; ?>
						</td>
						<td><input type="password" name="zopim_password"
							value="<?php echo $zopim_password; ?>" size="30" /> <?php if ($error_password) { ?>
							<span class="error"><?php echo $error_password; ?> </span> <?php } ?>
						</td>
					</tr>
					<tr>
						<td><?php echo $entry_usessl; ?></td>
						<td><input type="checkbox" name="zopim_usessl" value="true"
						<?php if($zopim_usessl==true) echo 'checked="checked"'; ?> />
							uncheck this if you are unable to login</td>
					</tr>
					<tr>
						<td><a href="<?php echo $zopimDashboard; ?>" target="_blank">Zopim Dashboard</a><br /></td>
						<td>
							<strong><?php echo $zopim_accountDetails; ?></strong><br />
							The Zopim chat bar will displayed on your site once your account is linked up.
						</td>
					</tr>
					<tr>
						<td colspan="2"><h3>
						<?php echo $text_support_us; ?>
							</h3>
						</td>
					</tr>
					<tr>
						<td colspan="2"><?php echo $text_paypal_donate; ?></td>
					</tr>
					<tr>
						<td colspan="2"><?php echo $text_zopim_aff; ?></td>
					</tr>
					<tr>
						<td colspan="2"><?php echo $text_licensepal_aff; ?></td>
					</tr>
					<tr>
						<td colspan="2">
							<div style="width: 270px; height: 125px; position: relative;">
								<style>
a:hover#z_tryme_01 {
	background-position: 0 27px;
}
</style>
								<a id="z_tryme_01"
									style="display: none; position: absolute; width: 92px; height: 27px; top: 76px; left: 94px; background-image: url('https://www.zopim.com/static/affiliates/tryme_01.png')"
									href="javascript: $zopim.livechat.window.toggle();"></a><a
									href="http://www.zopim.com/affiliates/landing/webwoke"
									target="_blank"><img
									src="https://www.zopim.com/static/affiliates/banner_01.jpg"
									alt="zopim" /> <script type="text/javascript"
										src="https://www.zopim.com/static/affiliates/zbanner_01.js"></script>
							
							</div>
						</td>
					</tr>
				</table>

				<table class="form">
					<tr>
						<td colspan="2"><strong><?php echo $text_general_setting; ?> </strong>
						</td>
					</tr>
					<tr>
						<td><?php echo $entry_store; ?></td>
						<td><input type="text" name="zopim_store"
							id="zopim_store" value="<?php echo $zopim_store; ?>"
							size="30" onKeyup="updateSoon()" />
						</td>
					</tr>
					<tr>
						<td><?php echo $entry_language; ?></td>
						<td><select name="zopim_language" id="zopim_language"
							onchange="updateWidget()">
							<?php foreach($zopimLanguage as $key=>$value): ?>
								<option value="<?php echo $key;?>"
								<?php if($zopim_language==$key) echo 'selected="selected"';?>>
									<?php echo $value;?>
								</option>
								<?php endforeach; ?>
						</select>
						</td>
					</tr>
					<tr>
						<td><?php echo $entry_position; ?></td>
						<td><select name="zopim_position" id="zopim_position"
							onchange="updatePosition()">
							<?php foreach($zopimPosition as $key=>$value): ?>
								<option value="<?php echo $key;?>"
								<?php if($zopim_position==$key) echo 'selected="selected"';?>>
									<?php echo $value;?>
								</option>
								<?php endforeach; ?>
						</select>
						</td>
					</tr>
					<tr>
						<td><?php echo $entry_hideOnOffline; ?></td>
						<td><input type="checkbox" name="zopim_hideonoffline"
							id="zopim_hideonoffline" value="true"
							<?php if($zopim_hideonoffline==true) echo 'checked="checked"'; ?>
							onchange="updateWidget()" />
						</td>
					</tr>
					<tr>
						<td colspan="2"><strong><?php echo $text_theme_setting; ?> </strong>
						</td>
					</tr>
					<tr>
						<td><?php echo $entry_color; ?></td>
						<td><input type="hidden" id="zopim_color" name="zopim_color"
							value="<?php echo $zopim_color; ?>">
							<div
								style='display: inline-block; border: 11px solid #888; background: #888; color: #fee;'>
								<?php
								$i=0;
								foreach ($zopimColors as $color) {
									echo "<div class='swatch' style='background-color: $color;float: left;width: 15px;' onclick=\"document.getElementById('zopim_color').value='$color'; updateWidget();\">&nbsp</div>";
									if (++$i%40==0) {
										echo "<br>";
									}
								}
								echo "<br><a href=# style='color:#ff8' onclick=\"document.getElementById('zopim_color').value=''; updateWidget();\">Restore default color</a></div>";
								?>
							</div>
						</td>
					</tr>
					<tr>
						<td><?php echo $entry_theme; ?></td>
						<td><select name="zopim_theme" id="zopim_theme"
							onchange="updateWidget()">
							<?php foreach ($zopimThemes as $theme) { ?>
								<option value="<?php echo $theme;?>"
								<?php if($zopim_theme==$theme) echo 'selected="selected"';?>>
									<?php echo $theme;?>
								</option>
								<?php } ?>
						</select>
						</td>
					</tr>

					<tr>
						<td colspan="2"><strong><?php echo $text_bubble_setting; ?> </strong>
						</td>
					</tr>
					<tr>
						<td><?php echo $entry_BubbleEnable; ?></td>
						<td><select name="zopim_bubbleEnable" id="zopim_bubbleEnable"
							onchange="updateBubbleStatus()">
							<?php foreach ($zopimBublemodes as $key=>$value) { ?>
								<option value="<?php echo $key;?>"
								<?php if($zopim_bubbleEnable==$key) echo 'selected="selected"';?>>
									<?php echo $value;?>
								</option>
								<?php } ?>
						</select>
						</td>
					</tr>
					<tr>
						<td><?php echo $entry_BubbleTitle; ?></td>
						<td><input type="text" name="zopim_bubbletitle"
							id="zopim_bubbletitle" value="<?php echo $zopim_bubbletitle; ?>"
							size="30" onKeyup="updateSoon()" />
						</td>
					</tr>
					<tr>
						<td><?php echo $entry_BubbleText; ?></td>
						<td><input type="text" name="zopim_bubbletext"
							id="zopim_bubbletext" value="<?php echo $zopim_bubbletext; ?>"
							size="30" onKeyup="updateSoon()" />
						</td>
					</tr>
					<tr>
						<td colspan="2"><strong><?php echo $text_greeting_setting; ?> </strong>
						</td>
					</tr>
					<tr>
						<td><?php echo $entry_UseGreetings; ?></td>
						<td><input type="checkbox" name="zopim_UseGreetings"
							id="zopim_UseGreetings" value="true"
							onchange="greetingsChanged()"
							<?php if($zopim_UseGreetings==true) echo 'checked="checked"'; ?> />
						</td>
					</tr>
					<tr>
						<td colspan="2"><strong><?php echo $text_greeting_short; ?> </strong>
						</td>
					</tr>
					<tr>
						<td><?php echo $entry_OnlineShort; ?></td>
						<td><input type="text" name="zopim_OnlineShort"
							id="zopim_OnlineShort" value="<?php echo $zopim_OnlineShort; ?>"
							maxlength="26" size="30" onKeyup="updateSoon()" />
						</td>
					</tr>
					<tr>
						<td><?php echo $entry_AwayShort; ?></td>
						<td><input type="text" name="zopim_AwayShort" id="zopim_AwayShort"
							value="<?php echo $zopim_AwayShort; ?>" maxlength="26" size="30"
							onKeyup="updateSoon()" />
						</td>
					</tr>
					<tr>
						<td><?php echo $entry_OfflineShort; ?></td>
						<td><input type="text" name="zopim_OfflineShort"
							id="zopim_OfflineShort"
							value="<?php echo $zopim_OfflineShort; ?>" maxlength="26"
							size="30" onKeyup="updateSoon()" />
						</td>
					</tr>
					<tr>
						<td colspan="2"><strong><?php echo $text_greeting_long; ?> </strong>
						</td>
					</tr>
					<tr>
						<td><?php echo $entry_OnlineLong; ?></td>
						<td><input type="text" name="zopim_OnlineLong"
							id="zopim_OnlineLong" value="<?php echo $zopim_OnlineLong; ?>"
							maxlength="140" size="70" onKeyup="updateSoon()" />
						</td>
					</tr>
					<tr>
						<td><?php echo $entry_AwayLong; ?></td>
						<td><input type="text" name="zopim_AwayLong" id="zopim_AwayLong"
							value="<?php echo $zopim_AwayLong; ?>" maxlength="140" size="70"
							onKeyup="updateSoon()" />
						</td>
					</tr>
					<tr>
						<td><?php echo $entry_OfflineLong; ?></td>
						<td><input type="text" name="zopim_OfflineLong"
							id="zopim_OfflineLong" value="<?php echo $zopim_OfflineLong; ?>"
							maxlength="140" size="70" onKeyup="updateSoon()" />
						</td>
					</tr>
				</table>

				<table id="module" class="list">
					<thead>
						<tr>
							<td class="left"><?php echo $entry_layout; ?></td>
							<td class="left"><?php echo $entry_position; ?></td>
							<td class="left"><?php echo $entry_status; ?></td>
							<td class="right"><?php echo $entry_sort_order; ?></td>
							<td></td>
						</tr>
					</thead>
					<?php $module_row = 0; ?>
					<?php foreach ($modules as $module) { ?>
					<tbody id="module-row<?php echo $module_row; ?>">
						<tr>
							<td class="left"><select
								name="zopim_live_chat_module[<?php echo $module_row; ?>][layout_id]">
								<?php foreach ($layouts as $layout) { ?>
								<?php if ($layout['layout_id'] == $module['layout_id']) { ?>
									<option value="<?php echo $layout['layout_id']; ?>"
										selected="selected">
										<?php echo $layout['name']; ?>
									</option>
									<?php } else { ?>
									<option value="<?php echo $layout['layout_id']; ?>">
									<?php echo $layout['name']; ?>
									</option>
									<?php } ?>
									<?php } ?>
							</select></td>
							<td class="left"><select
								name="zopim_live_chat_module[<?php echo $module_row; ?>][position]">
								<?php if ($module['position'] == 'content_top') { ?>
									<option value="content_top" selected="selected">
									<?php echo $text_content_top; ?>
									</option>
									<?php } else { ?>
									<option value="content_top">
									<?php echo $text_content_top; ?>
									</option>
									<?php } ?>
									<?php if ($module['position'] == 'content_bottom') { ?>
									<option value="content_bottom" selected="selected">
									<?php echo $text_content_bottom; ?>
									</option>
									<?php } else { ?>
									<option value="content_bottom">
									<?php echo $text_content_bottom; ?>
									</option>
									<?php } ?>
									<?php if ($module['position'] == 'column_left') { ?>
									<option value="column_left" selected="selected">
									<?php echo $text_column_left; ?>
									</option>
									<?php } else { ?>
									<option value="column_left">
									<?php echo $text_column_left; ?>
									</option>
									<?php } ?>
									<?php if ($module['position'] == 'column_right') { ?>
									<option value="column_right" selected="selected">
									<?php echo $text_column_right; ?>
									</option>
									<?php } else { ?>
									<option value="column_right">
									<?php echo $text_column_right; ?>
									</option>
									<?php } ?>
							</select></td>
							<td class="left"><select
								name="zopim_live_chat_module[<?php echo $module_row; ?>][status]">
								<?php if ($module['status']) { ?>
									<option value="1" selected="selected">
									<?php echo $text_enabled; ?>
									</option>
									<option value="0">
									<?php echo $text_disabled; ?>
									</option>
									<?php } else { ?>
									<option value="1">
									<?php echo $text_enabled; ?>
									</option>
									<option value="0" selected="selected">
									<?php echo $text_disabled; ?>
									</option>
									<?php } ?>
							</select></td>
							<td class="right"><input type="text"
								name="zopim_live_chat_module[<?php echo $module_row; ?>][sort_order]"
								value="<?php echo $module['sort_order']; ?>" size="3" /></td>
							<td class="left"><a
								onclick="$('#module-row<?php echo $module_row; ?>').remove();"
								class="button"><span><?php echo $button_remove; ?> </span> </a>
							</td>
						</tr>
					</tbody>
					<?php $module_row++; ?>
					<?php } ?>
					<tfoot>
						<tr>
							<td colspan="4"></td>
							<td class="left"><a onclick="addModule();" class="button"><span><?php echo $button_add_module; ?>
								</span> </a></td>
						</tr>
					</tfoot>
				</table>
			</form>
		</div>

	</div>

	<?php
	if(isset($zopim_code) AND $zopim_code<>"error"):
	?>
	<!-- Start of Zopim Live Chat Script -->
	<script type="text/javascript">
window.$zopim||(function(d,s){var z=$zopim=function(c){z._.push(c)},$=
z.s=d.createElement(s),e=d.getElementsByTagName(s)[0];z.set=function(o
){z.set._.push(o)};$.setAttribute('charset','utf-8');$.async=!0;z.set.
_=[];$.src=('https:'==d.location.protocol?'https://ssl':'http://cdn')+
'.zopim.com/?<?php echo $zopim_code; ?>';$.type='text/java'+s;z.
t=+new Date;z._=[];e.parentNode.insertBefore($,e)})(document,'script')
</script>
	<!-- End of Zopim Live Chat Script -->


	<script type="text/javascript"> 
$zopim( function() {
$zopim.livechat.bubble.setTitle('<?php echo $zopim_bubbletitle; ?>');
$zopim.livechat.bubble.setText('<?php echo $zopim_bubbletext; ?>');
$zopim.livechat.setName('Visitor <?php echo $zopim_store; ?>');
})</script>

	<script type="text/javascript">

   function updateWidget() {

      var lang = document.getElementById('zopim_language').options[ document.getElementById('zopim_language').options.selectedIndex ].value;
      $zopim.livechat.setLanguage(lang);
      $zopim.livechat.setName('Visitor');
      $zopim.livechat.setEmail('');

      if (document.getElementById("zopim_hideonoffline").checked) {
         $zopim.livechat.button.setHideWhenOffline(true);
      } else {
         $zopim.livechat.button.setHideWhenOffline(false);
      }

      $zopim.livechat.window.setColor(document.getElementById("zopim_color").value);
      $zopim.livechat.window.setTheme(document.getElementById("zopim_theme").value);

      $zopim.livechat.bubble.setTitle(document.getElementById("zopim_bubbletitle").value);
      $zopim.livechat.bubble.setText(document.getElementById("zopim_bubbletext").value);

      $zopim.livechat.setGreetings({
         'online': [document.getElementById("zopim_OnlineShort").value, document.getElementById("zopim_OnlineLong").value],
            'offline': [document.getElementById("zopim_OfflineShort").value, document.getElementById("zopim_OfflineLong").value],
            'away': [document.getElementById("zopim_AwayShort").value, document.getElementById("zopim_AwayLong").value]
      });
   }

   function updatePosition() {
      var position = document.getElementById('zopim_position').options[ document.getElementById('zopim_position').options.selectedIndex ].value;
      $zopim.livechat.button.setPosition(position);
   }

   function updateBubbleStatus() {
			var value = document.getElementById("zopim_bubbleEnable").value;
			switch (value) {
				case 'default':
					$zopim.livechat.bubble.reset();
					break;
				case 'show':
					$zopim.livechat.bubble.show();
					break;
				case 'hide':
					$zopim.livechat.bubble.hide();
					break;
			}
   }
		
	function greetingsChanged() {
    var inputs = ['zopim_OnlineShort', 'zopim_AwayShort', 'zopim_OfflineShort',
                  'zopim_OnlineLong' , 'zopim_AwayLong', 'zopim_OfflineLong'];
    var isDisabled = false;

    if (document.getElementById('zopim_UseGreetings').checked) 
			isDisabled = false;
    else 
			isDisabled = true;

    for (var i=0; i<inputs.length; i++) {
        var el = document.getElementById(inputs[i]);
        el.disabled = isDisabled;
    }

		updateWidget();
	}

   var timer;
   function updateSoon() {

      clearTimeout(timer);
      timer = setTimeout("updateWidget()", 300);
   }
   </script>
   <?php
   endif;
   ?>
	<script type="text/javascript"><!--
var module_row = <?php echo $module_row; ?>;

function addModule() {	
	html  = '<tbody id="module-row' + module_row + '">';
	html += '  <tr>';
	html += '    <td class="left"><select name="zopim_live_chat_module[' + module_row + '][layout_id]">';
	<?php foreach ($layouts as $layout) { ?>
	html += '      <option value="<?php echo $layout['layout_id']; ?>"><?php echo $layout['name']; ?></option>';
	<?php } ?>
	html += '    </select></td>';
	html += '    <td class="left"><select name="zopim_live_chat_module[' + module_row + '][position]">';
	html += '      <option value="content_top"><?php echo $text_content_top; ?></option>';
	html += '      <option value="content_bottom"><?php echo $text_content_bottom; ?></option>';
	html += '      <option value="column_left"><?php echo $text_column_left; ?></option>';
	html += '      <option value="column_right"><?php echo $text_column_right; ?></option>';
	html += '    </select></td>';
	html += '    <td class="left"><select name="zopim_live_chat_module[' + module_row + '][status]">';
    html += '      <option value="1" selected="selected"><?php echo $text_enabled; ?></option>';
    html += '      <option value="0"><?php echo $text_disabled; ?></option>';
    html += '    </select></td>';
	html += '    <td class="right"><input type="text" name="zopim_live_chat_module[' + module_row + '][sort_order]" value="" size="3" /></td>';
	html += '    <td class="left"><a onclick="$(\'#module-row' + module_row + '\').remove();" class="button"><span><?php echo $button_remove; ?></span></a></td>';
	html += '  </tr>';
	html += '</tbody>';
	
	$('#module tfoot').before(html);
	
	module_row++;
}
//--></script>
<?php echo $footer; ?>