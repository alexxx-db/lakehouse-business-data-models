-- Metric views for domain: revenue | Business: Airlines | Version: 1 | Generated on: 2026-05-07 15:08:57

CREATE OR REPLACE VIEW `airlines_ecm`.`_metrics`.`revenue_ticket`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core passenger ticket revenue metrics covering fare yield, ancillary charges, refund exposure, and sales channel mix. Primary KPI surface for airline revenue management and finance leadership."
  source: "`airlines_ecm`.`revenue`.`ticket`"
  filter: ticket_status NOT IN ('VOID', 'REFUNDED')
  dimensions:
    - name: "cabin_class"
      expr: cabin_class
      comment: "Cabin class (e.g. First, Business, Economy) for revenue stratification by product tier."
    - name: "booking_class"
      expr: booking_class
      comment: "RBD booking class code used for yield management segmentation."
    - name: "fare_type"
      expr: fare_type
      comment: "Fare type classification (e.g. Published, Negotiated, Award) indicating revenue quality."
    - name: "sales_channel"
      expr: sales_channel
      comment: "Distribution channel through which the ticket was sold (e.g. Direct, GDS, NDC, Agency)."
    - name: "passenger_type_code"
      expr: passenger_type_code
      comment: "IATA passenger type code (ADT, CHD, INF) for demand and revenue segmentation."
    - name: "origin_airport_code"
      expr: origin_airport_code
      comment: "IATA origin airport code for O&D revenue analysis."
    - name: "destination_airport_code"
      expr: destination_airport_code
      comment: "IATA destination airport code for O&D revenue analysis."
    - name: "fare_basis_code"
      expr: fare_basis_code
      comment: "Fare basis code linking to specific fare rules and restrictions."
    - name: "form_of_payment_type"
      expr: form_of_payment_type
      comment: "Payment method used (e.g. Credit Card, Cash, Miles) for payment mix analysis."
    - name: "sale_country_code"
      expr: sale_country_code
      comment: "Country where the ticket was sold for geographic revenue reporting."
    - name: "ticket_status"
      expr: ticket_status
      comment: "Current lifecycle status of the ticket (e.g. Issued, Exchanged, Refunded)."
    - name: "issue_date"
      expr: DATE(issue_timestamp)
      comment: "Date the ticket was issued, used for time-series revenue trend analysis."
    - name: "issue_month"
      expr: DATE_TRUNC('MONTH', issue_timestamp)
      comment: "Month of ticket issuance for monthly revenue aggregation."
  measures:
    - name: "total_tickets_issued"
      expr: COUNT(1)
      comment: "Total number of tickets issued. Baseline volume KPI for capacity and demand planning."
    - name: "total_base_fare_revenue"
      expr: SUM(CAST(base_fare_amount AS DOUBLE))
      comment: "Sum of base fare amounts across all tickets. Core passenger revenue before taxes and surcharges — primary top-line revenue KPI."
    - name: "total_fare_revenue"
      expr: SUM(CAST(total_fare_amount AS DOUBLE))
      comment: "Sum of total fare amounts including taxes. Represents gross ticket revenue collected from passengers."
    - name: "total_tax_collected"
      expr: SUM(CAST(tax_total_amount AS DOUBLE))
      comment: "Total taxes collected on tickets. Used for tax remittance reconciliation and net revenue calculation."
    - name: "total_refund_amount"
      expr: SUM(CAST(refund_amount AS DOUBLE))
      comment: "Total refund amounts issued against tickets. Tracks revenue leakage from cancellations and involuntary changes."
    - name: "total_net_remit_amount"
      expr: SUM(CAST(net_remit_amount AS DOUBLE))
      comment: "Net remittance amount after agency commissions and deductions. Represents actual cash received by the airline from agency sales."
    - name: "avg_base_fare_per_ticket"
      expr: AVG(CAST(base_fare_amount AS DOUBLE))
      comment: "Average base fare per ticket. Key yield indicator used by revenue management to assess pricing effectiveness."
    - name: "avg_total_fare_per_ticket"
      expr: AVG(CAST(total_fare_amount AS DOUBLE))
      comment: "Average total fare (including taxes) per ticket. Reflects average passenger spend and pricing power."
    - name: "refund_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(refund_amount AS DOUBLE)) / NULLIF(SUM(CAST(total_fare_amount AS DOUBLE)), 0), 2)
      comment: "Refund amount as a percentage of total fare revenue. Measures revenue leakage risk from cancellations and refund policy exposure."
    - name: "distinct_passengers"
      expr: COUNT(DISTINCT profile_id)
      comment: "Count of unique passengers who purchased tickets. Used for customer reach and revenue-per-passenger analysis."
    - name: "ffp_ticket_count"
      expr: COUNT(DISTINCT CASE WHEN ffp_member_id IS NOT NULL THEN ticket_id END)
      comment: "Number of tickets issued to frequent flyer program members. Measures loyalty program contribution to ticket revenue."
$$;


