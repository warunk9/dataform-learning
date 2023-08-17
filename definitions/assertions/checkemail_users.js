assert("df_ecomm_users_sl_assertions_email").query(ctx => {
   `${check_func.emailsyntax(ctx.ref("stg_users"), "email")}`;
});

