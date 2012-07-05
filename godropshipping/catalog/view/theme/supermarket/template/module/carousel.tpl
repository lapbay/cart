<?php 
    if(isset($_GET['route']))
    {
        if(($_GET['route'])!='common/home'){
                
        $page=' other_page';
        }
        
        else {
        
        $page='';
        }     
    }  
    
    else {
        
        $page='';
        }
?>
<div id="carousel<?php echo $module; ?>">
<div class="<?php echo $page; ?>">
  <ul class="jcarousel-skin-opencart">
    <?php foreach ($banners as $banner) { ?>
    <li><a href="<?php echo $banner['link']; ?>"><img src="<?php echo $banner['image']; ?>" alt="<?php echo $banner['title']; ?>" title="<?php echo $banner['title']; ?>" /></a></li>
    <?php } ?>
  </ul>
  </div>
</div>
<script type="text/javascript"><!--
$('#carousel<?php echo $module; ?> ul').jcarousel({
	vertical: false,
	visible: <?php echo $limit; ?>,
	scroll: <?php echo $scroll; ?>,
    wrap: 'circular'
});
//--></script>