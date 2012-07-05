<?php
################################################################################
### CONFIGURE HERE
################################################################################

$dbdriver = "mysql";	# Database driver
$dbhost = "localhost";	# Database host name
$dbname = "gds"; # Database name
$dbuser = "root"; # Database username
$dbpass = "litb-461"; # Database password
$prefix = ""; # Database prefix tables

require_once('install.lib.php');
opendb($dbdriver,$dbhost,$dbname,$dbuser,$dbpass,$prefix);

################################################################################
### INSTALL BANNERS
################################################################################

$banner=array('name' => 'Banner', 'status' => 1, 'banner_image' => array(
	0 => array('banner_image_description' => array(
		1 => array('title' => 'banner')), 'link' => '#', 'image' => 'data/banner.png' )
));
addBanner($banner); 

$category=array('name' => 'Banner Category', 'status' => 1, 'banner_image' => array(
	0 => array('banner_image_description' => array(
		1 => array('title' => 'Banner Category')), 'link' => '#', 'image' => 'data/cat1.png' )
));
addBanner($category); 
$block=array('name' => 'Block', 'status' => 1, 'banner_image' => array(
	0 => array('banner_image_description' => array(
		1 => array('title' => 'block1')), 'link' => '#', 'image' => 'data/block1.png' ),
	1 => array('banner_image_description' => array(
		1 => array('title' => 'block2')), 'link' => '#', 'image' => 'data/block2.png' ),
	2 => array('banner_image_description' => array(
		1 => array('title' => 'block3')), 'link' => '#', 'image' => 'data/block3.png' ),
	4 => array('banner_image_description' => array(
		1 => array('title' => 'block4')), 'link' => '#', 'image' => 'data/block4.png' )
));
addBanner($block);

$brands=array('name' => 'Brands', 'status' => 1, 'banner_image' => array(
	0 => array('banner_image_description' => array(
		1 => array('title' => 'Lacoste')), 'link' => '#', 'image' => 'data/brand1.png' ),
	1 => array('banner_image_description' => array(
		1 => array('title' => 'Fizzler')), 'link' => '#', 'image' => 'data/brand2.png' ),
	2 => array('banner_image_description' => array(
		1 => array('title' => 'Puma')), 'link' => '#', 'image' => 'data/brand3.png' ),
	3 => array('banner_image_description' => array(
		1 => array('title' => 'Nikon')), 'link' => '#', 'image' => 'data/brand4.png' ),
	4 => array('banner_image_description' => array(
		1 => array('title' => 'Cybershot')), 'link' => '#', 'image' => 'data/brand5.png' ),
	5 => array('banner_image_description' => array(
		1 => array('title' => 'OMEGA')), 'link' => '#', 'image' => 'data/brand6.png' ),
	6 => array('banner_image_description' => array(
		1 => array('title' => 'levi')), 'link' => '#', 'image' => 'data/brand7.png' ),
	7 => array('banner_image_description' => array(
		1 => array('title' => 'HTC')), 'link' => '#', 'image' => 'data/brand8.png' )
));
addBanner($brands);

$slideshow=array('name' => 'Slide show', 'status' => 1, 'banner_image' => array(
	0 => array('banner_image_description' => array(
		1 => array('title' => 'h1')), 'link' => '#', 'image' => 'data/banner11.png' ),
	1 => array('banner_image_description' => array(
		1 => array('title' => 'h2')), 'link' => '#', 'image' => 'data/banner22.png' ),
	2 => array('banner_image_description' => array(
		1 => array('title' => 'h3')), 'link' => '#', 'image' => 'data/banner33.png' ),
	3 => array('banner_image_description' => array(
		1 => array('title' => 'h4')), 'link' => '#', 'image' => 'data/h2-01.png' )
));
addBanner($slideshow);

$static=array('name' => 'Static Block', 'status' => 1, 'banner_image' => array(
	0 => array('banner_image_description' => array(
		1 => array('title' => 'Static Block1')), 'link' => '#', 'image' => 'data/static-block1.png' ),
	1 => array('banner_image_description' => array(
		1 => array('title' => 'Static Block2')), 'link' => '#', 'image' => 'data/static-block2.png' ),
	2 => array('banner_image_description' => array(
		1 => array('title' => 'Static Block3')), 'link' => '#', 'image' => 'data/static-block3.png' ),
	3 => array('banner_image_description' => array(
		1 => array('title' => 'Static Block4')), 'link' => '#', 'image' => 'data/static-block4.png' )
));
addBanner($static);

