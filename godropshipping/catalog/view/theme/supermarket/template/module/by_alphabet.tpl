<?php //var_dump($manufactureres)?>
<div class="alphabet">
  <div class="box-content">
  <h3 class="title-alphabet"><?php echo $heading_title; ?></h3>
	<ul>
        <?php foreach ($alphabet as $char) { ?>
        <li><a href="<?php echo $char['href']; ?>"><?php echo $char['char']; ?></a></li>
        <?php } ?>
      </ul>
  </div>
</div>
