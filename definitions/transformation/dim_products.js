publish("products_sl",
   {
    type: "table",
    database: dataform.projectConfig.vars.silverDatabase,
    schema: dataform.projectConfig.vars.silver_Schema,
    description: "Product Details"  ,
    
    tags: ["products" ,"silver"],  
    dependencies: ["assert_products_nonnull","assert_products_id_nonnull","assert_products_uniquekey","assert_products_id_nonnull_inline"]
    })
    .query(ctx => `SELECT 
    id,
    round(cost,3) as cost,
    ${utils.null_if_string("category")} , 
    ${utils.null_if_string("name")} ,
    ${utils.null_if_string("brand")} ,
    round(retail_price,3) as retail_price,
    ${utils.null_if_string("department")} ,
    ${utils.null_if_string("sku")} ,
    distribution_center_id
    FROM ${ctx.ref("stg_products")}`)



assert("assert_products_id_nonnull_inline")
.query(ctx => `SELECT id FROM  ${ctx.ref("stg_products")} WHERE id IS NULL`);






