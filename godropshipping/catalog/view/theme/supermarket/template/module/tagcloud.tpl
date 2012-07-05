<div class="box tagcloud">
  <div class="box-heading"><?php echo $heading_title; ?></div>
  <div class="box-content">
    <?php if ($tagcloud) {
		echo $tagcloud;
    } else {
		echo $text_notags;
	} ?>
  </div>
</div>
