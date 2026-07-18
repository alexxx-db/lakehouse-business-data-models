-- Metric views for domain: masterdata | Business: Pharmaceuticals | Version: 1 | Generated on: 2026-05-05 17:46:18

CREATE OR REPLACE VIEW `pharmaceuticals_ecm`.`_metrics`.`masterdata_legal_entity`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Strategic metrics for legal entity portfolio management, M&A activity, and corporate structure governance"
  source: "`pharmaceuticals_ecm`.`masterdata`.`legal_entity`"
  dimensions:
    - name: "entity_type"
      expr: entity_type
      comment: "Type of legal entity (subsidiary, joint venture, holding company, etc.)"
    - name: "entity_status"
      expr: entity_status
      comment: "Current operational status of the legal entity"
    - name: "jurisdiction_of_incorporation"
      expr: jurisdiction_of_incorporation
      comment: "Country or state where entity is legally incorporated"
    - name: "legal_form"
      expr: legal_form
      comment: "Legal structure (LLC, Corporation, Partnership, etc.)"
    - name: "gmp_certification_status"
      expr: gmp_certification_status
      comment: "Good Manufacturing Practice certification status"
    - name: "iso_certification_status"
      expr: iso_certification_status
      comment: "ISO quality management certification status"
    - name: "primary_business_activity"
      expr: primary_business_activity
      comment: "Primary business function (manufacturing, R&D, distribution, etc.)"
    - name: "consolidation_group"
      expr: consolidation_group
      comment: "Financial consolidation group for reporting"
    - name: "incorporation_year"
      expr: YEAR(incorporation_date)
      comment: "Year the entity was incorporated"
    - name: "fiscal_year_end_month"
      expr: fiscal_year_end_month
      comment: "Month when fiscal year ends"
  measures:
    - name: "total_legal_entities"
      expr: COUNT(DISTINCT legal_entity_id)
      comment: "Total number of distinct legal entities in the corporate structure"
    - name: "active_legal_entities"
      expr: COUNT(DISTINCT CASE WHEN entity_status = 'Active' THEN legal_entity_id END)
      comment: "Number of currently active legal entities"
    - name: "gmp_certified_entities"
      expr: COUNT(DISTINCT CASE WHEN gmp_certification_status = 'Certified' THEN legal_entity_id END)
      comment: "Number of entities with valid GMP certification"
    - name: "avg_data_quality_score"
      expr: AVG(CAST(data_quality_score AS DOUBLE))
      comment: "Average master data quality score across legal entities"
    - name: "entities_with_lei"
      expr: COUNT(DISTINCT CASE WHEN lei_code IS NOT NULL THEN legal_entity_id END)
      comment: "Number of entities with Legal Entity Identifier for regulatory compliance"
$$;

CREATE OR REPLACE VIEW `pharmaceuticals_ecm`.`_metrics`.`masterdata_plant`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Manufacturing site performance, capacity utilization, and regulatory compliance metrics"
  source: "`pharmaceuticals_ecm`.`masterdata`.`plant`"
  dimensions:
    - name: "plant_type"
      expr: plant_type
      comment: "Type of manufacturing facility (API, formulation, packaging, etc.)"
    - name: "operational_status"
      expr: operational_status
      comment: "Current operational status of the plant"
    - name: "gmp_certification_status"
      expr: gmp_certification_status
      comment: "Good Manufacturing Practice certification status"
    - name: "iso_certification_status"
      expr: iso_certification_status
      comment: "ISO quality certification status"
    - name: "capacity_class"
      expr: capacity_class
      comment: "Production capacity classification (small, medium, large scale)"
    - name: "environmental_permit_status"
      expr: environmental_permit_status
      comment: "Environmental operating permit status"
    - name: "commissioning_year"
      expr: YEAR(commissioning_date)
      comment: "Year the plant was commissioned"
    - name: "gmp_certification_year"
      expr: YEAR(gmp_certification_date)
      comment: "Year of current GMP certification"
    - name: "inspection_overdue_flag"
      expr: CASE WHEN next_inspection_due_date < CURRENT_DATE THEN 'Overdue' ELSE 'Current' END
      comment: "Flag indicating if regulatory inspection is overdue"
  measures:
    - name: "total_plants"
      expr: COUNT(DISTINCT plant_id)
      comment: "Total number of manufacturing plants in the network"
    - name: "operational_plants"
      expr: COUNT(DISTINCT CASE WHEN operational_status = 'Operational' THEN plant_id END)
      comment: "Number of plants currently in operational status"
    - name: "gmp_certified_plants"
      expr: COUNT(DISTINCT CASE WHEN gmp_certification_status = 'Certified' THEN plant_id END)
      comment: "Number of plants with valid GMP certification"
    - name: "total_annual_capacity"
      expr: SUM(CAST(annual_capacity_units AS DOUBLE))
      comment: "Total annual production capacity across all plants"
    - name: "avg_annual_capacity_per_plant"
      expr: AVG(CAST(annual_capacity_units AS DOUBLE))
      comment: "Average annual production capacity per plant"
    - name: "plants_with_overdue_inspection"
      expr: COUNT(DISTINCT CASE WHEN next_inspection_due_date < CURRENT_DATE THEN plant_id END)
      comment: "Number of plants with overdue regulatory inspections"
    - name: "fda_registered_plants"
      expr: COUNT(DISTINCT CASE WHEN fda_establishment_identifier IS NOT NULL THEN plant_id END)
      comment: "Number of plants registered with FDA"
