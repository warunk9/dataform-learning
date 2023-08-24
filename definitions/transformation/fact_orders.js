publish("fact_orders", {
  type: "incremental",
  schema: dataform.projectConfig.vars.silverSchema,
  name: "fact_orders",
  tags: ["orders" ,"silver"],
  description: "Order information and details",
  dependencies: ["assert_orders_nonnull","assert_orders_user_id_nonnull","assert_orders_rowvalidation"],
  bigquery: {
     labels: {"type":"fact"}
  }
}).query(ctx => `
    SELECT 
    order_id,
    user_id,
    status,
    gender,
    ${utils.parse_date("created_at")} as created_at,
    ${utils.parse_date("returned_at")} as returned_at,
    ${utils.parse_date("shipped_at")} as shipped_at,
    ${utils.parse_date("delivered_at")} as delivered_at,
    num_of_item
    FROM ${ctx.ref("stg_orders")}
  ${ctx.when(ctx.incremental(),`WHERE cast(substr(created_at, 1, 10) as date) > (SELECT IFNULL(MAX(EXTRACT(DATE FROM created_at)), CAST('${constants.DEFAULT_DATE}' as DATE)) FROM ${ctx.self()})`)}
`)