CREATE OR REPLACE VIEW `airlines_ecm`.`_metrics`.`revenue_recognition`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Revenue recognition metrics aligned to accounting periods, covering recognized fare, prorate, fuel surcharge, and interline revenue. Critical for financial close, IFRS 15 compliance, and period-over-period revenue reporting."
  source: "`airlines_ecm`.`revenue`.`recognition`"
  filter: accounting_status NOT IN ('REVERSED', 'CANCELLED')
  dimensions:
    - name: "accounting_period"
      expr: accounting_period
      comment: "Accounting period (e.g. 2024-01) in which revenue was recognized. Primary dimension for financial close reporting."
    - name: "accounting_status"
      expr: accounting_status
      comment: "Status of the recognition record (e.g. Recognized, Pending, Adjusted) for reconciliation workflows."
    - name: "cabin_class"
      expr: cabin_class
      comment: "Cabin class associated with the recognized revenue for product-level P&L."
    - name: "booking_class"
      expr: booking_class
      comment: "RBD booking class for yield-level revenue recognition analysis."
    - name: "passenger_type_code"
      expr: passenger_type_code
      comment: "Passenger type code for segmented revenue recognition reporting."
    - name: "destination_airport_code"
      expr: destination_airport_code
      comment: "Destination airport for route-level recognized revenue analysis."
    - name: "issuing_airline_code"
      expr: issuing_airline_code
      comment: "Airline code that issued the ticket, distinguishing own-metal vs. interline recognized revenue."
    - name: "recognition_method"
      expr: recognition_method
      comment: "Method used to recognize revenue (e.g. Flown, Prorate, EMD) for accounting policy compliance."
    - name: "form_of_payment_type"
      expr: form_of_payment_type
      comment: "Payment type associated with the recognized revenue record."
    - name: "interline_flag"
      expr: CAST(interline_flag AS STRING)
      comment: "Indicates whether the recognized revenue relates to an interline itinerary."
    - name: "codeshare_flag"
      expr: CAST(codeshare_flag AS STRING)
      comment: "Indicates whether the recognized revenue relates to a codeshare flight."
    - name: "settlement_currency"
      expr: settlement_currency
      comment: "Currency in which the revenue was settled, for FX exposure analysis."
    - name: "ticket_issue_date"
      expr: ticket_issue_date
      comment: "Date the original ticket was issued, enabling booking-to-recognition lag analysis."
    - name: "recognition_month"
      expr: DATE_TRUNC('MONTH', recognition_timestamp)
      comment: "Month of revenue recognition for monthly financial reporting."
  measures:
    - name: "total_recognized_fare_amount"
      expr: SUM(CAST(fare_amount AS DOUBLE))
      comment: "Total fare revenue recognized in the accounting period. Primary top-line metric for financial close and IFRS 15 compliance."
    - name: "total_recognized_reporting_currency_amount"
      expr: SUM(CAST(reporting_currency_amount AS DOUBLE))
      comment: "Total recognized revenue converted to reporting currency. Used for consolidated financial statements and FX-adjusted performance reporting."
    - name: "total_prorate_amount"
      expr: SUM(CAST(prorate_amount AS DOUBLE))
      comment: "Total interline prorate revenue recognized. Measures the airline's share of interline itinerary revenue."
    - name: "total_fuel_surcharge_recognized"
      expr: SUM(CAST(fuel_surcharge_amount AS DOUBLE))
      comment: "Total fuel surcharge revenue recognized. Tracks ancillary surcharge contribution to total revenue."
    - name: "total_tax_recognized"
      expr: SUM(CAST(tax_amount AS DOUBLE))
      comment: "Total tax amounts recognized. Used for tax liability reconciliation against remittance obligations."
    - name: "avg_recognized_fare_per_record"
      expr: AVG(CAST(fare_amount AS DOUBLE))
      comment: "Average recognized fare per recognition record. Indicates yield quality of recognized revenue."
    - name: "interline_revenue_count"
      expr: COUNT(DISTINCT CASE WHEN interline_flag = TRUE THEN recognition_id END)
      comment: "Count of interline revenue recognition records. Measures interline revenue volume for partner settlement oversight."
    - name: "total_recognition_records"
      expr: COUNT(1)
      comment: "Total number of revenue recognition records. Baseline volume for reconciliation completeness checks."
    - name: "prorate_share_pct"
      expr: ROUND(100.0 * SUM(CAST(prorate_amount AS DOUBLE)) / NULLIF(SUM(CAST(fare_amount AS DOUBLE)), 0), 2)
      comment: "Prorate revenue as a percentage of total recognized fare. Measures interline revenue dependency and partner revenue sharing exposure."
$$;


