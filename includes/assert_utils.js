  function emailsyntax(table, email_cl) {
    return ` SELECT
        ${email_cl}
        from ${table} where ${email_cl} not like "%@%.%"`;
  }


    function age_check(table, age_cl) {
    return ` SELECT
        ${age_cl}
        from ${table} where ${age_cl} > 0 and ${age_cl} < 200`;
  }

 function duplicate_on_id(table, id_cl) {
    return ` SELECT ${id_cl}
FROM (
    SELECT ${id_cl}, SUM(1) AS count
    FROM ${table}
    GROUP BY 1
)
WHERE count > 1`;
  }


function nonnullcheck(table, null_chk_cl) {
  return `
      SELECT
      ${null_chk_cl.map((field) => `${field} AS ${field}`).join(",\\n")}
      FROM ${table}
      WHERE ${null_chk_cl.map((field) => `${field} is null`) .join(" OR ")} `;
}
  

module.exports = { emailsyntax,
                  age_check,
                  duplicate_on_id,
                  nonnullcheck };

