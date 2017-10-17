connection: "hawking_presentation"
label: "Retention 2A"
explore: retention_2a {
  label: "Mockup Retention 2A"
}
view: retention_2a {
  derived_table: {
    sql:
        select  day.renewal_day, day.effective_renewal_day,
                insurance_type_lvl_1, insurance_type_lvl_2,  element_type, renewal_up_to_date, day_factor * volume as volume, day_factor * gcp as gcp, day_factor * atv as atv
        from
        (
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
        ) t,
        (
        select convert(datetime, '09/25/2017') as renewal_day, convert(datetime,'09/25/2017') as effective_renewal_day, 1 as day_factor union all
        select convert(datetime, '10/25/2017') as renewal_day, convert(datetime,'10/25/2017') as effective_renewal_day, 0.6 as day_factor union all
        select convert(datetime, '11/25/2017') as renewal_day, convert(datetime,'11/25/2017') as effective_renewal_day, 0.2 as day_factor union all
        select convert(datetime, '08/25/2017') as renewal_day, convert(datetime,'08/25/2017') as effective_renewal_day, 0.451 as day_factor union all
        select convert(datetime, '07/25/2017') as renewal_day, convert(datetime,'07/25/2017') as effective_renewal_day, 0.1 as day_factor
        ) day

       ;;
  }

  ##  DIMENSIONS  ##

  dimension_group: renewal_day {
    label: "Renewal Cohort"
    type: time
    timeframes: [date, month, year, raw] #week
    convert_tz: no
    sql: ${TABLE}.renewal_day ;;
  }

  dimension_group: renewal_day_previous_month {
    label: "Renewal Cohort Previous"
    type: time
    timeframes: [date, month, year, raw] #week
    convert_tz: no
    sql: DATEADD(day,-30,${TABLE}.renewal_day) ;;
  }

  dimension_group: renewal_day_second_previous_month {
    label: "Renewal Cohort Second Previous"
    type: time
    timeframes: [date, month, year, raw] #week
    convert_tz: no
    sql: DATEADD(day,-60,${TABLE}.renewal_day) ;;
  }

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
    label: "Volume Month"
    type: sum
    value_format_name: decimal_0
    sql: ${TABLE}.volume ;;
  }

  measure: volume_month_vs_forecast {
    label: "Volume Month vs Forecast %"
    type: average
    value_format_name: percent_2
    sql: ${TABLE}.volume / (${TABLE}.volume * 0.9)  ;;
  }

  measure: volume_month_vs_ly {
    label: "Volume Month vs LY %"
    type: average
    value_format_name: percent_2
    sql: ${TABLE}.volume / (${TABLE}.volume * 1.05)  ;;
  }

  measure: volume_year {
    label: "Volume Year"
    type: sum
    value_format_name: decimal_0
    sql: ${TABLE}.volume * 6 ;;
  }

  measure: volume_year_vs_forecast {
    label: "Volume Year vs Forecast %"
    type: average
    value_format_name: percent_2
    sql: (${TABLE}.volume * 6) / (${TABLE}.volume * 6 * 0.85)  ;;
  }

  measure: volume_year_vs_ly {
    label: "Volume Year vs LY %"
    type: average
    value_format_name: percent_2
    sql: (${TABLE}.volume * 6) / (${TABLE}.volume * 6 * 1.15)  ;;
  }

  measure: gcp_month {
    label: "GCP Month"
    type: sum
    value_format_name: gbp
    sql: ${TABLE}.gcp ;;
  }

  measure: gcp_month_ly {
    label: "GCP Month LY"
    type: sum
    value_format_name: gbp
    sql: ${TABLE}.gcp * 1.05;;
  }

  measure: gcp_month_forecast {
    label: "GCP Month Forecast"
    type: sum
    value_format_name: gbp
    sql: ${TABLE}.gcp * 0.9;;
  }

  measure: gcp_month_vs_forecast {
    label: "GCP Month vs Forecast %"
    type: average
    value_format_name: percent_2
    sql: ${TABLE}.gcp / (${TABLE}.gcp * 0.9) ;;
  }

  measure: gcp_month_vs_ly {
    label: "GCP Month vs LY %"
    type: average
    value_format_name: percent_2
    sql: ${TABLE}.gcp / (${TABLE}.gcp * 1.05) ;;
  }

  measure: gcp_year {
    label: "GCP Year"
    type: sum
    value_format_name: gbp
    sql: ${TABLE}.gcp * 6 ;;
  }

  measure: gcp_year_vs_forecast {
    label: "GCP Year vs Forecast %"
    type: average
    value_format_name: percent_2
    sql: (${TABLE}.gcp * 6) / (${TABLE}.gcp * 6 * 1.1)  ;;
  }

  measure: gcp_year_vs_ly {
    label: "GCP Year vs LY %"
    type: average
    value_format_name: percent_2
    sql: (${TABLE}.gcp * 6) / (${TABLE}.gcp * 6 * 1.15)  ;;
  }

  measure: atv_month {
    label: "ATV Month"
    type: sum
    value_format_name: gbp
    sql: ${TABLE}.atv ;;
  }

  measure: atv_month_vs_forecast {
    label: "ATV Month vs Forecast %"
    type: average
    value_format_name: percent_2
    sql: ${TABLE}.atv / (${TABLE}.atv * 0.98)  ;;
  }

  measure: atv_month_vs_ly {
    label: "ATV Month vs LY %"
    type: average
    value_format_name: percent_2
    sql: ${TABLE}.atv / (${TABLE}.atv * 1.03)  ;;
  }

  measure: atv_year {
    label: "ATV Year"
    type: sum
    value_format_name: gbp
    sql: ${TABLE}.atv * 1.16 ;;
  }

  measure: atv_year_vs_forecast {
    label: "ATV Year vs Forecast %"
    type: average
    value_format_name: percent_2
    sql: (${TABLE}.atv * 1.16) / (${TABLE}.atv * 1.16 * 0.94)  ;;
  }

  measure: atv_year_vs_ly {
    label: "ATV Year vs LY %"
    type: average
    value_format_name: percent_2
    sql: (${TABLE}.atv * 1.16) / (${TABLE}.atv * 1.16 * 1.21)  ;;
  }



}
