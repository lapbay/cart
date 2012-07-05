<div class="bg_cart">
<?php if ($products || $vouchers) { ?>
<table class="cart">
  <?php foreach ($products as $product) { ?>
  <tr>
	<td class="remove"><img src="catalog/view/theme/supermarket/image/close.png" alt="<?php echo $button_remove; ?>" title="<?php echo $button_remove; ?>" onclick="removeCart('<?php echo $product['key']; ?>');" /></td>
    <td class="image"><?php if ($product['thumb']) { ?>
      <a href="<?php echo $product['href']; ?>"><img src="<?php echo $product['thumb']; ?>" alt="<?php echo $product['name']; ?>" title="<?php echo $product['name']; ?>" /></a>
      <?php } ?></td>
    <td class="name"><a href="<?php echo $product['href']; ?>"><?php echo $product['name']; ?></a>
      <div>
        <?php foreach ($product['option'] as $option) { ?>
         <small><?php echo $option['name']; ?> <?php echo $option['value']; ?></small><br />
        <?php } ?>
      </div>
	    <div class="quantity"><?php echo $product['quantity']; ?>&nbsp;x&nbsp;</div>
		<div class="total"><?php echo $product['total']; ?></div>
	 </td>
    
    
  </tr>
  <?php } ?>
  <?php foreach ($vouchers as $voucher) { ?>
  <tr>
    <td class="image"></td>
    <td class="name"><?php echo $voucher['description']; ?></td>
    <td class="quantity">x&nbsp;1</td>
    <td class="total"><?php echo $voucher['amount']; ?></td>
    <td class="remove"><img src="catalog/view/theme/supermarket/image/close.png" alt="<?php echo $button_remove; ?>" title="<?php echo $button_remove; ?>" onclick="removeVoucher('<?php echo $voucher['key']; ?>');" /></td>
  </tr>
  <?php } ?>  
</table>
<table class="total">
  <?php foreach ($totals as $total) { ?>
  <tr>
    <td align="left"><b><?php echo $total['title']; ?></b></td>
    <td align="left" class="mau"><?php echo $total['text']; ?></td>
  </tr>
  <?php } ?>
</table>
<div class="checkout"><a href="<?php echo $checkout; ?>" class="button"><span><?php echo $button_checkout; ?></span></a></div>
<?php } else { ?>
<div class="empty"><?php echo $text_empty; ?></div>
<?php } ?>
</div>