CREATE OR REPLACE VIEW `airlines_ecm`.`_metrics`.`revenue_bsp_settlement`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "BSP/ARC agency settlement metrics covering gross sales, net remittance, commission costs, and dispute exposure. Essential for agency channel profitability, distribution cost management, and settlement reconciliation."
  source: "`airlines_ecm`.`revenue`.`bsp_settlement`"
  filter: settlement_status NOT IN ('CANCELLED', 'REVERSED')
  dimensions:
    - name: "settlement_status"
      expr: settlement_status
      comment: "Current status of the BSP settlement record (e.g. Settled, Pending, Disputed)."
    - name: "sales_channel"
      expr: sales_channel
      comment: "Sales channel through which the settlement was generated (e.g. GDS, NDC, Direct)."
    - name: "bsp_market_country_code"
      expr: bsp_market_country_code
      comment: "BSP market country code for geographic settlement analysis and regulatory reporting."
    - name: "gds_provider_code"
      expr: gds_provider_code
      comment: "GDS provider (e.g. Amadeus, Sabre, Travelport) for distribution cost analysis by platform."
    - name: "transaction_type"
      expr: transaction_type
      comment: "Type of BSP transaction (e.g. Sale, Refund, ADM, ACM) for settlement composition analysis."
    - name: "interline_indicator"
      expr: CAST(interline_indicator AS STRING)
      comment: "Indicates whether the settlement involves an interline itinerary."
    - name: "ndc_indicator"
      expr: CAST(ndc_indicator AS STRING)
      comment: "Indicates whether the transaction was processed via NDC channel."
    - name: "settlement_currency_code"
      expr: settlement_currency_code
      comment: "Currency of the BSP settlement for FX exposure and multi-currency reporting."
    - name: "billing_period_start_date"
      expr: billing_period_start_date
      comment: "Start date of the BSP billing period for period-level settlement analysis."
    - name: "settlement_date"
      expr: settlement_date
      comment: "Actual settlement date for cash flow and remittance timing analysis."
    - name: "settlement_month"
      expr: DATE_TRUNC('MONTH', settlement_date)
      comment: "Month of settlement for monthly distribution cost and agency revenue reporting."
  measures:
    - name: "total_gross_sales_amount"
      expr: SUM(CAST(gross_sales_amount AS DOUBLE))
      comment: "Total gross sales amount settled through BSP/ARC. Represents total agency channel revenue before commissions and deductions."
    - name: "total_net_remittance_amount"
      expr: SUM(CAST(net_remittance_amount AS DOUBLE))
      comment: "Total net remittance received from agencies after commissions. Measures actual cash collected from the agency distribution channel."
    - name: "total_commission_cost"
      expr: SUM(CAST(commission_amount AS DOUBLE))
      comment: "Total commission paid to travel agencies. Key distribution cost metric for agency channel profitability analysis."
    - name: "total_tax_collected"
      expr: SUM(CAST(tax_amount AS DOUBLE))
      comment: "Total taxes collected through BSP settlements for tax remittance reconciliation."
    - name: "total_adm_amount"
      expr: SUM(CAST(adm_amount AS DOUBLE))
      comment: "Total Agency Debit Memo amounts issued. Measures revenue recovery from agency billing errors and policy violations."
    - name: "total_acm_amount"
      expr: SUM(CAST(acm_amount AS DOUBLE))
      comment: "Total Agency Credit Memo amounts issued. Tracks concessions granted to agencies impacting net settlement revenue."
    - name: "avg_commission_rate"
      expr: AVG(CAST(commission_rate AS DOUBLE))
      comment: "Average commission rate across BSP settlements. Benchmarks agency commission cost against contracted rates."
    - name: "commission_as_pct_of_gross_sales"
      expr: ROUND(100.0 * SUM(CAST(commission_amount AS DOUBLE)) / NULLIF(SUM(CAST(gross_sales_amount AS DOUBLE)), 0), 2)
      comment: "Commission cost as a percentage of gross sales. Primary distribution cost efficiency KPI for agency channel management."
    - name: "net_remittance_pct_of_gross"
      expr: ROUND(100.0 * SUM(CAST(net_remittance_amount AS DOUBLE)) / NULLIF(SUM(CAST(gross_sales_amount AS DOUBLE)), 0), 2)
      comment: "Net remittance as a percentage of gross sales. Measures effective yield from agency channel after all deductions."
    - name: "disputed_settlement_count"
      expr: COUNT(DISTINCT CASE WHEN dispute_raised_date IS NOT NULL AND dispute_resolution_date IS NULL THEN bsp_settlement_id END)
      comment: "Count of settlements with open disputes. Tracks unresolved settlement disputes that represent revenue at risk."
    - name: "total_pfc_amount"
      expr: SUM(CAST(pfc_amount AS DOUBLE))
      comment: "Total Passenger Facility Charges collected. Required for regulatory remittance compliance reporting."
$$;


CREATE OR REPLACE VIEW `airlines_ecm`.`_metrics`.`revenue_refund`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Passenger refund metrics covering refund volume, penalty recovery, involuntary refund exposure, and refund method mix. Critical for revenue leakage management, customer policy governance, and operational disruption cost tracking."
  source: "`airlines_ecm`.`revenue`.`refund`"
  filter: refund_status NOT IN ('REJECTED', 'CANCELLED')
  dimensions:
    - name: "refund_type"
      expr: refund_type
      comment: "Type of refund (e.g. Voluntary, Involuntary, Schedule Change) for policy and cost attribution."
    - name: "refund_status"
      expr: refund_status
      comment: "Current processing status of the refund (e.g. Approved, Processed, Pending)."
    - name: "refund_method"
      expr: refund_method
      comment: "Method of refund disbursement (e.g. Original Form of Payment, Voucher, Miles) for cash flow impact analysis."
    - name: "sales_channel"
      expr: sales_channel
      comment: "Sales channel through which the original ticket was sold, for channel-level refund rate analysis."
    - name: "cabin_class"
      expr: cabin_class
      comment: "Cabin class of the refunded ticket for product-level refund exposure analysis."
    - name: "reason_code"
      expr: reason_code
      comment: "Reason code for the refund (e.g. Schedule Change, Cancellation, Voluntary) for root cause analysis."
    - name: "involuntary_reason"
      expr: involuntary_reason
      comment: "Specific reason for involuntary refunds (e.g. Flight Cancellation, IROP) for operational disruption cost tracking."
    - name: "origin_airport_code"
      expr: origin_airport_code
      comment: "Origin airport of the refunded itinerary for geographic refund concentration analysis."
    - name: "destination_airport_code"
      expr: destination_airport_code
      comment: "Destination airport of the refunded itinerary."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the refund for multi-currency cash flow reporting."
    - name: "refund_month"
      expr: DATE_TRUNC('MONTH', processed_timestamp)
      comment: "Month the refund was processed for monthly revenue leakage trend analysis."
    - name: "bsp_arc_settlement_date"
      expr: bsp_arc_settlement_date
      comment: "BSP/ARC settlement date for the refund, used in agency settlement reconciliation."
  measures:
    - name: "total_refunds_processed"
      expr: COUNT(1)
      comment: "Total number of refunds processed. Baseline volume KPI for refund operations and policy governance."
    - name: "total_refund_amount"
      expr: SUM(CAST(total_refund_amount AS DOUBLE))
      comment: "Total monetary value of refunds issued. Primary revenue leakage KPI — directly impacts net passenger revenue."
    - name: "total_fare_refunded"
      expr: SUM(CAST(fare_amount AS DOUBLE))
      comment: "Total base fare component refunded. Measures pure fare revenue returned to passengers."
    - name: "total_tax_refunded"
      expr: SUM(CAST(tax_refund_amount AS DOUBLE))
      comment: "Total taxes refunded to passengers. Used for tax remittance adjustment and regulatory compliance."
    - name: "total_penalty_collected"
      expr: SUM(CAST(penalty_amount AS DOUBLE))
      comment: "Total change/cancellation penalties collected on refunds. Measures revenue retained through fare rule enforcement."
    - name: "avg_refund_amount"
      expr: AVG(CAST(total_refund_amount AS DOUBLE))
      comment: "Average refund amount per transaction. Benchmarks refund cost per event for policy calibration."
    - name: "penalty_recovery_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(penalty_amount AS DOUBLE)) / NULLIF(SUM(CAST(gross_fare_amount AS DOUBLE)), 0), 2)
      comment: "Penalty fees collected as a percentage of gross fare refunded. Measures effectiveness of fare rule enforcement in recovering revenue from cancellations."
    - name: "involuntary_refund_count"
      expr: COUNT(DISTINCT CASE WHEN involuntary_reason IS NOT NULL THEN refund_id END)
      comment: "Count of involuntary refunds (e.g. due to cancellations, IRROPs). Tracks operational disruption cost exposure."
    - name: "voucher_refund_count"
      expr: COUNT(DISTINCT CASE WHEN refund_method = 'VOUCHER' THEN refund_id END)
      comment: "Count of refunds issued as travel vouchers. Measures deferred revenue liability from voucher issuance."
