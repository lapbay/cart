<?php
class ModelTotalVip extends Model {
	public function getTotal(&$total_data, &$total, &$taxes) {
        $this->load->language('total/voucher');

        $this->load->model('account/customer');

        $customer = $this->model_account_customer->getCustomerWithGroup($this->session->data['customer_id']);
        $discount = null;
        if ($customer) {
            switch ($customer['customer_group_name']) {
                case 'Golden':
                    $discount = 0.15;
                    break;
                case 'Silver':
                    $discount = 0.10;
                    break;
                case 'Copper':
                    $discount = 0.05;
                    break;
            }
            if ($discount) {
                $amount = $total * $discount;
                $total_data[] = array(
                    'code'       => 'vip',
                    'title'      => 'Vip Discount',
                    'text'       => $this->currency->format(-$amount),
                    'value'      => -$amount,
                    'sort_order' => $this->config->get('coupon_sort_order')
                );

                $total -= $amount;
            }

        }
	}
	
	public function confirm($order_info, $order_total) {
		$code = '';
		
		$start = strpos($order_total['title'], '(') + 1;
		$end = strrpos($order_total['title'], ')');
		
		if ($start && $end) {  
			$code = substr($order_total['title'], $start, $end - $start);
		}	
		
		$this->load->model('checkout/voucher');
		
		$voucher_info = $this->model_checkout_voucher->getVoucher($code);
		
		if ($voucher_info) {
			$this->model_checkout_voucher->redeem($voucher_info['voucher_id'], $order_info['order_id'], $order_total['value']);	
		}						
	}	
}
?>