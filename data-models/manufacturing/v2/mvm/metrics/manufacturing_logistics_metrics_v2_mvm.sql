-- Metric views for domain: logistics | Business: Manufacturing | Version: 2 | Generated on: 2026-07-03 07:48:26

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`logistics_bill_of_lading`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Bill Of Lading business metrics"
  source: "`vibe_manufacturing_v1`.`logistics`.`bill_of_lading`"
  dimensions:
    - name: "Actual Delivery Date"
      expr: actual_delivery_date
    - name: "Bill Of Lading Status"
      expr: bill_of_lading_status
    - name: "Bol Number"
      expr: bol_number
    - name: "Bol Type"
      expr: bol_type
    - name: "Commodity Description"
      expr: commodity_description
    - name: "Consignee Address Line1"
      expr: consignee_address_line1
    - name: "Consignee City"
      expr: consignee_city
    - name: "Consignee Country Code"
      expr: consignee_country_code
    - name: "Consignee Name"
      expr: consignee_name
    - name: "Consignee Postal Code"
      expr: consignee_postal_code
    - name: "Consignee State Province"
      expr: consignee_state_province
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Expected Delivery Date"
      expr: expected_delivery_date
    - name: "Handling Unit Count"
      expr: handling_unit_count
    - name: "Handling Unit Type"
      expr: handling_unit_type
    - name: "Hazmat Flag"
      expr: hazmat_flag
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Bill Of Lading"
      expr: COUNT(DISTINCT bill_of_lading_id)
    - name: "Total Declared Value Amount"
      expr: SUM(declared_value_amount)
    - name: "Average Declared Value Amount"
      expr: AVG(declared_value_amount)
    - name: "Total Declared Value Currency"
      expr: SUM(declared_value_currency)
    - name: "Average Declared Value Currency"
      expr: AVG(declared_value_currency)
    - name: "Total Freight Charge Amount"
      expr: SUM(freight_charge_amount)
    - name: "Average Freight Charge Amount"
      expr: AVG(freight_charge_amount)
    - name: "Total Freight Charge Currency"
      expr: SUM(freight_charge_currency)
    - name: "Average Freight Charge Currency"
      expr: AVG(freight_charge_currency)
    - name: "Total Freight Class"
      expr: SUM(freight_class)
    - name: "Average Freight Class"
      expr: AVG(freight_class)
    - name: "Total Freight Terms"
      expr: SUM(freight_terms)
    - name: "Average Freight Terms"
      expr: AVG(freight_terms)
    - name: "Total Total Weight"
      expr: SUM(total_weight)
    - name: "Average Total Weight"
      expr: AVG(total_weight)
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`logistics_carrier`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Carrier business metrics"
  source: "`vibe_manufacturing_v1`.`logistics`.`carrier`"
  dimensions:
    - name: "Api Endpoint Url"
      expr: api_endpoint_url
    - name: "Carrier Status"
      expr: carrier_status
    - name: "Carrier Type"
      expr: carrier_type
    - name: "Contract Effective Date"
      expr: contract_effective_date
    - name: "Contract Expiry Date"
      expr: contract_expiry_date
    - name: "Contract Status"
      expr: contract_status
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Currency Code"
      expr: currency_code
    - name: "Customs Broker Flag"
      expr: customs_broker_flag
    - name: "Dot Number"
      expr: dot_number
    - name: "Duns Number"
      expr: duns_number
    - name: "Edi Capability Flag"
      expr: edi_capability_flag
    - name: "Edi Version"
      expr: edi_version
    - name: "Hazmat Certified Flag"
      expr: hazmat_certified_flag
    - name: "Headquarters Address"
      expr: headquarters_address
    - name: "Headquarters City"
      expr: headquarters_city
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Carrier"
      expr: COUNT(DISTINCT carrier_id)
    - name: "Total Claims Ratio"
      expr: SUM(claims_ratio)
    - name: "Average Claims Ratio"
      expr: AVG(claims_ratio)
    - name: "Total Insurance Coverage Amount"
      expr: SUM(insurance_coverage_amount)
    - name: "Average Insurance Coverage Amount"
      expr: AVG(insurance_coverage_amount)
    - name: "Total On Time Delivery Percentage"
      expr: SUM(on_time_delivery_percentage)
    - name: "Average On Time Delivery Percentage"
      expr: AVG(on_time_delivery_percentage)
    - name: "Total Payment Terms"
      expr: SUM(payment_terms)
    - name: "Average Payment Terms"
      expr: AVG(payment_terms)
    - name: "Total Safety Score"
      expr: SUM(safety_score)
    - name: "Average Safety Score"
      expr: AVG(safety_score)
    - name: "Total Tms Integration Status"
      expr: SUM(tms_integration_status)
    - name: "Average Tms Integration Status"
      expr: AVG(tms_integration_status)
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`logistics_carrier_contract`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Carrier Contract business metrics"
  source: "`vibe_manufacturing_v1`.`logistics`.`carrier_contract`"
  dimensions:
    - name: "Accessorial Charges Included Flag"
      expr: accessorial_charges_included_flag
    - name: "Approval Date"
      expr: approval_date
    - name: "Approved By Name"
      expr: approved_by_name
    - name: "Auto Renewal Flag"
      expr: auto_renewal_flag
    - name: "Carrier Contact Email"
      expr: carrier_contact_email
    - name: "Carrier Contact Name"
      expr: carrier_contact_name
    - name: "Carrier Contact Phone"
      expr: carrier_contact_phone
    - name: "Contract Document Url"
      expr: contract_document_url
    - name: "Contract Number"
      expr: contract_number
    - name: "Contract Status"
      expr: contract_status
    - name: "Contract Type"
      expr: contract_type
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Currency Code"
      expr: currency_code
    - name: "Detention Free Time Minutes"
      expr: detention_free_time_minutes
    - name: "Effective Date"
      expr: effective_date
    - name: "Expiry Date"
      expr: expiry_date
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Carrier Contract"
      expr: COUNT(DISTINCT carrier_contract_id)
    - name: "Total Base Rate Type"
      expr: SUM(base_rate_type)
    - name: "Average Base Rate Type"
      expr: AVG(base_rate_type)
    - name: "Total Damage Claim Liability Limit"
      expr: SUM(damage_claim_liability_limit)
    - name: "Average Damage Claim Liability Limit"
      expr: AVG(damage_claim_liability_limit)
    - name: "Total Detention Charge Per Hour"
      expr: SUM(detention_charge_per_hour)
    - name: "Average Detention Charge Per Hour"
      expr: AVG(detention_charge_per_hour)
    - name: "Total Fuel Surcharge Method"
      expr: SUM(fuel_surcharge_method)
    - name: "Average Fuel Surcharge Method"
      expr: AVG(fuel_surcharge_method)
    - name: "Total Insurance Minimum Coverage Amount"
      expr: SUM(insurance_minimum_coverage_amount)
    - name: "Average Insurance Minimum Coverage Amount"
      expr: AVG(insurance_minimum_coverage_amount)
    - name: "Total Minimum Volume Commitment"
      expr: SUM(minimum_volume_commitment)
    - name: "Average Minimum Volume Commitment"
      expr: AVG(minimum_volume_commitment)
    - name: "Total On Time Delivery Target Pct"
      expr: SUM(on_time_delivery_target_pct)
    - name: "Average On Time Delivery Target Pct"
      expr: AVG(on_time_delivery_target_pct)
    - name: "Total Payment Terms"
      expr: SUM(payment_terms)
    - name: "Average Payment Terms"
      expr: AVG(payment_terms)
    - name: "Total Rate Adjustment Trigger"
      expr: SUM(rate_adjustment_trigger)
    - name: "Average Rate Adjustment Trigger"
      expr: AVG(rate_adjustment_trigger)
    - name: "Total Rate Review Frequency"
      expr: SUM(rate_review_frequency)
    - name: "Average Rate Review Frequency"
      expr: AVG(rate_review_frequency)
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`logistics_delivery_note`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Delivery Note business metrics"
  source: "`vibe_manufacturing_v1`.`logistics`.`delivery_note`"
  dimensions:
    - name: "Actual Delivery Date"
      expr: actual_delivery_date
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Delivery Direction"
      expr: delivery_direction
    - name: "Delivery Note Number"
      expr: delivery_note_number
    - name: "Delivery Priority"
      expr: delivery_priority
    - name: "Delivery Status"
      expr: delivery_status
    - name: "Goods Issue Date"
      expr: goods_issue_date
    - name: "Goods Issue Status"
      expr: goods_issue_status
    - name: "Goods Receipt Date"
      expr: goods_receipt_date
    - name: "Goods Receipt Status"
      expr: goods_receipt_status
    - name: "Incoterms Code"
      expr: incoterms_code
    - name: "Incoterms Location"
      expr: incoterms_location
    - name: "Last Modified Timestamp"
      expr: last_modified_timestamp
    - name: "Loading Date"
      expr: loading_date
    - name: "Material Document Number"
      expr: material_document_number
    - name: "Number Of Packages"
      expr: number_of_packages
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Delivery Note"
      expr: COUNT(DISTINCT delivery_note_id)
    - name: "Total Customs Declaration Number"
      expr: SUM(customs_declaration_number)
    - name: "Average Customs Declaration Number"
      expr: AVG(customs_declaration_number)
    - name: "Total Freight Cost Amount"
      expr: SUM(freight_cost_amount)
    - name: "Average Freight Cost Amount"
      expr: AVG(freight_cost_amount)
    - name: "Total Freight Cost Currency"
      expr: SUM(freight_cost_currency)
    - name: "Average Freight Cost Currency"
      expr: AVG(freight_cost_currency)
    - name: "Total Total Gross Weight Kg"
      expr: SUM(total_gross_weight_kg)
    - name: "Average Total Gross Weight Kg"
      expr: AVG(total_gross_weight_kg)
    - name: "Total Total Net Weight Kg"
      expr: SUM(total_net_weight_kg)
    - name: "Average Total Net Weight Kg"
      expr: AVG(total_net_weight_kg)
    - name: "Total Total Volume M3"
      expr: SUM(total_volume_m3)
    - name: "Average Total Volume M3"
      expr: AVG(total_volume_m3)
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`logistics_freight_order`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Freight Order business metrics"
  source: "`vibe_manufacturing_v1`.`logistics`.`freight_order`"
  dimensions:
    - name: "Actual Delivery Timestamp"
      expr: actual_delivery_timestamp
    - name: "Actual Pickup Timestamp"
      expr: actual_pickup_timestamp
    - name: "Bill Of Lading Number"
      expr: bill_of_lading_number
    - name: "Carrier Acceptance Status"
      expr: carrier_acceptance_status
    - name: "Carrier Acceptance Timestamp"
      expr: carrier_acceptance_timestamp
    - name: "Created By User"
      expr: created_by_user
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Customs Required Indicator"
      expr: customs_required_indicator
    - name: "Delivery Window End"
      expr: delivery_window_end
    - name: "Delivery Window Start"
      expr: delivery_window_start
    - name: "Equipment Type"
      expr: equipment_type
    - name: "Hazmat Indicator"
      expr: hazmat_indicator
    - name: "Incoterm Code"
      expr: incoterm_code
    - name: "Modified By User"
      expr: modified_by_user
    - name: "Modified Timestamp"
      expr: modified_timestamp
    - name: "Package Count"
      expr: package_count
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Freight Order"
      expr: COUNT(DISTINCT freight_order_id)
    - name: "Total Accessorial Charges Amount"
      expr: SUM(accessorial_charges_amount)
    - name: "Average Accessorial Charges Amount"
      expr: AVG(accessorial_charges_amount)
    - name: "Total Freight Order Number"
      expr: SUM(freight_order_number)
    - name: "Average Freight Order Number"
      expr: AVG(freight_order_number)
    - name: "Total Freight Order Status"
      expr: SUM(freight_order_status)
    - name: "Average Freight Order Status"
      expr: AVG(freight_order_status)
    - name: "Total Freight Rate Amount"
      expr: SUM(freight_rate_amount)
    - name: "Average Freight Rate Amount"
      expr: AVG(freight_rate_amount)
    - name: "Total Freight Rate Currency Code"
      expr: SUM(freight_rate_currency_code)
    - name: "Average Freight Rate Currency Code"
      expr: AVG(freight_rate_currency_code)
    - name: "Total Sap Tm Freight Order Reference"
      expr: SUM(sap_tm_freight_order_reference)
    - name: "Average Sap Tm Freight Order Reference"
      expr: AVG(sap_tm_freight_order_reference)
    - name: "Total Temperature Max C"
      expr: SUM(temperature_max_c)
    - name: "Average Temperature Max C"
      expr: AVG(temperature_max_c)
    - name: "Total Temperature Min C"
      expr: SUM(temperature_min_c)
    - name: "Average Temperature Min C"
      expr: AVG(temperature_min_c)
    - name: "Total Total Freight Cost"
      expr: SUM(total_freight_cost)
    - name: "Average Total Freight Cost"
      expr: AVG(total_freight_cost)
    - name: "Total Volume M3"
      expr: SUM(volume_m3)
    - name: "Average Volume M3"
      expr: AVG(volume_m3)
    - name: "Total Weight Kg"
      expr: SUM(weight_kg)
    - name: "Average Weight Kg"
      expr: AVG(weight_kg)
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`logistics_inbound_delivery`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Inbound Delivery business metrics"
  source: "`vibe_manufacturing_v1`.`logistics`.`inbound_delivery`"
  dimensions:
    - name: "Actual Delivery Date"
      expr: actual_delivery_date
    - name: "Blocked Stock Flag"
      expr: blocked_stock_flag
    - name: "Country Of Origin"
      expr: country_of_origin
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Customs Clearance Status"
      expr: customs_clearance_status
    - name: "Customs Entry Number"
      expr: customs_entry_number
    - name: "Delivery Complete Flag"
      expr: delivery_complete_flag
    - name: "Delivery Note Text"
      expr: delivery_note_text
    - name: "Delivery Priority"
      expr: delivery_priority
    - name: "Delivery Status"
      expr: delivery_status
    - name: "Expected Delivery Date"
      expr: expected_delivery_date
    - name: "Goods Receipt Date"
      expr: goods_receipt_date
    - name: "Goods Receipt Posted By"
      expr: goods_receipt_posted_by
    - name: "Goods Receipt Status"
      expr: goods_receipt_status
    - name: "Inbound Delivery Number"
      expr: inbound_delivery_number
    - name: "Incoterm Code"
      expr: incoterm_code
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Inbound Delivery"
      expr: COUNT(DISTINCT inbound_delivery_id)
    - name: "Total Delivery Variance Quantity"
      expr: SUM(delivery_variance_quantity)
    - name: "Average Delivery Variance Quantity"
      expr: AVG(delivery_variance_quantity)
    - name: "Total Freight Cost Amount"
      expr: SUM(freight_cost_amount)
    - name: "Average Freight Cost Amount"
      expr: AVG(freight_cost_amount)
    - name: "Total Freight Cost Currency"
      expr: SUM(freight_cost_currency)
    - name: "Average Freight Cost Currency"
      expr: AVG(freight_cost_currency)
    - name: "Total Over Delivery Tolerance Percent"
      expr: SUM(over_delivery_tolerance_percent)
    - name: "Average Over Delivery Tolerance Percent"
      expr: AVG(over_delivery_tolerance_percent)
    - name: "Total Quantity Ordered"
      expr: SUM(quantity_ordered)
    - name: "Average Quantity Ordered"
      expr: AVG(quantity_ordered)
    - name: "Total Quantity Received"
      expr: SUM(quantity_received)
    - name: "Average Quantity Received"
      expr: AVG(quantity_received)
    - name: "Total Under Delivery Tolerance Percent"
      expr: SUM(under_delivery_tolerance_percent)
    - name: "Average Under Delivery Tolerance Percent"
      expr: AVG(under_delivery_tolerance_percent)
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`logistics_shipment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Shipment business metrics"
  source: "`vibe_manufacturing_v1`.`logistics`.`shipment`"
  dimensions:
    - name: "Actual Delivery Timestamp"
      expr: actual_delivery_timestamp
    - name: "Actual Pickup Timestamp"
      expr: actual_pickup_timestamp
    - name: "Bol Number"
      expr: bol_number
    - name: "Commercial Invoice Number"
      expr: commercial_invoice_number
    - name: "Consolidation Group Code"
      expr: consolidation_group_code
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Destination Address Line1"
      expr: destination_address_line1
    - name: "Destination City"
      expr: destination_city
    - name: "Destination Country Code"
      expr: destination_country_code
    - name: "Destination Postal Code"
      expr: destination_postal_code
    - name: "Destination State Province"
      expr: destination_state_province
    - name: "Direction"
      expr: direction
    - name: "Hazmat Class"
      expr: hazmat_class
    - name: "Hazmat Flag"
      expr: hazmat_flag
    - name: "Incoterm Code"
      expr: incoterm_code
    - name: "Last Modified Timestamp"
      expr: last_modified_timestamp
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Shipment"
      expr: COUNT(DISTINCT shipment_id)
    - name: "Total Customs Declaration Number"
      expr: SUM(customs_declaration_number)
    - name: "Average Customs Declaration Number"
      expr: AVG(customs_declaration_number)
    - name: "Total Freight Class"
      expr: SUM(freight_class)
    - name: "Average Freight Class"
      expr: AVG(freight_class)
    - name: "Total Freight Cost Amount"
      expr: SUM(freight_cost_amount)
    - name: "Average Freight Cost Amount"
      expr: AVG(freight_cost_amount)
    - name: "Total Freight Cost Currency Code"
      expr: SUM(freight_cost_currency_code)
    - name: "Average Freight Cost Currency Code"
      expr: AVG(freight_cost_currency_code)
    - name: "Total Insurance Value Amount"
      expr: SUM(insurance_value_amount)
    - name: "Average Insurance Value Amount"
      expr: AVG(insurance_value_amount)
    - name: "Total Insurance Value Currency Code"
      expr: SUM(insurance_value_currency_code)
    - name: "Average Insurance Value Currency Code"
      expr: AVG(insurance_value_currency_code)
    - name: "Total Temperature Max Celsius"
      expr: SUM(temperature_max_celsius)
    - name: "Average Temperature Max Celsius"
      expr: AVG(temperature_max_celsius)
    - name: "Total Temperature Min Celsius"
      expr: SUM(temperature_min_celsius)
    - name: "Average Temperature Min Celsius"
      expr: AVG(temperature_min_celsius)
    - name: "Total Total Volume M3"
      expr: SUM(total_volume_m3)
    - name: "Average Total Volume M3"
      expr: AVG(total_volume_m3)
    - name: "Total Total Weight Kg"
      expr: SUM(total_weight_kg)
    - name: "Average Total Weight Kg"
      expr: AVG(total_weight_kg)
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`logistics_transport_route`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Transport Route business metrics"
  source: "`vibe_manufacturing_v1`.`logistics`.`transport_route`"
  dimensions:
    - name: "Alternate Carrier Codes"
      expr: alternate_carrier_codes
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Customs Clearance Required"
      expr: customs_clearance_required
    - name: "Destination Country Code"
      expr: destination_country_code
    - name: "Destination Location Code"
      expr: destination_location_code
    - name: "Destination Location Name"
      expr: destination_location_name
    - name: "Effective From Date"
      expr: effective_from_date
    - name: "Effective To Date"
      expr: effective_to_date
    - name: "Equipment Type"
      expr: equipment_type
    - name: "Hazmat Approved"
      expr: hazmat_approved
    - name: "Last Modified Timestamp"
      expr: last_modified_timestamp
    - name: "Last Review Date"
      expr: last_review_date
    - name: "Load Type"
      expr: load_type
    - name: "Next Review Date"
      expr: next_review_date
    - name: "Optimization Priority"
      expr: optimization_priority
    - name: "Origin Country Code"
      expr: origin_country_code
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Transport Route"
      expr: COUNT(DISTINCT transport_route_id)
    - name: "Total Carbon Emission Factor Kg Per Km"
      expr: SUM(carbon_emission_factor_kg_per_km)
    - name: "Average Carbon Emission Factor Kg Per Km"
      expr: AVG(carbon_emission_factor_kg_per_km)
    - name: "Total Cost Currency Code"
      expr: SUM(cost_currency_code)
    - name: "Average Cost Currency Code"
      expr: AVG(cost_currency_code)
    - name: "Total Cost Per Km"
      expr: SUM(cost_per_km)
    - name: "Average Cost Per Km"
      expr: AVG(cost_per_km)
    - name: "Total Distance Km"
      expr: SUM(distance_km)
    - name: "Average Distance Km"
      expr: AVG(distance_km)
    - name: "Total Fuel Surcharge Applicable"
      expr: SUM(fuel_surcharge_applicable)
    - name: "Average Fuel Surcharge Applicable"
      expr: AVG(fuel_surcharge_applicable)
    - name: "Total Maximum Transit Time Days"
      expr: SUM(maximum_transit_time_days)
    - name: "Average Maximum Transit Time Days"
      expr: AVG(maximum_transit_time_days)
    - name: "Total Minimum Transit Time Days"
      expr: SUM(minimum_transit_time_days)
    - name: "Average Minimum Transit Time Days"
      expr: AVG(minimum_transit_time_days)
    - name: "Total Standard Freight Cost"
      expr: SUM(standard_freight_cost)
    - name: "Average Standard Freight Cost"
      expr: AVG(standard_freight_cost)
    - name: "Total Standard Transit Time Days"
      expr: SUM(standard_transit_time_days)
    - name: "Average Standard Transit Time Days"
      expr: AVG(standard_transit_time_days)
$$;