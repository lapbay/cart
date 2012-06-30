<?php  
class ControllerCheckoutBCheckout extends Controller {
	public function index() {
        if (!$this->customer->isLogged()) {
            $this->redirect($this->url->link('account/login'));
    	}
				
		$this->language->load('checkout/bcheckout');
		
		$this->document->setTitle($this->language->get('heading_title'));
        $this->document->addScript('catalog/view/javascript/jquery/jquery.fileupload.js');

        $this->data['breadcrumbs'] = array();

      	$this->data['breadcrumbs'][] = array(
        	'text'      => $this->language->get('text_home'),
			'href'      => $this->url->link('common/home'),
        	'separator' => false
      	); 

      	$this->data['breadcrumbs'][] = array(
        	'text'      => $this->language->get('text_cart'),
			'href'      => $this->url->link('checkout/cart'),
        	'separator' => $this->language->get('text_separator')
      	);
		
      	$this->data['breadcrumbs'][] = array(
        	'text'      => $this->language->get('heading_title'),
			'href'      => $this->url->link('checkout/bcheckout', '', 'SSL'),
        	'separator' => $this->language->get('text_separator')
      	);

        $this->data['batch_parser'] = $this->url->link('checkout/bcheckout/parser');

        $this->data['heading_title'] = $this->language->get('heading_title');

        $this->data['text_upload_file'] = $this->language->get('text_upload_file');
        $this->data['text_checkout_option'] = sprintf($this->language->get('text_checkout_option'));
        $this->data['text_checkout_account'] = $this->language->get('text_checkout_account');
        $this->data['text_checkout_payment_address'] = $this->language->get('text_checkout_payment_address');
		$this->data['text_checkout_shipping_address'] = $this->language->get('text_checkout_shipping_address');
		$this->data['text_checkout_shipping_method'] = $this->language->get('text_checkout_shipping_method');
		$this->data['text_checkout_payment_method'] = $this->language->get('text_checkout_payment_method');		
		$this->data['text_checkout_confirm'] = $this->language->get('text_checkout_confirm');
		$this->data['text_modify'] = $this->language->get('text_modify');
		
		$this->data['logged'] = $this->customer->isLogged();
		$this->data['shipping_required'] = $this->cart->hasShipping();
		
		if (file_exists(DIR_TEMPLATE . $this->config->get('config_template') . '/template/checkout/bcheckout.tpl')) {
			$this->template = $this->config->get('config_template') . '/template/checkout/bcheckout.tpl';
		} else {
			$this->template = 'default/template/checkout/bcheckout.tpl';
		}
		
		$this->children = array(
			'common/column_left',
			'common/column_right',
			'common/content_top',
			'common/content_bottom',
			'common/footer',
			'common/header'	
		);
				
		$this->response->setOutput($this->render());
  	}


