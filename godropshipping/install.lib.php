<?php
// init
require_once('system/library/db.php');
define('DIR_DATABASE', 'system/database/');

function opendb($dbdriver,$dbhost,$dbname,$dbuser,$dbpass,$prefix){
	define('DB_PREFIX', $prefix);
	global $db;
	$db = new DB($dbdriver, $dbhost, $dbuser, $dbpass, $dbname);
}
// function install - main function
function install($extension) {
	installmodule('module', $extension);
	addPermission(1, 'access', 'module/' . $extension);
	addPermission(1, 'modify', 'module/' . $extension);
	echo '<font color="blue"> Install Module <i> '.$extension.' </i>Success! </font><br /><br />';
}

// install module
function installmodule($type, $code) {
	global $db;
	$db->query("INSERT INTO " . DB_PREFIX . "extension SET `type` = '" . $db->escape($type) . "', `code` = '" . $db->escape($code) . "'");
}

//uninstall module
function uninstallmodule() {
	global $db;
	$db->query("DELETE FROM " . DB_PREFIX . "extension WHERE `type` = 'module'");
	echo '<font color="green"> Refesh all Module Success! </font><br /><br />';
}

// add permission
function addPermission($user_id, $type, $page) {
	global $db;
	$user_query = $db->query("SELECT DISTINCT user_group_id FROM " . DB_PREFIX . "user WHERE user_id = '" . (int)$user_id . "'");
	
	if ($user_query->num_rows) {
		$user_group_query = $db->query("SELECT DISTINCT * FROM " . DB_PREFIX . "user_group WHERE user_group_id = '" . (int)$user_query->row['user_group_id'] . "'");
	
		if ($user_group_query->num_rows) {
			$data = unserialize($user_group_query->row['permission']);
	
			$data[$type][] = $page;
	
			$db->query("UPDATE " . DB_PREFIX . "user_group SET permission = '" . serialize($data) . "' WHERE user_group_id = '" . (int)$user_query->row['user_group_id'] . "'");
		}
	}
}

// edit setting
function editSetting($group, $data, $store_id = 0) {
	global $db;
	$db->query("DELETE FROM " . DB_PREFIX . "setting WHERE store_id = '" . (int)$store_id . "' AND `group` = '" . $db->escape($group) . "'");

	foreach ($data as $key => $value) {
		if (!is_array($value)) {
			$db->query("INSERT INTO " . DB_PREFIX . "setting SET store_id = '" . (int)$store_id . "', `group` = '" . $db->escape($group) . "', `key` = '" . $db->escape($key) . "', `value` = '" . $db->escape($value) . "'");
		} else {
			$db->query("INSERT INTO " . DB_PREFIX . "setting SET store_id = '" . (int)$store_id . "', `group` = '" . $db->escape($group) . "', `key` = '" . $db->escape($key) . "', `value` = '" . $db->escape(serialize($value)) . "', serialized = '1'");
		}
	}
	echo '<font color="brown"> Setting Module <i> '.$group.' </i>Success! </font><br /><br />';
}

// get id layout
function getIdLayout($layout_name) {
	global $db;
	$query = $db->query("SELECT DISTINCT * FROM " . DB_PREFIX . "layout WHERE LOWER(name) = LOWER('".$layout_name."')");
	return (int)$query->row['layout_id'];
}
// get id banner
function getIdBanner($banner_name) {
	global $db;
	$query = $db->query("SELECT DISTINCT * FROM " . DB_PREFIX . "banner WHERE LOWER(name) = LOWER('".$banner_name."')");
	return (int)$query->row['banner_id'];
}
function finish_config() {
        echo '<font color="red" size="5"> <b>Finish Install</b></font><br /><br />';

}
function addBanner($data) {
	global $db;
		$name=$db->escape($data['name']);
		deleteBanner($name);
		$db->query("INSERT INTO " . DB_PREFIX . "banner SET name = '" . $db->escape($data['name']) . "', status = '" . (int)$data['status'] . "'");
	
		$banner_id = $db->getLastId();
	
		if (isset($data['banner_image'])) {
			foreach ($data['banner_image'] as $banner_image) {
				$db->query("INSERT INTO " . DB_PREFIX . "banner_image SET banner_id = '" . (int)$banner_id . "', link = '" .  $db->escape($banner_image['link']) . "', image = '" .  $db->escape($banner_image['image']) . "'");
				
				$banner_image_id = $db->getLastId();
				
				foreach ($banner_image['banner_image_description'] as $language_id => $banner_image_description) {				
					$db->query("INSERT INTO " . DB_PREFIX . "banner_image_description SET banner_image_id = '" . (int)$banner_image_id . "', language_id = '" . (int)$language_id . "', banner_id = '" . (int)$banner_id . "', title = '" .  $db->escape($banner_image_description['title']) . "'");
				}
			}
		}
		echo '<font color="purple"> Install Banner <i> '.$name.' </i>Success! </font><br /><br />';		
	}
function deleteBanner($banner_name) {
	global $db;
	$query=$db->query("SELECT * FROM " . DB_PREFIX . "banner WHERE name = '".$banner_name."'");
	if($query->num_rows){
		$banner_id = $query->row['banner_id'];
		$db->query("DELETE FROM " . DB_PREFIX . "banner WHERE banner_id = '" . (int)$banner_id . "'");
		$db->query("DELETE FROM " . DB_PREFIX . "banner_image WHERE banner_id = '" . (int)$banner_id . "'");
		$db->query("DELETE FROM " . DB_PREFIX . "banner_image_description WHERE banner_id = '" . (int)$banner_id . "'");
		}
	}
function addLayout($data) {
global $db;
		$name=$db->escape($data['name']);
		deleteLayout($name);
		$db->query("INSERT INTO " . DB_PREFIX . "layout SET name = '" . $db->escape($data['name']) . "'");
		
		$layout_id = $db->getLastId();
		
		if (isset($data['layout_route'])) {
			foreach ($data['layout_route'] as $layout_route) {
				$db->query("INSERT INTO " . DB_PREFIX . "layout_route SET layout_id = '" . (int)$layout_id . "', store_id = '" . (int)$layout_route['store_id'] . "', route = '" . $db->escape($layout_route['route']) . "'");
			}	
		}
		echo '<font color="orange"> Install Layout <i> '.$name.' </i>Success! </font><br /><br />';
	}
function deleteLayout($layout_name) {
	global $db;
	$query = $db->query("SELECT * FROM " . DB_PREFIX . "layout WHERE name = '".$layout_name."'");
	if($query->num_rows){
		$layout_id = $query->row['layout_id'];
		$db->query("DELETE FROM " . DB_PREFIX . "layout WHERE layout_id = '" . (int)$layout_id . "'");
		$db->query("DELETE FROM " . DB_PREFIX . "layout_route WHERE layout_id = '" . (int)$layout_id . "'");
		$db->query("DELETE FROM " . DB_PREFIX . "category_to_layout WHERE layout_id = '" . (int)$layout_id . "'");
		$db->query("DELETE FROM " . DB_PREFIX . "product_to_layout WHERE layout_id = '" . (int)$layout_id . "'");
		$db->query("DELETE FROM " . DB_PREFIX . "information_to_layout WHERE layout_id = '" . (int)$layout_id . "'");	
		}
	}
?>