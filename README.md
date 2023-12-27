# dataform-learning
#This is test commit added by warun
#This is test commit by madhu





--stg_events
config {
  type: "operations",  
  hasOutput: true,  
  schema: dataform.projectConfig.defaultSchema,
  name: "stg_events",
  tags: ["events" ,"bronze"]
}
LOAD DATA INTO ${ self() }
(
    id INTEGER NOT NULL OPTIONS (description = "Id of the customer"),
    userid INTEGER OPTIONS (description = "Name of the customer"),
    sequence_number INTEGER OPTIONS (description = "Sequence of events"),
    session_id STRING OPTIONS (description = "Session ID"),
    created_at STRING OPTIONS (description = "Event creation time"),
    ip_address STRING OPTIONS (description = "IP Address from which event created"),
    city STRING OPTIONS (description = "City"),
    state STRING OPTIONS (description = "State"),
    postal_code STRING OPTIONS (description = "Postal Code"),
    browser STRING OPTIONS (description = "Browser used for event creation"),
    traffic_source STRING OPTIONS (description = "Traffic source"),
    uri STRING OPTIONS (description = "URI"),
    event_type STRING OPTIONS (description = "Type of event")
)
FROM FILES (
  format = "CSV",
  field_delimiter = ",",
  skip_leading_rows = 1,
  quote = "",
  uris = ["gs://df_ecom_demo/raw_data/events/*"]
);



--stg_order_items
config {
  type: "operations",  
  hasOutput: true,  
  schema: dataform.projectConfig.defaultSchema,
  name: "stg_order_items",
  tags: ["order_items" ,"bronze"]
}
LOAD DATA INTO ${ self() }
(
    id INTEGER NOT NULL OPTIONS (description = "Order Item Id"),
    order_id INTEGER OPTIONS (description = "Order Id"),
    user_id INTEGER OPTIONS (description = "User Id"),
    product_id INTEGER OPTIONS (description = "Product Id"),
    inventory_item_id INTEGER OPTIONS (description = "Inventory Item Id"),
    status STRING OPTIONS (description = "Order Item Status"),
    created_at STRING OPTIONS (description = "Order Item Creation Timestamp"),
    shipped_at STRING OPTIONS (description = "Order Item Shipped Timestamp"),
    delivered_at STRING OPTIONS (description = "Order Item Delivered Timestamp"),
    returned_at STRING OPTIONS (description = "Order Item Returned Timestamp"),
    sale_price STRING OPTIONS (description = "Order Item Sale Price")
)
FROM FILES (
  format = "CSV",
  field_delimiter = ",",
  skip_leading_rows = 1,
  quote = "",
  uris = ["gs://df_ecom_demo/raw_data/order_items/*"]
)


--stg_pr.js
publish("test2_stg_products")
  .query(`LOAD DATA OVERWRITE ${ dataform.projectConfig.vars.bronzeSchema }.${ constants.STG_PRODUCTS }
( id	INT64 NOT NULL,
    cost	FLOAT64,
    category	STRING,
    name	STRING,
    brand	STRING,
    retail_price	FLOAT64,
    department	STRING,
    sku	STRING,
    distribution_center_id	INT64	
)
FROM FILES (
  format = "CSV",
  field_delimiter = ",",
  skip_leading_rows = 1,
  quote = "",
  uris = ["gs://df_ecom_demo/raw_data/products/products_20230811.csv"])
  `) 
  .type("table")



  --STG_PRODUCTS

  config {
  hasOutput: true,
  type: "operations",
  name: "stg_products",
  schema: dataform.projectConfig.vars.bronze_Schema,
  tags: ["products" ,"bronze"]
}
LOAD DATA OVERWRITE ${ self() }
(
    id	INT64 NOT NULL,
    cost	FLOAT64,
    category	STRING,
    name	STRING,
    brand	STRING,
    retail_price	FLOAT64,
    department	STRING,
    sku	STRING,
    distribution_center_id	INT64	
)
FROM FILES (
  format = "CSV",
  field_delimiter = ",",
  skip_leading_rows = 1,
  quote = "",
  uris = ["gs://df_ecom_demo/raw_data/products/products_20230811.csv"]
);


