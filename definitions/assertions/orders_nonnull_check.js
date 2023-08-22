assert("assert_orders_nonnull").query(ctx => 
    assert_utils.nonnullcheck(ctx.ref("stg_orders"), ["order_id"])
);

assert("assert_orders_user_id_nonnull").query(ctx => 
    assert_utils.nonnullcheck(ctx.ref("stg_orders"), ["user_id"])
);
