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
	protected function index($setting) {
		$this->data = array_merge($this->data, $this->language->load('module/tagcloud'));

      	$this->load->model('module/tagcloud');

		$this->data['tagcloud'] = $this->model_module_tagcloud->getRandomTags(
			(int)$setting['limit'],
			(int)$setting['min_font_size'],
			(int)$setting['max_font_size']
		);

		if (file_exists(DIR_TEMPLATE . $this->config->get('config_template') . '/template/module/tagcloud.tpl')) {
			$this->template = $this->config->get('config_template') . '/template/module/tagcloud.tpl';
		} else {
			$this->template = 'default/template/module/tagcloud.tpl';
		}
		
		$this->render();
	}
}

?>