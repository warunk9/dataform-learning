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
