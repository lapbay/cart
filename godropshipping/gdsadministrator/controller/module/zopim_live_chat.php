<?php
/*
 * @package Zopim Live Chat
 * @version 0.2.0
 */

class ControllerModuleZopimLiveChat extends Controller {
	private $error = array();
	private $ZOPIM_LINKED = false;
	private $ZOPIM_USE_SSL = false;
	private $ZOPIM_BASE_URL = "https://www.zopim.com/";
	private $ZOPIM_COLORS_LIST = "assets/dashboard/themes/window/plugins-colors.txt";
	private $ZOPIM_THEMES_LIST = "assets/dashboard/themes/window/plugins-themes.txt";
	private $ZOPIM_LOGIN_URL  = "plugins/login";
	private $ZOPIM_GETACCOUNTDETAILS_URL = "plugins/getAccountDetails";
	private $ZOPIM_DASHBOARD_URL = "http://dashboard.zopim.com/";

	public function index() {
		$this->load->language('module/zopim_live_chat');
		$this->load->model('setting/setting');
      	
		if (($this->request->server['REQUEST_METHOD'] == 'POST') && $this->validate()) {
			$zopimaccountDetails = $this->get_accountDetails($this->request->post['zopim_salt']);
			$this->request->post['zopim_code'] = $zopimaccountDetails->account_key;
			$this->model_setting_setting->editSetting('zopim_live_chat', $this->request->post);
			$this->session->data['success'] = $this->language->get('text_success');
			$this->redirect($this->url->link('extension/module', 'token=' . $this->session->data['token'], 'SSL'));
		}

		$this->data['heading_title'] = $this->language->get('heading_title');
		$this->data['entry_username'] = $this->language->get('entry_username');
		$this->data['entry_password'] = $this->language->get('entry_password');
		$this->data['entry_usessl'] = $this->language->get('entry_usessl');
		$this->data['entry_language'] = $this->language->get('entry_language');
		$this->data['entry_position'] = $this->language->get('entry_position');
		$this->data['entry_hideOnOffline'] = $this->language->get('entry_hideOnOffline');

		$this->data['entry_store'] = $this->language->get('entry_store');
		$this->data['entry_color'] = $this->language->get('entry_color');
		$this->data['entry_theme'] = $this->language->get('entry_theme');
		$this->data['entry_BubbleEnable'] = $this->language->get('entry_BubbleEnable');
		$this->data['entry_BubbleTitle'] = $this->language->get('entry_BubbleTitle');
		$this->data['entry_BubbleText'] = $this->language->get('entry_BubbleText');
		$this->data['entry_UseGreetings'] = $this->language->get('entry_UseGreetings');
		$this->data['entry_OnlineShort'] = $this->language->get('entry_OnlineShort');
		$this->data['entry_AwayShort'] = $this->language->get('entry_AwayShort');
		$this->data['entry_OfflineShort'] = $this->language->get('entry_OfflineShort');
		$this->data['entry_OnlineLong'] = $this->language->get('entry_OnlineLong');
		$this->data['entry_AwayLong'] = $this->language->get('entry_AwayLong');
		$this->data['entry_OfflineLong'] = $this->language->get('entry_OfflineLong');
		$this->data['entry_layout'] = $this->language->get('entry_layout');
		$this->data['entry_position'] = $this->language->get('entry_position');
		$this->data['entry_status'] = $this->language->get('entry_status');
		$this->data['entry_sort_order'] = $this->language->get('entry_sort_order');

		$this->data['button_save'] = $this->language->get('button_save');
		$this->data['button_cancel'] = $this->language->get('button_cancel');
		$this->data['button_add_module'] = $this->language->get('button_add_module');
		$this->data['button_remove'] = $this->language->get('button_remove');

		$this->data['text_account_setting'] = $this->language->get('text_account_setting');
		$this->data['text_support_us'] = $this->language->get('text_support_us');
		$this->data['text_zopim_aff'] = $this->language->get('text_zopim_aff');
		$this->data['text_licensepal_aff'] = $this->language->get('text_licensepal_aff');
		$this->data['text_paypal_donate'] = $this->language->get('text_paypal_donate');
		$this->data['text_general_setting'] = $this->language->get('text_general_setting');
		$this->data['text_theme_setting']   = $this->language->get('text_theme_setting');
		$this->data['text_bubble_setting']  = $this->language->get('text_bubble_setting');
		$this->data['text_greeting_setting']  = $this->language->get('text_greeting_setting');
		$this->data['text_greeting_short']= $this->language->get('text_greeting_short');
		$this->data['text_greeting_long']= $this->language->get('text_greeting_long');

		$this->data['text_enabled'] = $this->language->get('text_enabled');
		$this->data['text_disabled'] = $this->language->get('text_disabled');
		$this->data['text_content_top'] = $this->language->get('text_content_top');
		$this->data['text_content_bottom'] = $this->language->get('text_content_bottom');
		$this->data['text_column_left'] = $this->language->get('text_column_left');
		$this->data['text_column_right'] = $this->language->get('text_column_right');

		$this->document->setTitle($this->data['heading_title']);

		if (isset($this->request->post['zopim_salt']) AND $this->request->post['zopim_salt']=="error") {
			$this->ZOPIM_LINKED = false;
			$this->request->post['zopim_code']="error";
		}elseif($this->config->get('zopim_salt')<>"error"){
			$zopimaccountDetails = $this->get_accountDetails($this->config->get('zopim_salt'));
			if(!isset($zopimaccountDetails) || isset($zopimaccountDetails->error)){
				$this->ZOPIM_LINKED = false;
			}else{
				$this->ZOPIM_LINKED = true;
			}
		}else{
			$this->ZOPIM_LINKED = false;
		}

		if(!$this->ZOPIM_LINKED){
			$this->request->post['zopim_code'] = "error";
			$this->data['zopim_accountDetails'] = "Account not linked! or We could not verify your Zopim account. Please check your password and try again.";
		}else{
			$this->request->post['zopim_code'] = $zopimaccountDetails->account_key;

			$this->data['zopim_accountDetails'] = ($zopimaccountDetails->package_id=="trial") ? "Free Lite Package + 14 Days Full-features" : $zopimaccountDetails->package_id." Package";
			$this->data['zopim_accountDetails'] .= ($zopimaccountDetails->widget_customization_enabled==1) ? "<br />You can modify widget style." : "<br />You can NOT modify widget style.";
			$this->data['zopim_accountDetails'] .= ($zopimaccountDetails->color_customization_enabled==1) ? "<br />You can modify widget color." : "<br />You can NOT modify widget color.";

		}

		if (isset($this->error['warning'])) {
			$this->data['error_warning'] = $this->error['warning'];
		} else {
			$this->data['error_warning'] = '';
		}
		if (isset($this->error['zopim_username'])) {
			$this->data['error_username'] = $this->error['zopim_username'];
		} else {
			$this->data['error_username'] = '';
		}
		if (isset($this->error['zopim_password'])) {
			$this->data['error_password'] = $this->error['zopim_password'];
		} else {
			$this->data['error_password'] = '';
		}
		if (isset($this->error['zopim_account'])) {
			$this->data['error_account'] = $this->error['zopim_account'];
		} else {
			$this->data['error_account'] = '';
		}

		$this->data['breadcrumbs'] = array();

		$this->data['breadcrumbs'][] = array(
       		'text'      => $this->language->get('text_home'),
			'href'      => $this->url->link('common/home', 'token=' . $this->session->data['token'], 'SSL'),
      		'separator' => false
		);

		$this->data['breadcrumbs'][] = array(
	       		'text'      => $this->language->get('text_module'),
				'href'      => $this->url->link('extension/module', 'token=' . $this->session->data['token'], 'SSL'),
	      		'separator' => ' :: '
	      		);

	      		$this->data['breadcrumbs'][] = array(
       		'text'      => $this->language->get('heading_title'),
			'href'      => $this->url->link('module/zopim_live_chat', 'token=' . $this->session->data['token'], 'SSL'),
      		'separator' => ' :: '
      		);

      		$this->data['action'] = $this->url->link('module/zopim_live_chat', 'token=' . $this->session->data['token'], 'SSL');

      		$this->data['cancel'] = $this->url->link('extension/module', 'token=' . $this->session->data['token'], 'SSL');

      		if (isset($this->request->post['zopim_username'])) {
      			$this->data['zopim_username'] = $this->request->post['zopim_username'];
      		} else {
      			$this->data['zopim_username'] = $this->config->get('zopim_username');
      		}
      		if (isset($this->request->post['zopim_password'])) {
      			$this->data['zopim_password'] = $this->request->post['zopim_password'];
      		} else {
      			$this->data['zopim_password'] = $this->config->get('zopim_password');
      		}
      		if (isset($this->request->post['zopim_usessl'])) {
      			$this->data['zopim_usessl'] = $this->request->post['zopim_usessl'];
      		} else {
      			$this->data['zopim_usessl'] = (!$this->config->get('zopim_usessl')) ? $this->ZOPIM_USE_SSL : $this->config->get('zopim_usessl');
      		}
      		if (isset($this->request->post['zopim_salt'])) {
      			$this->data['zopim_salt'] = $this->request->post['zopim_salt'];
      		} else {
      			$this->data['zopim_salt'] = $this->config->get('zopim_salt');
      		}
      		if (isset($this->request->post['zopim_code'])) {
      			$this->data['zopim_code'] = $this->request->post['zopim_code'];
      		} else {
      			$this->data['zopim_code'] = $this->config->get('zopim_code');
      		}

      		if (isset($this->request->post['zopim_store'])) {
      			$this->data['zopim_store'] = $this->request->post['zopim_store'];
      		} else {
      			$this->data['zopim_store'] = $this->config->get('zopim_store');
      		}

      		if (isset($this->request->post['zopim_language'])) {
      			$this->data['zopim_language'] = $this->request->post['zopim_language'];
      		} else {
      			$this->data['zopim_language'] = $this->config->get('zopim_language');
      		}

      		if (isset($this->request->post['zopim_position'])) {
      			$this->data['zopim_position'] = $this->request->post['zopim_position'];
      		} else {
      			$this->data['zopim_position'] = $this->config->get('zopim_position');
      		}

      		if (isset($this->request->post['zopim_hideonoffline'])) {
      			$this->data['zopim_hideonoffline'] = $this->request->post['zopim_hideonoffline'];
      		} else {
      			$this->data['zopim_hideonoffline'] = (!$this->config->get('zopim_hideonoffline'))?false:$this->config->get('zopim_hideonoffline');
      		}

      		if (isset($this->request->post['zopim_color'])) {
      			$this->data['zopim_color'] = $this->request->post['zopim_color'];
      		} else {
      			$this->data['zopim_color'] = $this->config->get('zopim_color');
      		}
      		if (isset($this->request->post['zopim_theme'])) {
      			$this->data['zopim_theme'] = $this->request->post['zopim_theme'];
      		} else {
      			$this->data['zopim_theme'] = $this->config->get('zopim_theme');
      		}
      		if (isset($this->request->post['zopim_bubbleEnable'])) {
      			$this->data['zopim_bubbleEnable'] = $this->request->post['zopim_bubbleEnable'];
      		} else {
      			$this->data['zopim_bubbleEnable'] = $this->config->get('zopim_bubbleEnable');
      		}

      		if (isset($this->request->post['zopim_bubbletitle'])) {
      			$this->data['zopim_bubbletitle'] = $this->request->post['zopim_bubbletitle'];
      		} else {
      			$this->data['zopim_bubbletitle'] = (!$this->config->get('zopim_bubbletitle'))? $this->language->get('value_help_bubble_title') : $this->config->get('zopim_bubbletitle');
      		}

      		if (isset($this->request->post['zopim_bubbletext'])) {
      			$this->data['zopim_bubbletext'] = $this->request->post['zopim_bubbletext'];
      		} else {
      			$this->data['zopim_bubbletext'] = (!$this->config->get('zopim_bubbletext'))? $this->language->get('value_help_bubble_message') : $this->config->get('zopim_bubbletext');
      		}

      		if (isset($this->request->post['zopim_UseGreetings'])) {
      			$this->data['zopim_UseGreetings'] = $this->request->post['zopim_UseGreetings'];
      		} else {
      			$this->data['zopim_UseGreetings'] = (!$this->config->get('zopim_UseGreetings')) ? false : $this->config->get('zopim_UseGreetings');
      		}

      		if (isset($this->request->post['zopim_OnlineShort'])) {
      			$this->data['zopim_OnlineShort'] = $this->request->post['zopim_OnlineShort'];
      		} else {
      			$this->data['zopim_OnlineShort'] = (!$this->config->get('zopim_OnlineShort'))? $this->language->get('value_greetings_online_bar') : $this->config->get('zopim_OnlineShort');
      		}
      		if (isset($this->request->post['zopim_AwayShort'])) {
      			$this->data['zopim_AwayShort'] = $this->request->post['zopim_AwayShort'];
      		} else {
      			$this->data['zopim_AwayShort'] = (!$this->config->get('zopim_AwayShort')) ? $this->language->get('value_greetings_away_bar') : $this->config->get('zopim_AwayShort');
      		}
      		if (isset($this->request->post['zopim_OfflineShort'])) {
      			$this->data['zopim_OfflineShort'] = $this->request->post['zopim_OfflineShort'];
      		} else {
      			$this->data['zopim_OfflineShort'] = (!$this->config->get('zopim_OfflineShort')) ? $this->language->get('value_greetings_offline_bar') : $this->config->get('zopim_OfflineShort');
      		}
      		if (isset($this->request->post['zopim_OnlineLong'])) {
      			$this->data['zopim_OnlineLong'] = $this->request->post['zopim_OnlineLong'];
      		} else {
      			$this->data['zopim_OnlineLong'] = (!$this->config->get('zopim_OnlineLong')) ? $this->language->get('value_greetings_online_window') : $this->config->get('zopim_OnlineLong');
      		}
      		if (isset($this->request->post['zopim_AwayLong'])) {
      			$this->data['zopim_AwayLong'] = $this->request->post['zopim_AwayLong'];
      		} else {
      			$this->data['zopim_AwayLong'] = (!$this->config->get('zopim_AwayLong')) ? $this->language->get('value_greetings_away_window') : $this->config->get('zopim_AwayLong');
      		}
      		if (isset($this->request->post['zopim_OfflineLong'])) {
      			$this->data['zopim_OfflineLong'] = $this->request->post['zopim_OfflineLong'];
      		} else {
      			$this->data['zopim_OfflineLong'] = (!$this->config->get('zopim_OfflineLong')) ? $this->language->get('value_greetings_offline_window') : $this->config->get('zopim_OfflineLong');
      		}
      		
      		$this->data['zopimLanguage']= $this->get_languages();
      		$this->data['zopimPosition']= $this->get_position();
      		$this->data['zopimColors']= $this->get_colors();
      		$this->data['zopimThemes']= $this->get_themes();
      		$this->data['zopimBublemodes']= $this->get_bubblemodes();
      		$this->data['zopimDashboard']= $this->ZOPIM_DASHBOARD_URL;

      		$this->data['action'] = $this->url->link('module/zopim_live_chat', 'token=' . $this->session->data['token'], 'SSL');

      		$this->data['cancel'] = $this->url->link('extension/module', 'token=' . $this->session->data['token'], 'SSL');

      		$this->data['modules'] = array();

      		if (isset($this->request->post['zopim_live_chat_module'])) {
      			$this->data['modules'] = $this->request->post['zopim_live_chat_module'];
      		} elseif ($this->config->get('zopim_live_chat_module')) {
      			$this->data['modules'] = $this->config->get('zopim_live_chat_module');
      		}

      		$this->load->model('design/layout');
      		$this->data['layouts'] = $this->model_design_layout->getLayouts();
      		$this->template = 'module/zopim_live_chat.tpl';
      		$this->children = array(
			'common/header',
			'common/footer',
      		);

      		$this->response->setOutput($this->render());
	}

