  function emailsyntax(table, cl_name) {
    return `
        select
        ${cl_name}
        from ${table} where ${cl_name} like "%@%.%"`;
  }

module.exports = { emailsyntax };