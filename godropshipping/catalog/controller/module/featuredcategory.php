<?php
class ControllerModuleFeaturedcategory extends Controller {
	protected function index($setting) {
		$this->language->load('module/featuredcategory'); 

      	$this->data['heading_title'] = $this->language->get('heading_title');
		
		$this->data['button_cart'] = $this->language->get('button_cart');
		
		$this->load->model('catalog/category'); 
		
		$this->load->model('tool/image');

		$this->data['categories'] = array();

		$categories = explode(',', $this->config->get('featuredcategory_category'));		

		foreach ($categories as $category_id) {
			$category_info = $this->model_catalog_category->getCategory($category_id);
			
			if ($category_info) {
				if ($category_info['image']) {
					$image = $this->model_tool_image->resize($category_info['image'], $setting['image_width'], $setting['image_height']);
				} else {
					$image = false;
				}
					
				$this->data['categories'][] = array(
					'category_id' => $category_info['category_id'],
					'thumb'   	 => $image,
					'name'    	 => $category_info['name'],
					'href'        => $this->url->link('product/category', 'path=' . $category_info['category_id'])
				);
			}
		}

		if (file_exists(DIR_TEMPLATE . $this->config->get('config_template') . '/template/module/featuredcategory.tpl')) {
			$this->template = $this->config->get('config_template') . '/template/module/featuredcategory.tpl';
		} else {
			$this->template = 'default/template/module/featuredcategory.tpl';
		}

		$this->render();
	}
}
?>