    public function parser() {
        $this->tax = $this->registry->get('tax');

        $this->language->load('checkout/bcheckout');
        $this->load->model('setting/extension');
        $json = array();

        $this->data['column_customer_order'] = $this->language->get('column_customer_order');
        $this->data['column_gds_order'] = $this->language->get('column_gds_order');
        $this->data['column_vendor_sku'] = $this->language->get('column_vendor_sku');
        $this->data['column_gds_sku'] = $this->language->get('column_gds_sku');
        $this->data['column_end_customer_name'] = $this->language->get('column_end_customer_name');
        $this->data['column_ship_to_country'] = $this->language->get('column_ship_to_country');

        $this->data['column_name'] = $this->language->get('column_name');
        $this->data['column_model'] = $this->language->get('column_model');
        $this->data['column_quantity'] = $this->language->get('column_quantity');
        $this->data['column_price'] = $this->language->get('column_price');
        $this->data['column_total'] = $this->language->get('column_total');

        $this->data['products'] = array();
        $this->data['orders'] = array();
        $this->data['vouchers'] = array();
        $this->data['payment'] = 'placeholder';
        $total_data = array();
        $total = 0;

        $orders = array();
//        $file_data = $this->parse_csv($_FILES["files"]);
        $file_data = $this->parse_excel($_FILES["files"]);

        if (isset($file_data['error'])) {
            $json['error'] = $file_data['error'];
        }

        foreach ($file_data['data'] as $index=>$uploaded_data) {
            $order = array();
            $order['total'] = 0;

            $order['invoice_prefix'] = $this->config->get('config_invoice_prefix');
            $order['store_id'] = $this->config->get('config_store_id');
            $order['store_name'] = $this->config->get('config_name');

            if ($order['store_id']) {
                $order['store_url'] = $this->config->get('config_url');
            } else {
                $order['store_url'] = HTTP_SERVER;
            }

            if ($this->customer->isLogged()) {
                $order['customer_id'] = $this->customer->getId();
                $order['customer_group_id'] = $this->customer->getCustomerGroupId();
                $order['firstname'] = $this->customer->getFirstName();
                $order['lastname'] = $this->customer->getLastName();
                $order['email'] = $this->customer->getEmail();
                $order['telephone'] = $uploaded_data['ship_to_phone'];
                $order['fax'] = $this->customer->getFax();

                $this->load->model('account/address');

                $payment_address = $this->model_account_address->getAddress($this->session->data['payment_address_id']);
            } elseif (isset($this->session->data['guest'])) {
                $order['customer_id'] = 0;
                $order['customer_group_id'] = $this->config->get('config_customer_group_id');
                $order['firstname'] = $this->session->data['guest']['firstname'];
                $order['lastname'] = $this->session->data['guest']['lastname'];
                $order['email'] = $this->session->data['guest']['email'];
                $order['telephone'] = $uploaded_data['ship_to_phone'];
                $order['fax'] = $this->session->data['guest']['fax'];

                $payment_address = $this->session->data['guest']['payment'];
            }

            $order['payment_firstname'] = $payment_address['firstname'];
            $order['payment_lastname'] = $payment_address['lastname'];
            $order['payment_company'] = $payment_address['company'];
            $order['payment_address_1'] = $payment_address['address_1'];
            $order['payment_address_2'] = $payment_address['address_2'];
            $order['payment_city'] = $payment_address['city'];
            $order['payment_postcode'] = $payment_address['postcode'];
            $order['payment_zone'] = $payment_address['zone'];
            $order['payment_zone_id'] = $payment_address['zone_id'];
            $order['payment_country'] = $payment_address['country'];
            $order['payment_country_id'] = $payment_address['country_id'];
            $order['payment_address_format'] = $payment_address['address_format'];
            if (isset($this->session->data['payment_method']['title'])) {
                $order['payment_method'] = $this->session->data['payment_method']['title'];
            } else {
                $order['payment_method'] = '';
            }

            $order['shipping_firstname'] = $uploaded_data['end_cusotomer_name'];
            $order['shipping_lastname'] = '';
            $order['shipping_company'] = '';
            $order['shipping_address_1'] = $uploaded_data['ship_to_address1'];
            $order['shipping_address_2'] = '';
            $order['shipping_city'] = $uploaded_data['ship_to_city'];
            $order['shipping_postcode'] = $uploaded_data['ship_to_postcode'];
            $order['shipping_zone'] = '';
            $order['shipping_zone_id'] = '';
            $order['shipping_country'] = $uploaded_data['ship_to_country'];
            $order['shipping_country_id'] = '';
            $order['shipping_address_format'] = '';
            if (isset($this->session->data['shipping_method']['title'])) {
                $order['shipping_method'] = $this->session->data['shipping_method']['title'];
            } else {
                $order['shipping_method'] = '';
            }

            $this->load->library('encryption');
            $this->load->model('catalog/product');
            $this->load->model('checkout/order');

            $product_data = array();
            $tax_data = array();

            foreach ($this->model_catalog_product->getProductsByIds($uploaded_data['gds_products']) as $product_id => $product) {
                //$product = $this->model_catalog_product->getProduct($sku);
                $option_data = array();

                if ($product) {
                    if (isset($product['option'])) {
                        foreach ($product['option'] as $option) {
                            if ($option['type'] != 'file') {
                                $option_data[] = array(
                                    'product_option_id'       => $option['product_option_id'],
                                    'product_option_value_id' => $option['product_option_value_id'],
                                    'product_option_id'       => $option['product_option_id'],
                                    'product_option_value_id' => $option['product_option_value_id'],
                                    'option_id'               => $option['option_id'],
                                    'option_value_id'         => $option['option_value_id'],
                                    'name'                    => $option['name'],
                                    'value'                   => $option['option_value'],
                                    'type'                    => $option['type']
                                );
                            } else {
                                $encryption = new Encryption($this->config->get('config_encryption'));

                                $option_data[] = array(
                                    'product_option_id'       => $option['product_option_id'],
                                    'product_option_value_id' => $option['product_option_value_id'],
                                    'product_option_id'       => $option['product_option_id'],
                                    'product_option_value_id' => $option['product_option_value_id'],
                                    'option_id'               => $option['option_id'],
                                    'option_value_id'         => $option['option_value_id'],
                                    'name'                    => $option['name'],
                                    'value'                   => $encryption->decrypt($option['option_value']),
                                    'type'                    => $option['type']
                                );
                            }
                        }
                    }

                    if ($product['tax_class_id']) {
                        $tax_rates = $this->tax->getRates($product['total'], $product['tax_class_id']);

                        foreach ($tax_rates as $tax_rate) {
                            if (!isset($tax_data[$tax_rate['tax_rate_id']])) {
                                $tax_data[$tax_rate['tax_rate_id']] = $tax_rate['amount'];
                            } else {
                                $tax_data[$tax_rate['tax_rate_id']] += $tax_rate['amount'];
                            }
                        }
                    }

                    $product_data[] = array(
                        'product_id' => $product['product_id'],
                        'name'       => $product['name'],
                        'model'      => $product['model'],
                        'option'     => $option_data,
                        'download'   => isset($product['download']) ? $product['download']: array(),
                        'quantity'   => $product['quantity'],
                        'subtract'   => $product['subtract'],
                        'price'      => $product['price'],
                        'total'      => $product['total'],
                        'tax'        => $this->tax->getTax($product['total'], $product['tax_class_id'])
                    );
                    $order['total'] += $product['total'];
                    $uploaded_data['price'] = $product['price'];
                }else {
                    $json['error']['error'] = 'Error in line ' . ($index+1) . ', column 15: invalid product id ' . $product_id;
                    //Todo
                    //Delete created orders before this errored one.
                    break;
                }
            }

            // Gift Voucher
            if (isset($this->session->data['vouchers']) && $this->session->data['vouchers']) {
                foreach ($this->session->data['vouchers'] as $voucher) {
                    $product_data[] = array(
                        'product_id' => 0,
                        'name'       => $voucher['description'],
                        'model'      => '',
                        'option'     => array(),
                        'download'   => array(),
                        'quantity'   => 1,
                        'subtract'   => false,
                        'price'      => $voucher['amount'],
                        'total'      => $voucher['amount'],
                        'tax'        => 0
                    );
                }
            }

            $order['products'] = $product_data;
            $order['comment'] = '';
            $order['reward'] = $this->cart->getTotalRewardPoints();

            $order_total_data = array();
            $taxes = array();
            $sort_order = array();
            $total_models = $this->model_setting_extension->getExtensions('total');
            $results = array();
            foreach ($total_models as $key => $value) {
                if ($value['code'] != 'vip') {
                    $results[$key] = $value;
                }
            }
            foreach ($results as $key => $value) {
                $sort_order[$key] = $this->config->get($value['code'] . '_sort_order');
            }
            array_multisort($sort_order, SORT_ASC, $results);
            foreach ($results as $result) {
                if ($this->config->get($result['code'] . '_status')) {
                    $this->load->model('total/' . $result['code']);

                    $this->{'model_total_' . $result['code']}->getTotal($order_total_data, $order['total'], $taxes);
                }
            }
            $sort_order = array();
            foreach ($order_total_data as $key => $value) {
                $sort_order[$key] = $value['sort_order'];
            }
            array_multisort($sort_order, SORT_ASC, $order_total_data);
            $order['totals'] = $order_total_data;
            $total += $order['total'];

            if (isset($this->request->cookie['tracking'])) {
                $this->load->model('affiliate/affiliate');

                $affiliate_info = $this->model_affiliate_affiliate->getAffiliateByCode($this->request->cookie['tracking']);

                if ($affiliate_info) {
                    $order['affiliate_id'] = $affiliate_info['affiliate_id'];
                    $order['commission'] = ($order['total'] / 100) * $affiliate_info['commission'];
                } else {
                    $order['affiliate_id'] = 0;
                    $order['commission'] = 0;
                }
            } else {
                $order['affiliate_id'] = 0;
                $order['commission'] = 0;
            }

            $order['language_id'] = $this->config->get('config_language_id');
            $order['currency_id'] = $this->currency->getId();
            $order['currency_code'] = $this->currency->getCode();
            $order['currency_value'] = $this->currency->getValue($this->currency->getCode());
            $order['ip'] = $this->request->server['REMOTE_ADDR'];

            $uploaded_data['order_id'] = $this->model_checkout_order->create($order);
            $uploaded_data['total'] = $order['total'];
            $this->session->data['order_id'] = $uploaded_data['order_id'];

            $this->data['orders'][] = $uploaded_data;
        }


        $taxes = array();
        $sort_order = array();
        $total_models = $this->model_setting_extension->getExtensions('total');
        $results = array();
        foreach ($total_models as $key => $value) {
            if ($value['code'] == 'total' || $value['code'] == 'vip') {
                $results[$key] = $value;
            }
        }
        foreach ($results as $key => $value) {
            $sort_order[$key] = $this->config->get($value['code'] . '_sort_order');
        }
        array_multisort($sort_order, SORT_ASC, $results);
        foreach ($results as $result) {
            if ($this->config->get($result['code'] . '_status')) {
                $this->load->model('total/' . $result['code']);

                $this->{'model_total_' . $result['code']}->getTotal($total_data, $total, $taxes);
            }
        }
        $sort_order = array();
        foreach ($total_data as $key => $value) {
            $sort_order[$key] = $value['sort_order'];
        }
        array_multisort($sort_order, SORT_ASC, $total_data);
        $this->data['totals'] = $total_data;

        $this->data['payment'] = $this->get_confirm();

        $this->session->data['orders'] = $this->data['orders'];

        if (file_exists(DIR_TEMPLATE . $this->config->get('config_template') . '/template/checkout/parser.tpl')) {
            $this->template = $this->config->get('config_template') . '/template/checkout/parser.tpl';
        } else {
            $this->template = 'default/template/checkout/parser.tpl';
        }

        $json['output'] = $this->render();

//        header('Content-type: application/json');

        $this->response->setOutput(json_encode($json));
    }

