assert("assert_inventory_items_uniquekey").query(ctx => 
    assert_utils.duplicate_on_id(ctx.ref("stg_inventory_items"),"id")
);