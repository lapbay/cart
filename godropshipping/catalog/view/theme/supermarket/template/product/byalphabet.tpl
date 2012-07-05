<?php echo $header; ?>
	<div class="breadcrumb">
        <?php $num=count($breadcrumbs); ?>
        <?php $i=1;?>
      <?php foreach ($breadcrumbs as $breadcrumb) { ?>
      <?php if($i==$num){ ?>
      <a class="last" href="<?php echo $breadcrumb['href']; ?>"><?php echo $breadcrumb['text']; ?></a>
      <?php } else { ?>
      <a href="<?php echo $breadcrumb['href']; ?>"><?php echo $breadcrumb['text']; ?></a>
      <?php } ?>
      <?php $i++; } ?>
    </div>
    <h1 class="title-checkout"><?php echo $heading_title; ?></h1>
<?php echo $column_left; ?><?php echo $column_right; ?>
<div id="content-detail" class="content-category"><?php echo $content_top; ?>
<!--
  <div class="breadcrumb">
    <?php foreach ($breadcrumbs as $breadcrumb) { ?>
    <?php echo $breadcrumb['separator']; ?><a href="<?php echo $breadcrumb['href']; ?>"><?php echo $breadcrumb['text']; ?></a>
    <?php } ?>
  </div>
 -->
 <div class="framecart">
	  <!--
<h1><?php echo $heading_title; ?></h1>
-->
	  <?php if ($products) { ?>
	  <div class="product-filter">
		<div class="display"><b><?php echo $text_display; ?></b> <?php echo $text_list; ?> <b>/</b> <a onclick="display('grid');"><?php echo $text_grid; ?></a></div>
	  
		<div class="product-compare"><a href="<?php echo $compare; ?>" id="compare_total"><?php echo $text_compare; ?></a></div>
		<div class="limit"><b><?php echo $text_limit; ?></b>
		  <select onchange="location = this.value;">
			<?php foreach ($limits as $limits) { ?>
			<?php if ($limits['value'] == $limit) { ?>
			<option value="<?php echo $limits['href']; ?>" selected="selected"><?php echo $limits['text'];echo " per page"; ?></option>
			<?php } else { ?>
			<option value="<?php echo $limits['href']; ?>"><?php echo $limits['text'];echo " per page"; ?></option>
			<?php } ?>
			<?php } ?>
		  </select>
		</div>
	  </div>
	  <div class="product-list">
	<?php $i=1;  ?>
    <?php foreach ($products as $product) { ?>
    <?php if($i%3==0) { ?>
        <div class="one-product-category last">
    <?php } else { ?>
         <div class="one-product-category">
     <?php } $i++; ?>  
		  <?php if ($product['thumb']) { ?>
		  <div class="image"><a href="<?php echo $product['href']; ?>"><img src="<?php echo $product['thumb']; ?>" title="<?php echo $product['name']; ?>" alt="<?php echo $product['name']; ?>" /></a></div>
		  <?php } ?>
		  <div class="name"><a href="<?php echo $product['href']; ?>"><?php echo $product['name']; ?></a></div>
          <div class="rating"><img src="catalog/view/theme/supermarket/image/stars-<?php echo $product['rating']; ?>.png" alt="<?php echo $product['reviews']; ?>" /></div>
		  <div class="description"><?php echo $product['description']; ?></div>
		  <?php if ($product['price']) { ?>
		  <div class="price">
			<?php if (!$product['special']) { ?>
			<span class="price-all"><?php echo $product['price']; ?></span>
			<?php } else { ?>
			<span class="price-old"><?php echo $product['price']; ?></span> <span class="price-new"><?php echo $product['special']; ?></span>
			<?php } ?>
			<?php if ($product['tax']) { ?>
			<br/><span class="price-tax"><?php echo $text_tax; ?> <?php echo $product['tax']; ?></span>
			<?php } ?>
		  </div>
		  <?php } ?>
		  <div class="cart"><a onclick="addToCart('<?php echo $product['product_id']; ?>');" class="button"><span><?php echo $button_cart; ?></span></a></div>
		  <div class="wishlist"><a onclick="addToWishList('<?php echo $product['product_id']; ?>');"><?php echo $button_wishlist; ?></a></div>
		  <div class="compare"><a onclick="addToCompare('<?php echo $product['product_id']; ?>');"><?php echo $button_compare; ?></a></div>
		</div>
		<?php } ?>
	  </div>
	  <div class="pagination"><?php echo $pagination; ?></div>
	  <?php } else { ?>
	  <div class="content"><?php echo $text_empty; ?></div>
	  <div class="buttons">
		<div class="left"><a href="<?php echo $continue; ?>" class="button"><span><?php echo $button_continue; ?></span></a></div>
	  </div>
	  <?php }?>
	</div><!-- end framecart -->
  <?php echo $content_bottom; ?></div>
