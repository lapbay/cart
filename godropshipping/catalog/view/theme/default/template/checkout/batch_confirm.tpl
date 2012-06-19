<div class="buttons">
    <div class="left"><a id="button-remove" class="button"><span><?php echo 'Remove'; ?></span></a></div>
    <div class="right"><a id="button-confirm" class="button"><span><?php echo $button_confirm; ?></span></a></div>
</div>
<script type="text/javascript"><!--
$('#button-confirm').bind('click', function() {
    var oids = new Array();
    $('.gds_order').each(function(index, obj) {
        oids.push(parseInt($(this).closest('tr').attr('oid')));
    });
    $.post(
        'index.php?route=checkout/bcheckout/confirm',
        { 'orders': JSON.stringify(oids) },
        function(response) {
            location = '<?php echo $continue; ?>';
        }
    );
});
$('#button-remove').bind('click', function() {
    var objs_to_remove = new Array();
    var oids_to_remove = new Array();
    $('.gds_order_remove .gds_order_remove_checkbox:checked').each(function(index, obj) {
        objs_to_remove.push($(this).closest('tr'));
        oids_to_remove.push(parseInt($(this).closest('tr').attr('oid')));
    });
    $.post(
            'index.php?route=checkout/bcheckout/remove',
            { 'orders': JSON.stringify(oids_to_remove) },
            function(json) {
                if (json['redirect']) {
                    location = json['redirect'];
                }

                if (json['output']) {
                     for (var i in objs_to_remove) {
                         var obj = objs_to_remove[i];
                         console.log(obj);
                         obj.fadeOut();
                         obj.remove();
                     }
                };
            },
            'json'
    );
});
//--></script> 
