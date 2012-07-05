<?php   
class ControllerModuleMenu extends Controller {
    protected function index() {
        $this->load->model('catalog/category');
		$this->load->model('catalog/product');
		$this->language->load('common/header');
        // Khoi tao categories
		$this->data['categories'] = array();
					$this->data['text_home'] = $this->language->get('text_home');
		$categories = $this->model_catalog_category->getCategories(0);
		
		foreach ($categories as $category) {
			if ($category['top']) {
			     // Khoi tao children
				$children_data = array();
				
				$children = $this->model_catalog_category->getCategories($category['category_id']);
				
				foreach ($children as $child) {
					
					// Khoi tao children11
                    $children11_data = array();
				    $children11 = $this->model_catalog_category->getCategories($child['category_id']);
                    
                    foreach ($children11 as $child11){
                                              
					   // Khoi tao children22
						$children22_data = array();
						$children22 = $this->model_catalog_category->getCategories($child11['category_id']);
						
						foreach ($children22 as $child22){
						
							$data = array(
							'filter_category_id'  => $child22['category_id'],
							'filter_sub_category' => true	
						   );		
						
							$product_total = $this->model_catalog_product->getTotalProducts($data);
							
							$children22_data[] = array(
                            'name'  => $child22['name'],
                            'href'  => $this->url->link('product/category', 'path=' . $category['category_id'] . '_' . $child['category_id'] . '_' . $child11['category_id'] . '_' . $child22['category_id'])
							);
						}
                       $children11_data[] = array(
                            'name'  => $child11['name'],
							'children' => $children22_data,
							'column'   => $child11['column'] ? $child11['column'] : 1,
                            'href'  => $this->url->link('product/category', 'path=' . $category['category_id'] . '_' . $child['category_id'] . '_' . $child11['category_id'])
                       );
                        
                    }//End foreach children11
                    
                    
                    // Hoan thanh children				
					$children_data[] = array(
						'name'  => $child['name'],
                        'children' => $children11_data,
                        'column'   => $child['column'] ? $child['column'] : 1,
						'href'  => $this->url->link('product/category', 'path=' . $category['category_id'] . '_' . $child['category_id'])	
					);					
				}// End foreach $children
				
				// Level 1   Hoan thanh categories
				$this->data['categories'][] = array(
                'category_id' =>$category['category_id'],
					'name'     => $category['name'],
					'children' => $children_data,
					'column'   => $category['column'] ? $category['column'] : 1,
					'href'     => $this->url->link('product/category', 'path=' . $category['category_id'])
				);
			}
		}
				
		if (file_exists(DIR_TEMPLATE . $this->config->get('config_template') . '/template/module/menu.tpl')) {
			$this->template = $this->config->get('config_template') . '/template/module/menu.tpl';
		} else {
			$this->template = 'default/template/module/menu.tpl';
		}
		
    	$this->render();
    }
}
?>