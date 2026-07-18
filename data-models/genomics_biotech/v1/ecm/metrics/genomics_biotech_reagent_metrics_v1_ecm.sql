-- Metric views for domain: reagent | Business: Genomics Biotech | Version: 1 | Generated on: 2026-05-06 12:58:41

CREATE OR REPLACE VIEW `genomics_biotech_ecm`.`_metrics`.`reagent_inventory_balance`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Key inventory balances for reagents, enabling stock level monitoring and valuation."
  source: "`genomics_biotech_ecm`.`reagent`.`inventory_balance`"
  dimensions:
    - name: "unit_of_measure"
      expr: unit_of_measure
      comment: "Unit of measure for inventory quantities."
    - name: "storage_condition_code"
      expr: storage_condition_code
      comment: "Storage condition code indicating required storage environment."
    - name: "source_system_code"
      expr: source_system_code
      comment: "Source system identifier for the inventory record."
  measures:
    - name: "total_available_quantity"
      expr: SUM(CAST(available_quantity AS DOUBLE))
      comment: "Total quantity available across all inventory records."
    - name: "total_on_hand_quantity"
      expr: SUM(CAST(on_hand_quantity AS DOUBLE))
      comment: "Total on-hand quantity (ready for use)."
    - name: "total_reserved_quantity"
      expr: SUM(CAST(reserved_quantity AS DOUBLE))
      comment: "Total quantity reserved for pending orders."
    - name: "total_quarantine_quantity"
      expr: SUM(CAST(quarantine_quantity AS DOUBLE))
      comment: "Total quantity placed in quarantine."
    - name: "total_valuation_amount"
      expr: SUM(CAST(total_valuation_amount AS DOUBLE))
      comment: "Total monetary valuation of inventory."
    - name: "inventory_record_count"
      expr: COUNT(1)
      comment: "Number of inventory balance records."
$$;


CREATE OR REPLACE VIEW `genomics_biotech_ecm`.`_metrics`.`reagent_dispensing_event`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Reagent dispensing events capturing usage, compliance, and operational throughput."
  source: "`genomics_biotech_ecm`.`reagent`.`dispensing_event`"
  dimensions:
    - name: "dispensing_event_date"
      expr: DATE_TRUNC('day', event_timestamp)
      comment: "Date of dispensing event."
    - name: "sku_id"
      expr: sku_id
      comment: "SKU identifier of the dispensed reagent."
    - name: "storage_location_id"
      expr: storage_location_id
      comment: "Storage location where the lot was stored."
    - name: "asset_id"
      expr: asset_id
      comment: "Instrument asset used for dispensing."
    - name: "dispensing_event_type"
      expr: movement_type
      comment: "Type of dispensing movement."
  measures:
    - name: "total_dispensing_events"
      expr: COUNT(1)
      comment: "Count of dispensing events."
    - name: "total_quantity_dispensed"
      expr: SUM(CAST(quantity_dispensed AS DOUBLE))
      comment: "Total quantity dispensed across events."
    - name: "average_quantity_per_event"
      expr: AVG(CAST(quantity_dispensed AS DOUBLE))
      comment: "Average quantity dispensed per event."
    - name: "total_cold_chain_compliant_events"
      expr: SUM(CASE WHEN cold_chain_compliant_flag THEN 1 ELSE 0 END)
      comment: "Number of events compliant with cold chain requirements."
$$;


CREATE OR REPLACE VIEW `genomics_biotech_ecm`.`_metrics`.`reagent_inventory_transaction`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Inventory transactions reflecting movements, valuations, and GMP release status."
  source: "`genomics_biotech_ecm`.`reagent`.`inventory_transaction`"
  dimensions:
    - name: "transaction_date"
      expr: DATE_TRUNC('day', transaction_timestamp)
      comment: "Date of inventory transaction."
    - name: "transaction_type"
      expr: transaction_type
      comment: "Transaction type (e.g., receipt, issue, adjustment)."
    - name: "sku_id"
      expr: sku_id
      comment: "SKU involved in the transaction."
    - name: "source_location_id"
      expr: primary_inventory_storage_location_id
      comment: "Primary storage location before transaction."
    - name: "destination_location_id"
      expr: storage_location_id
      comment: "Destination storage location after transaction."
  measures:
    - name: "total_transactions"
      expr: COUNT(1)
      comment: "Count of inventory transactions."
    - name: "total_quantity"
      expr: SUM(CAST(quantity AS DOUBLE))
      comment: "Total quantity moved in transactions."
    - name: "total_transaction_value"
      expr: SUM(CAST(total_transaction_value AS DOUBLE))
      comment: "Total monetary value of transactions."
$$;


CREATE OR REPLACE VIEW `genomics_biotech_ecm`.`_metrics`.`reagent_recall_event`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Recall events tracking product safety incidents and financial impact."
  source: "`genomics_biotech_ecm`.`reagent`.`recall_event`"
  dimensions:
    - name: "recall_initiation_date"
      expr: DATE_TRUNC('day', initiation_date)
      comment: "Date the recall was initiated."
    - name: "recall_class"
      expr: recall_class
      comment: "Recall class indicating severity."
    - name: "recall_type"
      expr: recall_type
      comment: "Recall type (e.g., voluntary, mandatory)."
    - name: "regulatory_authority"
      expr: regulatory_authority
      comment: "Regulatory authority overseeing the recall."
    - name: "recall_status"
      expr: recall_status
      comment: "Current status of the recall."
  measures:
    - name: "total_recalls"
      expr: COUNT(1)
      comment: "Number of recall events."
    - name: "total_estimated_financial_impact"
      expr: SUM(CAST(estimated_financial_impact AS DOUBLE))
      comment: "Sum of estimated financial impact across recalls."
$$;
