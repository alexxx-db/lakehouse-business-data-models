-- Metric views for domain: supply | Business: Pharmaceuticals | Version: 1 | Generated on: 2026-05-05 17:46:18

CREATE OR REPLACE VIEW `pharmaceuticals_ecm`.`_metrics`.`supply_inventory_lot`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core inventory metrics tracking stock levels, valuation, expiry risk, and quality holds across pharmaceutical lots with GDP compliance and cold chain monitoring"
  source: "`pharmaceuticals_ecm`.`supply`.`inventory_lot`"
  dimensions:
    - name: "lot_number"
      expr: lot_number
      comment: "Unique manufacturing lot identifier for traceability"
    - name: "lot_status"
      expr: lot_status
      comment: "Current status of the lot (available, quarantined, released, expired)"
    - name: "material_type"
      expr: material_type
      comment: "Classification of material (finished good, API, excipient, packaging)"
    - name: "storage_condition"
      expr: storage_condition
      comment: "Required storage conditions (refrigerated, frozen, controlled room temperature)"
    - name: "site_code"
      expr: site_code
      comment: "Manufacturing or storage site identifier"
    - name: "is_clinical_supply"
      expr: is_clinical_supply
      comment: "Flag indicating if lot is designated for clinical trials"
    - name: "is_controlled_substance"
      expr: is_controlled_substance
      comment: "Flag indicating DEA controlled substance status"
    - name: "dea_schedule"
      expr: dea_schedule
      comment: "DEA schedule classification (I-V) for controlled substances"
    - name: "is_gdp_compliant"
      expr: is_gdp_compliant
      comment: "Flag indicating Good Distribution Practice compliance status"
    - name: "temperature_excursion_flag"
      expr: temperature_excursion_flag
      comment: "Flag indicating if lot experienced cold chain temperature excursion"
    - name: "valuation_type"
      expr: valuation_type
      comment: "Inventory valuation method (standard cost, moving average, FIFO)"
    - name: "expiry_year"
      expr: YEAR(expiry_date)
      comment: "Year of lot expiration for aging analysis"
    - name: "expiry_month"
      expr: DATE_TRUNC('MONTH', expiry_date)
      comment: "Month of lot expiration for short-term planning"
    - name: "receipt_year"
      expr: YEAR(receipt_date)
      comment: "Year lot was received into inventory"
    - name: "manufacture_year"
      expr: YEAR(manufacture_date)
      comment: "Year of lot manufacture"
  measures:
    - name: "total_quantity_on_hand"
      expr: SUM(CAST(quantity_on_hand AS DOUBLE))
      comment: "Total physical inventory quantity across all lots"
    - name: "total_quantity_available"
      expr: SUM(CAST(quantity_available AS DOUBLE))
      comment: "Total unreserved, saleable inventory quantity"
    - name: "total_quantity_reserved"
      expr: SUM(CAST(quantity_reserved AS DOUBLE))
      comment: "Total quantity allocated to orders but not yet shipped"
    - name: "total_quantity_on_quality_hold"
      expr: SUM(CAST(quantity_on_quality_hold AS DOUBLE))
      comment: "Total quantity quarantined pending quality release decision"
    - name: "total_inventory_value"
      expr: SUM(CAST(quantity_on_hand AS DOUBLE) * CAST(unit_cost AS DOUBLE))
      comment: "Total monetary value of inventory at standard cost"
    - name: "total_available_inventory_value"
      expr: SUM(CAST(quantity_available AS DOUBLE) * CAST(unit_cost AS DOUBLE))
      comment: "Total monetary value of saleable inventory"
    - name: "avg_unit_cost"
      expr: AVG(CAST(unit_cost AS DOUBLE))
      comment: "Average unit cost across inventory lots"
    - name: "distinct_lot_count"
      expr: COUNT(DISTINCT lot_number)
      comment: "Number of unique lots in inventory"
    - name: "lots_with_temperature_excursion"
      expr: COUNT(DISTINCT CASE WHEN temperature_excursion_flag = TRUE THEN lot_number END)
      comment: "Count of lots that experienced cold chain breaks"
    - name: "lots_on_quality_hold"
      expr: COUNT(DISTINCT CASE WHEN CAST(quantity_on_quality_hold AS DOUBLE) > 0 THEN lot_number END)
      comment: "Count of lots with any quantity under quality hold"
    - name: "controlled_substance_lot_count"
      expr: COUNT(DISTINCT CASE WHEN is_controlled_substance = TRUE THEN lot_number END)
      comment: "Count of DEA controlled substance lots requiring enhanced security"
    - name: "clinical_supply_lot_count"
      expr: COUNT(DISTINCT CASE WHEN is_clinical_supply = TRUE THEN lot_number END)
      comment: "Count of lots designated for clinical trial use"
    - name: "non_gdp_compliant_lot_count"
      expr: COUNT(DISTINCT CASE WHEN is_gdp_compliant = FALSE THEN lot_number END)
      comment: "Count of lots failing Good Distribution Practice standards"
