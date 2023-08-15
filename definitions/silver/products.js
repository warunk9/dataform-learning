publish("products_sl",
   {
    type: "table",
    database: dataform.projectConfig.vars.silverDatabase,
    schema: dataform.projectConfig.vars.silver_Schema,
    description: "Product Details"  ,
    tags: ["products" ,"silver"],  
    })
    .query(ctx => `SELECT 
    id,
    round(cost,3) as cost,
    nullif(trim(category),'') as category,
    nullif(trim(name),'') as name,
    nullif(trim(brand),'') as brand,
    round(retail_price,3) as retail_price,
    nullif(trim(department),'') as department,
    nullif(trim(sku),'') as sku,
    distribution_center_id
    FROM ${ctx.ref("stg_products")}`);

assert("df_ecomm_products_sl_assertions_notnull")
.query(ctx => `SELECT id FROM  ${ctx.ref("stg_products")} WHERE id IS NULL`);






