-- Metric views for domain: logistics | Business: Apparel Fashion | Version: 1 | Generated on: 2026-05-05 15:42:09

CREATE OR REPLACE VIEW `apparel_fashion_ecm`.`_metrics`.`logistics_shipment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core shipment performance metrics tracking on-time delivery, freight costs, volume, and compliance across transport modes and lanes"
  source: "`apparel_fashion_ecm`.`logistics`.`shipment`"
  dimensions:
    - name: "shipment_status"
      expr: shipment_status
      comment: "Current status of the shipment (in-transit, delivered, delayed, etc.)"
    - name: "transport_mode"
      expr: transport_mode
      comment: "Mode of transportation (air, ocean, ground, rail)"
    - name: "shipment_type"
      expr: shipment_type
      comment: "Type of shipment (inbound, outbound, transfer, return)"
    - name: "origin_country"
      expr: origin_country_code
      comment: "Country code where shipment originated"
    - name: "destination_country"
      expr: destination_country_code
      comment: "Country code of shipment destination"
    - name: "incoterm"
      expr: incoterm
      comment: "International commercial terms defining delivery responsibility"
    - name: "current_milestone"
      expr: current_milestone
      comment: "Current milestone in shipment journey"
    - name: "gsp_eligible"
      expr: gsp_eligible_flag
      comment: "Whether shipment qualifies for Generalized System of Preferences duty reduction"
    - name: "otif_compliant"
      expr: otif_compliant_flag
      comment: "Whether shipment met On-Time In-Full service level agreement"
    - name: "priority_shipment"
      expr: priority_flag
      comment: "Whether shipment is flagged as priority"
    - name: "shipment_month"
      expr: DATE_TRUNC('MONTH', actual_departure_timestamp)
      comment: "Month when shipment departed (for time-series analysis)"
    - name: "delivery_month"
      expr: DATE_TRUNC('MONTH', actual_arrival_timestamp)
      comment: "Month when shipment arrived (for time-series analysis)"
  measures:
    - name: "total_shipments"
      expr: COUNT(1)
      comment: "Total number of shipments"
    - name: "total_freight_cost"
      expr: SUM(CAST(freight_cost_estimate AS DOUBLE))
      comment: "Total estimated freight costs across all shipments"
    - name: "total_duty_amount"
      expr: SUM(CAST(duty_amount AS DOUBLE))
      comment: "Total customs duty paid across all shipments"
    - name: "total_cubic_volume_m3"
      expr: SUM(CAST(cubic_volume_m3 AS DOUBLE))
      comment: "Total cubic volume shipped in cubic meters"
    - name: "total_gross_weight_kg"
      expr: SUM(CAST(gross_weight_kg AS DOUBLE))
      comment: "Total gross weight shipped in kilograms"
    - name: "total_cartons"
      expr: SUM(CAST(carton_count AS DOUBLE))
      comment: "Total number of cartons shipped"
    - name: "total_pallets"
      expr: SUM(CAST(pallet_count AS DOUBLE))
      comment: "Total number of pallets shipped"
    - name: "avg_freight_cost_per_shipment"
      expr: AVG(CAST(freight_cost_estimate AS DOUBLE))
      comment: "Average freight cost per shipment"
    - name: "avg_cubic_volume_per_shipment"
      expr: AVG(CAST(cubic_volume_m3 AS DOUBLE))
      comment: "Average cubic volume per shipment in cubic meters"
    - name: "otif_shipment_count"
      expr: SUM(CASE WHEN otif_compliant_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of shipments that met On-Time In-Full service level"
    - name: "otif_compliance_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN otif_compliant_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of shipments meeting On-Time In-Full service level agreement"
    - name: "gsp_eligible_shipment_count"
      expr: SUM(CASE WHEN gsp_eligible_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of shipments eligible for GSP duty reduction"
    - name: "priority_shipment_count"
      expr: SUM(CASE WHEN priority_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of shipments flagged as priority"
    - name: "unique_carriers"
      expr: COUNT(DISTINCT carrier_id)
      comment: "Number of distinct carriers used"
    - name: "unique_origin_factories"
      expr: COUNT(DISTINCT supplier_factory_id)
      comment: "Number of distinct origin factories shipping product"
    - name: "unique_destination_facilities"
      expr: COUNT(DISTINCT distribution_center_id)
      comment: "Number of distinct destination distribution centers receiving shipments"
$$;


CREATE OR REPLACE VIEW `apparel_fashion_ecm`.`_metrics`.`logistics_freight_invoice`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Freight invoice and cost analytics tracking invoiced amounts, variances, disputes, and payment performance by carrier and service level"
  source: "`apparel_fashion_ecm`.`logistics`.`freight_invoice`"
  dimensions:
    - name: "invoice_status"
      expr: invoice_status
      comment: "Current status of freight invoice (pending, approved, paid, disputed)"
    - name: "payment_status"
      expr: payment_status
      comment: "Payment status of invoice"
    - name: "invoice_type"
      expr: invoice_type
      comment: "Type of freight invoice"
    - name: "transport_mode"
      expr: transport_mode
      comment: "Mode of transportation for invoiced shipment"
    - name: "service_level"
      expr: service_level
      comment: "Service level agreement tier (standard, expedited, express)"
    - name: "origin_country"
      expr: origin_country_code
      comment: "Country code of shipment origin"
    - name: "destination_country"
      expr: destination_country_code
      comment: "Country code of shipment destination"
    - name: "incoterm"
      expr: incoterm
      comment: "International commercial terms for the shipment"
    - name: "dispute_flag"
      expr: dispute_flag
      comment: "Whether invoice is under dispute"
    - name: "dispute_reason"
      expr: dispute_reason
      comment: "Reason code for invoice dispute"
    - name: "invoice_month"
      expr: DATE_TRUNC('MONTH', invoice_date)
      comment: "Month when invoice was issued"
    - name: "payment_month"
      expr: DATE_TRUNC('MONTH', payment_date)
      comment: "Month when invoice was paid"
  measures:
    - name: "total_invoices"
      expr: COUNT(1)
      comment: "Total number of freight invoices"
    - name: "total_invoiced_amount"
      expr: SUM(CAST(total_invoiced_amount AS DOUBLE))
      comment: "Total invoiced amount across all freight invoices"
    - name: "total_approved_amount"
      expr: SUM(CAST(approved_amount AS DOUBLE))
      comment: "Total approved amount after review and dispute resolution"
    - name: "total_base_freight_charge"
      expr: SUM(CAST(base_freight_charge AS DOUBLE))
      comment: "Total base freight charges before surcharges and fees"
    - name: "total_fuel_surcharge"
      expr: SUM(CAST(fuel_surcharge AS DOUBLE))
      comment: "Total fuel surcharges across all invoices"
    - name: "total_accessorial_charges"
      expr: SUM(CAST(accessorial_charges AS DOUBLE))
      comment: "Total accessorial charges (detention, demurrage, special handling)"
    - name: "total_detention_demurrage"
      expr: SUM(CAST(detention_demurrage_charges AS DOUBLE))
      comment: "Total detention and demurrage charges"
    - name: "total_customs_brokerage_fee"
      expr: SUM(CAST(customs_brokerage_fee AS DOUBLE))
      comment: "Total customs brokerage fees"
    - name: "total_duty_amount"
      expr: SUM(CAST(duty_amount AS DOUBLE))
      comment: "Total customs duty amounts invoiced"
    - name: "total_tax_amount"
      expr: SUM(CAST(tax_amount AS DOUBLE))
      comment: "Total tax amounts on freight invoices"
    - name: "total_variance_amount"
      expr: SUM(CAST(variance_amount AS DOUBLE))
      comment: "Total variance between contracted and invoiced amounts"
    - name: "avg_invoice_amount"
      expr: AVG(CAST(total_invoiced_amount AS DOUBLE))
      comment: "Average invoice amount per freight invoice"
    - name: "disputed_invoice_count"
      expr: SUM(CASE WHEN dispute_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of invoices under dispute"
    - name: "dispute_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN dispute_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of freight invoices disputed"
    - name: "variance_rate"
      expr: ROUND(100.0 * SUM(CAST(variance_amount AS DOUBLE)) / NULLIF(SUM(CAST(total_invoiced_amount AS DOUBLE)), 0), 2)
      comment: "Variance as percentage of total invoiced amount"
    - name: "unique_carriers"
      expr: COUNT(DISTINCT carrier_id)
      comment: "Number of distinct carriers invoiced"
$$;


CREATE OR REPLACE VIEW `apparel_fashion_ecm`.`_metrics`.`logistics_customs_entry`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Customs clearance and duty analytics tracking entry processing, duty costs, holds, and compliance by port and trade program"
  source: "`apparel_fashion_ecm`.`logistics`.`customs_entry`"
  dimensions:
    - name: "clearance_status"
      expr: clearance_status
      comment: "Current customs clearance status (pending, cleared, held, released)"
    - name: "entry_type"
      expr: entry_type
      comment: "Type of customs entry (consumption, warehouse, FTZ)"
    - name: "port_of_entry"
      expr: port_of_entry_code
      comment: "Port code where goods entered the country"
    - name: "country_of_origin"
      expr: country_of_origin
      comment: "Country where goods were manufactured"
    - name: "transport_mode"
      expr: transport_mode
      comment: "Mode of transport for customs entry"
    - name: "bond_type"
      expr: bond_type
      comment: "Type of customs bond (single, continuous)"
    - name: "trade_program"
      expr: trade_program_code
      comment: "Trade program code (FTA, GSP, etc.)"
    - name: "exam_type"
      expr: exam_type
      comment: "Type of customs examination if applicable"
    - name: "protest_filed"
      expr: protest_filed_indicator
      comment: "Whether a protest was filed against customs decision"
    - name: "reconciliation_indicator"
      expr: reconciliation_indicator
      comment: "Whether entry is subject to reconciliation"
    - name: "filing_month"
      expr: DATE_TRUNC('MONTH', entry_filing_date)
      comment: "Month when customs entry was filed"
    - name: "release_month"
      expr: DATE_TRUNC('MONTH', release_date)
      comment: "Month when goods were released from customs"
  measures:
    - name: "total_entries"
      expr: COUNT(1)
      comment: "Total number of customs entries"
    - name: "total_duty_amount"
      expr: SUM(CAST(duty_amount_usd AS DOUBLE))
      comment: "Total customs duty paid in USD"
    - name: "total_merchandise_processing_fee"
      expr: SUM(CAST(merchandise_processing_fee_usd AS DOUBLE))
      comment: "Total merchandise processing fees paid"
    - name: "total_harbor_maintenance_fee"
      expr: SUM(CAST(harbor_maintenance_fee_usd AS DOUBLE))
      comment: "Total harbor maintenance fees paid"
    - name: "total_declared_value"
      expr: SUM(CAST(declared_value_usd AS DOUBLE))
      comment: "Total declared value of imported goods in USD"
    - name: "total_bond_amount"
      expr: SUM(CAST(bond_amount_usd AS DOUBLE))
      comment: "Total customs bond amounts posted"
    - name: "total_quantity"
      expr: SUM(CAST(total_quantity AS DOUBLE))
      comment: "Total quantity of goods entered"
    - name: "total_weight_kg"
      expr: SUM(CAST(total_weight_kg AS DOUBLE))
      comment: "Total weight of goods entered in kilograms"
    - name: "avg_duty_per_entry"
      expr: AVG(CAST(duty_amount_usd AS DOUBLE))
      comment: "Average duty amount per customs entry"
    - name: "avg_declared_value_per_entry"
      expr: AVG(CAST(declared_value_usd AS DOUBLE))
      comment: "Average declared value per customs entry"
    - name: "effective_duty_rate"
      expr: ROUND(100.0 * SUM(CAST(duty_amount_usd AS DOUBLE)) / NULLIF(SUM(CAST(declared_value_usd AS DOUBLE)), 0), 2)
      comment: "Effective duty rate as percentage of declared value"
    - name: "protest_filed_count"
      expr: SUM(CASE WHEN protest_filed_indicator = TRUE THEN 1 ELSE 0 END)
      comment: "Count of entries with protests filed"
    - name: "protest_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN protest_filed_indicator = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of customs entries with protests filed"
    - name: "unique_ports_of_entry"
      expr: COUNT(DISTINCT port_of_entry_code)
      comment: "Number of distinct ports of entry used"
    - name: "unique_countries_of_origin"
      expr: COUNT(DISTINCT country_of_origin)
      comment: "Number of distinct countries of origin"
$$;


CREATE OR REPLACE VIEW `apparel_fashion_ecm`.`_metrics`.`logistics_carrier`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Carrier performance and compliance metrics tracking on-time performance, damage rates, service coverage, and certification status"
  source: "`apparel_fashion_ecm`.`logistics`.`carrier`"
  dimensions:
    - name: "carrier_name"
      expr: carrier_name
      comment: "Name of the carrier"
    - name: "carrier_type"
      expr: carrier_type
      comment: "Type of carrier (ocean, air, ground, rail, parcel)"
    - name: "carrier_status"
      expr: carrier_status
      comment: "Current operational status of carrier"
    - name: "service_mode"
      expr: service_mode
      comment: "Primary service mode offered by carrier"
    - name: "geographic_coverage"
      expr: geographic_coverage
      comment: "Geographic coverage area (domestic, regional, global)"
    - name: "is_active"
      expr: is_active
      comment: "Whether carrier is currently active"
    - name: "edi_capable"
      expr: edi_capability_flag
      comment: "Whether carrier supports EDI integration"
    - name: "api_integrated"
      expr: api_integration_flag
      comment: "Whether carrier has API integration enabled"
    - name: "sustainability_certified"
      expr: sustainability_certification
      comment: "Sustainability certification held by carrier"
    - name: "headquarters_country"
      expr: headquarters_country_code
      comment: "Country code of carrier headquarters"
  measures:
    - name: "total_carriers"
      expr: COUNT(1)
      comment: "Total number of carriers in network"
    - name: "active_carrier_count"
      expr: SUM(CASE WHEN is_active = TRUE THEN 1 ELSE 0 END)
      comment: "Count of active carriers"
    - name: "avg_on_time_performance_score"
      expr: AVG(CAST(on_time_performance_score AS DOUBLE))
      comment: "Average on-time performance score across carriers"
    - name: "avg_otif_score"
      expr: AVG(CAST(otif_score AS DOUBLE))
      comment: "Average On-Time In-Full score across carriers"
    - name: "avg_damage_claim_rate"
      expr: AVG(CAST(damage_claim_rate AS DOUBLE))
      comment: "Average damage claim rate across carriers"
    - name: "total_insurance_coverage"
      expr: SUM(CAST(insurance_coverage_amount AS DOUBLE))
      comment: "Total insurance coverage amount across all carriers"
    - name: "edi_capable_carrier_count"
      expr: SUM(CASE WHEN edi_capability_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of carriers with EDI capability"
    - name: "api_integrated_carrier_count"
      expr: SUM(CASE WHEN api_integration_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of carriers with API integration"
    - name: "edi_capability_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN edi_capability_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of carriers with EDI capability"
    - name: "unique_geographic_coverage_areas"
      expr: COUNT(DISTINCT geographic_coverage)
      comment: "Number of distinct geographic coverage areas"
    - name: "unique_service_modes"
      expr: COUNT(DISTINCT service_mode)
      comment: "Number of distinct service modes offered"
$$;


CREATE OR REPLACE VIEW `apparel_fashion_ecm`.`_metrics`.`logistics_distribution_center`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Distribution center capacity and capability metrics tracking storage capacity, automation level, channel support, and operational status"
  source: "`apparel_fashion_ecm`.`logistics`.`distribution_center`"
  dimensions:
    - name: "facility_name"
      expr: facility_name
      comment: "Name of the distribution center facility"
    - name: "facility_type"
      expr: facility_type
      comment: "Type of distribution facility (DC, fulfillment center, cross-dock)"
    - name: "operational_status"
      expr: operational_status
      comment: "Current operational status (active, inactive, under construction)"
    - name: "country"
      expr: country_code
      comment: "Country code where facility is located"
    - name: "state_province"
      expr: state_province
      comment: "State or province of facility location"
    - name: "automation_level"
      expr: automation_level
      comment: "Level of automation (manual, semi-automated, fully-automated)"
    - name: "supports_dtc"
      expr: supports_dtc_channel
      comment: "Whether facility supports direct-to-consumer fulfillment"
    - name: "supports_retail"
      expr: supports_retail_replenishment_channel
      comment: "Whether facility supports retail store replenishment"
    - name: "supports_wholesale"
      expr: supports_wholesale_channel
      comment: "Whether facility supports wholesale distribution"
    - name: "supports_outlet"
      expr: supports_outlet_channel
      comment: "Whether facility supports outlet channel"
    - name: "rfid_enabled"
      expr: rfid_enabled_flag
      comment: "Whether facility has RFID tracking enabled"
    - name: "customs_bonded"
      expr: customs_bonded_warehouse_flag
      comment: "Whether facility is a customs bonded warehouse"
    - name: "sustainability_certification"
      expr: sustainability_certification
      comment: "Sustainability certification held by facility"
  measures:
    - name: "total_facilities"
      expr: COUNT(1)
      comment: "Total number of distribution center facilities"
    - name: "total_square_footage"
      expr: SUM(CAST(total_square_footage AS DOUBLE))
      comment: "Total square footage across all distribution centers"
    - name: "total_bulk_storage_capacity"
      expr: SUM(CAST(bulk_storage_capacity_sqft AS DOUBLE))
      comment: "Total bulk storage capacity in square feet"
    - name: "total_cold_storage_capacity"
      expr: SUM(CAST(cold_storage_capacity_sqft AS DOUBLE))
      comment: "Total cold storage capacity in square feet"
    - name: "total_hanging_storage_capacity"
      expr: SUM(CAST(hanging_storage_capacity_sqft AS DOUBLE))
      comment: "Total hanging garment storage capacity in square feet"
    - name: "total_pick_zone_capacity"
      expr: SUM(CAST(pick_zone_capacity_sqft AS DOUBLE))
      comment: "Total pick zone capacity in square feet"
    - name: "avg_facility_size"
      expr: AVG(CAST(total_square_footage AS DOUBLE))
      comment: "Average facility size in square feet"
    - name: "dtc_capable_facility_count"
      expr: SUM(CASE WHEN supports_dtc_channel = TRUE THEN 1 ELSE 0 END)
      comment: "Count of facilities supporting direct-to-consumer channel"
    - name: "retail_capable_facility_count"
      expr: SUM(CASE WHEN supports_retail_replenishment_channel = TRUE THEN 1 ELSE 0 END)
      comment: "Count of facilities supporting retail replenishment"
    - name: "wholesale_capable_facility_count"
      expr: SUM(CASE WHEN supports_wholesale_channel = TRUE THEN 1 ELSE 0 END)
      comment: "Count of facilities supporting wholesale distribution"
    - name: "rfid_enabled_facility_count"
      expr: SUM(CASE WHEN rfid_enabled_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of facilities with RFID tracking enabled"
    - name: "customs_bonded_facility_count"
      expr: SUM(CASE WHEN customs_bonded_warehouse_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of customs bonded warehouse facilities"
    - name: "rfid_penetration_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN rfid_enabled_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of facilities with RFID enabled"
    - name: "unique_countries"
      expr: COUNT(DISTINCT country_code)
      comment: "Number of distinct countries with distribution centers"
$$;


CREATE OR REPLACE VIEW `apparel_fashion_ecm`.`_metrics`.`logistics_duty_calculation`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Landed cost and duty calculation analytics tracking duty amounts, trade agreement utilization, variances, and reconciliation status"
  source: "`apparel_fashion_ecm`.`logistics`.`duty_calculation`"
  dimensions:
    - name: "calculation_status"
      expr: calculation_status
      comment: "Status of duty calculation (draft, submitted, approved, reconciled)"
    - name: "reconciliation_status"
      expr: reconciliation_status
      comment: "Reconciliation status of duty calculation"
    - name: "country_of_origin"
      expr: country_of_origin
      comment: "Country where goods originated"
    - name: "destination_country"
      expr: destination_country
      comment: "Destination country for duty calculation"
    - name: "port_of_entry"
      expr: port_of_entry
      comment: "Port where goods entered destination country"
    - name: "fta_claimed"
      expr: fta_claimed_flag
      comment: "Whether Free Trade Agreement benefit was claimed"
    - name: "fta_name"
      expr: fta_name
      comment: "Name of Free Trade Agreement claimed"
    - name: "gsp_claimed"
      expr: gsp_claimed_flag
      comment: "Whether Generalized System of Preferences benefit was claimed"
    - name: "variance_reason"
      expr: variance_reason
      comment: "Reason for variance between estimated and actual duty"
    - name: "calculation_month"
      expr: DATE_TRUNC('MONTH', calculation_timestamp)
      comment: "Month when duty calculation was performed"
    - name: "payment_month"
      expr: DATE_TRUNC('MONTH', payment_date)
      comment: "Month when duty payment was made"
  measures:
    - name: "total_calculations"
      expr: COUNT(1)
      comment: "Total number of duty calculations"
    - name: "total_base_duty"
      expr: SUM(CAST(base_duty_amount AS DOUBLE))
      comment: "Total base duty amount before reductions"
    - name: "total_duty_amount"
      expr: SUM(CAST(total_duty_amount AS DOUBLE))
      comment: "Total duty amount after all adjustments"
    - name: "total_anti_dumping_duty"
      expr: SUM(CAST(anti_dumping_duty_amount AS DOUBLE))
      comment: "Total anti-dumping duty assessed"
    - name: "total_countervailing_duty"
      expr: SUM(CAST(countervailing_duty_amount AS DOUBLE))
      comment: "Total countervailing duty assessed"
    - name: "total_fta_reduction"
      expr: SUM(CAST(fta_reduction_amount AS DOUBLE))
      comment: "Total duty reduction from Free Trade Agreements"
    - name: "total_gsp_reduction"
      expr: SUM(CAST(gsp_reduction_amount AS DOUBLE))
      comment: "Total duty reduction from Generalized System of Preferences"
    - name: "total_mpf_amount"
      expr: SUM(CAST(mpf_amount AS DOUBLE))
      comment: "Total merchandise processing fees"
    - name: "total_hmf_amount"
      expr: SUM(CAST(hmf_amount AS DOUBLE))
      comment: "Total harbor maintenance fees"
    - name: "total_vat_amount"
      expr: SUM(CAST(vat_amount AS DOUBLE))
      comment: "Total value-added tax amounts"
    - name: "total_ldp_amount"
      expr: SUM(CAST(ldp_total_amount AS DOUBLE))
      comment: "Total landed duty paid amounts"
    - name: "total_fob_value"
      expr: SUM(CAST(fob_value AS DOUBLE))
      comment: "Total free-on-board value of goods"
    - name: "total_cif_value"
      expr: SUM(CAST(cif_value AS DOUBLE))
      comment: "Total cost-insurance-freight value of goods"
    - name: "total_variance_amount"
      expr: SUM(CAST(variance_amount AS DOUBLE))
      comment: "Total variance between estimated and actual duty"
    - name: "avg_duty_per_calculation"
      expr: AVG(CAST(total_duty_amount AS DOUBLE))
      comment: "Average duty amount per calculation"
    - name: "effective_duty_rate"
      expr: ROUND(100.0 * SUM(CAST(total_duty_amount AS DOUBLE)) / NULLIF(SUM(CAST(cif_value AS DOUBLE)), 0), 2)
      comment: "Effective duty rate as percentage of CIF value"
    - name: "fta_utilization_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN fta_claimed_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of calculations claiming FTA benefits"
    - name: "gsp_utilization_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN gsp_claimed_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of calculations claiming GSP benefits"
    - name: "fta_savings_rate"
      expr: ROUND(100.0 * SUM(CAST(fta_reduction_amount AS DOUBLE)) / NULLIF(SUM(CAST(base_duty_amount AS DOUBLE)), 0), 2)
      comment: "FTA savings as percentage of base duty"
    - name: "unique_origin_countries"
      expr: COUNT(DISTINCT country_of_origin)
      comment: "Number of distinct countries of origin"
    - name: "unique_destination_countries"
      expr: COUNT(DISTINCT destination_country)
      comment: "Number of distinct destination countries"
$$;


CREATE OR REPLACE VIEW `apparel_fashion_ecm`.`_metrics`.`logistics_return_shipment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Returns logistics and disposition analytics tracking return reasons, restocking eligibility, freight costs, and disposition outcomes"
  source: "`apparel_fashion_ecm`.`logistics`.`shipment`"
  dimensions:
    - name: "shipment_status"
      expr: shipment_status
      comment: "Current status of return shipment"
    - name: "origin_country"
      expr: origin_country_code
      comment: "Country code where return originated"
    - name: "destination_country"
      expr: destination_country_code
      comment: "Country code of return destination facility"
    - name: "priority_return"
      expr: priority_flag
      comment: "Whether return is flagged as priority"
  measures:
    - name: "total_returns"
      expr: COUNT(1)
      comment: "Total number of return shipments"
    - name: "total_duty_amount"
      expr: SUM(CAST(duty_amount AS DOUBLE))
      comment: "Total duty amounts on return shipments"
    - name: "total_cubic_volume_m3"
      expr: SUM(CAST(cubic_volume_m3 AS DOUBLE))
      comment: "Total cubic volume of returns in cubic meters"
    - name: "total_gross_weight_kg"
      expr: SUM(CAST(gross_weight_kg AS DOUBLE))
      comment: "Total gross weight of returns in kilograms"
    - name: "priority_return_count"
      expr: SUM(CASE WHEN priority_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of priority returns"
$$;