	private function validate() {
		if (!$this->user->hasPermission('modify', 'module/zopim_live_chat')) {
			$this->error['warning'] = $this->language->get('error_permission');
		}


		if (!$this->request->post['zopim_username']) {
			$this->error['zopim_username'] = $this->language->get('error_zopim_username');
		}

		if (!$this->request->post['zopim_password']) {
			$this->error['zopim_password'] = $this->language->get('error_zopim_password');
		}

		if (!isset($this->request->post['zopim_usessl'])) {
			$this->set_ssl_connect(false);
		}else{
			$this->set_ssl_connect(true);
		}

		if($this->request->post['zopim_username'] AND $this->request->post['zopim_username']){
			$loginresult = $this->get_login(array("zopim_username"=>$this->request->post['zopim_username'],"zopim_password"=>$this->request->post['zopim_password']));
			if(isset($loginresult->error)){
				$this->error['zopim_account'] = $this->language->get('error_zopim_account');
				$this->request->post['zopim_salt'] = "error";
				$this->request->post['zopim_code'] = "error";
				$this->ZOPIM_LINKED = false;
			}else{
				$this->request->post['zopim_salt'] = $loginresult->salt;
			}
		}

		if (!$this->error) {
			return true;
		} else {
			return false;
		}
	}

	private function set_ssl_connect($value){
		$this->ZOPIM_USE_SSL = $value;
	}