    protected function get_confirm() {
        $this->data['button_confirm'] = $this->language->get('button_confirm');

        $this->data['continue'] = $this->url->link('checkout/success');

        if (file_exists(DIR_TEMPLATE . $this->config->get('config_template') . '/template/checkout/batch_confirm.tpl')) {
            $this->template = $this->config->get('config_template') . '/template/checkout/batch_confirm.tpl';
        } else {
            $this->template = 'default/template/checkout/batch_confirm.tpl';
        }

        return $this->render();
    }

    public function confirm() {
        $json = array();
        $session_orders = $this->session->data['orders'];

        $this->load->model('checkout/order');
        if (isset($_POST['orders'])) {
            $order_indexes = array();
            $order_indexes = json_decode($_POST['orders']);
            foreach ($order_indexes as $index) {
                $order = isset($session_orders[$index]) ? $session_orders[$index] : null;
                if ($order) {
                    $this->model_checkout_order->confirm($order['order_id'], $this->config->get('cod_order_status_id'));
                    unset($this->session->data['orders'][$index]);
                }
            }
        }else{
            foreach ($session_orders as $order) {
                if ($order) {
                    $this->model_checkout_order->confirm($order['order_id'], $this->config->get('cod_order_status_id'));
                }
            }
            unset($this->session->data['orders']);
        }
        $json['output'] = 'success';
        $this->response->setOutput(json_encode($json));
    }

