<?php if ($reviews) { ?>
<?php foreach ($reviews as $review) { ?>
<div class="content"><b><?php echo $review['author']; ?></b> <br />
<img src="catalog/view/theme/supermarket/image/stars-<?php echo $review['rating'] . '.png'; ?>" alt="<?php echo $review['reviews']; ?>" /><br />
  <!--
    <?php echo $review['date_added']; ?><br />
    -->

  <?php echo $review['text']; ?></div>
<?php } ?>
<div class="pagination"><?php echo $pagination; ?></div>
<?php } else { ?>
<div class="content"><?php echo $text_no_reviews; ?></div>
<?php } ?>
