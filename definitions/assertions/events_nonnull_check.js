assert("assert_events_nonnull").query(ctx => 
    assert_utils.nonnullcheck(ctx.ref("stg_events"), ["session_id","sequence_number"])
);


assert("assert_events_id_nonnull").query(ctx => 
    assert_utils.nonnullcheck(ctx.ref("stg_events"), ["id"])
);

