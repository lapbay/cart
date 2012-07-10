<?php echo $header; ?>
<div class="frame-content">
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
  <h1><?php echo $heading_title; ?></h1>
<?php echo $column_left; ?><?php echo $column_right; ?>
<div id="content"><?php echo $content_top; ?>

  <?php if ($success) { ?>
  <div class="success"><?php echo $success; ?></div>
  <?php } ?>
  <h2><?php echo $text_my_account; ?></h2>
  <div class="content">
    <ul class="account">
      <li><a href="<?php echo $edit; ?>"><?php echo $text_edit; ?></a></li>
      <li><a href="<?php echo $password; ?>"><?php echo $text_password; ?></a></li>
      <li><a href="<?php echo $address; ?>"><?php echo $text_address; ?></a></li>
      <li><a href="<?php echo $wishlist; ?>"><?php echo $text_wishlist; ?></a></li>
    </ul>
  </div>
  <h2><?php echo $text_my_orders; ?></h2>
  <div class="content">
    <ul class="account">
      <li><a href="<?php echo $order; ?>"><?php echo $text_order; ?></a></li>
      <li><a href="<?php echo $download; ?>"><?php echo $text_download; ?></a></li>
      <li><a href="<?php echo $reward; ?>"><?php echo $text_reward; ?></a></li>
      <li><a href="<?php echo $return; ?>"><?php echo $text_return; ?></a></li>
      <li><a href="<?php echo $transaction; ?>"><?php echo $text_transaction; ?></a></li>
    </ul>
  </div>
    <!--Add by wuchang-->
    <?php if (isset($text_my_batch_orders)) { ?>
    <h2><?php echo $text_my_batch_orders; ?></h2>
    <div class="content">
        <ul class="account">
            <li><a href="<?php echo $batch_order; ?>"><?php echo $text_batch_order; ?></a></li>
            <li><a href="<?php echo $batch_checkout; ?>"><?php echo $text_batch_checkout; ?></a></li>
        </ul>
    </div>
    <?php } ?>
  <h2><?php echo $text_my_newsletter; ?></h2>
  <div class="content">
    <ul class="account">
      <li><a href="<?php echo $newsletter; ?>"><?php echo $text_newsletter; ?></a></li>
    </ul>
  </div>
  <?php echo $content_bottom; ?></div>
  </div>
<?php echo $footer; ?> 