$$;


CREATE OR REPLACE VIEW `airlines_ecm`.`_metrics`.`revenue_interline_prorate`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Interline prorate revenue metrics covering prorated revenue allocation, partner settlement exposure, and dispute tracking. Essential for interline revenue accounting, partner airline billing, and IATA settlement compliance."
  source: "`airlines_ecm`.`revenue`.`interline_prorate`"
  filter: agreement_status NOT IN ('TERMINATED', 'CANCELLED')
  dimensions:
    - name: "partner_carrier_code"
      expr: partner_carrier_code
      comment: "IATA code of the interline partner carrier for partner-level revenue settlement analysis."
    - name: "ticketing_carrier_code"
      expr: ticketing_carrier_code
      comment: "Carrier that issued the ticket, distinguishing own-metal vs. partner-ticketed interline revenue."
    - name: "cabin_class"
      expr: cabin_class
      comment: "Cabin class of the interline segment for product-level prorate analysis."
    - name: "passenger_type_code"
      expr: passenger_type_code
      comment: "Passenger type code for segmented interline revenue analysis."
    - name: "agreement_type"
      expr: agreement_type
      comment: "Type of interline agreement (e.g. SPA, MITA, Bilateral) governing the prorate calculation."
    - name: "prorate_basis"
      expr: prorate_basis
      comment: "Basis used for prorate calculation (e.g. Mileage, Equal Split, Published Fare) for methodology analysis."
    - name: "calculation_method"
      expr: calculation_method
      comment: "Specific calculation method applied to determine the prorate amount."
    - name: "origin_airport_code"
      expr: origin_airport_code
      comment: "Origin airport of the interline segment for route-level prorate analysis."
    - name: "destination_airport_code"
      expr: destination_airport_code
      comment: "Destination airport of the interline segment."
    - name: "dispute_status"
      expr: dispute_status
      comment: "Status of any prorate dispute (e.g. Open, Resolved, Escalated) for revenue-at-risk tracking."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the prorate transaction for multi-currency settlement reporting."
    - name: "transaction_month"
      expr: DATE_TRUNC('MONTH', transaction_date)
      comment: "Month of the prorate transaction for period-level interline revenue reporting."
    - name: "iata_conference_area"
      expr: iata_conference_area
      comment: "IATA conference area (TC1/TC2/TC3) for regional interline revenue analysis."
  measures:
    - name: "total_prorated_revenue"
      expr: SUM(CAST(prorated_revenue_amount AS DOUBLE))
      comment: "Total prorated revenue allocated to the operating carrier. Primary interline revenue KPI for partner settlement and P&L attribution."
    - name: "total_prorate_amount"
      expr: SUM(CAST(prorate_amount AS DOUBLE))
      comment: "Total prorate amounts calculated across all interline agreements. Used for IATA billing reconciliation."
    - name: "total_collected_fare"
      expr: SUM(CAST(collected_fare_amount AS DOUBLE))
      comment: "Total fare collected on interline itineraries before prorate allocation. Baseline for prorate share calculation."
    - name: "avg_prorate_factor"
      expr: AVG(CAST(prorate_factor AS DOUBLE))
      comment: "Average prorate factor applied across interline agreements. Benchmarks revenue share allocation against agreement terms."
    - name: "avg_prorate_percentage"
      expr: AVG(CAST(prorate_percentage AS DOUBLE))
      comment: "Average prorate percentage of collected fare allocated to the carrier. Measures revenue share efficiency in interline partnerships."
    - name: "prorate_share_pct"
      expr: ROUND(100.0 * SUM(CAST(prorated_revenue_amount AS DOUBLE)) / NULLIF(SUM(CAST(collected_fare_amount AS DOUBLE)), 0), 2)
      comment: "Prorated revenue as a percentage of total collected fare. Measures the airline's effective revenue share from interline itineraries."
    - name: "disputed_prorate_count"
      expr: COUNT(DISTINCT CASE WHEN dispute_status IS NOT NULL AND dispute_status != 'RESOLVED' THEN interline_prorate_id END)
      comment: "Count of interline prorate records with open disputes. Tracks revenue at risk from unresolved interline billing disputes."
    - name: "total_tax_on_interline"
      expr: SUM(CAST(tax_amount AS DOUBLE))
      comment: "Total taxes on interline prorate transactions for tax remittance and partner billing compliance."
    - name: "distinct_partner_carriers"
      expr: COUNT(DISTINCT partner_carrier_code)
      comment: "Number of distinct interline partner carriers. Measures breadth of interline network and partner revenue diversification."