$dealofweek=array('name' => 'dealofweek', 'status' => 1, 'banner_image' => array(
	0 => array('banner_image_description' => array(
		1 => array('title' => 'dealofweek')), 'link' => '#', 'image' => 'data/deal_of_week.png' )
));
addBanner($dealofweek);

################################################################################
### INSTALL LAYOUTS
################################################################################

$special= array ('name' => 'Special', 'layout_route' => array(
0 => array ('store_id' => 0, 'route' => 'product/special')
) );
addLayout($special);

$search= array ('name' => 'Search', 'layout_route' => array(
0 => array ('store_id' => 0, 'route' => 'product/search')
) );
addLayout($search);

################################################################################
### INSTALL MODULES
################################################################################

// uninstall module
uninstallmodule();
// install module	
$account = array('account_module' => array ( 0 => array ( 'layout_id' => getIdLayout("account"), 'position' => 'column_left', 'status' => 1, 'sort_order' => 1)
));
install('account');
editSetting('account',$account);

$affiliate = array('affiliate_module' => array ( 0 => array ( 'layout_id' => getIdLayout("affiliate"), 'position' => 'column_left', 'status' => 1, 'sort_order' => 1) ));
install('affiliate');
editSetting('affiliate',$affiliate);

$ocbanner = array('ocbanner_module' => array ( 
	0 => array ( 'banner_id' => getIdBanner("dealofweek"), 'width' => 315, 'height' => 265, 'layout_id' => getIdLayout("home"), 'position' => 'header', 'status' => 1, 'sort_order' => 2),
	1 => array ( 'banner_id' => getIdBanner("banner"), 'width' => 210, 'height' => 290, 'layout_id' => getIdLayout("category"), 'position' => 'column_left', 'status' => 1, 'sort_order' => 5),
	2 => array ( 'banner_id' => getIdBanner("banner"), 'width' => 210, 'height' => 290, 'layout_id' => getIdLayout("product"), 'position' => 'column_left', 'status' => 1, 'sort_order' => 5),
	3 => array ( 'banner_id' => getIdBanner("banner"), 'width' => 210, 'height' => 290, 'layout_id' => getIdLayout("manufacturer"), 'position' => 'column_left', 'status' => 1, 'sort_order' => 5)
	
));
install('ocbanner');
editSetting('ocbanner',$ocbanner);

$bestseller = array('bestseller_module' => array ( 
	0 => array ( 'limit' => 25, 'image_width' => 160, 'image_height' => 172, 'layout_id' => getIdLayout("home"), 'position' => 'content_top', 'status' => 1, 'sort_order' => 1) ));
install('bestseller');
editSetting('bestseller',$bestseller);

$by_alphabet = array('by_alphabet_module' => array ( 
	0 => array ( 'layout_id' => 0, 'position' => 'footer', 'status' => 1, 'sort_order' => 4)
));
install('by_alphabet');
editSetting('by_alphabet',$by_alphabet);

$occarousel = array('occarousel_module' => array ( 
	0 => array ('banner_id' => getIdBanner("brands"), 'limit' => 8, 'scroll' => 2, 'width' => 75, 'height' => 55, 'layout_id' => 0, 'position' => 'footer', 'status' => 1, 'sort_order' => '3'),
	1 => array ('banner_id' => getIdBanner("Static Block"), 'limit' => 4, 'scroll' => 0, 'width' => 195, 'height' => 45, 'layout_id' => 0, 'position' => 'footer', 'status' => 1, 'sort_order' => '1'),
	2 => array ('banner_id' => getIdBanner("Banner Category"), 'limit' => 1, 'scroll' => 0, 'width' => 912, 'height' => 260, 'layout_id' => getIdLayout("manufacturer"), 'position' => 'header', 'status' => 1, 'sort_order' => '2'),
	3 => array ('banner_id' => getIdBanner("Banner Category"), 'limit' => 1, 'scroll' => 0, 'width' => 912, 'height' => 260, 'layout_id' => getIdLayout("category"), 'position' => 'header', 'status' => 1, 'sort_order' => '2'),
	4 => array ('banner_id' => getIdBanner("Banner Category"), 'limit' => 1, 'scroll' => 0, 'width' => 912, 'height' => 260, 'layout_id' => getIdLayout("product"), 'position' => 'header', 'status' => 1, 'sort_order' => '2'),
	5 => array ('banner_id' => getIdBanner("Block"), 'limit' => 4, 'scroll' => 0, 'width' => 137, 'height' => 260, 'layout_id' => 0, 'position' => 'footer', 'status' => 1, 'sort_order' => '2')
));
install('occarousel');
editSetting('occarousel',$occarousel);

