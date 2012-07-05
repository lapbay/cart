<?php  
class ControllerModuleBlock extends Controller {
	protected function index($setting) {
	   	static $module = 0;
		$this->language->load('module/block');
		
    	$this->data['heading_title'] = sprintf($this->language->get('heading_title'), $this->config->get('config_name'));
    	
		$this->data['message'] = html_entity_decode($setting['description'][$this->config->get('config_language_id')], ENT_QUOTES, 'UTF-8');
$this->data['module'] = $module++;
		if (file_exists(DIR_TEMPLATE . $this->config->get('config_template') . '/template/module/block.tpl')) {
			$this->template = $this->config->get('config_template') . '/template/module/block.tpl';
		} else {
			$this->template = 'default/template/module/block.tpl';
		}
		
		$this->render();
	}
}
?>