$$;


CREATE OR REPLACE VIEW `pharmaceuticals_ecm`.`_metrics`.`supply_shipment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Shipment performance metrics tracking on-time delivery, GDP compliance, cold chain integrity, and cross-border logistics for pharmaceutical distribution"
  source: "`pharmaceuticals_ecm`.`supply`.`shipment`"
  dimensions:
    - name: "shipment_status"
      expr: shipment_status
      comment: "Current status of shipment (planned, in-transit, delivered, delayed, cancelled)"
    - name: "destination_country_code"
      expr: destination_country_code
      comment: "ISO country code of shipment destination"
    - name: "origin_country_code"
      expr: origin_country_code
      comment: "ISO country code of shipment origin"
    - name: "transport_mode"
      expr: transport_mode
      comment: "Mode of transportation (air, ground, ocean, courier)"
    - name: "cold_chain_required"
      expr: cold_chain_required
      comment: "Flag indicating if shipment requires temperature-controlled logistics"
    - name: "controlled_substance_flag"
      expr: controlled_substance_flag
      comment: "Flag indicating if shipment contains DEA controlled substances"
    - name: "hazardous_goods_flag"
      expr: hazardous_goods_flag
      comment: "Flag indicating if shipment contains hazardous materials"
    - name: "gdp_compliance_status"
      expr: gdp_compliance_status
      comment: "Good Distribution Practice compliance status (compliant, non-compliant, pending)"
    - name: "customs_required"
      expr: customs_required
      comment: "Flag indicating if shipment requires customs clearance"
    - name: "serialization_verified"
      expr: serialization_verified
      comment: "Flag indicating if product serialization was verified at shipment"
    - name: "destination_location_type"
      expr: destination_location_type
      comment: "Type of destination (hospital, pharmacy, distributor, depot)"
    - name: "origin_location_type"
      expr: origin_location_type
      comment: "Type of origin location (manufacturing site, warehouse, depot)"
    - name: "shipment_year"
      expr: YEAR(shipment_date)
      comment: "Year of shipment for trend analysis"
    - name: "shipment_month"
      expr: DATE_TRUNC('MONTH', shipment_date)
      comment: "Month of shipment for seasonality analysis"
    - name: "delivery_year"
      expr: YEAR(actual_delivery_date)
      comment: "Year of actual delivery"
  measures:
    - name: "total_shipments"
      expr: COUNT(1)
      comment: "Total number of shipments"
    - name: "total_shipped_quantity"
      expr: SUM(CAST(shipped_quantity AS DOUBLE))
      comment: "Total quantity shipped across all shipments"
    - name: "total_gross_weight_kg"
      expr: SUM(CAST(gross_weight_kg AS DOUBLE))
      comment: "Total gross weight of all shipments in kilograms"
    - name: "total_volume_m3"
      expr: SUM(CAST(volume_m3 AS DOUBLE))
      comment: "Total volume of all shipments in cubic meters"
    - name: "avg_shipped_quantity"
      expr: AVG(CAST(shipped_quantity AS DOUBLE))
      comment: "Average quantity per shipment"
    - name: "on_time_shipments"
      expr: COUNT(CASE WHEN actual_delivery_date <= estimated_delivery_date THEN 1 END)
      comment: "Count of shipments delivered on or before estimated delivery date"
    - name: "delayed_shipments"
      expr: COUNT(CASE WHEN actual_delivery_date > estimated_delivery_date THEN 1 END)
      comment: "Count of shipments delivered after estimated delivery date"
    - name: "cold_chain_shipments"
      expr: COUNT(CASE WHEN cold_chain_required = TRUE THEN 1 END)
      comment: "Count of shipments requiring temperature-controlled logistics"
    - name: "controlled_substance_shipments"
      expr: COUNT(CASE WHEN controlled_substance_flag = TRUE THEN 1 END)
      comment: "Count of shipments containing DEA controlled substances"
    - name: "cross_border_shipments"
      expr: COUNT(CASE WHEN origin_country_code != destination_country_code THEN 1 END)
      comment: "Count of international shipments crossing country borders"
    - name: "customs_required_shipments"
      expr: COUNT(CASE WHEN customs_required = TRUE THEN 1 END)
      comment: "Count of shipments requiring customs clearance"
    - name: "gdp_compliant_shipments"
      expr: COUNT(CASE WHEN gdp_compliance_status = 'compliant' THEN 1 END)
      comment: "Count of shipments meeting Good Distribution Practice standards"
    - name: "serialization_verified_shipments"
      expr: COUNT(CASE WHEN serialization_verified = TRUE THEN 1 END)
      comment: "Count of shipments with verified product serialization"
    - name: "hazmat_shipments"
      expr: COUNT(CASE WHEN hazardous_goods_flag = TRUE THEN 1 END)
      comment: "Count of shipments containing hazardous materials"
$$;


CREATE OR REPLACE VIEW `pharmaceuticals_ecm`.`_metrics`.`supply_product_recall`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Product recall effectiveness metrics tracking recovery rates, regulatory compliance, and patient safety response across pharmaceutical recalls"
  source: "`pharmaceuticals_ecm`.`supply`.`product_recall`"
  dimensions:
    - name: "recall_status"
      expr: recall_status
      comment: "Current status of recall (initiated, ongoing, completed, closed)"
    - name: "recall_class"
      expr: recall_class
      comment: "FDA recall classification (Class I, II, III) indicating health hazard severity"
    - name: "recall_type"
      expr: recall_type
      comment: "Type of recall (voluntary, mandatory, market withdrawal)"
    - name: "recall_scope"
      expr: recall_scope
      comment: "Geographic scope of recall (local, national, international)"
    - name: "recall_reason_code"
      expr: recall_reason_code
      comment: "Coded reason for recall (contamination, labeling, potency, etc.)"
    - name: "health_hazard_assessment"
      expr: health_hazard_assessment
      comment: "Assessment of potential health impact (serious, moderate, low)"
    - name: "distribution_level"
      expr: distribution_level
      comment: "Distribution level reached (consumer, retail, wholesale)"
    - name: "product_disposition"
      expr: product_disposition
      comment: "Disposition decision for recalled product (destroy, rework, return)"
    - name: "effectiveness_check_level"
      expr: effectiveness_check_level
      comment: "Level of effectiveness checking required (A, B, C, D)"
    - name: "cold_chain_required"
      expr: cold_chain_required
      comment: "Flag indicating if recalled product required cold chain"
    - name: "gdp_compliance_flag"
      expr: gdp_compliance_flag
      comment: "Flag indicating if recall followed GDP guidelines"
    - name: "customer_notification_status"
      expr: customer_notification_status
      comment: "Status of customer notification process"
    - name: "recall_year"
      expr: YEAR(recall_initiated_date)
      comment: "Year recall was initiated"
    - name: "recall_month"
      expr: DATE_TRUNC('MONTH', recall_initiated_date)
      comment: "Month recall was initiated"
  measures:
    - name: "total_recalls"
      expr: COUNT(1)
      comment: "Total number of product recalls"
    - name: "total_quantity_distributed"
      expr: SUM(CAST(quantity_distributed AS DOUBLE))
      comment: "Total quantity of product distributed before recall"
    - name: "total_quantity_recovered"
      expr: SUM(CAST(quantity_recovered AS DOUBLE))
      comment: "Total quantity of product successfully recovered"
    - name: "avg_recall_effectiveness_pct"
      expr: AVG(CAST(recall_effectiveness_pct AS DOUBLE))
      comment: "Average recall effectiveness percentage across all recalls"
    - name: "class_i_recalls"
      expr: COUNT(CASE WHEN recall_class = 'Class I' THEN 1 END)
      comment: "Count of Class I recalls (serious health hazard or death)"
    - name: "class_ii_recalls"
      expr: COUNT(CASE WHEN recall_class = 'Class II' THEN 1 END)
      comment: "Count of Class II recalls (temporary or medically reversible health consequences)"
    - name: "class_iii_recalls"
      expr: COUNT(CASE WHEN recall_class = 'Class III' THEN 1 END)
      comment: "Count of Class III recalls (unlikely to cause adverse health consequences)"
    - name: "mandatory_recalls"
      expr: COUNT(CASE WHEN recall_type = 'mandatory' THEN 1 END)
      comment: "Count of recalls mandated by regulatory authority"
    - name: "voluntary_recalls"
      expr: COUNT(CASE WHEN recall_type = 'voluntary' THEN 1 END)
      comment: "Count of voluntary recalls initiated by manufacturer"
    - name: "closed_recalls"
      expr: COUNT(CASE WHEN recall_status = 'closed' THEN 1 END)
      comment: "Count of recalls that have been closed by regulatory authority"
    - name: "international_recalls"
      expr: COUNT(CASE WHEN recall_scope = 'international' THEN 1 END)
      comment: "Count of recalls spanning multiple countries"
    - name: "gdp_compliant_recalls"
      expr: COUNT(CASE WHEN gdp_compliance_flag = TRUE THEN 1 END)
      comment: "Count of recalls executed following Good Distribution Practice guidelines"
$$;


CREATE OR REPLACE VIEW `pharmaceuticals_ecm`.`_metrics`.`supply_cold_chain_record`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Cold chain monitoring metrics tracking temperature excursions, GDP compliance, and product disposition decisions for temperature-sensitive pharmaceuticals"
  source: "`pharmaceuticals_ecm`.`supply`.`cold_chain_record`"
  dimensions:
    - name: "excursion_flag"
      expr: excursion_flag
      comment: "Flag indicating if temperature excursion occurred"
    - name: "excursion_severity"
      expr: excursion_severity
      comment: "Severity classification of temperature excursion (minor, moderate, major, critical)"
    - name: "disposition_status"
      expr: disposition_status
      comment: "Disposition decision status (pending, approved for use, rejected, destroyed)"
    - name: "regulatory_reportable"
      expr: regulatory_reportable
      comment: "Flag indicating if excursion requires regulatory reporting"
    - name: "gdp_compliance_status"
      expr: gdp_compliance_status
      comment: "Good Distribution Practice compliance status for cold chain event"
    - name: "location_type"
      expr: location_type
      comment: "Type of location where monitoring occurred (warehouse, in-transit, site)"
    - name: "supply_chain_segment"
      expr: supply_chain_segment
      comment: "Supply chain segment (inbound, storage, outbound, last-mile)"
    - name: "device_type"
      expr: device_type
      comment: "Type of monitoring device (data logger, probe, continuous monitor)"
    - name: "storage_zone"
      expr: storage_zone
      comment: "Storage zone identifier within facility"
    - name: "carrier_name"
      expr: carrier_name
      comment: "Name of logistics carrier for in-transit monitoring"
    - name: "monitoring_year"
      expr: YEAR(reading_timestamp)
      comment: "Year of temperature reading"
    - name: "monitoring_month"
      expr: DATE_TRUNC('MONTH', reading_timestamp)
      comment: "Month of temperature reading"
  measures:
    - name: "total_monitoring_events"
      expr: COUNT(1)
      comment: "Total number of cold chain monitoring events recorded"
    - name: "total_excursion_events"
      expr: COUNT(CASE WHEN excursion_flag = TRUE THEN 1 END)
      comment: "Total number of temperature excursion events"
    - name: "critical_excursions"
      expr: COUNT(CASE WHEN excursion_severity = 'critical' THEN 1 END)
      comment: "Count of critical temperature excursions requiring immediate action"
    - name: "major_excursions"
      expr: COUNT(CASE WHEN excursion_severity = 'major' THEN 1 END)
      comment: "Count of major temperature excursions with significant risk"
    - name: "regulatory_reportable_excursions"
      expr: COUNT(CASE WHEN regulatory_reportable = TRUE THEN 1 END)
      comment: "Count of excursions requiring regulatory authority notification"
    - name: "product_rejected_events"
      expr: COUNT(CASE WHEN disposition_status = 'rejected' THEN 1 END)
      comment: "Count of events resulting in product rejection"
    - name: "gdp_non_compliant_events"
      expr: COUNT(CASE WHEN gdp_compliance_status = 'non-compliant' THEN 1 END)
      comment: "Count of events failing Good Distribution Practice standards"
    - name: "avg_temperature_reading_c"
      expr: AVG(CAST(temperature_reading_c AS DOUBLE))
      comment: "Average temperature reading in Celsius across all monitoring events"
    - name: "avg_humidity_reading_pct"
      expr: AVG(CAST(humidity_reading_pct AS DOUBLE))
      comment: "Average humidity reading percentage across monitoring events"
    - name: "distinct_monitoring_devices"
      expr: COUNT(DISTINCT monitoring_device_code)
      comment: "Number of unique monitoring devices in use"
    - name: "distinct_locations_monitored"
      expr: COUNT(DISTINCT location_code)
      comment: "Number of unique locations with cold chain monitoring"
$$;


CREATE OR REPLACE VIEW `pharmaceuticals_ecm`.`_metrics`.`supply_demand_plan`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Demand planning accuracy and forecast performance metrics for pharmaceutical supply chain planning and inventory optimization"
  source: "`pharmaceuticals_ecm`.`supply`.`demand_plan`"
  dimensions:
    - name: "plan_status"
      expr: plan_status
      comment: "Current status of demand plan (draft, approved, active, superseded)"
    - name: "planning_cycle"
      expr: planning_cycle
      comment: "Planning cycle identifier (monthly, quarterly, annual)"
    - name: "forecast_granularity"
      expr: forecast_granularity
      comment: "Granularity level of forecast (SKU, product family, therapeutic area)"
    - name: "demand_classification"
      expr: demand_classification
      comment: "Demand pattern classification (stable, seasonal, volatile, new product)"
    - name: "demand_signal_source"
      expr: demand_signal_source
      comment: "Source of demand signal (sales history, market research, clinical trial)"
    - name: "statistical_model_type"
      expr: statistical_model_type
      comment: "Statistical forecasting model used (time series, regression, ML)"
    - name: "therapeutic_area"
      expr: therapeutic_area
      comment: "Therapeutic area of planned product"
    - name: "distribution_channel"
      expr: distribution_channel
      comment: "Distribution channel for demand (retail, hospital, specialty)"
    - name: "cold_chain_required"
      expr: cold_chain_required
      comment: "Flag indicating if product requires cold chain distribution"
    - name: "supply_chain_tier"
      expr: supply_chain_tier
      comment: "Supply chain tier classification (tier 1, tier 2, tier 3)"
    - name: "planning_year"
      expr: YEAR(forecast_period_date)
      comment: "Year of forecast period"
    - name: "planning_month"
      expr: DATE_TRUNC('MONTH', forecast_period_date)
      comment: "Month of forecast period"
  measures:
    - name: "total_baseline_forecast_qty"
      expr: SUM(CAST(baseline_forecast_qty AS DOUBLE))
      comment: "Total baseline forecast quantity before adjustments"
    - name: "total_adjusted_forecast_qty"
      expr: SUM(CAST(adjusted_forecast_qty AS DOUBLE))
      comment: "Total adjusted forecast quantity after planner overrides"
    - name: "total_consensus_forecast_qty"
      expr: SUM(CAST(consensus_forecast_qty AS DOUBLE))
      comment: "Total consensus forecast quantity approved by cross-functional team"
    - name: "total_safety_stock_qty"
      expr: SUM(CAST(safety_stock_qty AS DOUBLE))
      comment: "Total safety stock quantity planned across all SKUs"
    - name: "total_reorder_point_qty"
      expr: SUM(CAST(reorder_point_qty AS DOUBLE))
      comment: "Total reorder point quantity triggering replenishment"
    - name: "avg_forecast_accuracy_pct"
      expr: AVG(CAST(forecast_accuracy_pct AS DOUBLE))
      comment: "Average forecast accuracy percentage across planning periods"
    - name: "avg_forecast_bias"
      expr: AVG(CAST(forecast_bias AS DOUBLE))
      comment: "Average forecast bias indicating systematic over or under forecasting"
    - name: "distinct_planned_skus"
      expr: COUNT(DISTINCT plan_number)
      comment: "Number of unique demand plans"
    - name: "cold_chain_plans"
      expr: COUNT(CASE WHEN cold_chain_required = TRUE THEN 1 END)
      comment: "Count of demand plans for cold chain products"
    - name: "approved_plans"
      expr: COUNT(CASE WHEN plan_status = 'approved' THEN 1 END)
      comment: "Count of demand plans approved for execution"
$$;


CREATE OR REPLACE VIEW `pharmaceuticals_ecm`.`_metrics`.`supply_clinical_supply_order`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Clinical trial supply chain metrics tracking order fulfillment, blinding compliance, and investigational product distribution for clinical studies"
  source: "`pharmaceuticals_ecm`.`supply`.`clinical_supply_order`"
  dimensions:
    - name: "order_status"
      expr: order_status
      comment: "Current status of clinical supply order (pending, approved, shipped, delivered, cancelled)"
    - name: "order_type"
      expr: order_type
      comment: "Type of clinical supply order (initial, resupply, emergency, return)"
    - name: "priority_level"
      expr: priority_level
      comment: "Priority level of order (routine, urgent, emergency)"
    - name: "blinding_type"
      expr: blinding_type
      comment: "Blinding method for clinical trial (open-label, single-blind, double-blind)"
    - name: "is_blinded"
      expr: is_blinded
      comment: "Flag indicating if investigational product is blinded"
    - name: "qualified_person_release"
      expr: qualified_person_release
      comment: "Flag indicating if Qualified Person released product for clinical use"
    - name: "cold_chain_required"
      expr: cold_chain_required
      comment: "Flag indicating if order requires temperature-controlled logistics"
    - name: "destination_country_code"
      expr: destination_country_code
      comment: "ISO country code of investigational site destination"
    - name: "shipping_country_code"
      expr: shipping_country_code
      comment: "ISO country code of shipping origin"
    - name: "protocol_number"
      expr: protocol_number
      comment: "Clinical trial protocol number"
    - name: "order_year"
      expr: YEAR(order_date)
      comment: "Year order was placed"
    - name: "order_month"
      expr: DATE_TRUNC('MONTH', order_date)
      comment: "Month order was placed"
  measures:
    - name: "total_clinical_orders"
      expr: COUNT(1)
      comment: "Total number of clinical supply orders"
    - name: "total_ordered_quantity"
      expr: SUM(CAST(ordered_quantity AS DOUBLE))
      comment: "Total quantity ordered across all clinical supply orders"
    - name: "total_approved_quantity"
      expr: SUM(CAST(approved_quantity AS DOUBLE))
      comment: "Total quantity approved for shipment"
    - name: "total_shipped_quantity"
      expr: SUM(CAST(shipped_quantity AS DOUBLE))
      comment: "Total quantity shipped to investigational sites"
    - name: "avg_ordered_quantity"
      expr: AVG(CAST(ordered_quantity AS DOUBLE))
      comment: "Average quantity per clinical supply order"
    - name: "on_time_deliveries"
      expr: COUNT(CASE WHEN actual_delivery_date <= required_delivery_date THEN 1 END)
      comment: "Count of orders delivered on or before required delivery date"
    - name: "delayed_deliveries"
      expr: COUNT(CASE WHEN actual_delivery_date > required_delivery_date THEN 1 END)
      comment: "Count of orders delivered after required delivery date"
    - name: "emergency_orders"
      expr: COUNT(CASE WHEN priority_level = 'emergency' THEN 1 END)
      comment: "Count of emergency clinical supply orders"
    - name: "blinded_orders"
      expr: COUNT(CASE WHEN is_blinded = TRUE THEN 1 END)
      comment: "Count of orders containing blinded investigational product"
    - name: "qp_released_orders"
      expr: COUNT(CASE WHEN qualified_person_release = TRUE THEN 1 END)
      comment: "Count of orders released by Qualified Person"
    - name: "cold_chain_orders"
      expr: COUNT(CASE WHEN cold_chain_required = TRUE THEN 1 END)
      comment: "Count of orders requiring temperature-controlled logistics"
    - name: "cancelled_orders"
      expr: COUNT(CASE WHEN order_status = 'cancelled' THEN 1 END)
      comment: "Count of cancelled clinical supply orders"
    - name: "distinct_protocols"
      expr: COUNT(DISTINCT protocol_number)
      comment: "Number of unique clinical trial protocols served"
    - name: "distinct_destination_countries"
      expr: COUNT(DISTINCT destination_country_code)
      comment: "Number of unique destination countries for clinical supply"
$$;


CREATE OR REPLACE VIEW `pharmaceuticals_ecm`.`_metrics`.`supply_serialization_record`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Product serialization and track-and-trace metrics for pharmaceutical supply chain security, anti-counterfeiting, and regulatory compliance"
  source: "`pharmaceuticals_ecm`.`supply`.`serialization_record`"
  dimensions:
    - name: "serialization_status"
      expr: serialization_status
      comment: "Current status of serialized unit (commissioned, in-transit, dispensed, decommissioned)"
    - name: "verification_status"
      expr: verification_status
      comment: "Verification status of serial number (verified, unverified, suspect, counterfeit)"
    - name: "packaging_level"
      expr: packaging_level
      comment: "Packaging hierarchy level (unit, case, pallet)"
    - name: "supply_chain_type"
      expr: supply_chain_type
      comment: "Type of supply chain (commercial, clinical, compassionate use)"
    - name: "market_country_code"
      expr: market_country_code
      comment: "ISO country code of target market"
    - name: "regulatory_market_code"
      expr: regulatory_market_code
      comment: "Regulatory market code for serialization compliance"
    - name: "cold_chain_required"
      expr: cold_chain_required
      comment: "Flag indicating if serialized product requires cold chain"
    - name: "recall_flag"
      expr: recall_flag
      comment: "Flag indicating if serialized unit is subject to recall"
    - name: "saleable_return_flag"
      expr: saleable_return_flag
      comment: "Flag indicating if returned unit is saleable"
    - name: "gdp_compliance_flag"
      expr: gdp_compliance_flag
      comment: "Flag indicating Good Distribution Practice compliance"
    - name: "transaction_statement_flag"
      expr: transaction_statement_flag
      comment: "Flag indicating if transaction statement was generated"
    - name: "epcis_event_code"
      expr: epcis_event_code
      comment: "EPCIS event type code (commission, aggregation, observation, transformation)"
    - name: "commissioning_year"
      expr: YEAR(commissioning_event_timestamp)
      comment: "Year serial number was commissioned"
    - name: "commissioning_month"
      expr: DATE_TRUNC('MONTH', commissioning_event_timestamp)
      comment: "Month serial number was commissioned"
  measures:
    - name: "total_serialized_units"
      expr: COUNT(1)
      comment: "Total number of serialized product units"
    - name: "distinct_serial_numbers"
      expr: COUNT(DISTINCT serial_number)
      comment: "Number of unique serial numbers commissioned"
    - name: "distinct_gtins"
      expr: COUNT(DISTINCT gtin)
      comment: "Number of unique Global Trade Item Numbers"
    - name: "verified_units"
      expr: COUNT(CASE WHEN verification_status = 'verified' THEN 1 END)
      comment: "Count of serialized units with verified authenticity"
    - name: "suspect_units"
      expr: COUNT(CASE WHEN verification_status = 'suspect' THEN 1 END)
      comment: "Count of serialized units flagged as suspect"
    - name: "counterfeit_units"
      expr: COUNT(CASE WHEN verification_status = 'counterfeit' THEN 1 END)
      comment: "Count of serialized units confirmed as counterfeit"
    - name: "recalled_units"
      expr: COUNT(CASE WHEN recall_flag = TRUE THEN 1 END)
      comment: "Count of serialized units subject to product recall"
    - name: "decommissioned_units"
      expr: COUNT(CASE WHEN serialization_status = 'decommissioned' THEN 1 END)
      comment: "Count of serialized units decommissioned from supply chain"
    - name: "saleable_returns"
      expr: COUNT(CASE WHEN saleable_return_flag = TRUE THEN 1 END)
      comment: "Count of returned units eligible for resale"
    - name: "gdp_compliant_units"
      expr: COUNT(CASE WHEN gdp_compliance_flag = TRUE THEN 1 END)
      comment: "Count of units meeting Good Distribution Practice standards"
    - name: "transaction_statements_generated"
      expr: COUNT(CASE WHEN transaction_statement_flag = TRUE THEN 1 END)
      comment: "Count of units with transaction statement generated"
    - name: "distinct_markets"
      expr: COUNT(DISTINCT market_country_code)
      comment: "Number of unique country markets served"
    - name: "distinct_commissioning_sites"
      expr: COUNT(DISTINCT plant_id)
      comment: "Number of unique sites commissioning serial numbers"
$$;