$category = array('category_module' => array ( 
	0 => array ( 'layout_id' => getIdLayout("category"), 'position' => 'column_left', 'count' => 1, 'status' => 1, 'sort_order' => 1),
	1 => array ( 'layout_id' => getIdLayout("product"), 'position' => 'column_left', 'count' => 1, 'status' => 1, 'sort_order' => 1),
	2 => array ( 'layout_id' => getIdLayout("manufacturer"), 'position' => 'column_left', 'count' => 1, 'status' => 1, 'sort_order' => 1),
	3 => array ( 'layout_id' => getIdLayout("home"), 'position' => 'column_left', 'count' => 1, 'status' => 1, 'sort_order' => 1)	
));
install('category');
editSetting('category',$category);

$categoryhome = array('categoryhome_module' => array ());
install('categoryhome');
editSetting('categoryhome',$categoryhome);

$featured = array('featured_module' => array ( 
	0 => array ( 'image_width' => 70, 'image_height' => 70, 'layout_id' => getIdLayout("home"), 'position' => 'column_left', 'status' => 1, 'sort_order' => 3),
	1 => array ( 'image_width' => 160, 'image_height' => 172, 'layout_id' => getIdLayout("category"), 'position' => 'content_top', 'status' => 1, 'sort_order' => 2)
));
install('featured');
editSetting('featured',$featured);

$featuredcategory = array('featuredcategory_module' => array ( 
	0 => array ( 'image_width' => 152, 'image_height' => 163, 'layout_id' => getIdLayout("home"), 'position' => 'header', 'status' => 1, 'sort_order' => 4),
	1 => array ( 'image_width' => 111, 'image_height' => 123, 'layout_id' => getIdLayout("category"), 'position' => 'header', 'status' => 1, 'sort_order' => 3),
	2 => array ( 'image_width' => 111, 'image_height' => 123, 'layout_id' => getIdLayout("product"), 'position' => 'header', 'status' => 1, 'sort_order' => 3),
	3 => array ( 'image_width' => 111, 'image_height' => 123, 'layout_id' => getIdLayout("manufacturer"), 'position' => 'header', 'status' => 1, 'sort_order' => 3)
));
install('featuredcategory');
editSetting('featuredcategory',$featuredcategory);

$latest = array('latest_module' => array ( 
	0 => array ( 'limit' => 10, 'image_width' => 80, 'image_height' => 80, 'layout_id' => getIdLayout("home"), 'position' => 'column_left', 'status' => 1, 'sort_order' => 2),
	1 => array ( 'limit' => 5, 'image_width' => 80, 'image_height' => 80, 'layout_id' => getIdLayout("category"), 'position' => 'column_left', 'status' => 1, 'sort_order' => 2),
	2 => array ( 'limit' => 5, 'image_width' => 80, 'image_height' => 80, 'layout_id' => getIdLayout("product"), 'position' => 'column_left', 'status' => 1, 'sort_order' => 2),
	3 => array ( 'limit' => 5, 'image_width' => 80, 'image_height' => 80, 'layout_id' => getIdLayout("manufacturer"), 'position' => 'column_left', 'status' => 1, 'sort_order' => 2)
	));
install('latest');
editSetting('latest',$latest);

