<div class="buttons">
    <div class="right"><a id="button-confirm" class="button"><span><?php echo $button_confirm; ?></span></a></div>
</div>
<script type="text/javascript"><!--
$('#button-confirm').bind('click', function() {
    var oids = new Array();
    $('.gds_order').each(function(index, obj) {
        var oid = parseInt($(this).html());
        oids.push(oid);
    });
    $.post(
        'index.php?route=checkout/bcheckout/confirm',
        { 'orders': JSON.stringify(oids) },
        function(response) {
            location = '<?php echo $continue; ?>';
        }
    );
});
//--></script> 