    public function remove() {
        $this->load->model('setting/extension');
        $json = array();
        $session_orders = $this->session->data['orders'];
        $this->load->model('checkout/order');
        $order_indexes = array();
        if (isset($_POST['orders'])) {
            $order_indexes = json_decode($_POST['orders']);
        }else{
            $order_indexes = array();
        }
        foreach ($order_indexes as $index) {
            $order = isset($session_orders[$index]) ? $session_orders[$index] : null;
            if ($order) {
                $this->model_checkout_order->delete($order['order_id']);
                unset($this->session->data['orders'][$index]);
            }
        }


        $total = 0;
        foreach (array_values($this->session->data['orders']) as $order) {
            $total += $order['total'];
        }
        $total_data = array();
        $taxes = array();
        $sort_order = array();
        $total_models = $this->model_setting_extension->getExtensions('total');
        $results = array();
        foreach ($total_models as $key => $value) {
            if ($value['code'] == 'total' || $value['code'] == 'vip') {
                $results[$key] = $value;
            }
        }
        foreach ($results as $key => $value) {
            $sort_order[$key] = $this->config->get($value['code'] . '_sort_order');
        }
        array_multisort($sort_order, SORT_ASC, $results);
        foreach ($results as $result) {
            if ($this->config->get($result['code'] . '_status')) {
                $this->load->model('total/' . $result['code']);

                $this->{'model_total_' . $result['code']}->getTotal($total_data, $total, $taxes);
            }
        }
        $sort_order = array();
        foreach ($total_data as $key => $value) {
            $sort_order[$key] = $value['sort_order'];
        }
        array_multisort($sort_order, SORT_ASC, $total_data);
        $this->data['totals'] = $total_data;

        if (file_exists(DIR_TEMPLATE . $this->config->get('config_template') . '/template/checkout/total.tpl')) {
            $this->template = $this->config->get('config_template') . '/template/checkout/total.tpl';
        } else {
            $this->template = 'default/template/checkout/total.tpl';
        }

        $json['output'] = $this->render();
        $json['error']['info'] = 'test';
        $this->response->setOutput(json_encode($json));
    }