$$;

CREATE OR REPLACE VIEW `pharmaceuticals_ecm`.`_metrics`.`masterdata_material`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Product portfolio metrics for pharmaceutical materials, APIs, and finished goods"
  source: "`pharmaceuticals_ecm`.`masterdata`.`material`"
  dimensions:
    - name: "material_type"
      expr: material_type
      comment: "Type of material (API, excipient, finished product, packaging, etc.)"
    - name: "material_status"
      expr: material_status
      comment: "Lifecycle status of the material"
    - name: "material_group"
      expr: material_group
      comment: "Material grouping for portfolio management"
    - name: "gmp_classification"
      expr: gmp_classification
      comment: "GMP classification level"
    - name: "controlled_substance_schedule"
      expr: controlled_substance_schedule
      comment: "DEA controlled substance schedule (I-V)"
    - name: "hazardous_material_flag"
      expr: CASE WHEN hazardous_material_indicator = TRUE THEN 'Hazardous' ELSE 'Non-Hazardous' END
      comment: "Whether material is classified as hazardous"
    - name: "temperature_sensitive_flag"
      expr: CASE WHEN temperature_sensitive_indicator = TRUE THEN 'Temperature Sensitive' ELSE 'Ambient' END
      comment: "Whether material requires temperature-controlled storage"
    - name: "procurement_type"
      expr: procurement_type
      comment: "Procurement strategy (make, buy, contract manufacturing)"
    - name: "discontinuation_year"
      expr: YEAR(discontinuation_date)
      comment: "Year the material was discontinued"
  measures:
    - name: "total_materials"
      expr: COUNT(DISTINCT material_id)
      comment: "Total number of distinct materials in the portfolio"
    - name: "active_materials"
      expr: COUNT(DISTINCT CASE WHEN material_status = 'Active' THEN material_id END)
      comment: "Number of materials in active status"
    - name: "controlled_substances"
      expr: COUNT(DISTINCT CASE WHEN controlled_substance_schedule IS NOT NULL THEN material_id END)
      comment: "Number of materials classified as controlled substances"
    - name: "hazardous_materials"
      expr: COUNT(DISTINCT CASE WHEN hazardous_material_indicator = TRUE THEN material_id END)
      comment: "Number of materials classified as hazardous"
    - name: "temperature_sensitive_materials"
      expr: COUNT(DISTINCT CASE WHEN temperature_sensitive_indicator = TRUE THEN material_id END)
      comment: "Number of materials requiring temperature-controlled storage"
    - name: "materials_requiring_qi"
      expr: COUNT(DISTINCT CASE WHEN quality_inspection_required = TRUE THEN material_id END)
      comment: "Number of materials requiring quality inspection upon receipt"
    - name: "avg_shelf_life_days"
      expr: AVG(CAST(shelf_life_days AS DOUBLE))
      comment: "Average shelf life in days across materials"
    - name: "avg_gross_weight"
      expr: AVG(CAST(gross_weight AS DOUBLE))
      comment: "Average gross weight per material unit"
