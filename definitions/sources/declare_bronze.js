declare({
   database: constants.PROJECT_ID,
   schema: dataform.projectConfig.vars.bronze_Schema,
   name: "stg_products",
 });

declare({
   database: constants.PROJECT_ID,
   schema: dataform.projectConfig.vars.bronze_Schema,
   name: "stg_order_items",
 });

declare({
   database: constants.PROJECT_ID,
   schema: dataform.projectConfig.vars.bronze_Schema,
   name: "stg_orders",
 });
