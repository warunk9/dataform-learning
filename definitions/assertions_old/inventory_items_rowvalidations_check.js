assert("assert_inventory_items_rowvalidations")
.query(ctx => `SELECT id FROM  ${ctx.ref("stg_inventory_items")} WHERE product_department not in ('Women', 'Men')`);