<?php 
class ControllerAccountBOrder extends Controller {
	private $error = array();
		
	public function index() {
    	if (!$this->customer->isLogged()) {
      		$this->session->data['redirect'] = $this->url->link('account/border', '', 'SSL');

	  		$this->redirect($this->url->link('account/login', '', 'SSL'));
    	}
 
    	$this->language->load('account/border');

    	$this->document->setTitle($this->language->get('heading_title'));

      	$this->data['breadcrumbs'] = array();

      	$this->data['breadcrumbs'][] = array(
        	'text'      => $this->language->get('text_home'),
			'href'      => $this->url->link('common/home'),        	
        	'separator' => false
      	); 

      	$this->data['breadcrumbs'][] = array(
        	'text'      => $this->language->get('text_account'),
			'href'      => $this->url->link('account/account', '', 'SSL'),        	
        	'separator' => $this->language->get('text_separator')
      	);
		
      	$this->data['breadcrumbs'][] = array(
        	'text'      => $this->language->get('heading_title'),
			'href'      => $this->url->link('account/border', '', 'SSL'),
        	'separator' => $this->language->get('text_separator')
      	);

		$this->data['heading_title'] = $this->language->get('heading_title');

		$this->data['text_order_id'] = $this->language->get('text_order_group_id');
		$this->data['text_status'] = $this->language->get('text_status');
		$this->data['text_date_added'] = $this->language->get('text_date_added');
		$this->data['text_customer'] = $this->language->get('text_customer');
		$this->data['text_products'] = $this->language->get('text_products');
		$this->data['text_total'] = $this->language->get('text_total');
		$this->data['text_empty'] = $this->language->get('text_empty');

		$this->data['button_view'] = $this->language->get('button_view');
		$this->data['button_continue'] = $this->language->get('button_continue');
		
		$this->data['action'] = $this->url->link('account/border', '', 'SSL');
		
		$this->load->model('account/border');
		
		if (isset($this->request->get['page'])) {
			$page = $this->request->get['page'];
		} else {
			$page = 1;
		}
		
		$this->data['orders'] = array();
		
		$order_total = $this->model_account_border->getTotalBatchOrders();
		
		$results = $this->model_account_border->getBatchOrders(($page - 1) * $this->config->get('config_catalog_limit'), $this->config->get('config_catalog_limit'));
		
		foreach ($results as $result) {
			$batch_order_total = $this->model_account_border->getTotalOrdersByOrderGroupId($result['order_group_id']);

			$this->data['orders'][] = array(
				'order_group_id'   => $result['order_group_id'],
				'name'       => $result['firstname'] . ' ' . $result['lastname'],
				'status'     => $result['status'],
				'date_added' => date($this->language->get('date_format_short'), strtotime($result['date_added'])),
				'orders'   => $batch_order_total,
				'total'      => $this->currency->format($result['total'], $result['currency_code'], $result['currency_value']),
				'href'       => $this->url->link('account/border/info', 'order_group_id=' . $result['order_group_id'], 'SSL')
			);
		}

		$pagination = new Pagination();
		$pagination->total = $order_total;
		$pagination->page = $page;
		$pagination->limit = $this->config->get('config_catalog_limit');
		$pagination->text = $this->language->get('text_pagination');
		$pagination->url = $this->url->link('account/border', 'page={page}', 'SSL');
		
		$this->data['pagination'] = $pagination->render();

		$this->data['continue'] = $this->url->link('account/account', '', 'SSL');

		if (file_exists(DIR_TEMPLATE . $this->config->get('config_template') . '/template/account/batch_order_list.tpl')) {
			$this->template = $this->config->get('config_template') . '/template/account/batch_order_list.tpl';
		} else {
			$this->template = 'default/template/account/batch_order_list.tpl';
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
	
	public function info() {
		if (isset($this->request->get['order_group_id'])) {
			$order_group_id = $this->request->get['order_group_id'];
		} else {
            $order_group_id = 0;
		}

        if (!$this->customer->isLogged()) {
            $this->session->data['redirect'] = $this->url->link('account/border', '', 'SSL');

            $this->redirect($this->url->link('account/login', '', 'SSL'));
        }

        $this->language->load('account/border');

        $this->document->setTitle($this->language->get('text_order') . ' #' . $order_group_id);

        $this->data['breadcrumbs'] = array();

        $this->data['breadcrumbs'][] = array(
            'text'      => $this->language->get('text_home'),
            'href'      => $this->url->link('common/home'),
            'separator' => false
        );

        $this->data['breadcrumbs'][] = array(
            'text'      => $this->language->get('text_account'),
            'href'      => $this->url->link('account/account', '', 'SSL'),
            'separator' => $this->language->get('text_separator')
        );

        $this->data['breadcrumbs'][] = array(
            'text'      => $this->language->get('heading_title'),
            'href'      => $this->url->link('account/order', '', 'SSL'),
            'separator' => $this->language->get('text_separator')
        );

        $this->data['heading_title'] = $this->language->get('text_order') . ' #' . $order_group_id;

        $this->data['text_order_id'] = $this->language->get('text_order_id');
        $this->data['text_status'] = $this->language->get('text_status');
        $this->data['text_date_added'] = $this->language->get('text_date_added');
        $this->data['text_customer'] = $this->language->get('text_customer');
        $this->data['text_products'] = $this->language->get('text_products');
        $this->data['text_total'] = $this->language->get('text_total');
        $this->data['text_empty'] = $this->language->get('text_empty');

        $this->data['button_view'] = $this->language->get('button_view');
        $this->data['button_continue'] = $this->language->get('button_continue');

        $this->data['action'] = $this->url->link('account/border', '', 'SSL');

        $this->load->model('account/border');

        if (isset($this->request->get['page'])) {
            $page = $this->request->get['page'];
        } else {
            $page = 1;
        }

        $this->data['orders'] = array();

        $order_total = $this->model_account_border->getTotalOrders($order_group_id);

        $results = $this->model_account_border->getOrders(($page - 1) * $this->config->get('config_catalog_limit'), $this->config->get('config_catalog_limit'), $order_group_id);

        foreach ($results as $result) {
            $product_total = $this->model_account_border->getTotalOrderProductsByOrderId($result['order_id']);

            $this->data['orders'][] = array(
                'order_id'   => $result['order_id'],
                'name'       => $result['firstname'] . ' ' . $result['lastname'],
                'status'     => $result['status'],
                'date_added' => date($this->language->get('date_format_short'), strtotime($result['date_added'])),
                'products'   => $product_total,
                'total'      => $this->currency->format($result['total'], $result['currency_code'], $result['currency_value']),
                'href'       => $this->url->link('account/order/info', 'order_id=' . $result['order_id'] . '&order_group_id=' . $order_group_id, 'SSL')
            );
        }

        $pagination = new Pagination();
        $pagination->total = $order_total;
        $pagination->page = $page;
        $pagination->limit = $this->config->get('config_catalog_limit');
        $pagination->text = $this->language->get('text_pagination');
        $pagination->url = $this->url->link('account/order', 'page={page}', 'SSL');

        $this->data['pagination'] = $pagination->render();

        $this->data['continue'] = $this->url->link('account/border', '', 'SSL');

        if (file_exists(DIR_TEMPLATE . $this->config->get('config_template') . '/template/account/order_list.tpl')) {
            $this->template = $this->config->get('config_template') . '/template/account/order_list.tpl';
        } else {
            $this->template = 'default/template/account/order_list.tpl';
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
	
	private function validate() {
		if (!isset($this->request->post['selected']) || !isset($this->request->post['action']) || !$this->request->post['action']) {
			$this->error['warning'] = $this->language->get('error_warning');
		}
		
		if (!$this->error) {
      		return true;
    	} else {
      		return false;
    	}		
	}
}
?>