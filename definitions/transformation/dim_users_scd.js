
const scd = require("dataform-scd");

/**
 * Create an SCD table on top of the table defined in declare_users.sqlx.
 */
const { updates, view } = scd("dim_users", {
  // A unique identifier for rows in the table.
  uniqueKey: "id",
  // A field that stores a timestamp or date of when the row was last changed.
  timestamp: "updated_at",
  // The source table to build slowly changing dimensions from.
  source: {
    schema: dataform.projectConfig.vars.bronze_Schema,
    name: "stg_users",
  },
  // Any tags that will be added to actions.
  tags: ["scd","silver","users"],
  // Documentation of table columns
  columns: {user_id: "User ID", some_field: "Data Field", updated_at: "Timestamp for updates"},
  // Configuration parameters to apply to the incremental table that will be created.
  incrementalConfig: {
    bigquery: {
      partitionBy: "updated_at",
    },
  },
});

// Additional customization of the created models can be done by using the returned actions objects.
updates.config({
  description: "Updates table for SCD",
});