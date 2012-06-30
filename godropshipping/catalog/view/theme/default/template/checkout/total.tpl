<?php foreach ($totals as $total) { ?>
<tr>
    <td colspan="9" class="price"><b><?php echo $total['title']; ?>:</b></td>
    <td class="total"><?php echo $total['text']; ?></td>
</tr>
<?php } ?>