$$;

CREATE OR REPLACE VIEW `pharmaceuticals_ecm`.`_metrics`.`masterdata_business_partner`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Supplier and partner qualification, risk management, and compliance metrics"
  source: "`pharmaceuticals_ecm`.`masterdata`.`business_partner`"
  dimensions:
    - name: "bp_role"
      expr: bp_role
      comment: "Business partner role (supplier, contract manufacturer, distributor, etc.)"
    - name: "bp_category"
      expr: bp_category
      comment: "Business partner category"
    - name: "business_partner_status"
      expr: business_partner_status
      comment: "Current status of the business partner relationship"
    - name: "qualification_status"
      expr: qualification_status
      comment: "Supplier qualification status (qualified, pending, disqualified)"
    - name: "gmp_certification_status"
      expr: gmp_certification_status
      comment: "GMP certification status of the partner"
    - name: "risk_classification"
      expr: risk_classification
      comment: "Risk classification (low, medium, high, critical)"
    - name: "avl_status"
      expr: CASE WHEN avl_flag = TRUE THEN 'On AVL' ELSE 'Not on AVL' END
      comment: "Whether partner is on Approved Vendor List"
    - name: "blocking_status"
      expr: CASE WHEN blocking_indicator IS NOT NULL THEN 'Blocked' ELSE 'Active' END
      comment: "Whether partner is blocked from transactions"
    - name: "gmp_expiry_year"
      expr: YEAR(gmp_expiry_date)
      comment: "Year when GMP certification expires"
  measures:
    - name: "total_business_partners"
      expr: COUNT(DISTINCT business_partner_id)
      comment: "Total number of business partners in the network"
    - name: "qualified_suppliers"
      expr: COUNT(DISTINCT CASE WHEN qualification_status = 'Qualified' THEN business_partner_id END)
      comment: "Number of fully qualified suppliers"
    - name: "gmp_certified_partners"
      expr: COUNT(DISTINCT CASE WHEN gmp_certification_status = 'Certified' THEN business_partner_id END)
      comment: "Number of partners with valid GMP certification"
    - name: "high_risk_partners"
      expr: COUNT(DISTINCT CASE WHEN risk_classification = 'High' THEN business_partner_id END)
      comment: "Number of partners classified as high risk"
    - name: "avl_approved_partners"
      expr: COUNT(DISTINCT CASE WHEN avl_flag = TRUE THEN business_partner_id END)
      comment: "Number of partners on Approved Vendor List"
    - name: "blocked_partners"
      expr: COUNT(DISTINCT CASE WHEN blocking_indicator IS NOT NULL THEN business_partner_id END)
      comment: "Number of partners currently blocked from transactions"
    - name: "partners_with_expired_gmp"
      expr: COUNT(DISTINCT CASE WHEN gmp_expiry_date < CURRENT_DATE THEN business_partner_id END)
      comment: "Number of partners with expired GMP certification"
    - name: "total_credit_limit"
      expr: SUM(CAST(credit_limit_amount AS DOUBLE))
      comment: "Total credit limit extended to all business partners"
    - name: "avg_credit_limit"
      expr: AVG(CAST(credit_limit_amount AS DOUBLE))
      comment: "Average credit limit per business partner"
$$;

