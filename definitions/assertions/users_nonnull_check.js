assert("assert_users_id_nonnull").query(ctx => 
    assert_utils.nonnullcheck(ctx.ref("stg_users"), ["id"])
);