$$;


CREATE OR REPLACE VIEW `airlines_ecm`.`_metrics`.`revenue_pricing_record`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Fare pricing and quote metrics covering base fare levels, tax composition, equivalent fare conversion, and pricing source mix. Supports revenue management, fare filing governance, and NDC offer performance analysis."
  source: "`airlines_ecm`.`revenue`.`pricing_record`"
  filter: pricing_status NOT IN ('EXPIRED', 'CANCELLED')
  dimensions:
    - name: "cabin_class"
      expr: cabin_class
      comment: "Cabin class for which the pricing record was generated."
    - name: "booking_class"
      expr: booking_class
      comment: "RBD booking class associated with the pricing record for yield class analysis."
    - name: "fare_type"
      expr: fare_type
      comment: "Fare type (e.g. Published, Negotiated, Corporate) for pricing strategy segmentation."
    - name: "pricing_source"
      expr: pricing_source
      comment: "Source system or channel that generated the pricing record (e.g. ATPCO, NDC, Direct)."
    - name: "pricing_status"
      expr: pricing_status
      comment: "Status of the pricing record (e.g. Active, Quoted, Ticketed) for conversion funnel analysis."
    - name: "passenger_type_code"
      expr: passenger_type_code
      comment: "Passenger type code for demand-segment pricing analysis."
    - name: "origin_airport_code"
      expr: origin_airport_code
      comment: "Origin airport for O&D pricing level analysis."
    - name: "destination_airport_code"
      expr: destination_airport_code
      comment: "Destination airport for O&D pricing level analysis."
    - name: "trip_type"
      expr: trip_type
      comment: "Trip type (e.g. One-Way, Round-Trip) for itinerary-level pricing analysis."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the pricing record for multi-currency fare analysis."
    - name: "refundable_flag"
      expr: CAST(refundable_flag AS STRING)
      comment: "Indicates whether the priced fare is refundable, for refundability mix analysis."
    - name: "changeable_flag"
      expr: CAST(changeable_flag AS STRING)
      comment: "Indicates whether the priced fare is changeable, for flexibility mix analysis."
    - name: "pricing_date"
      expr: pricing_date
      comment: "Date the pricing record was generated for time-series fare level analysis."
    - name: "pricing_month"
      expr: DATE_TRUNC('MONTH', pricing_date)
      comment: "Month of pricing for monthly fare trend and revenue management reporting."
  measures:
    - name: "total_pricing_records"
      expr: COUNT(1)
      comment: "Total number of pricing records generated. Baseline volume for quote-to-ticket conversion analysis."
    - name: "total_base_fare_quoted"
      expr: SUM(CAST(base_fare_amount AS DOUBLE))
      comment: "Sum of base fare amounts across all pricing records. Measures total fare value quoted to passengers."
    - name: "total_fare_quoted"
      expr: SUM(CAST(total_fare_amount AS DOUBLE))
      comment: "Sum of total fare amounts (including taxes) quoted. Represents gross revenue potential from active pricing records."
    - name: "total_tax_quoted"
      expr: SUM(CAST(tax_amount AS DOUBLE))
      comment: "Total tax amounts included in pricing records for tax composition analysis."
    - name: "total_carrier_surcharge_quoted"
      expr: SUM(CAST(carrier_surcharge_amount AS DOUBLE))
      comment: "Total carrier surcharge amounts quoted. Measures surcharge revenue contribution to total fare."
    - name: "avg_base_fare_quoted"
      expr: AVG(CAST(base_fare_amount AS DOUBLE))
      comment: "Average base fare quoted per pricing record. Key revenue management KPI for fare level monitoring and competitive benchmarking."
    - name: "avg_total_fare_quoted"
      expr: AVG(CAST(total_fare_amount AS DOUBLE))
      comment: "Average total fare (all-in) quoted per pricing record. Reflects average passenger price point for demand elasticity analysis."
    - name: "tax_as_pct_of_total_fare"
      expr: ROUND(100.0 * SUM(CAST(tax_amount AS DOUBLE)) / NULLIF(SUM(CAST(total_fare_amount AS DOUBLE)), 0), 2)
      comment: "Tax as a percentage of total fare quoted. Measures tax burden on passengers and its impact on price competitiveness."
    - name: "surcharge_as_pct_of_base_fare"
      expr: ROUND(100.0 * SUM(CAST(carrier_surcharge_amount AS DOUBLE)) / NULLIF(SUM(CAST(base_fare_amount AS DOUBLE)), 0), 2)
      comment: "Carrier surcharge as a percentage of base fare. Tracks surcharge loading relative to base fare for pricing transparency analysis."
    - name: "ndc_pricing_record_count"
      expr: COUNT(DISTINCT CASE WHEN ndc_offer_reference IS NOT NULL THEN pricing_record_id END)
      comment: "Count of pricing records generated via NDC channel. Measures NDC adoption and its contribution to the pricing pipeline."
$$;


