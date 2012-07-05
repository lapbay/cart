<?php echo $header; ?>
<div class="container">
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
<div class="frame-content">
<?php echo $column_left; ?><?php echo $column_right; ?>
  <div id="content"><?php echo $content_top; ?>
    <h1><?php echo $heading_title; ?>
      <?php if ($weight) { ?>
      &nbsp;(<?php echo $weight; ?>)
      <?php } ?>
    </h1>
    <?php if ($attention) { ?>
    <div class="attention"><?php echo $attention; ?></div>
    <?php } ?>    
    <?php if ($success) { ?>
    <div class="success"><?php echo $success; ?></div>
    <?php } ?>
    <?php if ($error_warning) { ?>
    <div class="warning"><?php echo $error_warning; ?></div>
    <?php } ?>
    <form action="<?php echo $action; ?>" method="post" enctype="multipart/form-data" id="basket">
      <div class="cart-info">
        <table>
          <thead>
            <tr>
              <td class="name"><?php echo $column_name; ?></td>
              <td class="sku"><?php echo $column_sku; ?></td>
              <td class="quantity"><?php echo $column_quantity; ?></td>
              <td class="price"><?php echo $column_price; ?></td>
               <td class="tax"><?php echo $text_tax; ?></td>
              <td class="total"><?php echo $column_total; ?></td>
            </tr>
          </thead>
          <tbody>
            <?php $i=1; ?>
            <?php foreach ($products as $product) { ?>
            
                <?php $total=$product['total']; ?>
                <?php $price=$product['price']; ?>
                <?php $price= substr($price,1); ?>
                <?php $cur= substr($product['total'],0,1); ?>     
                <?php $total= substr($total,1);?>
                <?php $total=str_replace(",","",$total); ?>
                <?php $price=str_replace(",","",$price); ?>
                <?php $tax=$total-$price*$product['quantity']; ?>
                
            <tr>
              <td class="image">
				<div class="remove">
                    <input type="checkbox" onclick="$('#basket').submit();" name="remove[]" id="removeck<?php echo $i ?>" value="<?php echo $product['key']; ?>" />
                    <label for="removeck<?php echo $i ?>">remove</label>
                </div>
                <?php if ($product['thumb']) { ?>
                    <a href="<?php echo $product['href']; ?>"><img src="<?php echo $product['thumb']; ?>" alt="<?php echo $product['name']; ?>" title="<?php echo $product['name']; ?>" /></a>
                <?php } ?>
                <div class="name">
                    <a href="<?php echo $product['href']; ?>"><?php echo $product['name']; ?></a>
                    <?php if (!$product['stock']) { ?>
                    <span class="stock">***</span>
                    <?php } ?>
                    <div>
                      <?php foreach ($product['option'] as $option) { ?>
                      - <small><?php echo $option['name']; ?>: <?php echo $option['value']; ?></small><br />
                      <?php } ?>
                    </div>
                    <!--
                    <?php if ($product['reward']) { ?>
                    <small><?php echo $product['reward']; ?></small>
                    <?php } ?>
                    -->
                    <span class="model"><?php echo $product['model']; ?> </span>
                </div>
                </td>
              <td class="sku"><?php echo $product['sku']; ?></td>
              <td class="quantity"><input type="text" name="quantity[<?php echo $product['key']; ?>]" value="<?php echo $product['quantity']; ?>" size="3" /></td>
              <td class="price"><?php echo $product['price']; ?></td>
              <td class="tax"><?php echo $product['tax']; ?></td>
              <td class="total"><?php echo $product['total']; ?></td>
            </tr>
            <?php } ?>
            <?php foreach ($vouchers as $voucher) { ?>
            <tr>
              <td class="remove"><input type="checkbox" name="voucher[]" value="<?php echo $voucher['key']; ?>" /></td>
              <td class="image"></td>
              <td class="name"><?php echo $voucher['description']; ?></td>
              <td class="model"></td>
              <td class="quantity">1</td>
              <td class="price"><?php echo $voucher['amount']; ?></td>
              <td class="total"><?php echo $voucher['amount']; ?></td>
            </tr>
            <?php } $i++; ?>
          </tbody>
        </table>
      </div>
    </form>
    <div class="cart-module">
      <?php foreach ($modules as $module) { ?>
      <?php echo $module; ?>
      <?php } ?>
    </div>
	<div class="buttons but-cart">
      <div class="left"><a onclick="$('#basket').submit();" class="button"><span><?php echo $button_update; ?></span></a></div>
     
      <div class="center"><a href="<?php echo $continue; ?>" class="button"><span><?php echo $button_shopping; ?></span></a></div>
    </div>
    <div class="cart-total">
      <table>
        <?php foreach ($totals as $total) { ?>
        <tr>
          
          <td class="right"><b><?php echo $total['title']; ?>:</b></td>
		  <td class="space"> &nbsp;</td>
          <td class="price"><?php echo $total['text']; ?></td>
        </tr>
        <?php } ?>
	</table>
	<div class="right">
		<a href="<?php echo $checkout; ?>" class="button"><span><?php echo $button_checkout; ?></span></a>
		</div>   
    </div>
    
    <?php echo $content_bottom; ?></div>
</div>	
</div>
<script type="text/javascript"><!--
$('.cart-module .cart-heading').bind('click', function() {
	if ($(this).hasClass('active')) {
		$(this).removeClass('active');
	} else {
		$(this).addClass('active');
	}
		
	$(this).parent().find('.cart-content').slideToggle('slow');
});
//--></script> 
<?php echo $footer; ?>