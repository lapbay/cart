<?php  
class ControllerModuleOcslideshow extends Controller {
	protected function index($setting) {
	static $module = 0;
    
		$this->language->load('module/ocslideshow');
		
    	$this->data['heading_title'] = sprintf($this->language->get('heading_title'), $this->config->get('config_name'));
    	
		$this->data['message'] = html_entity_decode($setting['description'][$this->config->get('config_language_id')], ENT_QUOTES, 'UTF-8');
		
		$this->load->model('design/banner');
		$this->load->model('tool/image');
		
		$this->data['width'] = $setting['width'];
		$this->data['height'] = $setting['height'];
		
		$this->data['banners'] = array();
		
		$results = $this->model_design_banner->getBanner($setting['banner_id']);
		  
		foreach ($results as $result) {
			if (file_exists(DIR_IMAGE . $result['image'])) {
				$this->data['banners'][] = array(
					'title' => $result['title'],
					'link'  => $result['link'],
					'image' => $this->model_tool_image->resize($result['image'], $setting['width'], $setting['height'])
				);
			}
		}
        $this->data['module'] = $module++;
        if (file_exists(DIR_TEMPLATE . $this->config->get('config_template') . '/template/module/ocslideshow.tpl')) {
			$this->template = $this->config->get('config_template') . '/template/module/ocslideshow.tpl';
		} else {
			$this->template = 'default/template/module/ocslideshow.tpl';
		}
		$this->render();
        	
	}
}
?>