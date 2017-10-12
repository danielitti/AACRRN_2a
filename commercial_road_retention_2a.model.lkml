connection: "hawking_presentation"
label: "Retention 2A"
explore: retention_2a {
  label: "Mockup Retention 2A"
}
view: retention_2a {
  derived_table: {
    sql:
        select    'Fixed Term Renewals' as insurance_type_lvl_1,
                  'Fixed' as insurance_type_lvl_2,
                  'Assisted Renewals' as element_type,
                  '15th Sept 2017' as renewal_up_to_date,
                  100 as volume,
                  1000 as gcp,
                  118.52 as atv
        union all
        select    'Fixed Term Renewals' as insurance_type_lvl_1,
                  'Fixed' as insurance_type_lvl_2,
                  'Saved Renewals' as element_type,
                  '15th Sept 2017' as renewal_up_to_date,
                  150 as volume,
                  2200 as gcp,
                  97.85 as atv
        union all
        select    'Fixed Term Renewals' as insurance_type_lvl_1,
                  'Fixed' as insurance_type_lvl_2,
                  'Auto-Renewals' as element_type,
                  '15th Sept 2017' as renewal_up_to_date,
                  35 as volume,
                  650 as gcp,
                  185.52 as atv
        union all
        select    'Continuous Reprices' as insurance_type_lvl_1,
                  'Monthly' as insurance_type_lvl_2,
                  'Assisted Renewals' as element_type,
                  '15th Sept 2017' as renewal_up_to_date,
                  100 as volume,
                  1000 as gcp,
                  118.52 as atv
        union all
        select    'Continuous Reprices' as insurance_type_lvl_1,
                  'Monthly' as insurance_type_lvl_2,
                  'Saved Renewals' as element_type,
                  '15th Sept 2017' as renewal_up_to_date,
                  150 as volume,
                  2200 as gcp,
                  97.85 as atv
        union all
        select    'Continuous Reprices' as insurance_type_lvl_1,
                  'Monthly' as insurance_type_lvl_2,
                  'Auto-Renewals' as element_type,
                  '15th Sept 2017' as renewal_up_to_date,
                  35 as volume,
                  650 as gcp,
                  185.52 as atv
        union all
        select    'Continuous Reprices' as insurance_type_lvl_1,
                  'Quarterly' as insurance_type_lvl_2,
                  'Assisted Renewals' as element_type,
                  '15th Sept 2017' as renewal_up_to_date,
                  100 as volume,
                  1000 as gcp,
                  118.52 as atv
        union all
        select    'Continuous Reprices' as insurance_type_lvl_1,
                  'Quarterly' as insurance_type_lvl_2,
                  'Saved Renewals' as element_type,
                  '15th Sept 2017' as renewal_up_to_date,
                  150 as volume,
                  2200 as gcp,
                  97.85 as atv
        union all
        select    'Continuous Reprices' as insurance_type_lvl_1,
                  'Quarterly' as insurance_type_lvl_2,
                  'Auto-Renewals' as element_type,
                  '15th Sept 2017' as renewal_up_to_date,
                  35 as volume,
                  650 as gcp,
                  185.52 as atv
        union all
        select    'Continuous Rolls' as insurance_type_lvl_1,
                  'Monthly' as insurance_type_lvl_2,
                  'Rolls' as element_type,
                  '15th Sept 2017' as renewal_up_to_date,
                  100 as volume,
                  1000 as gcp,
                  118.52 as atv
        union all
        select    'Continuous Rolls' as insurance_type_lvl_1,
                  'Quarterly' as insurance_type_lvl_2,
                  'Rolls' as element_type,
                  '15th Sept 2017' as renewal_up_to_date,
                  150 as volume,
                  2200 as gcp,
                  97.85 as atv
        union all
        select    'Cancellation' as insurance_type_lvl_1,
                  'Cancellation' as insurance_type_lvl_2,
                  'Closure Cancellations' as element_type,
                  '15th Sept 2017' as renewal_up_to_date,
                  100 as volume,
                  1000 as gcp,
                  118.52 as atv
        union all
        select    'Cancellation' as insurance_type_lvl_1,
                  'Cancellation' as insurance_type_lvl_2,
                  'Lapser Cancellations' as element_type,
                  '15th Sept 2017' as renewal_up_to_date,
                  150 as volume,
                  2200 as gcp,
                  97.85 as atv
        union all
        select    'Cancellation' as insurance_type_lvl_1,
                  'Cancellation' as insurance_type_lvl_2,
                  'Suspensions less Reactivations' as element_type,
                  '15th Sept 2017' as renewal_up_to_date,
                  35 as volume,
                  650 as gcp,
                  185.52 as atv
       ;;
  }

  ##  DIMENSIONS  ##

  dimension: renewal_up_to_date {
    sql: ${TABLE}.renewal_up_to_date ;;
  }
  dimension: insurance_type_lvl_1 {
    sql: ${TABLE}.insurance_type_lvl_1 ;;
  }
  dimension: insurance_type_lvl_2 {
    sql: ${TABLE}.insurance_type_lvl_2 ;;
  }
  dimension: element_type {
    sql: ${TABLE}.element_type ;;
  }

  ##  MEASURES  ##


  measure: max_renewal_up_to_date {
    sql: ${TABLE}.renewal_up_to_date ;;
  }

  measure: volume_month {
    type: sum
    value_format_name: decimal_0
    sql: ${TABLE}.volume ;;
  }

  measure: volume_month_vs_forecast {
    type: average
    value_format_name: percent_2
    sql: ${TABLE}.volume / (${TABLE}.volume * 0.9)  ;;
  }

  measure: volume_month_vs_ly {
    type: average
    value_format_name: percent_2
    sql: ${TABLE}.volume / (${TABLE}.volume * 1.05)  ;;
  }

  measure: volume_year {
    type: sum
    value_format_name: decimal_0
    sql: ${TABLE}.volume * 6 ;;
  }

  measure: volume_year_vs_forecast {
    type: average
    value_format_name: percent_2
    sql: (${TABLE}.volume * 6) / (${TABLE}.volume * 6 * 0.85)  ;;
  }

  measure: volume_year_vs_ly {
    type: average
    value_format_name: percent_2
    sql: (${TABLE}.volume * 6) / (${TABLE}.volume * 6 * 1.15)  ;;
  }

  measure: gcp_month {
    type: sum
    value_format_name: decimal_0
    sql: ${TABLE}.gcp ;;
  }

  measure: gcp_month_vs_forecast {
    type: average
    value_format_name: percent_2
    sql: ${TABLE}.gcp / (${TABLE}.gcp * 0.9) ;;
  }

  measure: gcp_month_vs_ly {
    type: average
    value_format_name: percent_2
    sql: ${TABLE}.gcp / (${TABLE}.gcp * 1.05) ;;
  }

  measure: gcp_year {
    type: sum
    value_format_name: decimal_0
    sql: ${TABLE}.gcp * 6 ;;
  }

  measure: gcp_year_vs_forecast {
    type: average
    value_format_name: percent_2
    sql: (${TABLE}.gcp * 6) / (${TABLE}.gcp * 6 * 1.1)  ;;
  }

  measure: gcp_year_vs_ly {
    type: average
    value_format_name: percent_2
    sql: (${TABLE}.gcp * 6) / (${TABLE}.gcp * 6 * 1.15)  ;;
  }

  measure: atv_month {
    type: sum
    value_format_name: decimal_0
    sql: ${TABLE}.atv ;;
  }

  measure: atv_month_vs_forecast {
    type: average
    value_format_name: percent_2
    sql: ${TABLE}.atv / (${TABLE}.atv * 0.98)  ;;
  }

  measure: atv_month_vs_ly {
    type: average
    value_format_name: percent_2
    sql: ${TABLE}.atv / (${TABLE}.atv * 1.03)  ;;
  }

  measure: atv_year {
    type: sum
    value_format_name: decimal_0
    sql: ${TABLE}.atv * 1.16 ;;
  }

  measure: atv_year_vs_forecast {
    type: average
    value_format_name: percent_2
    sql: (${TABLE}.atv * 1.16) / (${TABLE}.atv * 1.16 * 0.94)  ;;
  }

  measure: atv_year_vs_ly {
    type: average
    value_format_name: percent_2
    sql: (${TABLE}.atv * 1.16) / (${TABLE}.atv * 1.16 * 1.21)  ;;
  }



}
