<div class="checkout-product">
  <table>
    <thead>
      <tr>
          <td class="gds_order_remove_all remove"><input type="checkbox" value="0" class="gds_order_remove_all_checkbox"> Remove</td>
          <td class="name"><?php echo $column_gds_order; ?></td>
          <td class="name"><?php echo $column_customer_order; ?></td>
          <td class="name"><?php echo $column_gds_sku; ?></td>
          <td class="name"><?php echo $column_end_customer_name; ?></td>
          <td class="name"><?php echo $column_ship_to_country; ?></td>

        <td class="quantity"><?php echo $column_quantity; ?></td>
        <td class="price"><?php echo $column_price; ?></td>
        <td class="total"><?php echo $column_total; ?></td>
      </tr>
    </thead>
    <tbody>
        <?php foreach ($orders as $index=>$order) { ?>
        <tr oid=<?php echo $index; ?>>
            <td class="gds_order_remove remove"><input type="checkbox" value="0" class="gds_order_remove_checkbox"></td>
            <td class="gds_order name"><?php echo $order['order_id']; ?></td>
            <td class="name"><?php echo $order['customer_order']; ?></td>
            <td class="name"><?php echo implode(", ", array_keys($order['gds_products'])); ; ?></td>
            <td class="name"><?php echo $order['end_cusotomer_name']; ?></td>
            <td class="name"><?php echo $order['ship_to_country']; ?></td>

            <td class="quantity"><?php echo $order['quantity']; ?></td>
            <td class="price"><?php echo $order['price']; ?></td>
            <td class="total"><?php echo $order['total']; ?></td>
        </tr>
        <?php } ?>
      <?php foreach ($products as $product) { ?>
      <tr>
        <td class="name"><a href="<?php echo $product['href']; ?>"><?php echo $product['name']; ?></a>
          <?php foreach ($product['option'] as $option) { ?>
          <br />
          &nbsp;<small> - <?php echo $option['name']; ?>: <?php echo $option['value']; ?></small>
          <?php } ?></td>
        <td class="model"><?php echo $product['model']; ?></td>
        <td class="quantity"><?php echo $product['quantity']; ?></td>
        <td class="price"><?php echo $product['price']; ?></td>
        <td class="total"><?php echo $product['total']; ?></td>
      </tr>
      <?php } ?>
      <?php foreach ($vouchers as $voucher) { ?>
      <tr>
        <td class="name"><?php echo $voucher['description']; ?></td>
        <td class="model"></td>
        <td class="quantity">1</td>
        <td class="price"><?php echo $voucher['amount']; ?></td>
        <td class="total"><?php echo $voucher['amount']; ?></td>
      </tr>
      <?php } ?>
    </tbody>
    <tfoot>
      <?php foreach ($totals as $total) { ?>
      <tr>
        <td colspan="8" class="price"><b><?php echo $total['title']; ?>:</b></td>
        <td class="total"><?php echo $total['text']; ?></td>
      </tr>
      <?php } ?>
    </tfoot>
  </table>
</div>
<div class="payment"><?php echo $payment; ?></div>