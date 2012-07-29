<?php if (isset($_SERVER['HTTP_USER_AGENT']) && !strpos($_SERVER['HTTP_USER_AGENT'], 'MSIE 6')) echo '<?xml version="1.0" encoding="UTF-8"?>'. "\n"; ?>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" dir="<?php echo $direction; ?>" lang="<?php echo $lang; ?>" xml:lang="<?php echo $lang; ?>">
<head>
<meta http-equiv="X-UA-Compatible" content="IE=7"/>
<title><?php echo $title; ?></title>
<base href="<?php echo $base; ?>" />
<?php if ($description) { ?>
<meta name="description" content="<?php echo $description; ?>" />
<?php } ?>
<?php if ($keywords) { ?>
<meta name="keywords" content="<?php echo $keywords; ?>" />
<?php } ?>
<?php if ($icon) { ?>
<link href="<?php echo $icon; ?>" rel="icon" />
<?php } ?>
<?php foreach ($links as $link) { ?>
<link href="<?php echo $link['href']; ?>" rel="<?php echo $link['rel']; ?>" />
<?php } ?>
<link rel="stylesheet" type="text/css" href="catalog/view/theme/supermarket/stylesheet/stylesheet.css" />
<link rel="stylesheet" type="text/css" href="catalog/view/theme/supermarket/stylesheet/global.css" />
<!--<link rel="stylesheet" type="text/css" href="catalog/view/theme/supermarket/stylesheet/carousel.css" />-->
<?php foreach ($styles as $style) { ?>
<link rel="<?php echo $style['rel']; ?>" type="text/css" href="<?php echo $style['href']; ?>" media="<?php echo $style['media']; ?>" />
<?php } ?>
<script type="text/javascript" src="catalog/view/javascript/jquery/jquery-1.6.1.min.js"></script>
<script type="text/javascript" src="catalog/view/javascript/jquery/ui/jquery-ui-1.8.16.custom.min.js"></script>
<link rel="stylesheet" type="text/css" href="catalog/view/javascript/jquery/ui/themes/ui-lightness/jquery-ui-1.8.16.custom.css" />
<script type="text/javascript" src="catalog/view/javascript/jquery/ui/external/jquery.cookie.js"></script>
<script type="text/javascript" src="catalog/view/javascript/jquery/fancybox/jquery.fancybox-1.3.4.pack.js"></script>
<link rel="stylesheet" type="text/css" href="catalog/view/javascript/jquery/fancybox/jquery.fancybox-1.3.4.css" media="screen" />
<!--[if IE]>
<script type="text/javascript" src="catalog/view/javascript/jquery/fancybox/jquery.fancybox-1.3.4-iefix.js"></script>
<![endif]--> 
<script type="text/javascript" src="catalog/view/javascript/jquery/tabs.js"></script>
<script type="text/javascript" src="catalog/view/javascript/jquery/slides.min.jquery.js"></script>
<script type="text/javascript" src="catalog/view/javascript/common.js"></script>
<!--<script type="text/javascript" src="catalog/view/javascript/jquery/jquery.jcarousel.min.js"></script>-->
<?php foreach ($scripts as $script) { ?>
<script type="text/javascript" src="<?php echo $script; ?>"></script>
<?php } ?>


<!--[if lt IE 6]>
<link rel="stylesheet" type="text/css" href="catalog/view/theme/default/stylesheet/ie6.css" />
<script type="text/javascript" src="catalog/view/javascript/DD_belatedPNG_0.0.8a-min.js"></script>
<script type="text/javascript">
DD_belatedPNG.fix('#logo img');
</script>
<![endif]-->



<!--[if IE 7]>
	<link rel="stylesheet" type="text/css" href="catalog/view/theme/supermarket/stylesheet/ie7.css" />
<![endif]-->

<!--[if IE 8]>
	<link rel="stylesheet" type="text/css" href="catalog/view/theme/supermarket/stylesheet/ie8.css" />
<![endif]-->


<!--[if IE 9]>
<link rel="stylesheet" type="text/css" href="catalog/view/theme/supermarket/stylesheet/ie9.css" />
<![endif]-->
<script type="text/javascript">

  var _gaq = _gaq || [];
  _gaq.push(['_setAccount', 'UA-33636066-1']);
  _gaq.push(['_trackPageview']);

  (function() {
    var ga = document.createElement('script'); ga.type = 'text/javascript'; ga.async = true;
    ga.src = ('https:' == document.location.protocol ? 'https://ssl' : 'http://www') + '.google-analytics.com/ga.js';
    var s = document.getElementsByTagName('script')[0]; s.parentNode.insertBefore(ga, s);
  })();

