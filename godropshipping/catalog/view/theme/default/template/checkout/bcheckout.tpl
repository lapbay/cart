<?php echo $header; ?><?php echo $column_left; ?><?php echo $column_right; ?>
<div id="content"><?php echo $content_top; ?>
  <div class="breadcrumb">
    <?php foreach ($breadcrumbs as $breadcrumb) { ?>
    <?php echo $breadcrumb['separator']; ?><a href="<?php echo $breadcrumb['href']; ?>"><?php echo $breadcrumb['text']; ?></a>
    <?php } ?>
  </div>
  <h1><?php echo $heading_title; ?></h1>

  <div class="checkout">
    <div id="checkout">
      <div class="checkout-heading"><?php echo $text_checkout_option; ?></div>
      <div class="checkout-content"></div>
    </div>
    <?php if (!$logged) { ?>
      <div id="payment-address">
          <div class="checkout-heading"><span><?php echo $text_checkout_account; ?></span></div>
          <div class="checkout-content"></div>
      </div>
      <?php } else { ?>
      <div id="payment-address">
          <div class="checkout-heading"><span><?php echo $text_checkout_payment_address; ?></span></div>
          <div class="checkout-content"></div>
      </div>
    <?php } ?>
    <?php if ($shipping_required) { ?>
      <div id="shipping-address" style="display: none;">
          <div class="checkout-heading"><?php echo $text_checkout_shipping_address; ?></div>
          <div class="checkout-content"></div>
      </div>
    <?php } ?>
      <div id="payment-method" style="display: none">
          <div class="checkout-heading">Step 5: Payment Method<a>Modify »</a></div>
          <div class="checkout-content" style="display: block;"><p>Please select the preferred payment method to use on this order.</p>
              <table class="form">
                  <tbody><tr>
                      <td style="width: 1px;">            <input type="radio" checked="checked" id="pp_standard" value="pp_standard" name="payment_method">
                      </td>
                      <td><label for="pp_standard">PayPal</label></td>
                  </tr>
                  </tbody></table>
              <b>Add Comments About Your Order</b>
              <textarea style="width: 98%;" rows="8" name="comment"></textarea>
              <br>
              <br>
              <div class="buttons">
                  <div class="right">I have read and agree to the <a alt="Terms &amp; Conditions" href="http://godropshipping.com/index.php?route=information/information/info&amp;information_id=5" class="fancybox"><b>Terms &amp; Conditions</b></a>        <input type="checkbox" value="1" name="agree" checked="checked">
                      <a class="button" id="button-payment"><span>Continue</span></a></div>
              </div>
          </div>
      </div>
      <div id="order-upload">
          <div class="checkout-heading"><?php echo $text_upload_file; ?></div>
          <div class="checkout-content">
              <input id="fileupload" type="file" name="files" data-url="http://godropshipping.com/index.php?route=checkout/bcheckout/parser" multiple>
              <img id="loading-image" src="catalog/view/javascript/jquery/loading.gif" style="display: none;">
              <p id="uploaded-file-name"></p>
          </div>
      </div>
    <div id="confirm">
      <div class="checkout-heading"><?php echo $text_checkout_confirm; ?></div>
      <div class="checkout-content"></div>
    </div>
  </div>
  <?php echo $content_bottom; ?></div>
<script type="text/javascript"><!--
$('#checkout .checkout-content input[name=\'account\']').live('change', function() {
	if ($(this).attr('value') == 'register') {
		$('#payment-address .checkout-heading span').html('<?php echo $text_checkout_account; ?>');
	} else {
		$('#payment-address .checkout-heading span').html('<?php echo $text_checkout_payment_address; ?>');
	}
});

$('.checkout-heading a').live('click', function() {
	$('.checkout-content').slideUp('slow');
	
	$(this).parent().parent().find('.checkout-content').slideDown('slow');
});
<?php if (!$logged) { ?> 
$(document).ready(function() {
	$.ajax({
		url: 'index.php?route=checkout/login',
		dataType: 'json',
		success: function(json) {
//			if (json['redirect']) {
//				location = json['redirect'];
//			}
			if (json['output']) {
				$('#checkout .checkout-content').html(json['output']);

				$('#checkout .checkout-content').slideDown('slow');
			}
		}
	});
});
<?php } else { ?>
$(document).ready(function() {
    $.ajax({
        url: 'index.php?route=checkout/address/payment',
        dataType: 'json',
        success: function(json) {
            if (json['redirect']) {
                //location = json['redirect'];
            }

            if (json['output']) {
                $('#payment-address .checkout-content').html(json['output']);

                $('#payment-address .checkout-content').slideDown('slow');
            }
        }
    });
});
<?php } ?>