<script type="text/javascript"><!--
function display(view) {
	if (view == 'list') {
		$('.product-grid').attr('class', 'product-list');
		
		$('.product-list > div').each(function(index, element) {
			html  = '<div class="left">';
				var image = $(element).find('.image').html();
			
				if (image != null) { 
					html += '<div class="image">' + image + '</div>';
				}
			html += '</div>';			
			
			html += '<div class="right">';
				html += '  <div class="name">' + $(element).find('.name').html() + '</div>';
                var rating = $(element).find('.rating').html();
				
					if (rating != null) {
						html += '<div class="rating">' + rating + '</div>';
					}
	
				html += '  <div class="description">' + $(element).find('.description').html() + '</div>';
				html += '<div class="frame-cart-cate">';
					var price = $(element).find('.price').html();
					
					if (price != null) {
						html += '<div class="price">' + price  + '</div>';
					}
					html += '  <div class="cart">' + $(element).find('.cart').html() + '</div>';
				html += '</div>';
				html += '<div class="frame-compare-wishlist">';
					html += '  <div class="compare">' + $(element).find('.compare').html() + '</div>';
					html += '  <div class="wishlist">' + $(element).find('.wishlist').html() + '</div>';
					
				html += '</div>';
					
			html += '</div>';

						
			$(element).html(html);
		});		
		
		$('.display').html('<b><?php echo $text_display; ?></b><a class="no-active-gird" onclick="display(\'grid\');"><?php echo $text_grid; ?></a> <span class="active-list"><?php echo $text_list; ?></span>');
		
		$.cookie('display', 'list'); 
	} else {
		$('.product-list').attr('class', 'product-grid');
		
		$('.product-grid > div').each(function(index, element) {
			html = '';
			html += '<div class="detail-small">';
			
			var image = $(element).find('.image').html();
			
			if (image != null) {
				html += '<div class="image">' + image + '</div>';
			}
			html += '<div class="name">' + $(element).find('.name').html() + '</div>';
            var rating = $(element).find('.rating').html();
					
				if (rating != null) {
					html += '<div class="rating">' + rating + '</div>';
				}

			html += '<div class="frame-price-rating">';
				var price = $(element).find('.price').html();
					
				if (price != null) {
					html += '<div class="price">' + price  + '</div>';
				}	
				
			html += '</div>';
			html += '<div class="description">' + $(element).find('.description').html() + '</div>';
			html += '<div class="productgird-category">';
				html += '<div class="cart">' + $(element).find('.cart').html() + '</div>';
				html += '<div class="compare">' + $(element).find('.compare').html() + '</div>';
				html += '<div class="wishlist">' + $(element).find('.wishlist').html() + '</div>';
			html += '</div>';
			$(element).html(html);
		});	
					
		$('.display').html('<b><?php echo $text_display; ?></b><span class="active-gird"><?php echo $text_grid; ?></span><a class="no-active-list" onclick="display(\'list\');"><?php echo $text_list; ?></a>');
		
		$.cookie('display', 'grid');
	}
}

view = $.cookie('display');

if (view) {
	display(view);
} else {
	display('list');
}
//--></script> 
<?php echo $footer; ?> 