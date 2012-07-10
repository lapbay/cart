<?php 
    if(isset($_GET['route']))
    {
        if(($_GET['route'])!='common/home'){
                
        $page='otherpage';
        }
        
        else {
        
        $page='homepage';
        }     
    }  
    
    else {
        
        $page='homepage';
        }
?>
<div class="feature-category">
  <div class="feature-heading"><?php echo $heading_title; ?></div>
  <div class="featured-<?php echo $page; ?>">
	  <div class="feature-content">
		<div class="feature-box-category">
			<ul class="jcarousel-skin-opencart feature-height">
		  <?php foreach ($categories as $category) { ?>
		   <li> <?php if ($category['thumb']) { ?>
			<div class="image"><a href="<?php echo $category['href']; ?>"><img src="<?php echo $category['thumb']; ?>" alt="<?php echo $category['name']; ?>" /></a></div>
			<?php } ?>
			<div class="name"><a href="<?php echo $category['href']; ?>"><!--<?php echo $category['name']; ?></a>--></div></li>
		  <?php } ?>
		  </ul>
		</div>
	  </div>
  </div>
</div>