CREATE OR REPLACE VIEW `pharmaceuticals_ecm`.`_metrics`.`masterdata_supply_agreement`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Supply chain contract performance, supplier reliability, and procurement efficiency metrics"
  source: "`pharmaceuticals_ecm`.`masterdata`.`supply_agreement`"
  dimensions:
    - name: "supply_agreement_status"
      expr: supply_agreement_status
      comment: "Current status of the supply agreement"
    - name: "avl_status"
      expr: avl_status
      comment: "Approved Vendor List status"
    - name: "gmp_certification_status"
      expr: gmp_certification_status
      comment: "GMP certification status of the supplier"
    - name: "preferred_supplier_flag"
      expr: CASE WHEN preferred_supplier_flag = TRUE THEN 'Preferred' ELSE 'Standard' END
      comment: "Whether supplier is designated as preferred"
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the supply agreement"
    - name: "lead_time_category"
      expr: CASE WHEN CAST(lead_time_days AS INT) <= 30 THEN 'Short (<= 30 days)' WHEN CAST(lead_time_days AS INT) <= 90 THEN 'Medium (31-90 days)' ELSE 'Long (> 90 days)' END
      comment: "Categorization of supplier lead time"
    - name: "audit_overdue_flag"
      expr: CASE WHEN next_audit_due_date < CURRENT_DATE THEN 'Overdue' ELSE 'Current' END
      comment: "Whether supplier audit is overdue"
    - name: "qualification_year"
      expr: YEAR(qualification_date)
      comment: "Year the supplier was qualified"
  measures:
    - name: "total_supply_agreements"
      expr: COUNT(DISTINCT supply_agreement_id)
      comment: "Total number of active supply agreements"
    - name: "active_supply_agreements"
      expr: COUNT(DISTINCT CASE WHEN supply_agreement_status = 'Active' THEN supply_agreement_id END)
      comment: "Number of currently active supply agreements"
    - name: "preferred_supplier_agreements"
      expr: COUNT(DISTINCT CASE WHEN preferred_supplier_flag = TRUE THEN supply_agreement_id END)
      comment: "Number of agreements with preferred suppliers"
    - name: "gmp_certified_agreements"
      expr: COUNT(DISTINCT CASE WHEN gmp_certification_status = 'Certified' THEN supply_agreement_id END)
      comment: "Number of agreements with GMP-certified suppliers"
    - name: "agreements_with_overdue_audit"
      expr: COUNT(DISTINCT CASE WHEN next_audit_due_date < CURRENT_DATE THEN supply_agreement_id END)
      comment: "Number of agreements with overdue supplier audits"
    - name: "avg_lead_time_days"
      expr: AVG(CAST(lead_time_days AS DOUBLE))
      comment: "Average supplier lead time in days"
    - name: "avg_unit_price"
      expr: AVG(CAST(unit_price AS DOUBLE))
      comment: "Average unit price across supply agreements"
    - name: "total_minimum_order_value"
      expr: SUM(CAST(minimum_order_quantity AS DOUBLE))
      comment: "Total minimum order quantity commitments"
    - name: "total_maximum_order_capacity"
      expr: SUM(CAST(maximum_order_quantity AS DOUBLE))
      comment: "Total maximum order capacity across suppliers"
$$;

CREATE OR REPLACE VIEW `pharmaceuticals_ecm`.`_metrics`.`masterdata_storage_location`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Warehouse capacity utilization, compliance, and operational efficiency metrics"
  source: "`pharmaceuticals_ecm`.`masterdata`.`storage_location`"
  dimensions:
    - name: "storage_location_status"
      expr: storage_location_status
      comment: "Current operational status of the storage location"
    - name: "storage_type"
      expr: storage_type
      comment: "Type of storage (ambient, refrigerated, freezer, controlled substance vault, etc.)"
    - name: "gmp_zone_classification"
      expr: gmp_zone_classification
      comment: "GMP zone classification (white, grey, black)"
    - name: "gdp_compliant_flag"
      expr: CASE WHEN gdp_compliant_flag = TRUE THEN 'GDP Compliant' ELSE 'Non-GDP' END
      comment: "Whether location meets Good Distribution Practice standards"
    - name: "quarantine_zone_flag"
      expr: CASE WHEN quarantine_zone_flag = TRUE THEN 'Quarantine Zone' ELSE 'General Storage' END
      comment: "Whether location is designated for quarantine"
    - name: "hazmat_storage_class"
      expr: hazmat_storage_class
      comment: "Hazardous material storage classification"
    - name: "security_level"
      expr: security_level
      comment: "Security level of the storage location"
    - name: "temperature_monitoring_system"
      expr: temperature_monitoring_system
      comment: "Temperature monitoring system in use"
    - name: "qualification_overdue_flag"
      expr: CASE WHEN next_qualification_due_date < CURRENT_DATE THEN 'Overdue' ELSE 'Current' END
      comment: "Whether storage location qualification is overdue"
  measures:
    - name: "total_storage_locations"
      expr: COUNT(DISTINCT storage_location_id)
      comment: "Total number of storage locations in the network"
    - name: "active_storage_locations"
      expr: COUNT(DISTINCT CASE WHEN storage_location_status = 'Active' THEN storage_location_id END)
      comment: "Number of currently active storage locations"
    - name: "gdp_compliant_locations"
      expr: COUNT(DISTINCT CASE WHEN gdp_compliant_flag = TRUE THEN storage_location_id END)
      comment: "Number of GDP-compliant storage locations"
    - name: "quarantine_zones"
      expr: COUNT(DISTINCT CASE WHEN quarantine_zone_flag = TRUE THEN storage_location_id END)
      comment: "Number of designated quarantine storage zones"
    - name: "controlled_substance_vaults"
      expr: COUNT(DISTINCT CASE WHEN dea_license_number IS NOT NULL THEN storage_location_id END)
      comment: "Number of DEA-licensed controlled substance storage locations"
    - name: "locations_with_overdue_qualification"
      expr: COUNT(DISTINCT CASE WHEN next_qualification_due_date < CURRENT_DATE THEN storage_location_id END)
      comment: "Number of storage locations with overdue qualification"
    - name: "total_storage_capacity"
      expr: SUM(CAST(capacity_storage_units AS DOUBLE))
      comment: "Total storage capacity across all locations"
    - name: "avg_storage_capacity"
      expr: AVG(CAST(capacity_storage_units AS DOUBLE))
      comment: "Average storage capacity per location"
    - name: "avg_temperature_range"
      expr: AVG(CAST(temperature_max_celsius AS DOUBLE) - CAST(temperature_min_celsius AS DOUBLE))
      comment: "Average temperature range across storage locations"
