<div class="footer-container">
   <div class="footer-top"> <?php foreach ($modules as $module) { ?>
        <?php echo $module; ?>
    <?php } ?> 
	
    <div id="footer">
      <div class="column column-1">
          <div class="information">
            <h3><?php echo $text_information; ?></h3>
            <ul>
              <li><a href="<?php echo $about ;?>"><?php echo $text_about; ?></a></li>
              <li><a href="<?php echo $contact; ?>"><?php echo $text_contact; ?></a></li>
              <li><a href="<?php echo $privacy ;?>"><?php echo $text_policies; ?></a></li>
              <!--<li><a href="#"><?php echo $text_support; ?></a></li>-->
            </ul>
          </div>
          
          <div class="store">
            <h3><?php echo $text_store; ?></h3>
            <a href="#" class="visit"><?php echo $text_visit; ?></a>
          </div>
      </div>
      <div class="column column-2">
        <h3><?php echo $text_dropship; ?></h3>
        <ul>
          <li><a href="http://www.godropshipping.com/index.php?route=information/information&information_id=8"><?php echo 'Locations We Ship To'; ?></a></li>
          <li><a href="http://www.godropshipping.com/index.php?route=information/information&information_id=5"><?php echo 'Terms & Conditions'; ?></a></li>
          <li><a href="http://www.godropshipping.com/index.php?route=information/information&information_id=10"><?php echo 'What is Dropshipping'; ?></a></li>
        </ul>
      </div>
      <div class="column column-3">
        <h3><?php echo $text_service; ?></h3>
        <ul>
          <li><a href="http://www.godropshipping.com/index.php?route=information/information&information_id=6"><?php echo 'After Sales'; ?></a></li>
          <li><a href="http://www.godropshipping.com/index.php?route=information/information&information_id=12"><?php echo 'Payment Methods'; ?></a></li>
          <li><a href="http://www.godropshipping.com/index.php?route=information/information&information_id=13"><?php echo 'Service Guarantee'; ?></a></li>
        </ul>
      </div>
      <div class="column column-4">
        <h3><?php echo $text_social; ?></h3>
       <!--
 <ul>
          <li><a href="<?php echo $account; ?>"><?php echo $text_account; ?></a></li>
          <li><a href="<?php echo $order; ?>"><?php echo $text_order; ?></a></li>
          <li><a href="<?php echo $wishlist; ?>"><?php echo $text_wishlist; ?></a></li>
          <li><a href="<?php echo $newsletter; ?>"><?php echo $text_newsletter; ?></a></li>
        </ul>
-->
        <ul>
          <li class="facebook"><a href="http://facebook.com">Facebook</a></li>
          <li class="twitter"><a href="http://support.twitter.com">Twitter</a></li>
          <li class="google"><a href="http://google-plus.com">Google</a></li>
        </ul>
        <ul>
          <li class="rss"><a href="http://vnexpress.net/gl/rss/">RSS Feed</a></li>
          <li class="flickr"><a href="http://www.flickr.com">Flickr</a></li>
          <li class="vimeo"><a href="http://vimeo.com">Vimeo</a></li>
        </ul>
      </div>
    </div>
    </div> <!-- footer top -->
    <div class="category-footer">
    <h3><?php echo $text_category; ?></h3>
        <ul>
		<?php $i=1; $num=count($categories);?>
        <?php foreach ($categories as $category) { ?>
		<?php if($i==$num){ ?>
			<li class="last">
		<?php } else { ?>
			<li>
		<?php } $i++; ?>
              <a href="<?php echo $category['href']; ?>"><?php echo $category['name']; ?></a>
              <?php if ($category['children']) { ?>
              <ul>
                <?php foreach ($category['children'] as $child) { ?>
                <li>
                  <a href="<?php echo $child['href']; ?>"><?php echo $child['name']; ?></a>
                </li>
                <?php } ?>
              </ul>
              <?php } ?>
            </li>
        <?php } ?>
      </ul>
    
    </div>
    
    <div class="footer-bottom">
			<div id="powered">
			<!--	<span><?php echo $powered; ?></span> -->
			 <span><?php echo "Power by Palindrome Network co., LTD<br/>Established in 2011"; ?></span>
			</div>
			<div id="footer-pay">
				<ul>
                    <li><a title="paypal" href="#"><img src="catalog/view/theme/supermarket/image/paypal_03.png" alt="card" /></a></li>
					<li class="visa"><a title="visa" href="#"><img src="catalog/view/theme/supermarket/image/visa_05.png" alt="visa" /></a> </li>
                    <li class="paypal"><a title="American" href="#"><img src="catalog/view/theme/supermarket/image/card3_07.png" alt="Pay pal" /></a></li>
					<li><a title="MasterCard" href="#"><img src="catalog/view/theme/supermarket/image/card_09.png" alt="card" /> </a></li>
					<li class="visa1"><a title="DHL" href="#"><img src="catalog/view/theme/supermarket/image/dhl_11.png" alt="card" /></a></li>
                    <li class="visa1"><a title="FedEx" href="#"><img src="catalog/view/theme/supermarket/image/fed_13.png" alt="card" /></a></li>
				</ul>
			</div>
		</div> <!-- End . footer-bootom -->
</div> <!-- End .footer-container -->

</div>
</body></html>
