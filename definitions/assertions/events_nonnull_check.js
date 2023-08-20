assert("assert_events_nonnull").query(ctx => {
    `${assert_utils.nonnullcheck(ctx.ref("stg_users"), ["session_id","sequence_number"])}`;
});
