<?php

class ControllerModulecategoryhome extends Controller {
    

    protected $category_id = 0;
    protected $path = array();

    protected function index($setting) {
        static $module = 0;
        $this->language->load('module/categoryhome');
        $this->language->load('product/category');
        $category_info = $this->model_catalog_category->getCategory($setting['categoryhome_category']);
        $this->data['heading_title'] = $category_info['name'];

        $this->data['text_refine'] = $this->language->get('text_refine');
        $this->data['text_empty'] = $this->language->get('text_empty');
        $this->data['text_quantity'] = $this->language->get('text_quantity');
        $this->data['text_manufacturer'] = $this->language->get('text_manufacturer');
        $this->data['text_model'] = $this->language->get('text_model');
        $this->data['text_price'] = $this->language->get('text_price');
        $this->data['text_tax'] = $this->language->get('text_tax');
        $this->data['text_points'] = $this->language->get('text_points');
        $this->data['text_compare'] = sprintf($this->language->get('text_compare'), (isset($this->session->data['compare']) ? count($this->session->data['compare']) : 0));
        $this->data['text_display'] = $this->language->get('text_display');
        $this->data['text_list'] = $this->language->get('text_list');
        $this->data['text_grid'] = $this->language->get('text_grid');
        $this->data['text_sort'] = $this->language->get('text_sort');
        $this->data['text_limit'] = $this->language->get('text_limit');
        $this->data['text_showall'] = $this->language->get('text_showall');


        $this->data['button_cart'] = $this->language->get('button_cart');
        $this->data['button_wishlist'] = $this->language->get('button_wishlist');
        $this->data['button_compare'] = $this->language->get('button_compare');
        $this->data['button_continue'] = $this->language->get('button_continue');
        
        
        $this->load->model('catalog/category');
        $this->load->model('tool/image');
        if (isset($this->request->get['path'])) {
            $this->path = explode('_', $this->request->get['path']);

            $this->category_id = end($this->path);
        }
        $url = '';
        $this->data['categoryhome'] = $this->getProduct($setting['categoryhome_category'], $setting['limit']);

        $this->id = 'categoryhome';
        $this->data['link']=$this->url->link('product/category', 'path=' . $setting['categoryhome_category']);
        $this->data['module'] = $module++; 
        if (file_exists(DIR_TEMPLATE . $this->config->get('config_template') . '/template/module/categoryhome.tpl')) {
            $this->template = $this->config->get('config_template') . '/template/module/categoryhome.tpl';
        } else {
            $this->template = 'default/template/module/categoryhome.tpl';
        }

        $this->render();
    }

    protected function getProduct($catID, $limit) {
        $this->load->model('catalog/category');

        $this->load->model('catalog/product');

        $this->load->model('tool/image');
        $this->data['products'] = array();
        $page = 1;
        $data = array(
            'filter_category_id' => $catID,
            'sort' => '',
            'order' => '',
            'start' => ($page - 1) * $limit,
            'limit' => $limit
        );
        $product_total = $this->model_catalog_product->getTotalProducts($data);
        $results = $this->model_catalog_product->getProducts($data);
        foreach ($results as $result) {
            if ($result['image']) {
                $image = $this->model_tool_image->resize($result['image'], $this->config->get('config_image_product_width'), $this->config->get('config_image_product_height'));
            } else {
                $image = false;
            }
            if (($this->config->get('config_customer_price') && $this->customer->isLogged()) || !$this->config->get('config_customer_price')) {
                $price = $this->currency->format($this->tax->calculate($result['price'], $result['tax_class_id'], $this->config->get('config_tax')));
            } else {
                $price = false;
            }
            if ((float) $result['special']) {
                $special = $this->currency->format($this->tax->calculate($result['special'], $result['tax_class_id'], $this->config->get('config_tax')));
            } else {
                $special = false;
            }
            if ($this->config->get('config_tax')) {
                $tax = $this->currency->format((float) $result['special'] ? $result['special'] : $result['price']);
            } else {
                $tax = false;
            }
            if ($this->config->get('config_review_status')) {
                $rating = (int) $result['rating'];
            } else {
                $rating = false;
            }
            $this->data['products'][] = array(
                'product_id' => $result['product_id'],
                'thumb' => $image,
                'name' => $result['name'],
                'description' => mb_substr(strip_tags(html_entity_decode($result['description'], ENT_QUOTES, 'UTF-8')), 0, 100) . '..',
                'price' => $price,
                'special' => $special,
                'tax' => $tax,
                'rating' => $result['rating'],
                'reviews' => sprintf($this->language->get('text_reviews'), (int) $result['reviews']),
                'href' => $this->url->link('product/product', 'path=' . $catID . '&product_id=' . $result['product_id'])
            );
        }
    }

}

?>