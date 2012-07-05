<?php  
class ControllerModuleByAlphabet extends Controller {
	protected function index() {
		$this->language->load('module/by_alphabet');
		
    	$this->data['heading_title'] = $this->language->get('heading_title');
		
		if (isset($this->request->get['path'])) {
			$parts = explode('_', (string)$this->request->get['path']);
		} else {
			$parts = array();
		}
		
		if (isset($parts[1])) {
			$this->data['child_id'] = $parts[1];
		} else {
			$this->data['child_id'] = 0;
		}
							
		$alphabet = array("a","b","c","d","e","f","g","h","i","j","k","l","m","n","o","p","q","r","s","t","u","v","w","x","y","z","0","1","2","3","4","5","6","7","8");
		foreach($alphabet as $char)
		{
			$this->data['alphabet'][] = array(
				'char' => $char,
				'href'        => $this->url->link('product/byalphabet', 'c=' . $char)
				//route=product/byalphabet&c=a
			);
		}
		$this->data['alphabet'][] = array(
			'char' => "9",
			'href'        => $this->url->link('product/byalphabet', 'c=9')
		);

		if (file_exists(DIR_TEMPLATE . $this->config->get('config_template') . '/template/module/by_alphabet.tpl')) {
			$this->template = $this->config->get('config_template') . '/template/module/by_alphabet.tpl';
		} else {
			$this->template = 'default/template/module/by_alphabet.tpl';
		}
		
		$this->render();
  	}
}
?>