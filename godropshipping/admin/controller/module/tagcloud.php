<?php
#############################################################################
#  Module Tag Cloud for Opencart 1.4.x From Team SiamOpencart.com		  													           #
#  เว็บผู้พัฒนา www.siamopencart.com ,www.thaiopencart.com                                                                                 #
#  โดย Somsak2004 วันที่ 25 กุมภาพันธ์ 2553                                                                                                            #
#############################################################################
# โดยการสนับสนุนจาก                                                                                                                                            #
# Unitedsme.com : ผู้ให้บริการเช่าพื้นที่เว็บไซต์ จดโดเมน ระบบ Linux                                                                              #
# Net-LifeStyle.com : ผู้ให้บริการเช่าพื้นที่เว็บไซต์์ จดโดเมน ระบบ Linux																           #
# SiamWebThai.com : SEO ขั้นเทพ โปรโมทเว็บขั้นเซียน ออกแบบ พัฒนาเว็บไซต์ / ตามความต้องการ และถูกใจ Google 		   #
#############################################################################
class ControllerModuleTagCloud extends Controller {
	private $error = array();

	public function index() {
		$this->data = array_merge($this->data, $this->load->language('module/tagcloud'));

		$this->document->setTitle($this->language->get('heading_title'));

		$this->load->model('setting/setting');

		if (($this->request->server['REQUEST_METHOD'] == 'POST') && ($this->validate())) {
			$this->model_setting_setting->editSetting('tagcloud', $this->request->post);

			$this->session->data['success'] = $this->language->get('text_success');

			$this->redirect($this->url->link('extension/module', '&token=' . $this->session->data['token'], 'SSL'));
		}

		$this->data['text_enabled'] = $this->language->get('text_enabled');
		$this->data['text_disabled'] = $this->language->get('text_disabled');
		
		$this->data['button_save'] = $this->language->get('button_save');
		$this->data['button_cancel'] = $this->language->get('button_cancel');

		$this->data['tab_general'] = $this->language->get('tab_general');

		if (isset($this->error['warning']))	{
			$this->data['error_warning'] = $this->error['warning'];
		} else {
			$this->data['error_warning'] = '';
		}
		
		if (isset($this->error['font'])) {
			$this->data['error_font'] = $this->error['font'];
		} else {
			$this->data['error_font'] = array();
		}

  		$this->data['breadcrumbs'] = array();

   		$this->data['breadcrumbs'][] = array(
       		'href'      => $this->url->link('common/home', '&token=' . $this->session->data['token'], 'SSL'),
       		'text'      => $this->language->get('text_home'),
      		'separator' => FALSE
   		);

   		$this->data['breadcrumbs'][] = array(
       		'href'      => $this->url->link('extension/module', '&token=' . $this->session->data['token'], 'SSL'),
       		'text'      => $this->language->get('text_module'),
      		'separator' => ' :: '
   		);

   		$this->data['breadcrumbs'][] = array(
       		'href'      => $this->url->link('module/tagcloud', '&token=' . $this->session->data['token'], 'SSL'),
       		'text'      => $this->language->get('heading_title'),
      		'separator' => ' :: '
   		);

		$this->data['action'] = $this->url->link('module/tagcloud', '&token=' . $this->session->data['token'], 'SSL');

		$this->data['cancel'] = $this->url->link('extension/module', '&token=' . $this->session->data['token'], 'SSL');

		$this->data['modules'] = array();
		
		if(isset($this->request->post['tagcloud_module'])){
			$this->data['modules'] = $this->request->post['tagcloud_module'];
		} elseif ($this->config->get('tagcloud_module')) {
			$this->data['modules'] = $this->config->get('tagcloud_module');
		}
		
		$this->load->model('design/layout');
		
		$this->data['layouts'] = $this->model_design_layout->getLayouts();
		
		$this->template = 'module/tagcloud.tpl';
		$this->children = array(
			'common/header',
			'common/footer'
		);
		
		$this->response->setOutput($this->render());
	}

	private function validate() {
		if (!$this->user->hasPermission('modify', 'module/tagcloud')) {
			$this->error['warning'] = $this->language->get('error_permission');
		}
		
		if(isset($this->request->post['tagcloud_module'])){
			foreach($this->request->post['tagcloud_module'] as $key => $value){
				if(!$value['min_font_size'] || !$value['max_font_size']){
					$this->error['font'][$key] = $this->language->get('error_font');
				}	
			}
		}
		
		if (!$this->error) {
			return TRUE;
		} else {
			return FALSE;
		}
	}
}
?>