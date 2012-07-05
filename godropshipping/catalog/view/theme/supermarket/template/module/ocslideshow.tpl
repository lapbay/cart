<div id="slides<?php echo $module; ?>">
    <div class="slides_container">
        <?php $i=1; ?>
		<?php foreach ($banners as $banner) { ?>
            <div class="slide">
        		<?php if ($banner['link']) { ?>
        		<a href="<?php echo $banner['link']; ?>"><img src="<?php echo $banner['image']; ?>" alt="<?php echo $banner['title']; ?>" /></a>
        		<?php } else { ?>
        		<img src="<?php echo $banner['image']; ?>" alt="<?php echo $banner['title']; ?>" />
        		<?php } ?>
                <?php if ($i==1) { ?>
                <div class="caption" style="bottom:0">
    							
    	        </div>
           <?php } else { ?>
                <div class="caption">
    							
    	        </div>
           <?php } $i++; ?>                
            </div>
            
		<?php } ?>
    </div>
</div>
<?php echo $message; ?>

<script type="text/javascript"><!--
	$(document).ready(function(){
	
			//Add Title
            var numCont = $('.slides_container .slide .caption').length;
            var numTit = $('#title li').length;
            var num = Math.min(numCont,numTit);
            
           for (var i=1; i<=num; i++)
           {
                $('#title li:nth-child('+i+')').children('').appendTo('.slides_container div.slide:nth-child('+i+') .caption');
           }
           
		   
		   // Box slideshow
		   $('#slides<?php echo $module; ?>').slides({
				play: 3000,
				pause: 2500,
				hoverPause: true,
				effect: 'fade',
				animationStart: function(current){
					$('.caption').animate({
						bottom:-35
					},100);
					if (window.console && console.log) {
						// example return of current slide number
						console.log('animationStart on slide: ', current);
					};
				},
				animationComplete: function(current){
					$('.caption').animate({
						bottom:0
					},200);
					if (window.console && console.log) {
						// example return of current slide number
						console.log('animationComplete on slide: ', current);
					};
				},
				slidesLoaded: function() {
					$('.caption').animate({
						bottom:0
					},200);
				}
			});
    });
--></script>