$$;

CREATE OR REPLACE VIEW `pharmaceuticals_ecm`.`_metrics`.`masterdata_inn_registry`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "International Nonproprietary Name (INN) portfolio metrics for drug substance management and regulatory compliance"
  source: "`pharmaceuticals_ecm`.`masterdata`.`inn_registry`"
  dimensions:
    - name: "inn_status"
      expr: inn_status
      comment: "Status of the INN (proposed, recommended, approved)"
    - name: "record_status"
      expr: record_status
      comment: "Record lifecycle status"
    - name: "therapeutic_area"
      expr: therapeutic_area
      comment: "Therapeutic area of the drug substance"
    - name: "substance_class"
      expr: substance_class
      comment: "Chemical or biological class of the substance"
    - name: "pharmacological_class"
      expr: pharmacological_class
      comment: "Pharmacological classification"
    - name: "controlled_substance_schedule"
      expr: controlled_substance_schedule
      comment: "DEA controlled substance schedule"
    - name: "route_of_administration"
      expr: route_of_administration
      comment: "Route of administration"
    - name: "orphan_drug_flag"
      expr: CASE WHEN orphan_drug_designation_flag = TRUE THEN 'Orphan Drug' ELSE 'Standard' END
      comment: "Whether substance has orphan drug designation"
    - name: "breakthrough_therapy_flag"
      expr: CASE WHEN breakthrough_therapy_designation_flag = TRUE THEN 'Breakthrough' ELSE 'Standard' END
      comment: "Whether substance has breakthrough therapy designation"
    - name: "who_publication_year"
      expr: YEAR(who_publication_date)
      comment: "Year of WHO INN publication"
  measures:
    - name: "total_inn_substances"
      expr: COUNT(DISTINCT inn_registry_id)
      comment: "Total number of INN substances in the registry"
    - name: "active_inn_substances"
      expr: COUNT(DISTINCT CASE WHEN record_status = 'Active' THEN inn_registry_id END)
      comment: "Number of active INN substances"
    - name: "orphan_drug_substances"
      expr: COUNT(DISTINCT CASE WHEN orphan_drug_designation_flag = TRUE THEN inn_registry_id END)
      comment: "Number of substances with orphan drug designation"
    - name: "breakthrough_therapy_substances"
      expr: COUNT(DISTINCT CASE WHEN breakthrough_therapy_designation_flag = TRUE THEN inn_registry_id END)
      comment: "Number of substances with breakthrough therapy designation"
    - name: "controlled_substances"
      expr: COUNT(DISTINCT CASE WHEN controlled_substance_schedule IS NOT NULL THEN inn_registry_id END)
      comment: "Number of controlled substances"
    - name: "avg_molecular_weight"
      expr: AVG(CAST(molecular_weight AS DOUBLE))
      comment: "Average molecular weight of substances"
