assert("df_ecomm_users_sl_assertions_email").query(ctx => {
   `${assert_utils.emailsyntax(ctx.ref("stg_users"), "email")}`;
});



assert("df_ecomm_users_sl_assertions_age").query(ctx => {
   `${assert_utils.age_check(ctx.ref("stg_users"), "age")}`;
});