	private function build_url($url, $usessl = false, $nowww = false){
		$url = $this->ZOPIM_BASE_URL.$url;
		if ($nowww) {
			$url = str_replace("www.", "", $url);
		}
		if ($usessl) {
			$url = str_replace("https", "http", $url);
		}
		return $url;
	}

	private function curl_get_url($filename) {
		$ch = curl_init();
		$timeout = 5; // set to zero for no timeout
		curl_setopt ($ch, CURLOPT_URL, $filename);
		curl_setopt ($ch, CURLOPT_RETURNTRANSFER, 1);
		curl_setopt ($ch, CURLOPT_CONNECTTIMEOUT, $timeout);
		$file_contents = curl_exec($ch);
		curl_close($ch);

		return $file_contents;
	}

	private function do_post_request($url, $_data, $optional_headers = null)
	{

		$data = array();

		while(list($n,$v) = each($_data)){
			$data[] = urlencode($n)."=".urlencode($v);
		}

		$data = implode('&', $data);

		$ch = curl_init();

		curl_setopt($ch, CURLOPT_URL, $url);
		curl_setopt($ch, CURLOPT_POST, true);
		curl_setopt($ch, CURLOPT_POSTFIELDS, $data);
		curl_setopt($ch, CURLOPT_RETURNTRANSFER, true);

		$response = curl_exec($ch);
		curl_close($ch);

		return $response;
	}
	private function get_login($data){
		$logindata = array("email" => $data["zopim_username"], "password" => $data["zopim_password"]);
		if($this->ZOPIM_USE_SSL==true)
		$loginurl = $this->build_url($this->ZOPIM_LOGIN_URL, true);
		else
		$loginurl = $this->build_url($this->ZOPIM_LOGIN_URL, false);

		$loginresult = json_decode($this->do_post_request($loginurl, $logindata));
		return $loginresult;
	}
	function get_accountDetails($salt) {
		if($this->ZOPIM_USE_SSL==true)
		$detailurl = $this->build_url($this->ZOPIM_GETACCOUNTDETAILS_URL, true);
		else
		$detailurl = $this->build_url($this->ZOPIM_GETACCOUNTDETAILS_URL, false);
		return json_decode($this->do_post_request($detailurl, array("salt" => $salt)));
	}
	private function get_colors(){
		$url = $this->build_url($this->ZOPIM_COLORS_LIST, false, true);
		$colors = $this->curl_get_url($url);
		$colors = explode("\n", $colors);
		return $colors;
	}
	private function get_themes(){
		$url = $this->build_url($this->ZOPIM_THEMES_LIST, false, true);
		$themes = $this->curl_get_url($url);
		$themes = explode("\n", $themes);

		$newarray = array();
		foreach ($themes as $s) {
			if($s<>"")
			$newarray[$s] = $s;
		}

		return $newarray;
	}
	private function get_languages() {
		$langjson = '{"--":" - Auto Detect - ","ar":"Arabic","bn":"Bengali","bg":"Bulgarian","zh_CN":"Chinese (China)","zh_TW":"Chinese (Taiwan)","hr":"Croatian","cs":"Czech","da":"Danish","nl":"Dutch; Flemish","et":"Estonian","fo":"Faroese","fi":"Finnish","fr":"French","ka":"Georgian","de":"German","el":"Greek","he":"Hebrew","hu":"Hungarian","is":"Icelandic","id":"Indonesian","it":"Italian","ja":"Japanese","ko":"Korean","ku":"Kurdish","lv":"Latvian","lt":"Lithuanian","mk":"Macedonian","ms":"Malay","nb":"Norwegian Bokmal","fa":"Persian","pl":"Polish","pt":"Portuguese","pt_BR":"Portuguese (Brazil)","ro":"Romanian","ru":"Russian","sr":"Serbian","sk":"Slovak","sl":"Slovenian","es":"Spanish; Castilian","sv":"Swedish","th":"Thai","tr":"Turkish","uk":"Ukrainian","ur":"Urdu","vi":"Vietnamese"}';
		return json_decode($langjson);
	}
	private function get_position(){
		$posjson = '{"br":"Bottom Right","bl":"Bottom Left"}';
		return json_decode($posjson);
	}
	private function get_bubblemodes(){
		$bubblejson = '{"default":"Let user decide","show":"Always show","hide":"Always hide"}';
		return json_decode($bubblejson);
	}
}
?>