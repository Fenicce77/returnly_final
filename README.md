# Returnly RDBMS Schema Design Challenge


## Basics

All tables have and int auto_increment columns as primary key named  `sk_id`

Indexes added on `Merchants`  and `Shoppers`  are related to Primary Key, Foreign Key and columnd zip,state and city. More indexes should be added according the application use case analizing queries to be 
executed on each table.

Regarding other team will generate a tool for Locations, all data related (zip,state,city and address) are not managed on this DB environment design. This kind of data are only stored in corresponding columns
for each table as they are inserted / provided and the only manipulation would be related for updating the information on corresponding entity.

##### Merchants
`Merchants` represent **business** customers.

	* sk_id int unsigned (PK) autoincrement for merchant ID. 
	* name varchar(100) mandatory (NOT NULL) as merchant name.
	* email varchar(256) mandatory (NOT NULL) for merchant main mail.
	* contact_name varchar(100) mandatory (NOT NULL) for merchant contact name.
	* contact_phone varchar(50) mandatory (NOT NULL) for merchant contact phone number.
	* street varchar(100) mandatory (NOT NULL) for merchant location street.
	* state varchar(2) mandatory (NOT NULL) for merchant location state'.
	* city varchar(50) mandatory (NOT NULL) for merchant location city.
	* zip varchar(5) mandatory (NOT NULL) merchant location zip.
	* billing_code int unsigned mandatory (NOT NULL) Reference to billing_plan. Foreign Key
	* active enum ('0','1') mandatory (NOT NULL)
		- Merchant could be active or not, for example, temporary disabled by any issue or request. 
		- By default (or omission) Merchant billing plan is disabled
		- DEFAULT Value : 0 COMMENT 'merchant plan activation 0:NO ACTIVE,1:ACTIVE'.
	* created_at timestamp mandatory (NOT NULL) merchant creation datetime in system.
		- Default value : CURRENT_TIMESTAMP. Creation row timestamp
	* startdate date mandatory (NOT NULL). Merchant billing Start Date.  
		- Default value : '0000-00-00'.
		- Value must be set by application.
	* enddate date mandatory (NOT NULL). Merchant Billing end date.
		- Default value : '0000-00-00'.
		- Value must by set by application.
	* updated_at timestamp mandatory (NOT NULL). Merchant Billing Update Date
		- Register last change for each merchant billing plan.
		- Default Value : CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP.
	** Foreign Keys :
		FK_merchants_bilplan foreign key (billing_code) references billing_plan (sk_id) on delete NO ACTION on update cascade


##### Billing Plans

A `billing plan` represents a level of service offered to a `merchant`. The plans must have an internal code, name or description, and subscription terms (e.g. monthly).
Examples of plan codes are `BRONZE`, `SILVER`, `GOLD`. There are also some plans that can be purchased in addition to either of the above ones, for example `EXTRAS`.

Merchants can upgrade/downgrade throughout their relationship with us.
Company's accountant states it's important to keep track of those changes.

	* sk_id int unsigned (PK) autoincrement for Billing_plan.
	* code varchar(50) mandatory (NOT NULL) as billing_plan code.
		- Unique key. Non duplicated value.
	* name varchar(100) mandatory (NOT NULL) as billing_plan full name.
	* period enum mandatory (NOT NULL) as subscription plan periodicity.
		- Default value 'monthly'.
		- Values available : 'weekly','monthly','yearly'
	* extra enum mandatory (NOT NULL)
		- Billing_plan type 0: Usual plan type for BRONZE/SILVER/GOLD, 1: For different plans
		- Default value on creation : 0 
		- Values Available : ('0','1')
	* fee int mandatory (NOT NULL) for plan fee in wholw cents.
		- Default Value on creation : 0

##### Shoppers

`Shoppers` are the main users of the software.

We want to keep track of the basics like `name` and `email`, as well as billing address. There may be tens of millions of shoppers. It is necessary to keep track of which merchants a give shopper has a relationship with.


	* sk_id int unsigned (PK) autoincrement for Shopper ID. 
	* name varchar(100) mandatory (NOT NULL) as Shopper name.
	* email varchar(256) mandatory (NOT NULL) for Shopper main mail.
	* street varchar(100) mandatory (NOT NULL) for Shopper location street.
	* state varchar(2) mandatory (NOT NULL) for Shopper location state'.
	* city varchar(50) mandatory (NOT NULL) for Shopper location city.
	* zip varchar(5) mandatory (NOT NULL) Shopper location zip.
	* merchant_id int unsigned mandatory (NOT NULL) Reference to Merchants.
	* created_at timestamp mandatory (NOT NULL) as merchant creation datetime in system.
		- Default value : CURRENT_TIMESTAMP on shopper creation.
	* updated_at timestamp mandatory (NOT NULL). Merchant Billing Update Date
		- Register last change for each shopper.
		- Default Value : CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP.
