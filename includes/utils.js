  function null_if_string(string_cl) {
    return ` nullif(trim(${string_cl}),'') as ${string_cl}`;
  }


  

module.exports = { null_if_string };