$manufacturer = array('manufacturer_module' => array ( 
	0 => array ( 'layout_id' => getIdLayout("category"), 'position' => 'column_left', 'status' => 1, 'sort_order' => 3),
	1 => array ( 'layout_id' => getIdLayout("product"), 'position' => 'column_left', 'status' => 1, 'sort_order' => 3),
	2 => array ( 'layout_id' => getIdLayout("manufacturer"), 'position' => 'column_left', 'status' => 1, 'sort_order' => 3) 
));
install('manufacturer');
editSetting('manufacturer',$manufacturer);

$ocslideshow = array('ocslideshow_module' => array ( 
	0 => array ( 'description' => array (1 => '<ul id="title">
	<li>
		<div class="content-title">
			<span>consectetur D7000</span>
			<p>
				Pellentesque imperdiet viverra tristique vestibulum pellentesque laoreet nisl</p>
			<label>starting at $1200.00</label></div>
		<div class="shopnow">
			<a class="button" href="#"><span>SHOP NOW</span></a></div>
	</li>
	<li>
		<div class="content-title">
			<span>SAMSUNG Class NOTE </span>
			<p>
				Pellentesque imperdiet viverra tristique vestibulum pellentesque laoreet nisl</p>
		</div>
		<label>starting at $950.00</label>
		<div class="shopnow">
			<a class="button" href="#"><span>SHOP NOW</span></a></div>
	</li>
	<li>
		<div class="content-title">
			<span>APPLE IPAD accumsan</span>
			<p>
				Pellentesque imperdiet viverra tristique vestibulum pellentesque laoreet nisl</p>
		</div>
		<label>starting at $850.00</label>
		<div class="shopnow">
			<a class="button" href="#"><span>SHOP NOW</span></a></div>
	</li>
	<li>
		<div class="content-title">
			<span>SONY accumsan</span>
			<p>
				Pellentesque imperdiet viverra tristique vestibulum pellentesque laoreet nisl</p>
		</div>
		<label>starting at $850.00</label>
		<div class="shopnow">
			<a class="button" href="#"><span>SHOP NOW</span></a></div>
	</li>
</ul>
'), 'banner_id' => getIdBanner("Slide show"), 'width' => 313, 'height' => 256, 'layout_id' => getIdLayout("home"), 'position' => 'header', 'status' => 1, 'sort_order' => 2)
));
install('ocslideshow');
editSetting('ocslideshow',$ocslideshow);

$tagcloud = array('tagcloud_module' => array ( 
	0 => array ( 'limit' => 200, 'min_font_size' => 14, 'max_font_size' => 22, 'layout_id' => getIdLayout("product"), 'position' => 'column_left', 'status' => 1, 'sort_order' => 4),
	1 => array ( 'limit' => 200, 'min_font_size' => 14, 'max_font_size' => 22, 'layout_id' => getIdLayout("category"), 'position' => 'column_left', 'status' => 1, 'sort_order' => 4),
	2 => array ( 'limit' => 200, 'min_font_size' => 14, 'max_font_size' => 22, 'layout_id' => getIdLayout("manufacturer"), 'position' => 'column_left', 'status' => 1, 'sort_order' => 4)
));
install('tagcloud');
editSetting('tagcloud',$tagcloud);

$block = array('block_module' => array ( 
	0 => array ( 'description' => array (1 => '<p>
	<span>FREE SHIPPING ON EVERYTHING</span></p>
<p>
	Lorem ipsum dolor sit amet consectetur adipiscing nec augue nisi gravida ut bibendum adipiscing lectus</p>
',2 => '<p>
	<span>FREE SHIPPING ON EVERYTHING</span></p>
<p>
	Lorem ipsum dolor sit amet consectetur adipiscing nec augue nisi gravida ut bibendum adipiscing lectus</p>
',3 => '<p>
	<span>FREE SHIPPING ON EVERYTHING</span></p>
<p>
	Lorem ipsum dolor sit amet consectetur adipiscing nec augue nisi gravida ut bibendum adipiscing lectus</p>
'), 'layout_id' => getIdLayout("home"), 'position' => 'header', 'status' => 1, 'sort_order' => 3)
));
install('block');
editSetting('block',$block);

$vqmod_manager= array('vqmod_manager_module' => array ());
install('vqmod_manager');
editSetting('vqmod_manager',$vqmod_manager);

################################################################################
### FINISH CONFIG	
################################################################################

finish_config();
?>
