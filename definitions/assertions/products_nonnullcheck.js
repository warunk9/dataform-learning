assert("assert_products_nonnull").query(ctx => 
    assert_utils.nonnullcheck(ctx.ref("stg_products"), ["brand","sku","distribution_center_id"])
);


assert("assert_products_id_nonnull").query(ctx => 
    assert_utils.nonnullcheck(ctx.ref("stg_products"), ["id"])
);