// Checkout
$('#button-account').live('click', function() {
	$.ajax({
		url: 'index.php?route=checkout/' + $('input[name=\'account\']:checked').attr('value'),
		dataType: 'json',
		beforeSend: function() {
			$('#button-account').attr('disabled', true);
			$('#button-account').after('<span class="wait">&nbsp;<img src="catalog/view/theme/default/image/loading.gif" alt="" /></span>');
		},		
		complete: function() {
			$('#button-account').attr('disabled', false);
			$('.wait').remove();
		},			
		success: function(json) {
			$('.warning').remove();
			
			if (json['redirect']) {
				location = json['redirect'];
			}

			if (json['output']) {
				$('#payment-address .checkout-content').html(json['output']);

				$('#checkout .checkout-content').slideUp('slow');

				$('#payment-address .checkout-content').slideDown('slow');

				$('.checkout-heading a').remove();

				$('#checkout .checkout-heading').append('<a><?php echo $text_modify; ?></a>');
			}
		}
	});
});

// Login
$('#button-login').live('click', function() {
	$.ajax({
		url: 'index.php?route=checkout/login',
		type: 'post',
		data: $('#checkout #login :input'),
		dataType: 'json',
		beforeSend: function() {
			$('#button-login').attr('disabled', true);
			$('#button-login').after('<span class="wait">&nbsp;<img src="catalog/view/theme/default/image/loading.gif" alt="" /></span>');
		},	
		complete: function() {
			$('#button-login').attr('disabled', false);
			$('.wait').remove();
		},				
		success: function(json) {
			$('.warning').remove();
			
			if (json['redirect']) {
				location = json['redirect'];
			}
			
			if (json['total']) {
				$('#cart_total').html(json['total']);
			}
			
			if (json['logged']) {
				$('#welcome').html(json['logged']);
			}
						
			if (json['error']) {
				$('#checkout .checkout-content').prepend('<div class="warning" style="display: none;">' + json['error']['warning'] + '</div>');
				
				$('.warning').fadeIn('slow');
			} else {								
				$.ajax({
					url: 'index.php?route=checkout/address/payment',
					dataType: 'json',
					success: function(json) {
						if (json['redirect']) {
							location = json['redirect'];
						}						
						
						if (json['output']) {
							$('#payment-address .checkout-content').html(json['output']);
							
							$('#checkout .checkout-content').slideUp('slow');
							
							$('#payment-address .checkout-content').slideDown('slow');
							
							$('#payment-address .checkout-heading span').html('<?php echo $text_checkout_payment_address; ?>');
							
							$('.checkout-heading a').remove();
						}
					}
				});	
			}
		}
	});	
});

