<?php 
class ControllerCatalogFeaturedcategory extends Controller { 
	public function autocomplete() {
		$json = array();
		
		if (isset($this->request->get['filter_name']) || isset($this->request->get['filter_category_id'])) {
			$this->load->model('module/featuredcategory');
			
			if (isset($this->request->get['filter_name'])) {
				$filter_name = $this->request->get['filter_name'];
			} else {
				$filter_name = '';
			}
						
			if (isset($this->request->get['filter_category_id'])) {
				$filter_category_id = $this->request->get['filter_category_id'];
			} else {
				$filter_category_id = '';
			}
			
			if (isset($this->request->get['filter_sub_category'])) {
				$filter_sub_category = $this->request->get['filter_sub_category'];
			} else {
				$filter_sub_category = '';
			}		
						
			$data = array(
				'filter_name'         => $filter_name,
				'filter_category_id'  => $filter_category_id,
				'filter_sub_category' => $filter_sub_category,
			);
			//$data=$filter_category_id;
			//$results = $this->model_catalog_product->getProducts($data);
            $results = $this->model_module_featuredcategory->getCategoryauto($data);
			
			foreach ($results as $result) {
				$json[] = array(
					'category_id' => $result['category_id'],
					'name'       => html_entity_decode($result['name'], ENT_QUOTES, 'UTF-8')
				);	
			}
		}

		$this->response->setOutput(json_encode($json));
	}     
}
?>