<?php
class ControllerPaymentPPStandardBatch extends Controller {
	protected function index() {
		$this->language->load('payment/pp_standard');
		
		$this->data['text_testmode'] = $this->language->get('text_testmode');		
    	
		$this->data['button_confirm'] = $this->language->get('button_confirm');

		$this->data['testmode'] = $this->config->get('pp_standard_test');
		
		if (!$this->config->get('pp_standard_test')) {
    		$this->data['action'] = 'https://www.paypal.com/cgi-bin/webscr';
  		} else {
			$this->data['action'] = 'https://www.sandbox.paypal.com/cgi-bin/webscr';
		}

		$this->load->model('checkout/border');

		$batch_order_info = $this->model_checkout_border->getBatchOrder($this->session->data['order_group_id']);

		if ($batch_order_info) {
			$currencies = array(
				'AUD',
				'CAD',
				'EUR',
				'GBP',
				'JPY',
				'USD',
				'NZD',
				'CHF',
				'HKD',
				'SGD',
				'SEK',
				'DKK',
				'PLN',
				'NOK',
				'HUF',
				'CZK',
				'ILS',
				'MXN',
				'MYR',
				'BRL',
				'PHP',
				'TWD',
				'THB',
				'TRY'
			);
			
			if (in_array($batch_order_info['currency_code'], $currencies)) {
				$currency = $batch_order_info['currency_code'];
			} else {
				$currency = 'USD';
			}		
		
			$this->data['business'] = $this->config->get('pp_standard_email');
			$this->data['item_name'] = html_entity_decode($this->config->get('config_name'), ENT_QUOTES, 'UTF-8');

			$this->data['products'] = array();
			
			$this->data['discount_amount_cart'] = 0;
			
			$total = $batch_order_info['total'];

            if ($total >= 0) {
                $this->data['orders'][] = array(
                    'name'     => $this->language->get('text_total'),
                    'model'    => '',
                    'price'    => round($total, 2),
                    'quantity' => 1,
                    'option'   => array(),
                    'weight'   => 0
                );
            } else {
//                $this->data['discount_amount_cart'] -= $this->currency->format($total, $currency, false, false);
            }
			
			$this->data['currency_code'] = $currency;
			$this->data['first_name'] = html_entity_decode($batch_order_info['payment_firstname'], ENT_QUOTES, 'UTF-8');
			$this->data['last_name'] = html_entity_decode($batch_order_info['payment_lastname'], ENT_QUOTES, 'UTF-8');
			$this->data['address1'] = html_entity_decode($batch_order_info['payment_address_1'], ENT_QUOTES, 'UTF-8');
			$this->data['address2'] = html_entity_decode($batch_order_info['payment_address_2'], ENT_QUOTES, 'UTF-8');
			$this->data['city'] = html_entity_decode($batch_order_info['payment_city'], ENT_QUOTES, 'UTF-8');
			$this->data['zip'] = html_entity_decode($batch_order_info['payment_postcode'], ENT_QUOTES, 'UTF-8');
			$this->data['country'] = $batch_order_info['payment_iso_code_2'];
			$this->data['notify_url'] = $this->url->link('payment/pp_standard/callback');
			$this->data['email'] = $batch_order_info['email'];
			$this->data['invoice'] = $this->session->data['order_group_id'] . ' - ' . html_entity_decode($batch_order_info['payment_firstname'], ENT_QUOTES, 'UTF-8') . ' ' . html_entity_decode($batch_order_info['payment_lastname'], ENT_QUOTES, 'UTF-8');
			$this->data['lc'] = $this->session->data['language'];
			$this->data['return'] = $this->url->link('checkout/success');
			$this->data['notify_url'] = $this->url->link('payment/pp_standard/callback');
			$this->data['cancel_return'] = $this->url->link('checkout/bcheckout', '', 'SSL');
			
			if (!$this->config->get('pp_standard_transaction')) {
				$this->data['paymentaction'] = 'authorization';
			} else {
				$this->data['paymentaction'] = 'sale';
			}
			
			$this->load->library('encryption');
	
			$encryption = new Encryption($this->config->get('config_encryption'));
	
			$this->data['custom'] = $encryption->encrypt($this->session->data['order_group_id']);
            $this->data['continue'] = $this->url->link('checkout/success');

            if (file_exists(DIR_TEMPLATE . $this->config->get('config_template') . '/template/payment/pp_standard_batch.tpl')) {
				$this->template = $this->config->get('config_template') . '/template/payment/pp_standard_batch.tpl';
			} else {
				$this->template = 'default/template/payment/pp_standard_batch.tpl';
			}
	
			$this->render();
		}
	}
	