CREATE OR REPLACE VIEW `airlines_ecm`.`_metrics`.`revenue_emd`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Electronic Miscellaneous Document (EMD) revenue metrics covering ancillary service revenue, refund exposure, and service type mix. Critical for ancillary revenue strategy, unbundling performance, and EMD settlement compliance."
  source: "`airlines_ecm`.`revenue`.`revenue_emd`"
  filter: emd_status NOT IN ('VOID', 'CANCELLED')
  dimensions:
    - name: "emd_type"
      expr: emd_type
      comment: "Type of EMD (e.g. EMD-A for associated, EMD-S for standalone) for ancillary revenue classification."
    - name: "emd_status"
      expr: emd_status
      comment: "Current status of the EMD (e.g. Issued, Used, Refunded) for lifecycle tracking."
    - name: "rfic"
      expr: rfic
      comment: "Reason for Issuance Code (RFIC) classifying the ancillary service category (e.g. A=Air, B=Surface, C=Baggage)."
    - name: "rfisc"
      expr: rfisc
      comment: "Reason for Issuance Sub-Code (RFISC) for granular ancillary service type analysis."
    - name: "sales_channel"
      expr: sales_channel
      comment: "Channel through which the EMD was sold for distribution cost and ancillary channel mix analysis."
    - name: "operating_carrier_code"
      expr: operating_carrier_code
      comment: "Operating carrier code for the EMD service, distinguishing own vs. partner ancillary revenue."
    - name: "origin_airport_code"
      expr: origin_airport_code
      comment: "Origin airport for geographic ancillary revenue analysis."
    - name: "destination_airport_code"
      expr: destination_airport_code
      comment: "Destination airport for route-level ancillary revenue analysis."
    - name: "form_of_payment_type"
      expr: form_of_payment_type
      comment: "Payment method for the EMD for payment mix and cash flow analysis."
    - name: "interline_indicator"
      expr: CAST(interline_indicator AS STRING)
      comment: "Indicates whether the EMD is associated with an interline itinerary."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the EMD transaction for multi-currency ancillary revenue reporting."
    - name: "issue_month"
      expr: DATE_TRUNC('MONTH', issue_date)
      comment: "Month of EMD issuance for monthly ancillary revenue trend analysis."
    - name: "service_date"
      expr: service_date
      comment: "Date the ancillary service is to be rendered, for revenue recognition timing."
  measures:
    - name: "total_emd_base_amount"
      expr: SUM(CAST(base_amount AS DOUBLE))
      comment: "Total base amount of EMDs issued. Core ancillary revenue KPI before taxes and equivalents."
    - name: "total_emd_revenue"
      expr: SUM(CAST(total_amount AS DOUBLE))
      comment: "Total EMD revenue including taxes. Represents gross ancillary revenue from unbundled services."
    - name: "total_emd_tax_amount"
      expr: SUM(CAST(tax_amount AS DOUBLE))
      comment: "Total taxes collected on EMDs for tax remittance compliance."
    - name: "total_emd_refund_amount"
      expr: SUM(CAST(refund_amount AS DOUBLE))
      comment: "Total refunds issued on EMDs. Measures ancillary revenue leakage from service cancellations and refunds."
    - name: "total_equivalent_amount"
      expr: SUM(CAST(equivalent_amount AS DOUBLE))
      comment: "Total equivalent fare amount for EMDs converted to reporting currency. Used for consolidated ancillary revenue reporting."
    - name: "avg_emd_revenue_per_document"
      expr: AVG(CAST(total_amount AS DOUBLE))
      comment: "Average revenue per EMD document. Benchmarks ancillary yield per transaction for product pricing optimization."
    - name: "emd_refund_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(refund_amount AS DOUBLE)) / NULLIF(SUM(CAST(total_amount AS DOUBLE)), 0), 2)
      comment: "EMD refund amount as a percentage of total EMD revenue. Measures ancillary revenue leakage rate for service policy governance."
    - name: "total_emds_issued"
      expr: COUNT(1)
      comment: "Total number of EMDs issued. Baseline volume KPI for ancillary attach rate and unbundling strategy performance."
    - name: "distinct_ffp_members_with_emd"
      expr: COUNT(DISTINCT ffp_member_id)
      comment: "Count of distinct FFP members who purchased ancillary services via EMD. Measures loyalty member ancillary engagement."
$$;


