
assert("assert_dc_id_nonnull").query(ctx => 
    assert_utils.nonnullcheck(ctx.ref("stg_distribution_centre"), ["id"])
);