// Register
$('#button-register').live('click', function() {
	$.ajax({
		url: 'index.php?route=checkout/register',
		type: 'post',
		data: $('#payment-address input[type=\'text\'], #payment-address input[type=\'password\'], #payment-address input[type=\'checkbox\']:checked, #payment-address input[type=\'radio\']:checked, #payment-address select'),
		dataType: 'json',
		beforeSend: function() {
			$('#button-register').attr('disabled', true);
			$('#button-register').after('<span class="wait">&nbsp;<img src="catalog/view/theme/default/image/loading.gif" alt="" /></span>');
		},	
		complete: function() {
			$('#button-register').attr('disabled', false); 
			$('.wait').remove();
		},			
		success: function(json) {
			$('.warning').remove();
			$('.error').remove();
						
			if (json['redirect']) {
				location = json['redirect'];
			}
						
			if (json['error']) {
				if (json['error']['warning']) {
					$('#payment-address .checkout-content').prepend('<div class="warning" style="display: none;">' + json['error']['warning'] + '</div>');
					
					$('.warning').fadeIn('slow');
				}
				
				if (json['error']['firstname']) {
					$('#payment-address input[name=\'firstname\'] + br').after('<span class="error">' + json['error']['firstname'] + '</span>');
				}
				
				if (json['error']['lastname']) {
					$('#payment-address input[name=\'lastname\'] + br').after('<span class="error">' + json['error']['lastname'] + '</span>');
				}	
				
				if (json['error']['email']) {
					$('#payment-address input[name=\'email\'] + br').after('<span class="error">' + json['error']['email'] + '</span>');
				}
				
				if (json['error']['telephone']) {
					$('#payment-address input[name=\'telephone\'] + br').after('<span class="error">' + json['error']['telephone'] + '</span>');
				}		
										
				if (json['error']['address_1']) {
					$('#payment-address input[name=\'address_1\'] + br').after('<span class="error">' + json['error']['address_1'] + '</span>');
				}	
				
				if (json['error']['city']) {
					$('#payment-address input[name=\'city\'] + br').after('<span class="error">' + json['error']['city'] + '</span>');
				}	
				
				if (json['error']['postcode']) {
					$('#payment-address input[name=\'postcode\'] + br').after('<span class="error">' + json['error']['postcode'] + '</span>');
				}	
				
				if (json['error']['country']) {
					$('#payment-address select[name=\'country_id\'] + br').after('<span class="error">' + json['error']['country'] + '</span>');
				}	
				
				if (json['error']['zone']) {
					$('#payment-address select[name=\'zone_id\'] + br').after('<span class="error">' + json['error']['zone'] + '</span>');
				}
				
				if (json['error']['password']) {
					$('#payment-address input[name=\'password\'] + br').after('<span class="error">' + json['error']['password'] + '</span>');
				}	
				
				if (json['error']['confirm']) {
					$('#payment-address input[name=\'confirm\'] + br').after('<span class="error">' + json['error']['confirm'] + '</span>');
				}																																	
			} else {
				<?php if ($shipping_required) { ?>				
				var shipping_address = $('#payment-address input[name=\'shipping_address\']:checked').attr('value');
				
				if (shipping_address) {
					$.ajax({
						url: 'index.php?route=checkout/shipping',
						dataType: 'json',
						success: function(json) {
							if (json['redirect']) {
								location = json['redirect'];
							}
														
							if (json['output']) {
								$('#shipping-method .checkout-content').html(json['output']);
								
								$('#payment-address .checkout-content').slideUp('slow');
								
								$('#shipping-method .checkout-content').slideDown('slow');
								
								$('#checkout .checkout-heading a').remove();
								$('#payment-address .checkout-heading a').remove();
								$('#shipping-address .checkout-heading a').remove();
								$('#shipping-method .checkout-heading a').remove();
								$('#payment-method .checkout-heading a').remove();											
								
								$('#shipping-address .checkout-heading').append('<a><?php echo $text_modify; ?></a>');									
								$('#payment-address .checkout-heading').append('<a><?php echo $text_modify; ?></a>');	
	
								$.ajax({
									url: 'index.php?route=checkout/address/shipping',
									dataType: 'json',
									success: function(json) {
										if (json['redirect']) {
											location = json['redirect'];
										}										
										
										if (json['output']) {
											$('#shipping-address .checkout-content').html(json['output']);
										}
									}
								});	
							}
						}
					});	
				} else {
					$.ajax({
						url: 'index.php?route=checkout/address/shipping',
						dataType: 'json',
						success: function(json) {
							if (json['redirect']) {
								location = json['redirect'];
							}
										
							if (json['output']) {
								$('#shipping-address .checkout-content').html(json['output']);
								
								$('#payment-address .checkout-content').slideUp('slow');
								
								$('#shipping-address .checkout-content').slideDown('slow');
								
								$('#checkout .checkout-heading a').remove();
								$('#payment-address .checkout-heading a').remove();
								$('#shipping-address .checkout-heading a').remove();
								$('#shipping-method .checkout-heading a').remove();
								$('#payment-method .checkout-heading a').remove();							

								$('#payment-address .checkout-heading').append('<a><?php echo $text_modify; ?></a>');	
							}
						}
					});			
				}
				<?php } else { ?>
				$.ajax({
					url: 'index.php?route=checkout/payment',
					dataType: 'json',
					success: function(json) {
						if (json['redirect']) {
							location = json['redirect'];
						}	
											
						if (json['output']) {
							$('#payment-method .checkout-content').html(json['output']);
							
							$('#payment-address .checkout-content').slideUp('slow');
							
							$('#payment-method .checkout-content').slideDown('slow');
							
							$('#checkout .checkout-heading a').remove();
							$('#payment-address .checkout-heading a').remove();
							$('#payment-method .checkout-heading a').remove();								
							
							$('#payment-address .checkout-heading').append('<a><?php echo $text_modify; ?></a>');	
						}
					}
				});					
				<?php } ?>
				
				$.ajax({
					url: 'index.php?route=checkout/address/payment',
					dataType: 'json',
					success: function(json) {
						if (json['redirect']) {
							location = json['redirect'];
						}
									
						if (json['output']) {
							$('#payment-address .checkout-content').html(json['output']);
							
							$('#payment-address .checkout-heading span').html('<?php echo $text_checkout_payment_address; ?>');
						}
					}
				});
			}	 
		}
	});	
});

