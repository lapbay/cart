<div id="menu">
  <ul>
  <li class='menu00'> <a href="index.php?route=common/home"> <?php echo $text_home; ?> </a> </li>
    <?php foreach ($categories as $category) { ?>
    <li class='menu00'>
        <?php if (!$category['children']) { ?>
        <a href="<?php echo $category['href']; ?>"><?php echo $category['name']; ?></a>
        <?php } ?>
      <?php if ($category['children']) { ?>
      <a class="level0" href="<?php echo $category['href']; ?>"><?php echo $category['name']; ?></a>
      <div class="menu-child">
        <?php for ($i = 0; $i < count($category['children']);) { ?>
        <ul>
          <?php $j = $i + ceil(count($category['children']) / $category['column']); ?>
          <?php for (; $i < $j; $i++) { ?>
			  <?php if (isset($category['children'][$i])) { ?>
			  <li>
              <?php if (!$category['children'][$i]['children']) { ?>
              <a href="<?php echo $category['children'][$i]['href']; ?>"><?php echo $category['children'][$i]['name']; ?></a>
				<?php } ?>
				<?php if ($category['children'][$i]['children']) { ?>
                    <a class="level1" href="<?php echo $category['children'][$i]['href']; ?>"><?php echo $category['children'][$i]['name']; ?></a>
				  <div class="menu-child1">
					<?php for ($m = 0; $m < count($category['children'][$i]['children']);) { ?>
					<ul>
					  <?php $n = $m + ceil(count($category['children'][$i]['children']) / $category['children'][$i]['column']); ?>
					  <?php for (; $m < $n; $m++) { ?>
						  <?php if (isset($category['children'][$i]['children'][$m])) { ?>
						  <li>
						   <?php if (!$category['children'][$i]['children'][$m]['children']) { ?>
						  <a href="<?php echo $category['children'][$i]['children'][$m]['href']; ?>"><?php echo $category['children'][$i]['children'][$m]['name']; ?></a>
						   <?php } ?>
						  <?php if ($category['children'][$i]['children'][$m]['children']) { ?>
							 <a class="level2" href="<?php echo $category['children'][$i]['children'][$m]['href']; ?>"><?php echo $category['children'][$i]['children'][$m]['name']; ?></a>
							  <div class="menu-child2">
								<?php for ($x = 0; $x < count($category['children'][$i]['children'][$m]['children']);) { ?>
									<ul>
									  <?php $y = $x + ceil(count($category['children'][$i]['children'][$m]['children']) / $category['children'][$i]['children'][$m]['column']); ?>
									  <?php for (; $x < $y; $x++) { ?>
										  <?php if (isset($category['children'][$i]['children'][$m]['children'][$x])) { ?>
										  <li><a href="<?php echo $category['children'][$i]['children'][$m]['children'][$x]['href']; ?>"><?php echo $category['children'][$i]['children'][$m]['children'][$x]['name']; ?></a></li>
										  <?php } ?>
									  <?php } ?>
									</ul>
								<?php } ?>
							  </div>
						  
						  <?php } ?>
						  
						  </li>
						  <?php } ?>
					  <?php } ?>
					</ul>
					<?php } ?>
				  </div>
      
				<?php } ?>
				
			  </li>
			  <?php } ?>
          <?php } ?>
        </ul>
        <?php } ?>
      </div>
      
      <?php } ?>
    </li>
    <?php } ?>
  </ul>
</div>
<div id="notification"></div>