publish("dim_inventory_items", {
  type: "incremental",
  schema: dataform.projectConfig.vars.silverSchema,
  name: "dim_inventory_items",
  tags: ["inventory_items" ,"silver"],
  description: "Inventory Items Dimension Table",
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
    