// Payment Address
$('#payment-address #button-address').live('click', function() {
    $.ajax({
        url: 'index.php?route=checkout/address/payment',
        type: 'post',
        data: $('#payment-address input[type=\'text\'], #payment-address input[type=\'password\'], #payment-address input[type=\'checkbox\']:checked, #payment-address input[type=\'radio\']:checked, #payment-address select'),
        dataType: 'json',
        beforeSend: function() {
            $('#payment-address #button-address').attr('disabled', true);
            $('#payment-address #button-address').after('<span class="wait">&nbsp;<img src="catalog/view/theme/default/image/loading.gif" alt="" /></span>');
        },
        complete: function() {
            $('#payment-address #button-address').attr('disabled', false);
            $('.wait').remove();
        },
        success: function(json) {
            $('.error').remove();

//            if (json['redirect']) {
//                location = json['redirect'];
//            }

            if (json['error']) {
                if (json['error']['firstname']) {
                    $('#payment-address input[name=\'firstname\']').after('<span class="error">' + json['error']['firstname'] + '</span>');
                }

                if (json['error']['lastname']) {
                    $('#payment-address input[name=\'lastname\']').after('<span class="error">' + json['error']['lastname'] + '</span>');
                }

                if (json['error']['telephone']) {
                    $('#payment-address input[name=\'telephone\']').after('<span class="error">' + json['error']['telephone'] + '</span>');
                }

                if (json['error']['address_1']) {
                    $('#payment-address input[name=\'address_1\']').after('<span class="error">' + json['error']['address_1'] + '</span>');
                }

                if (json['error']['city']) {
                    $('#payment-address input[name=\'city\']').after('<span class="error">' + json['error']['city'] + '</span>');
                }

                if (json['error']['postcode']) {
                    $('#payment-address input[name=\'postcode\']').after('<span class="error">' + json['error']['postcode'] + '</span>');
                }

                if (json['error']['country']) {
                    $('#payment-address select[name=\'country_id\']').after('<span class="error">' + json['error']['country'] + '</span>');
                }

                if (json['error']['zone']) {
                    $('#payment-address select[name=\'zone_id\']').after('<span class="error">' + json['error']['zone'] + '</span>');
                }
            } else {
            <?php if ($shipping_required) { ?>
                    $.ajax({
                        url: 'index.php?route=checkout/address/shipping',
                        dataType: 'json',
                        success: function(json) {
//                            if (json['redirect']) {
//                                location = json['redirect'];
//                            }

                            if (json['output']) {
                                $('#order-upload .checkout-content').slideDown('slow');

                                $('#shipping-address .checkout-content').html(json['output']);

                                $('#payment-address .checkout-content').slideUp('slow');

                                $('#shipping-address .checkout-content').slideDown('slow');

                                $('#payment-address .checkout-heading a').remove();
                                $('#shipping-address .checkout-heading a').remove();
                                $('#shipping-method .checkout-heading a').remove();
                                $('#payment-method .checkout-heading a').remove();

                                $('#payment-address .checkout-heading').append('<a><?php echo $text_modify; ?></a>');
                            }
                        }
                    });
                <?php } else { ?>
                    $.ajax({
                        url: 'index.php?route=checkout/payment',
                        dataType: 'json',
                        success: function(json) {
//                            if (json['redirect']) {
//                                location = json['redirect'];
//                            }

                            if (json['output']) {
                                $('#order-upload .checkout-content').slideDown('slow');

                                $('#payment-method .checkout-content').html(json['output']);

                                $('#payment-address .checkout-content').slideUp('slow');

                                $('#payment-method .checkout-content').slideDown('slow');

                                $('#payment-address .checkout-heading a').remove();
                                $('#payment-method .checkout-heading a').remove();

                                $('#payment-address .checkout-heading').append('<a><?php echo $text_modify; ?></a>');
                            }
                        }
                    });
                <?php } ?>
                $.ajax({
                    url: 'index.php?route=checkout/address/payment',
                    dataType: 'json',
                    success: function(json) {
//                        if (json['redirect']) {
//                            location = json['redirect'];
//                        }

                        if (json['output']) {
                            $('#payment-address .checkout-content').html(json['output']);
                        }
                    }
                });

                $.ajax({
                    url: 'index.php?route=checkout/address/shipping',
                    type: 'post',
                    data: "shipping_address=existing&address_id=1&firstname=&lastname=&company=&address_1=&address_2=&city=&postcode=&country_id=222&zone_id=",
                    dataType: 'json',
                    success: function(json) {
                    }
                });

                $.ajax({
                    url: 'index.php?route=checkout/payment',
                    dataType: 'json',
                    success: function(json) {
                        if (json['output']) {
//                            $('#payment-method .checkout-content').html(json['output']);
                            $.ajax({
                                url: 'index.php?route=checkout/payment',
                                type: 'post',
                                data: $('#payment-method input[type=\'radio\']:checked, #payment-method input[type=\'checkbox\']:checked, #payment-method textarea'),
                                dataType: 'json',
                                success: function(json) {
                                    if (json['error']) {
                                        if (json['error']['warning']) {
                                            $('#payment-method .checkout-content').prepend('<div class="warning" style="display: none;">' + json['error']['warning'] + '</div>');

                                            $('.warning').fadeIn('slow');
                                        }
                                    } else {

                                    }
                                }
                            });
                        }
                    },
                    error: function(xhr, ajaxOptions, thrownError) {
                        alert(thrownError);
                    }
                });

            }
        }
    });
});

