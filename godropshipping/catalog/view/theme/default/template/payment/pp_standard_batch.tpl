<?php if ($testmode) { ?>
<div class="warning"><?php echo $text_testmode; ?></div>
<?php } ?>
<form action="<?php echo $action; ?>" method="post" id="payment">
  <input type="hidden" name="cmd" value="_cart" />
  <input type="hidden" name="upload" value="1" />
  <input type="hidden" name="business" value="<?php echo $business; ?>" />
  <?php $i = 1; ?>
  <?php foreach ($orders as $orders) { ?>
  <input type="hidden" name="item_name_<?php echo $i; ?>" value="<?php echo $orders['name']; ?>" />
  <input type="hidden" name="item_number_<?php echo $i; ?>" value="<?php echo $orders['model']; ?>" />
  <input type="hidden" name="amount_<?php echo $i; ?>" value="<?php echo $orders['price']; ?>" />
  <input type="hidden" name="quantity_<?php echo $i; ?>" value="<?php echo $orders['quantity']; ?>" />
  <input type="hidden" name="weight_<?php echo $i; ?>" value="<?php echo $orders['weight']; ?>" />
  <?php $i++; ?>
  <?php } ?>
  <?php if ($discount_amount_cart) { ?>
  <input type="hidden" name="discount_amount_cart" value="<?php echo $discount_amount_cart; ?>" />
  <?php } ?>
  <input type="hidden" name="currency_code" value="<?php echo $currency_code; ?>" />
  <input type="hidden" name="first_name" value="<?php echo $first_name; ?>" />
  <input type="hidden" name="last_name" value="<?php echo $last_name; ?>" />
  <input type="hidden" name="address1" value="<?php echo $address1; ?>" />
  <input type="hidden" name="address2" value="<?php echo $address2; ?>" />
  <input type="hidden" name="city" value="<?php echo $city; ?>" />
  <input type="hidden" name="zip" value="<?php echo $zip; ?>" />
  <input type="hidden" name="country" value="<?php echo $country; ?>" />
  <input type="hidden" name="address_override" value="0" />
  <input type="hidden" name="email" value="<?php echo $email; ?>" />
  <input type="hidden" name="invoice" value="<?php echo $invoice; ?>" />
  <input type="hidden" name="lc" value="<?php echo $lc; ?>" />
  <input type="hidden" name="rm" value="2" />
  <input type="hidden" name="no_note" value="1" />
  <input type="hidden" name="charset" value="utf-8" />
  <input type="hidden" name="return" value="<?php echo $return; ?>" />
  <input type="hidden" name="notify_url" value="<?php echo $notify_url; ?>" />
  <input type="hidden" name="cancel_return" value="<?php echo $cancel_return; ?>" />
  <input type="hidden" name="paymentaction" value="<?php echo $paymentaction; ?>" />
  <input type="hidden" name="custom" value="<?php echo $custom; ?>" />
</form>
<div class="buttons" id="batch_buttons">
    <div class="left"><a id="button-remove" class="batch_button_remove button"><span><?php echo 'Remove'; ?></span></a></div>
    <div class="right"><a id="button-confirm" class="batch_button_confirm button" onclick="$('#payment').submit();"><span><?php echo $button_confirm; ?></span></a></div>
</div>
<script type="text/javascript">
$('#button-confirm1').bind('click', function() {
    var oids = new Array();
    $('.gds_order').each(function(index, obj) {
        oids.push(parseInt($(this).closest('tr').attr('oid')));
    });
    $.post(
            'index.php?route=checkout/bcheckout/confirm',
            { 'orders': JSON.stringify(oids) },
            function(response) {
                location = '<?php echo $continue; ?>';
            }
    );
});
</script>
