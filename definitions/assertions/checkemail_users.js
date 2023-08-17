assert("df_ecomm_users_sl_assertions_email").query(ctx => {
   `${assert_utils.emailsyntax(ctx.ref("stg_users"), "email")}`;
});