$$;

CREATE OR REPLACE VIEW `pharmaceuticals_ecm`.`_metrics`.`masterdata_cost_center`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Cost center portfolio management, budget allocation, and financial control metrics"
  source: "`pharmaceuticals_ecm`.`masterdata`.`cost_center`"
  dimensions:
    - name: "cost_center_status"
      expr: cost_center_status
      comment: "Current status of the cost center"
    - name: "cost_center_type"
      expr: cost_center_type
      comment: "Type of cost center (production, R&D, admin, sales, etc.)"
    - name: "cost_center_category"
      expr: cost_center_category
      comment: "Category classification"
    - name: "gmp_classification"
      expr: gmp_classification
      comment: "GMP classification of the cost center"
    - name: "sox_relevant_flag"
      expr: CASE WHEN sox_relevant_flag = TRUE THEN 'SOX Relevant' ELSE 'Non-SOX' END
      comment: "Whether cost center is SOX-relevant for financial controls"
    - name: "statistical_flag"
      expr: CASE WHEN statistical_cost_center_flag = TRUE THEN 'Statistical' ELSE 'Operational' END
      comment: "Whether cost center is statistical or operational"
    - name: "controlling_area_code"
      expr: controlling_area_code
      comment: "Controlling area code"
    - name: "functional_area_code"
      expr: functional_area_code
      comment: "Functional area code"
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the cost center"
  measures:
    - name: "total_cost_centers"
      expr: COUNT(DISTINCT cost_center_id)
      comment: "Total number of cost centers in the organization"
    - name: "active_cost_centers"
      expr: COUNT(DISTINCT CASE WHEN cost_center_status = 'Active' THEN cost_center_id END)
      comment: "Number of currently active cost centers"
    - name: "sox_relevant_cost_centers"
      expr: COUNT(DISTINCT CASE WHEN sox_relevant_flag = TRUE THEN cost_center_id END)
      comment: "Number of SOX-relevant cost centers requiring enhanced controls"
    - name: "gmp_cost_centers"
      expr: COUNT(DISTINCT CASE WHEN gmp_classification IS NOT NULL THEN cost_center_id END)
      comment: "Number of cost centers with GMP classification"
    - name: "statistical_cost_centers"
      expr: COUNT(DISTINCT CASE WHEN statistical_cost_center_flag = TRUE THEN cost_center_id END)
      comment: "Number of statistical cost centers"
$$;

CREATE OR REPLACE VIEW `pharmaceuticals_ecm`.`_metrics`.`masterdata_merger_acquisition_event`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "M&A transaction portfolio metrics for corporate development and integration management"
  source: "`pharmaceuticals_ecm`.`masterdata`.`merger_acquisition_event`"
  dimensions:
    - name: "event_type"
      expr: event_type
      comment: "Type of M&A event (merger, acquisition, divestiture, joint venture, etc.)"
    - name: "status"
      expr: merger_acquisition_event_status
      comment: "Current status of the M&A event"
    - name: "integration_status"
      expr: integration_status
      comment: "Integration status post-closing"
    - name: "transaction_structure"
      expr: transaction_structure
      comment: "Structure of the transaction (asset purchase, stock purchase, etc.)"
    - name: "payment_method"
      expr: payment_method
      comment: "Payment method (cash, stock, mixed)"
    - name: "therapeutic_area"
      expr: therapeutic_area
      comment: "Therapeutic area focus of the transaction"
    - name: "regulatory_jurisdiction"
      expr: regulatory_jurisdiction
      comment: "Primary regulatory jurisdiction"
    - name: "antitrust_clearance_status"
      expr: antitrust_clearance_status
      comment: "Antitrust clearance status"
    - name: "announcement_year"
      expr: YEAR(announcement_date)
      comment: "Year the transaction was announced"
    - name: "closing_year"
      expr: YEAR(closing_date)
      comment: "Year the transaction closed"
  measures:
    - name: "total_ma_events"
      expr: COUNT(DISTINCT merger_acquisition_event_id)
      comment: "Total number of M&A events in the portfolio"
    - name: "completed_ma_events"
      expr: COUNT(DISTINCT CASE WHEN merger_acquisition_event_status = 'Completed' THEN merger_acquisition_event_id END)
      comment: "Number of completed M&A transactions"
    - name: "pending_ma_events"
      expr: COUNT(DISTINCT CASE WHEN merger_acquisition_event_status = 'Pending' THEN merger_acquisition_event_id END)
      comment: "Number of pending M&A transactions"
    - name: "total_transaction_value"
      expr: SUM(CAST(transaction_value_amount AS DOUBLE))
      comment: "Total transaction value across all M&A events"
    - name: "avg_transaction_value"
      expr: AVG(CAST(transaction_value_amount AS DOUBLE))
      comment: "Average transaction value per M&A event"
    - name: "total_expected_synergies"
      expr: SUM(CAST(expected_synergy_amount AS DOUBLE))
      comment: "Total expected synergies from M&A portfolio"
    - name: "events_with_ip_included"
      expr: COUNT(DISTINCT CASE WHEN intellectual_property_included_flag = TRUE THEN merger_acquisition_event_id END)
      comment: "Number of transactions including intellectual property"
    - name: "events_with_manufacturing_assets"
      expr: COUNT(DISTINCT CASE WHEN manufacturing_facilities_included_flag = TRUE THEN merger_acquisition_event_id END)
      comment: "Number of transactions including manufacturing facilities"
    - name: "events_with_pipeline_assets"
      expr: COUNT(DISTINCT CASE WHEN research_pipeline_included_flag = TRUE THEN merger_acquisition_event_id END)
      comment: "Number of transactions including R&D pipeline assets"