    protected function parse_csv($file) {
        $result = array();
        $result['data'] = array();
        if (($file["type"] == "text/csv") || ($file["type"] == "text/excel") && ($file["size"] < 20000)) {
            if ($file["error"] > 0) {
                $result['error']['error'] = 'File upload error: ' . $file["error"];
            } else {
                $result["Upload"] = $file["name"];
                $result["Type"] = $file["type"];
                $result["Size"] = ($file["size"] / 1024) . " Kb";
                $result["TempFile"] = $file["tmp_name"];
                $row = 0;
                if (($handle = fopen($file["tmp_name"], "r")) !== FALSE) {
                    $this->load->model('checkout/order');

                    while (($data = fgetcsv($handle, 1000, ";")) !== FALSE) {
                        $row++;
                        if ($row == 1) {
                            continue;
                        }

                        $row_data = array();
                        $row_data['customer_order'] = $data[0];
                        $row_data['end_cusotomer_name'] = $data[1];
                        $row_data['ship_to_address1'] = $data[2];
                        $row_data['ship_to_address2'] = $data[3];
                        $row_data['ship_to_address3'] = $data[4];
                        $row_data['ship_to_city'] = $data[5];
                        $row_data['ship_to_state'] = $data[6];
                        $row_data['ship_to_postcode'] = $data[7];
                        $row_data['ship_to_country'] = $data[8];
                        $row_data['ship_to_phone'] = $data[9];
                        $row_data['order_qty'] = $data[10];
                        $row_data['unit_cost'] = $data[11];
                        $row_data['order_amount'] = $data[12];
                        $row_data['vendor_sku'] = $data[13];
                        $row_data['gds_sku'] = $data[14];
                        $row_data['gds_skus'] = explode(',', $data[14]);

                        $result['data'][] = $row_data;
                    }
                    fclose($handle);
                }
                if (file_exists("upload/" . $file["name"])) {
                    $result['error']['info'] = $file["name"] . " already exists. ";
                } else {
                    move_uploaded_file($file["tmp_name"], "upload/" . $file["name"]);
                    $result['error']['info'] = "Stored in: upload/" . $file["name"];
                }
            }
        } else {
            $result['error']['error'] = "Invalid file";
        }
        return $result;
    }

