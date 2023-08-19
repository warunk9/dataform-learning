function parse_date(date_field) {
    return `PARSE_DATETIME('%Y-%m-%d %H:%M:%E*S UTC', nullif(TRIM(${date_field}),''))`;
}

module.exports = { parse_date };
   