	public function callback() {
		$this->load->library('encryption');
	
		$encryption = new Encryption($this->config->get('config_encryption'));
		
		if (isset($this->request->post['custom'])) {
			$order_group_id = $encryption->decrypt($this->request->post['custom']);
		} else {
            $order_group_id = 0;
		}		
		
		$this->load->model('checkout/border');

        $batch_order_info = $this->model_checkout_border->getBatchOrder($order_group_id);
		
		if ($batch_order_info) {
			$request = 'cmd=_notify-validate';
		
			foreach ($this->request->post as $key => $value) {
				$request .= '&' . $key . '=' . urlencode(html_entity_decode($value, ENT_QUOTES, 'UTF-8'));
			}
			
			if (!$this->config->get('pp_standard_test')) {
				$curl = curl_init('https://www.paypal.com/cgi-bin/webscr');
			} else {
				$curl = curl_init('https://www.sandbox.paypal.com/cgi-bin/webscr');
			}

			curl_setopt($curl, CURLOPT_POST, true);
			curl_setopt($curl, CURLOPT_POSTFIELDS, $request);
			curl_setopt($curl, CURLOPT_RETURNTRANSFER, true);
			curl_setopt($curl, CURLOPT_HEADER, false);
			curl_setopt($curl, CURLOPT_TIMEOUT, 30);
			curl_setopt($curl, CURLOPT_SSL_VERIFYPEER, false);
					
			$response = curl_exec($curl);
			
			if (!$response) {
				$this->log->write('PP_STANDARD :: CURL failed ' . curl_error($curl) . '(' . curl_errno($curl) . ')');
			}
					
			if ($this->config->get('pp_standard_debug')) {
				$this->log->write('PP_STANDARD :: IPN REQUEST: ' . $request);
				$this->log->write('PP_STANDARD :: IPN RESPONSE: ' . $response);
			}
						
			if ((strcmp($response, 'VERIFIED') == 0 || strcmp($response, 'UNVERIFIED') == 0) && isset($this->request->post['payment_status'])) {
				$order_status_id = $this->config->get('config_order_status_id');
				
				switch($this->request->post['payment_status']) {
					case 'Canceled_Reversal':
						$order_status_id = $this->config->get('pp_standard_canceled_reversal_status_id');
						break;
					case 'Completed':
						if ((float)$this->request->post['mc_gross'] == $this->currency->format($batch_order_info['total'], $batch_order_info['currency_code'], $batch_order_info['currency_value'], false)) {
							$order_status_id = $this->config->get('pp_standard_completed_status_id');
						}
						break;
					case 'Denied':
						$order_status_id = $this->config->get('pp_standard_denied_status_id');
						break;
					case 'Expired':
						$order_status_id = $this->config->get('pp_standard_expired_status_id');
						break;
					case 'Failed':
						$order_status_id = $this->config->get('pp_standard_failed_status_id');
						break;
					case 'Pending':
						$order_status_id = $this->config->get('pp_standard_pending_status_id');
						break;
					case 'Processed':
						$order_status_id = $this->config->get('pp_standard_processed_status_id');
						break;
					case 'Refunded':
						$order_status_id = $this->config->get('pp_standard_refunded_status_id');
						break;
					case 'Reversed':
						$order_status_id = $this->config->get('pp_standard_reversed_status_id');
						break;	 
					case 'Voided':
						$order_status_id = $this->config->get('pp_standard_voided_status_id');
						break;								
				}
				
				if (!$batch_order_info['order_status_id']) {
					$this->model_checkout_border->confirm($order_group_id, $order_status_id);
				} else {
					$this->model_checkout_border->update($order_group_id, $order_status_id);
				}
			} else {
				$this->model_checkout_order->confirm($order_group_id, $this->config->get('config_order_status_id'));
			}
			
			curl_close($curl);
		}	
	}
}
?>