</script>
<?php echo $google_analytics; ?>
<!--Start of Zopim Live Chat Script-->
<script type="text/javascript">
window.$zopim||(function(d,s){var z=$zopim=function(c){z._.push(c)},$=z.s=
d.createElement(s),e=d.getElementsByTagName(s)[0];z.set=function(o){z.set.
_.push(o)};z._=[];z.set._=[];$.async=!0;$.setAttribute('charset','utf-8');
$.src='//cdn.zopim.com/?YVCRE7Rxoto98IhpzdU9XJRkaRPJo3ZW';z.t=+new Date;$.
type='text/javascript';e.parentNode.insertBefore($,e)})(document,'script');
</script>
<!--End of Zopim Live Chat Script-->
</head>
<body>
<div id="container">
<div id="header"> 
    <div class="top-header">
        <div class="top-left">
            <div id="welcome">
                <?php if (!$logged) { ?>
                <?php echo $text_welcome; ?>
                <?php } else { ?>
                <?php echo $text_logged; ?>
                <?php } ?>
            </div>
        </div> <!-- End .top-left -->
        
        <div class="top-right">
		
			<div class="quick-access">
                <div class="acount">
                    <ul>
						<li>
							<a class="login-icon" href="index.php?route=account/login"></a>
							<?php if (!$logged) { ?>
						<!-- Login -->
						<div class="frame_big">
						<div class="content-login">
							<form action="<?php echo $action_login; ?>" method="post" enctype="multipart/form-data" id="logintop">
								<div class="login-frame">
									<span class="title-login"><?php echo $text_login; ?></span>
									<input type="text" name="email" onblur="if(this.value=='') this.value=this.defaultValue" onfocus="if(this.value==this.defaultValue) this.value=''" value="<?php echo $text_email; ?>" />
									<input type="password" name="password" onblur="if(this.value=='') this.value=this.defaultValue" onfocus="if(this.value==this.defaultValue) this.value=''" value="<?php echo $entry_password; ?>" />
									<a onclick="$('#logintop').submit();" class="button"><span><?php echo $button_login; ?></span></a>
									<a class="forgotpass" href="<?php echo $forgotten; ?>"><?php  echo $text_forgotten; ?></a><br />
									<?php if ($redirect) { ?>
									<input type="hidden" name="redirect" value="<?php echo $redirect; ?>" />
									<?php } ?>
									<span class="signup"><?php echo $text_register; ?><a href="<?php echo $register; ?>">Sign Up</a></span>
								</div>
							</form>
						</div>
						</div><!-- end frame_big -->
						<?php } else { ?>
						<div class="frame_big">
						<div class="content-logged-frame">
							<div class="content-logged">
								<?php echo $text_logged; ?>
								<ul class="link">
									<li class="my-account"><a href="<?php echo $account; ?>"><?php echo $text_account; ?></a></li>
									<li><a href="<?php echo $wishlist; ?>" id="wishlist_total"><?php echo $text_wishlist; ?></a></li>
									<li><a href="<?php echo $cart; ?>"><?php echo $text_cart; ?></a></li>
								</ul>
							</div>
						</div><!-- content-logged-frame -->
						</div><!-- end frame_big -->
						<?php } ?>
						</li>
					</ul>
                </div> <!-- End .account -->
                               
                <div class="contact-us">
                    <ul>
						<li>
							<a class="contact-icon" href="index.php?route=information/contact"></a>
							<div class="frame_big contact_big">
							<div id="header-contact-content">
								<form action="<?php echo $action_contact; ?>" method="post" enctype="multipart/form-data" id="contactform">
									<div id="contact-content">
										<span class="title-contact">Contact Us </span>
										<input type="text" name="name" onblur="if(this.value=='') this.value=this.defaultValue" onfocus="if(this.value==this.defaultValue) this.value=''" value="<?php echo $entry_name; ?>" autocomplete="off" />
										<input type="text" name="email" onblur="if(this.value=='') this.value=this.defaultValue" onfocus="if(this.value==this.defaultValue) this.value=''" value="<?php echo $entry_email; ?>" autocomplete="off" />
										<textarea name="enquiry" cols="40" rows="10" style="width: 99%;" onblur="if(this.value=='') this.value=this.defaultValue" onfocus="if(this.value==this.defaultValue) this.value=''"><?php echo $entry_enquiry; ?></textarea>
										<div class="buttons">
											<div class="left"><a onclick="$('#contactform').submit();" class="button"><span><?php echo $button_continue; ?></span></a></div>
										</div>
										<p class="phone-contact"><?php echo $text_callus; ?> <span> 1800 - 999 9999999</span></p>
									</div>
								</form>
								<!-- end contact-content -->
							</div><!--  end header-contact-content -->
							</div><!-- end frame_big contact_big -->
						</li>
					</ul>	
                </div> <!-- End .contact-us -->
                
                <div id="search">
					<ul>
						<li>
							<a class="icon_seach" href="index.php?route=product/search"></a>
							<div class="frame_big search_big">
							<div id="search-form">
								<div id="search-form-bot">
									<span class="title-search">Search </span>
									<input type="text" name="filter_name" value="<?php echo $text_search;?>" onblur="if(this.value=='') this.value=this.defaultValue" onfocus="if(this.value==this.defaultValue) this.value=''" />
	                                    
                                    <select name="filter_category_id">
                                        <option value="0" selected="selected"><?php echo $text_category; ?></option>
                                        <?php foreach ($categories as $category_1) { ?>
                                        <?php if ($category_1['category_id'] == $filter_category_id) { ?>
                                        <option value="<?php echo $category_1['category_id']; ?>"><?php echo $category_1['name']; ?></option>
                                        <?php } else { ?>
                                        <option value="<?php echo $category_1['category_id']; ?>"><?php echo $category_1['name']; ?></option>
                                        <?php } ?>
                                        <?php if (isset($category_1['children'])) { ?>
                                        <?php foreach ($category_1['children'] as $category_2) { ?>
                                        <?php if ($category_2['category_id'] == $filter_category_id) { ?>
                                        <option value="<?php echo $category_2['category_id']; ?>">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<?php echo $category_2['name']; ?></option>
                                        <?php } else { ?>
                                        <option value="<?php echo $category_2['category_id']; ?>">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<?php echo $category_2['name']; ?></option>
                                        <?php } ?>
                                        <?php } ?>
                                        <?php if (isset($category_2['children'])) { ?>
                                        <?php foreach ($category_2['children'] as $category_3) { ?>
                                        <?php if ($category_3['category_id'] == $filter_category_id) { ?>
                                        <option value="<?php echo $category_3['category_id']; ?>">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<?php echo $category_3['name']; ?></option>
                                        <?php } else { ?>
                                        <option value="<?php echo $category_3['category_id']; ?>">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<?php echo $category_3['name']; ?></option>
                                        <?php } ?>
                                        <?php } ?>
                                        <?php } ?>
                                        <?php } ?>
                                        <?php } ?>
                                    </select><!-- End Filter all category -->
                                    
									<div class="button-search"><?php echo $button_search; ?></div>
								</div><!-- end #search-form-bot  -->
							</div><!-- end #serach-form -->
							</div><!-- end .frame_big search_big -->
						</li>
					</ul>
				</div><!-- end search -->
            </div> <!-- End .quick-access -->
			
			
		
			 <?php if (count($currencies) > 0) { ?>
                <form id="formcurrency" action="<?php echo $action; ?>" method="post" enctype="multipart/form-data">
                           <div class="title"><?php echo $text_currency; ?></div> 
                           <div>                               
                            <select id="currencybox" onchange=" $('input[name=\'currency_code\']').attr('value', this.value).submit(); $('#formcurrency').submit();">
                                  <?php foreach ($currencies as $currency) { ?>
                                  <option id="<?php echo $currency['code']; ?>"  value="<?php echo $currency['code']; ?>" <?php if ($currency['code'] == $currency_code) echo("selected='selected'") ?>>
                                      <?php if ($currency['symbol_left']) { ?>
                                            <?php echo $currency['symbol_left']; ?>
                                      <?php } else { ?>
                                            <?php echo $currency['symbol_right']; ?>
                                      <?php } ?>
                                  </option>
                                  <?php } ?>
                            </select>
                            <input type="hidden" name="currency_code" value="" />
                            <input type="hidden" name="redirect" value="<?php echo $redirect; ?>" />
                            </div>
                </form>
            <?php } ?><!-- End .currency -->
			
			
            <?php if (count($languages) > 0) { ?>
              <form id="formlang" action="<?php echo $action; ?>" method="post" enctype="multipart/form-data">
              <div class="title"><?php echo $text_language; ?></div>   
              <div>         
              <select id="langbox" onchange="$('input[name=\'language_code\']').attr('value', this.value).submit(); $('#formlang').submit();">
                      <?php foreach ($languages as $language) { ?>
                          <option id="<?php echo $language['code']; ?>" value="<?php echo $language['code'];?>" <?php if ($language['code'] == $language_code) echo("selected='selected'") ?> ><?php echo $language['code']; ?></option>
                      <?php } ?>
              </select>
              <input type="hidden" name="language_code" value="" />
              <input type="hidden" name="redirect" value="<?php echo $redirect; ?>" />
              </div>
              </form>
              <?php } ?> <!-- End #language -->
        </div> <!-- End .top-right -->
    </div> <!-- End .top-header -->
    
    <div class="content-header">
        <div class="header-left">
            <?php if ($logo) { ?>
              <div id="logo">
                <a href="<?php echo $home; ?>"><img src="<?php echo $logo; ?>" title="<?php echo $name; ?>" alt="<?php echo $name; ?>" /></a>
              </div>
            <?php } ?>
        </div> <!-- End .header-left -->
        
        <div class="header-right">
            <div class="live-chat">
        <!--        <a href="#"><?php echo $text_livechat; ?></a> -->
            </div> <!-- End .live-chat -->
            
            <div id="cart">
                <div class="heading">
                  <a><?php echo $text_cart; ?>
                  <span id="cart_total"><?php echo $text_items; ?></span></a></div>
                <div class="content"></div>
            </div>
        </div> <!-- End .header-right -->
    </div> <!-- End .header-content -->

</div> <!-- End #header -->
<?php echo $menu; ?>
<?php foreach ($modules as $module) { ?>
<?php echo $module; ?>
<?php } ?>
<script type="text/javascript"><!--
$('.feature-box-category ul').jcarousel({
	vertical: false,
	visible: 6,
	scroll: 1,
    wrap: 'circular'
});
//--></script>