$(document).ready(function() {
    $('#fileupload').fileupload({
        dataType: 'json',
        maxNumberOfFiles: 1,
        change: function (e, data) {
            $.each(data.files, function (index, file) {
                $('#loading-image').show();
                $('#uploaded-file-name').html(file.name);
//                $('#loading-image').after('<p>' + file.name + '</p>');
            });
        },
        done: function (e, data) {
            $('#loading-image').hide();
            var json = data.result;

            if (!json) {
                $('#confirm .checkout-content').prepend('<div class="warning" style="display: none;">' + 'Error getting upload result.' + '</div>');
                $('.warning').fadeIn('slow');
                return;
            }
            if (json['redirect']) {
                location = json['redirect'];
            }
            if (json['error']) {
                if (json['error']['error']) {
                    $('#order-upload .checkout-content').prepend('<div class="warning" style="display: none;">' + json['error']['error'] + '</div>');
                    $('#order-upload .checkout-content').slideDown('slow');
                    $('.warning').fadeIn('slow');
                    return;
                }
            }
            if (json['output']) {
                $('#confirm .checkout-content').html(json['output']);
                $('#confirm .checkout-content').slideDown('slow');
                $('.warning').fadeOut('slow');
            } else {
                $('#confirm .checkout-content').prepend('<div class="warning" style="display: none;">' + 'Error getting result.' + '</div>');
                $('.warning').fadeIn('slow');
            }
            $.each(data.result, function (index, file) {
            });
        }
    });
});

$(".gds_order_remove_all_checkbox").live('click', function(){
    if( $(this).is(':checked') ) {
        $('.gds_order_remove_checkbox').attr('checked', true);
    } else {
        $('.gds_order_remove_checkbox').attr('checked', false);
    }
});

//--></script>
<?php echo $footer; ?>