    protected function parse_excel($file) {
        $result = array();
        $result['data'] = array();
        if (($file["type"] == "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet") || ($file["type"] == "text/excel") && ($file["size"] < 20000)) {
            if ($file["error"] > 0) {
                $result['error']['error'] = 'File upload error: ' . $file["error"];
            } else {
                ini_set("memory_limit","100M");
                ini_set("max_execution_time",180);
                //set_time_limit( 60 );
                require_once( 'system/PHPExcel/Classes/PHPExcel.php' );
                $inputFileType = PHPExcel_IOFactory::identify($file["tmp_name"]);
                $objReader = PHPExcel_IOFactory::createReader($inputFileType);
                $objReader->setReadDataOnly(true);
                $objPHPExcel = $objReader->load($file["tmp_name"]);
                $sheet = $objPHPExcel->getActiveSheet();
                $sheet_data = $sheet->toArray();

                foreach($sheet_data as $index => $row){
                    if(0 == $index) {
                        $columns = count($row);
                        continue;
                    }
                    if (count($row) != $columns) {
                        continue;
                    }
                    $row_data = array();
                    $products = array();
                    if ($row[0] && $row[1]) {
                        $row_data['customer_order'] = $row[0];
                        $products[$row[1]] = $row[8];
                    }else{
                        if ($index == 1) {
                            $result['error']['error'] = "Row 1, column 1 cannot be empty.";
                            return $result;
                        }
                        if (isset($row[1])) {
                            $sheet_data[$index][0] = $sheet_data[$index - 1][0];
                            $row_data['customer_order'] = $sheet_data[$index][0];
                            $products[$row[1]] = $row[8];
                        }else{
                            continue;
                        }
                    }
                    $row_data['gds_products'] = $products;
                    $row_data['end_cusotomer_name'] = $row[2];
                    $row_data['ship_to_address1'] = $row[3];
                    $row_data['ship_to_city'] = $row[4];
                    $row_data['ship_to_country'] = $row[5];
                    $row_data['ship_to_postcode'] = $row[6];
                    $row_data['ship_to_phone'] = $row[7];
                    $row_data['quantity'] = $row[8];
                    $result['data'][] = $row_data;
                }

                if (file_exists("upload/" . $file["name"])) {
                    $result['error']['info'] = $file["name"] . " already exists. ";
                } else {
                    move_uploaded_file($file["tmp_name"], "upload/" . $file["name"]);
                    $result['error']['info'] = "Stored in: upload/" . $file["name"];
                }
            }
        } else {
            $result['error']['error'] = "Invalid file";
        }
        return $result;
    }
}
?>