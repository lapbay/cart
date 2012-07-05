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
<div class="frame-content">
<?php echo $column_right; ?>
<div id="content"><?php echo $content_top; ?>
  <h1><?php echo $heading_title; ?></h1>  
  <?php if ($products) { ?>
  <form action="<?php echo $action; ?>" method="post" enctype="multipart/form-data" id="wishlist">
    <div class="wishlist-product">
      <table>
        <thead>
          <tr>
            <td class="name"><?php echo $column_name; ?></td>
            <td class="sku"><?php echo $column_sku; ?></td>
            <td class="stock"><?php echo $column_stock; ?></td>
            <td class="price"><?php echo $column_price; ?></td>
            <td class="cart"></td>
          </tr>
        </thead>
        <tbody>
            <?php $i=1; ?>
          <?php foreach ($products as $product) { ?>
          <tr>
            <td class="name">
            <?php if ($product['thumb']) { ?>
              <a href="<?php echo $product['href']; ?>"><img src="<?php echo $product['thumb']; ?>" alt="<?php echo $product['name']; ?>" title="<?php echo $product['name']; ?>" /></a>
              <?php } ?>
            <a class='descrip' href="<?php echo $product['href']; ?>"><?php echo $product['name']; ?></a>
            <span class="model"><?php echo $product['model']; ?> </span>
            <div class="remove">
                    <input type="checkbox" onclick="$('#wishlist').submit();" name="remove[]" id="removeck<?php echo $i ?>" value="<?php echo $product['product_id']; ?>" />
                    <label for="removeck<?php echo $i ?>">remove</label>
            </div>
            </td>
            <td class="sku"><?php echo $product['sku']; ?></td>
            <td class="stock"><?php echo $product['stock']; ?></td>
            <td class="price"><?php if ($product['price']) { ?>
              <div class="price">
                <?php if (!$product['special']) { ?>
                <?php echo $product['price']; ?>
                <?php } else { ?>
                <s><?php echo $product['price']; ?></s> <b><?php echo $product['special']; ?></b>
                <?php } ?>
              </div>
              <?php } ?></td>
            <td class="cart"><a onclick="addToCart('<?php echo $product['product_id']; ?>');" class="button"><span><?php echo $button_cart; ?></span></a></td>
          </tr>
          <?php $i++; } ?>
        </tbody>
      </table>
    </div>
  </form>
  <div class="buttons">
    <div class="left wishlist"><a href="<?php echo $back; ?>" class="button"><span><?php echo $button_back; ?></span></a></div>
    <div class="right"><a onclick="$('#wishlist').submit();" class="button"><span><?php echo $button_update; ?></span></a></div>
  </div>
  <?php } else { ?>
  <div class="content"><?php echo $text_empty; ?></div>
  <div class="buttons">
    <div class="right"><a href="<?php echo $continue; ?>" class="button"><span><?php echo $button_continue; ?></span></a></div>
  </div>
  <?php } ?>
  <?php echo $content_bottom; ?></div>
  </div>
<?php echo $footer; ?>