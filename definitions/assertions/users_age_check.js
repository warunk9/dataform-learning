

assert("df_ecomm_users_sl_assertions_age").query(ctx =>
   assert_utils.age_check(ctx.ref("stg_users"), 'cast(age as INT64)')
);