$$;

CREATE OR REPLACE VIEW `pharmaceuticals_ecm`.`_metrics`.`masterdata_country`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Global market regulatory landscape and compliance requirement metrics"
  source: "`pharmaceuticals_ecm`.`masterdata`.`country`"
  dimensions:
    - name: "country_name"
      expr: country_name
      comment: "Name of the country"
    - name: "country_status"
      expr: country_status
      comment: "Status of country in the system"
    - name: "region"
      expr: region
      comment: "Geographic region"
    - name: "sub_region"
      expr: sub_region
      comment: "Geographic sub-region"
    - name: "ich_region_name"
      expr: ich_region_name
      comment: "ICH (International Council for Harmonisation) region"
    - name: "pharmaceutical_market_classification"
      expr: pharmaceutical_market_classification
      comment: "Market classification (developed, emerging, frontier)"
    - name: "market_access_tier"
      expr: market_access_tier
      comment: "Market access tier classification"
    - name: "pharmacovigilance_requirement_level"
      expr: pharmacovigilance_requirement_level
      comment: "Level of pharmacovigilance requirements"
    - name: "reimbursement_framework_type"
      expr: reimbursement_framework_type
      comment: "Type of reimbursement framework"
    - name: "data_privacy_regulation"
      expr: data_privacy_regulation
      comment: "Data privacy regulation framework (GDPR, etc.)"
  measures:
    - name: "total_countries"
      expr: COUNT(DISTINCT country_id)
      comment: "Total number of countries in the master data"
    - name: "active_countries"
      expr: COUNT(DISTINCT CASE WHEN country_status = 'Active' THEN country_id END)
      comment: "Number of active countries for operations"
    - name: "ich_member_countries"
      expr: COUNT(DISTINCT CASE WHEN ich_region_flag = TRUE THEN country_id END)
      comment: "Number of ICH member countries"
    - name: "pics_member_countries"
      expr: COUNT(DISTINCT CASE WHEN pics_member_flag = TRUE THEN country_id END)
      comment: "Number of PIC/S (Pharmaceutical Inspection Co-operation Scheme) member countries"
    - name: "countries_requiring_serialization"
      expr: COUNT(DISTINCT CASE WHEN serialization_requirement_flag = TRUE THEN country_id END)
      comment: "Number of countries requiring product serialization"
    - name: "countries_requiring_clinical_trial_registration"
      expr: COUNT(DISTINCT CASE WHEN clinical_trial_registration_required_flag = TRUE THEN country_id END)
      comment: "Number of countries requiring clinical trial registration"
    - name: "countries_requiring_distribution_license"
      expr: COUNT(DISTINCT CASE WHEN distribution_license_required_flag = TRUE THEN country_id END)
      comment: "Number of countries requiring distribution licenses"
$$;