--stg_users

config {
  hasOutput: true,
  type: "operations",
  name: "stg_users",
  schema: dataform.projectConfig.vars.bronze_Schema,
  description: "users table till 2021",
  tags: ["users" ,"bronze"]
}


LOAD DATA OVERWRITE ${ self() }
(
id	STRING	NOT NULL,		
first_name	STRING	,				
last_name	STRING	,			
email	STRING	,		
age	STRING	,			
gender	STRING	,				
state	STRING	,			
street_address	STRING	,				
postal_code	STRING	,		
city	STRING	,	
country	STRING	,				
latitude	STRING	,				
longitude	STRING	,				
traffic_source	STRING	,				
created_at	STRING	
)
FROM FILES (
  format = "CSV",
  field_delimiter = ",",
  skip_leading_rows = 1,
  quote = "",
  uris = ["gs://df_ecom_demo/raw_data/users/users_till_2021.csv"]
);


--stg_inventory_items.sqlx

config {
  type: "operations",  
  hasOutput: true,  
  schema: dataform.projectConfig.defaultSchema,
  name: "stg_inventory_items",
  tags: ["inventory_items" ,"bronze"]
}
LOAD DATA INTO ${ self() }
(
    id INTEGER NOT NULL OPTIONS (description = "Inventory Item Id"),
    product_id INTEGER OPTIONS (description = "Product Id"),
    created_at STRING OPTIONS (description = "Inventory Item Creation Timestamp"),
    sold_at STRING OPTIONS (description = "Inventory Item Sold Timestamp"),
    cost STRING OPTIONS (description = "Inventory Item Cost"),
    product_category STRING OPTIONS (description = "Inventory Item Product Category"),
    product_name STRING OPTIONS (description = "Inventory Item Product Name"),
    product_brand STRING OPTIONS (description = "Inventory Item Product Brand"),
    product_retail_price STRING OPTIONS (description = "Inventory Item Product Retail Price"),
    product_department STRING OPTIONS (description = "Inventory Item Product Department"),
    product_sku STRING OPTIONS (description = "Inventory Item Product SKU"),
    product_distribution_ceter_id STRING OPTIONS (description = "Inventory Item Product Distribution Centre ID")
)
FROM FILES (
  format = "CSV",
  field_delimiter = ",",
  skip_leading_rows = 1,
  quote = "",
  uris = ["gs://df_ecom_demo/raw_data/inventory_items/*"]
)


--dim_inventory_items.js

publish("dim_inventory_items", {
  type: "incremental",
  schema: dataform.projectConfig.vars.silverSchema,
  name: "dim_inventory_items",
  tags: ["inventory_items" ,"silver"],
  description: "Inventory Items Dimension Table",
  columns: {
      product_name: {
        bigqueryPolicyTags: ["projects/gcp-sandbox-3-393305/locations/us-central1/taxonomies/6103638487414924910/policyTags/6256338910151106080"]
      }
    },
  dependencies: ["assert_inventory_items_rowvalidations"],
  bigquery: {
     labels: {"type":"dimension"}
  }
}).query(ctx => `
  SELECT id, 
  product_id, 
  ${utils.parse_date("created_at")} as created_at, 
  ${utils.parse_date("sold_at")} as sold_at, 
  CAST(cost as NUMERIC) as cost, 
  product_category, 
  product_name, 
  product_brand, 
  product_retail_price, 
  product_department, 
  product_sku, 
  product_distribution_ceter_id FROM ${ctx.ref("stg_inventory_items")}
  ${ctx.when(ctx.incremental(),`WHERE cast(substr(created_at, 1, 10) as date) > (SELECT IFNULL(MAX(EXTRACT(DATE FROM created_at)), CAST('${constants.DEFAULT_DATE}' as DATE)) FROM ${ctx.self()})`)}
`)