CREATE OR REPLACE VIEW `airlines_ecm`.`_metrics`.`revenue_yield_parameter`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Revenue management yield parameter metrics covering load factor targets, overbooking authorization, dynamic pricing bounds, and RASK/CASK benchmarks. Supports RM strategy governance, pricing floor management, and capacity optimization decisions."
  source: "`airlines_ecm`.`revenue`.`yield_parameter`"
  filter: parameter_status = 'ACTIVE'
  dimensions:
    - name: "parameter_type"
      expr: parameter_type
      comment: "Type of yield parameter (e.g. Load Factor, Overbooking, Dynamic Pricing) for RM strategy categorization."
    - name: "parameter_name"
      expr: parameter_name
      comment: "Name of the yield parameter for human-readable RM configuration reporting."
    - name: "parameter_status"
      expr: parameter_status
      comment: "Status of the yield parameter (e.g. Active, Inactive, Under Review) for governance tracking."
    - name: "origin_airport_code"
      expr: origin_airport_code
      comment: "Origin airport for route-level yield parameter analysis."
    - name: "destination_airport_code"
      expr: destination_airport_code
      comment: "Destination airport for route-level yield parameter analysis."
    - name: "optimization_method"
      expr: optimization_method
      comment: "Revenue optimization method applied (e.g. EMSRb, DAVN, Bid Price) for RM methodology analysis."
    - name: "forecast_model_type"
      expr: forecast_model_type
      comment: "Demand forecast model type used (e.g. Pickup, Regression, ML) for RM model governance."
    - name: "dynamic_pricing_enabled"
      expr: CAST(dynamic_pricing_enabled AS STRING)
      comment: "Indicates whether dynamic pricing is enabled for the route/class combination."
    - name: "od_control_enabled"
      expr: CAST(od_control_enabled AS STRING)
      comment: "Indicates whether O&D revenue control is enabled for network-level optimization."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the yield parameter amounts for multi-currency RM reporting."
    - name: "effective_from"
      expr: effective_from
      comment: "Effective start date of the yield parameter for temporal governance analysis."
    - name: "effective_until"
      expr: effective_until
      comment: "Effective end date of the yield parameter."
  measures:
    - name: "avg_load_factor_target"
      expr: AVG(CAST(load_factor_target AS DOUBLE))
      comment: "Average load factor target across active yield parameters. Measures RM ambition level for capacity utilization planning."
    - name: "avg_load_factor_minimum"
      expr: AVG(CAST(load_factor_minimum AS DOUBLE))
      comment: "Average minimum acceptable load factor. Defines the floor below which revenue management intervention is triggered."
    - name: "avg_overbooking_authorization_rate"
      expr: AVG(CAST(overbooking_authorization_rate AS DOUBLE))
      comment: "Average authorized overbooking rate. Key RM risk parameter balancing spoilage reduction against denied boarding exposure."
    - name: "avg_no_show_rate"
      expr: AVG(CAST(no_show_rate AS DOUBLE))
      comment: "Average no-show rate assumption used in yield parameters. Drives overbooking calibration and revenue recovery strategy."
    - name: "avg_cancellation_rate"
      expr: AVG(CAST(cancellation_rate AS DOUBLE))
      comment: "Average cancellation rate assumption. Used to calibrate overbooking levels and forecast demand accuracy."
    - name: "avg_minimum_yield_floor"
      expr: AVG(CAST(minimum_yield_floor AS DOUBLE))
      comment: "Average minimum yield floor across active parameters. Defines the lowest acceptable fare level — critical for preventing revenue dilution."
    - name: "avg_rask_target"
      expr: AVG(CAST(rask_target AS DOUBLE))
      comment: "Average Revenue per Available Seat Kilometre (RASK) target. Primary airline profitability benchmark used by executives to set revenue performance expectations."
    - name: "avg_cask_benchmark"
      expr: AVG(CAST(cask_benchmark AS DOUBLE))
      comment: "Average Cost per Available Seat Kilometre (CASK) benchmark. Used alongside RASK target to assess unit economics and margin viability."
    - name: "avg_dynamic_pricing_ceiling"
      expr: AVG(CAST(dynamic_pricing_ceiling AS DOUBLE))
      comment: "Average dynamic pricing ceiling across active parameters. Defines the upper bound of automated fare adjustments for revenue maximization."
    - name: "avg_dynamic_pricing_floor"
      expr: AVG(CAST(dynamic_pricing_floor AS DOUBLE))
      comment: "Average dynamic pricing floor. Defines the lower bound of automated fare adjustments to prevent revenue dilution."
    - name: "rask_vs_cask_spread"
      expr: ROUND(AVG(CAST(rask_target AS DOUBLE)) - AVG(CAST(cask_benchmark AS DOUBLE)), 4)
      comment: "Difference between average RASK target and CASK benchmark. Measures targeted unit margin — positive spread indicates profitable route economics."
    - name: "active_parameter_count"
      expr: COUNT(1)
      comment: "Count of active yield parameters. Measures RM configuration coverage across routes and fare classes."
$$;


CREATE OR REPLACE VIEW `airlines_ecm`.`_metrics`.`revenue_ticket_exchange`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Ticket exchange and reissue metrics covering fare difference collection, penalty recovery, involuntary exchange exposure, and upgrade revenue. Critical for revenue integrity, IROP cost management, and exchange policy governance."
  source: "`airlines_ecm`.`revenue`.`ticket_exchange`"
  filter: exchange_status NOT IN ('CANCELLED', 'REVERSED')
  dimensions:
    - name: "exchange_type"
      expr: exchange_type
      comment: "Type of exchange (e.g. Voluntary, Involuntary, Upgrade, Downgrade) for revenue impact classification."
    - name: "exchange_status"
      expr: exchange_status
      comment: "Current status of the exchange transaction (e.g. Completed, Pending, Disputed)."
    - name: "sales_channel"
      expr: sales_channel
      comment: "Channel through which the exchange was processed for distribution cost analysis."
    - name: "passenger_type_code"
      expr: passenger_type_code
      comment: "Passenger type code for segmented exchange analysis."
    - name: "original_cabin_class"
      expr: original_cabin_class
      comment: "Original cabin class before exchange for upgrade/downgrade revenue impact analysis."
    - name: "new_cabin_class"
      expr: new_cabin_class
      comment: "New cabin class after exchange for upgrade revenue and cabin mix shift analysis."
    - name: "involuntary_reason_code"
      expr: involuntary_reason_code
      comment: "Reason code for involuntary exchanges (e.g. Schedule Change, IROP) for operational disruption cost attribution."
    - name: "issuing_carrier_code"
      expr: issuing_carrier_code
      comment: "Carrier that processed the exchange for interline exchange revenue attribution."
    - name: "validating_carrier_code"
      expr: validating_carrier_code
      comment: "Validating carrier on the exchanged ticket for settlement responsibility analysis."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the exchange transaction for multi-currency reporting."
    - name: "settlement_plan_type"
      expr: settlement_plan_type
      comment: "Settlement plan type for the exchange (e.g. BSP, Direct) for settlement channel analysis."
    - name: "exchange_month"
      expr: DATE_TRUNC('MONTH', exchange_date)
      comment: "Month the exchange was processed for monthly exchange volume and revenue impact trending."
    - name: "new_travel_date"
      expr: new_travel_date
      comment: "New travel date after exchange for forward booking revenue impact analysis."
  measures:
    - name: "total_exchanges_processed"
      expr: COUNT(1)
      comment: "Total number of ticket exchanges processed. Baseline volume KPI for exchange operations and policy governance."
    - name: "total_fare_difference_collected"
      expr: SUM(CAST(fare_difference_amount AS DOUBLE))
      comment: "Total fare difference amounts collected on exchanges. Measures incremental revenue generated from passengers upgrading or rebooking to higher fares."
    - name: "total_penalty_collected"
      expr: SUM(CAST(penalty_amount AS DOUBLE))
      comment: "Total change penalties collected on voluntary exchanges. Measures revenue retained through fare rule enforcement on ticket changes."
    - name: "total_tax_difference_collected"
      expr: SUM(CAST(tax_difference_amount AS DOUBLE))
      comment: "Total tax difference amounts collected on exchanges for tax remittance adjustment."
    - name: "avg_fare_difference_per_exchange"
      expr: AVG(CAST(fare_difference_amount AS DOUBLE))
      comment: "Average fare difference per exchange transaction. Measures average incremental revenue or cost per exchange event."
    - name: "involuntary_exchange_count"
      expr: COUNT(DISTINCT CASE WHEN involuntary_reason_code IS NOT NULL THEN ticket_exchange_id END)
      comment: "Count of involuntary exchanges (e.g. due to IRROPs or schedule changes). Tracks operational disruption cost exposure from forced rebooking."
    - name: "upgrade_exchange_count"
      expr: COUNT(DISTINCT CASE WHEN exchange_type = 'UPGRADE' THEN ticket_exchange_id END)
      comment: "Count of upgrade exchanges. Measures upsell revenue opportunity conversion through the exchange channel."
    - name: "positive_fare_diff_pct"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN fare_difference_amount > 0 THEN ticket_exchange_id END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of exchanges where additional fare was collected. Measures the proportion of exchanges that generate incremental revenue vs. cost."
