  function emailsyntax(table, cl_name) {
    return ` SELECT
        ${cl_name}
        from ${table} where ${cl_name} not like "%@%.%"`;
  }

module.exports = { emailsyntax };

