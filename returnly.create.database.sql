create database if not exists returnly;

use returnly;

create table if not exists billing_plan (
	sk_id int unsigned not null AUTO_INCREMENT primary KEY COMMENT 'billing_plan ID',
	code varchar(50) NOT NULL COMMENT 'billing_plan code',
	name varchar(100) NOT NULL COMMENT 'billing_plan full name',
	period enum ('weekly','monthly','yearly') NOT NULL default 'monthly' COMMENT 'billing_plan periodicity',
	extra enum ('0','1') NOT NULL DEFAULT '0' COMMENT 'billing_plan type 0: Usual plan type for BRONZE/SILVER/GOLD, 1: For different plans',
	fee int NOT NULL default 0 COMMENT 'plan fee in whole cents',
	unique KEY uq_billing_plan_code(code)
);

create table if not exists merchants (
	sk_id int unsigned not null AUTO_INCREMENT primary KEY COMMENT 'merchant ID', 
	name varchar(100) NOT NULL COMMENT 'merchant name',
	email varchar(256) NOT NULL COMMENT 'merchant main mail',
	contact_name varchar(100) NOT NULL COMMENT 'merchant contact name',
	contact_phone varchar(50) NOT NULL COMMENT 'merchant contact phone number',
	street varchar(100) NOT NULL COMMENT 'merchant street',
	state varchar(2) NOT NULL COMMENT 'merchant state',
	city varchar(50) COMMENT 'merchant city',
	zip varchar(5) NOT NULL COMMENT 'merchant zip',
	billing_code int unsigned NOT NULL COMMENT 'billing_plan id',
	active enum ('0','1') NOT NULL DEFAULT '0' COMMENT 'merchant plan activation 0:NO ACTIVE,1:ACTIVE',
	created_at timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'merchant billing creation date',
	startdate date NOT NULL DEFAULT '0000-00-00' COMMENT 'merchant billing start date',
	enddate date NOT NULL DEFAULT '0000-00-00' COMMENT 'merchant billing end date',
	updated_at timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'merchant billing update date',
	KEY IDX_city (city),
	KEY IDX_zip (zip),
	KEY IDX_state (state),
	KEY FK_merchants_bilplan (billing_code), 
	CONSTRAINT FK_merchants_bilplan foreign KEY (billing_code) references billing_plan (sk_id) on delete NO ACTION on update cascade
);

create table if not exists shoppers (
	sk_id int unsigned not null AUTO_INCREMENT primary KEY COMMENT 'shopper ID',
	name varchar(100) NOT NULL COMMENT 'shopper name',
	email varchar(256) NOT NULL COMMENT 'shopper mail',
	street varchar(200) NOT NULL COMMENT 'shooper street address',
	state varchar(2) NOT NULL COMMENT 'shooper location state',
	city varchar(50) NOT NULL COMMENT 'shooper location city',
	zip varchar(5) NOT NULL COMMENT 'shooper location zip',
	merchant_id int unsigned NOT NULL COMMENT 'merchant ID',
	created_at timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'creation date',
	updated_at timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'update date',
	KEY IDX_city (city),
	KEY IDX_zip (zip),
	KEY IDX_state (state),
	KEY FK_shoppers_marchants (merchant_id),
	CONSTRAINT FK_shoppers_marchants foreign KEY (merchant_id) references merchants (sk_id) on delete NO ACTION on update cascade
);
