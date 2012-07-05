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
<?php echo $column_left; ?><?php echo $column_right; ?>
  <h1><?php echo $heading_title; ?></h1>
  <?php echo $description; ?>
  <div class="buttons">
    <div class="left"><a href="<?php echo $continue; ?>" class="button"><span><?php echo $button_continue; ?></span></a></div>
  </div>
  <?php echo $content_bottom; ?>
<?php echo $footer; ?>
</div>