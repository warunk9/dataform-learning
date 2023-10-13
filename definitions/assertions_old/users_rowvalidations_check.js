

assert("assert_users_rowvalidation_age").query(ctx =>
   assert_utils.age_check(ctx.ref("stg_users"), "cast(age as INT64)")
);


assert("assert_users_rowvalidation_email").query(ctx =>
   assert_utils.emailsyntax(ctx.ref("stg_users"), "email")
);



