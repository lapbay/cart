# SCRIPT TO ADD BATCH ORDERS IMPORT IN OPENCART v1.5.x
# WWW.GODROPSHIPPING.COM
# WuChang

#### Version 1.5.1.3, Create

CREATE TABLE IF NOT EXISTS gds_order_group (
    order_group_id int(11) NOT NULL COMMENT '' auto_increment,
    invoice_no int(11) NOT NULL DEFAULT '0',
    invoice_prefix varchar(26) COLLATE utf8_bin NOT NULL DEFAULT '',
    store_id int(11) NOT NULL DEFAULT '0',
    store_name varchar(64) COLLATE utf8_bin NOT NULL DEFAULT '',
    store_url varchar(255) COLLATE utf8_bin NOT NULL DEFAULT '',
    customer_id int(11) NOT NULL DEFAULT '0',
    customer_group_id int(11) NOT NULL DEFAULT '0',
    firstname varchar(32) COLLATE utf8_bin NOT NULL DEFAULT '',
    lastname varchar(32) COLLATE utf8_bin NOT NULL DEFAULT '',
    email varchar(96) COLLATE utf8_bin NOT NULL DEFAULT '',
    telephone varchar(32) COLLATE utf8_bin NOT NULL DEFAULT '',
    fax varchar(32) COLLATE utf8_bin NOT NULL DEFAULT '',
    payment_firstname varchar(32) COLLATE utf8_bin NOT NULL DEFAULT '',
    payment_lastname varchar(32) COLLATE utf8_bin NOT NULL DEFAULT '',
    payment_company varchar(32) COLLATE utf8_bin NOT NULL DEFAULT '',
    payment_address_1 varchar(128) COLLATE utf8_bin NOT NULL DEFAULT '',
    payment_address_2 varchar(128) COLLATE utf8_bin NOT NULL DEFAULT '',
    payment_city varchar(128) COLLATE utf8_bin NOT NULL DEFAULT '',
    payment_postcode varchar(10) COLLATE utf8_bin NOT NULL DEFAULT '',
    payment_country varchar(128) COLLATE utf8_bin NOT NULL DEFAULT '',
    payment_country_id int(11) NOT NULL DEFAULT '0',
    payment_zone varchar(128) COLLATE utf8_bin NOT NULL DEFAULT '',
    payment_zone_id int(11) NOT NULL DEFAULT '0',
    payment_address_format text COLLATE utf8_bin NOT NULL DEFAULT '',
    payment_method varchar(128) COLLATE utf8_bin NOT NULL DEFAULT '',
    comment text COLLATE utf8_bin NOT NULL DEFAULT '',
    total decimal(15,4) NOT NULL DEFAULT '0.0000',
    order_status_id int(11) NOT NULL DEFAULT '0',
    affiliate_id int(11) NOT NULL DEFAULT '0',
    commission decimal(15,4) NOT NULL DEFAULT '0',
    language_id int(11) NOT NULL DEFAULT '0',
    currency_id int(11) NOT NULL DEFAULT '0',
    currency_code varchar(3) COLLATE utf8_bin NOT NULL DEFAULT '',
    currency_value decimal(15,8) NOT NULL DEFAULT '0',
    date_added datetime NOT NULL DEFAULT '0000-00-00',
    date_modified datetime NOT NULL DEFAULT '0000-00-00',
    ip varchar(15) COLLATE utf8_bin NOT NULL DEFAULT '',
    PRIMARY KEY (order_group_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

ALTER TABLE `gds_order` ADD `order_group_id` int(11) DEFAULT 0 COMMENT '';


#### Version 1.5.1.3, Revert

-- ALTER TABLE `gds_order` DROP `order_group_id`;
-- drop table gds_order_group;
