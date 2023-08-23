assert("assert_inventory_items_nonnull").query(ctx => 
    assert_utils.nonnullcheck(ctx.ref("stg_inventory_items"), ["product_id","product_category","product_name", "product_brand", "product_retail_price"])
);