$$;


CREATE OR REPLACE VIEW `airlines_ecm`.`_metrics`.`revenue_corporate_account`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Corporate account revenue metrics covering commitment levels, credit exposure, discount depth, and account portfolio health. Supports corporate sales strategy, account management, and B2B revenue governance."
  source: "`airlines_ecm`.`revenue`.`corporate_account`"
  filter: account_status = 'ACTIVE'
  dimensions:
    - name: "account_type"
      expr: account_type
      comment: "Type of corporate account (e.g. SME, Enterprise, Government) for portfolio segmentation."
    - name: "account_status"
      expr: account_status
      comment: "Current status of the corporate account (e.g. Active, Suspended, Churned) for portfolio health monitoring."
    - name: "revenue_tier"
      expr: revenue_tier
      comment: "Revenue tier classification of the corporate account (e.g. Platinum, Gold, Silver) for tiered service and pricing strategy."
    - name: "industry_sector"
      expr: industry_sector
      comment: "Industry sector of the corporate account for vertical market revenue analysis."
    - name: "billing_country_code"
      expr: billing_country_code
      comment: "Country of the corporate account for geographic B2B revenue analysis."
    - name: "preferred_cabin_class"
      expr: preferred_cabin_class
      comment: "Preferred cabin class of the corporate account for product mix and yield analysis."
    - name: "risk_rating"
      expr: risk_rating
      comment: "Credit risk rating of the corporate account for credit exposure management."
    - name: "annual_revenue_commitment_currency_code"
      expr: annual_revenue_commitment_currency_code
      comment: "Currency of the annual revenue commitment for multi-currency corporate revenue reporting."
    - name: "contract_start_date"
      expr: contract_start_date
      comment: "Contract start date for cohort analysis of corporate account revenue performance."
    - name: "contract_end_date"
      expr: contract_end_date
      comment: "Contract end date for renewal pipeline and revenue-at-risk analysis."
  measures:
    - name: "total_active_corporate_accounts"
      expr: COUNT(1)
      comment: "Total number of active corporate accounts. Baseline KPI for B2B customer portfolio size and market penetration."
    - name: "total_annual_revenue_commitment"
      expr: SUM(CAST(annual_revenue_commitment_amount AS DOUBLE))
      comment: "Total contracted annual revenue commitment across all corporate accounts. Measures guaranteed B2B revenue pipeline and forward revenue visibility."
    - name: "avg_annual_revenue_commitment"
      expr: AVG(CAST(annual_revenue_commitment_amount AS DOUBLE))
      comment: "Average annual revenue commitment per corporate account. Benchmarks account value for portfolio segmentation and sales resource allocation."
    - name: "total_credit_limit_exposure"
      expr: SUM(CAST(credit_limit_amount AS DOUBLE))
      comment: "Total credit limit extended to corporate accounts. Measures aggregate credit risk exposure in the B2B portfolio."
    - name: "avg_discount_percentage"
      expr: AVG(CAST(discount_percentage AS DOUBLE))
      comment: "Average discount percentage granted to corporate accounts. Measures revenue dilution from corporate pricing concessions."
    - name: "accounts_expiring_within_90_days"
      expr: COUNT(DISTINCT CASE WHEN contract_end_date BETWEEN CURRENT_DATE AND DATE_ADD(CURRENT_DATE, 90) THEN corporate_account_id END)
      comment: "Count of corporate accounts with contracts expiring within 90 days. Identifies renewal pipeline at risk for proactive account management."
    - name: "high_risk_account_count"
      expr: COUNT(DISTINCT CASE WHEN risk_rating IN ('HIGH', 'CRITICAL') THEN corporate_account_id END)
      comment: "Count of corporate accounts with high or critical risk ratings. Measures credit risk concentration in the B2B portfolio."
    - name: "avg_credit_limit_per_account"
      expr: AVG(CAST(credit_limit_amount AS DOUBLE))
      comment: "Average credit limit per corporate account. Used to calibrate credit policy and assess per-account financial exposure."
$$;
