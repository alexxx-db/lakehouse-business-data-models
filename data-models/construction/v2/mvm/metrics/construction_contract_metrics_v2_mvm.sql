-- Metric views for domain: contract | Business: Construction | Version: 2 | Generated on: 2026-07-10 14:32:32

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`contract_agreement`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core contract agreement KPIs tracking contract value, amendments, performance bonds, and retention across contract lifecycle stages."
  source: "`vibe_construction_v1`.`contract`.`agreement`"
  dimensions:
    - name: "agreement_status"
      expr: agreement_status
      comment: "Current status of the contract agreement (e.g., active, completed, terminated)."
    - name: "contract_type"
      expr: contract_type
      comment: "Type of contract (e.g., lump sum, unit price, cost plus)."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency in which the contract value is denominated."
    - name: "geographic_location"
      expr: geographic_location
      comment: "Geographic location or region where the contract is executed."
    - name: "amendment_type"
      expr: amendment_type
      comment: "Type of amendment applied to the contract (e.g., scope change, time extension, value adjustment)."
    - name: "award_year"
      expr: YEAR(award_date)
      comment: "Year in which the contract was awarded."
    - name: "award_quarter"
      expr: CONCAT('Q', QUARTER(award_date), '-', YEAR(award_date))
      comment: "Quarter and year in which the contract was awarded."
    - name: "effective_start_year"
      expr: YEAR(effective_start_date)
      comment: "Year in which the contract became effective."
  measures:
    - name: "total_contract_value"
      expr: SUM(CAST(contract_value AS DOUBLE))
      comment: "Total original contract value across all agreements — primary revenue metric for contract portfolio."
    - name: "total_revised_contract_value"
      expr: SUM(CAST(revised_contract_value AS DOUBLE))
      comment: "Total revised contract value after amendments — tracks actual committed revenue."
    - name: "total_performance_bond_amount"
      expr: SUM(CAST(performance_bond_amount AS DOUBLE))
      comment: "Total performance bond amounts held — measures financial security and risk exposure."
    - name: "total_liquidated_damages_amount"
      expr: SUM(CAST(liquidated_damages_amount AS DOUBLE))
      comment: "Total liquidated damages provisions across contracts — quantifies delay penalty exposure."
    - name: "avg_retention_percentage"
      expr: AVG(CAST(retention_percentage AS DOUBLE))
      comment: "Average retention percentage held across contracts — measures working capital impact."
    - name: "total_retention_value"
      expr: SUM(CAST(contract_value AS DOUBLE) * CAST(retention_percentage AS DOUBLE) / 100.0)
      comment: "Total retention value held across all contracts — measures cash flow impact of retention clauses."
    - name: "contract_value_change"
      expr: SUM(CAST(revised_contract_value AS DOUBLE) - CAST(contract_value AS DOUBLE))
      comment: "Total net change in contract value due to amendments — measures scope creep or reduction."
    - name: "avg_contract_value"
      expr: AVG(CAST(contract_value AS DOUBLE))
      comment: "Average original contract value — measures typical deal size."
    - name: "contract_count"
      expr: COUNT(DISTINCT agreement_id)
      comment: "Number of distinct contract agreements — measures portfolio size and activity volume."
    - name: "amended_contract_count"
      expr: COUNT(DISTINCT CASE WHEN amendment_number IS NOT NULL THEN agreement_id END)
      comment: "Number of contracts with amendments — measures contract change frequency and stability."
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`contract_change_order`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Contract change order KPIs tracking cost and schedule impacts, variation management, and change order approval rates."
  source: "`vibe_construction_v1`.`contract`.`contract_change_order`"
  dimensions:
    - name: "contract_change_order_status"
      expr: contract_change_order_status
      comment: "Current status of the change order (e.g., submitted, approved, rejected, executed)."
    - name: "change_order_type"
      expr: change_order_type
      comment: "Type of change order (e.g., scope change, design change, unforeseen conditions)."
    - name: "reason_code"
      expr: reason_code
      comment: "Reason code for the change order (e.g., client request, design error, site conditions)."
    - name: "is_critical"
      expr: is_critical
      comment: "Flag indicating whether the change order is on the critical path."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency in which the change order amounts are denominated."
    - name: "submitted_year"
      expr: YEAR(submitted_timestamp)
      comment: "Year in which the change order was submitted."
    - name: "submitted_quarter"
      expr: CONCAT('Q', QUARTER(submitted_timestamp), '-', YEAR(submitted_timestamp))
      comment: "Quarter and year in which the change order was submitted."
  measures:
    - name: "total_cost_impact"
      expr: SUM(CAST(cost_impact_amount AS DOUBLE))
      comment: "Total cost impact of all change orders — measures financial impact of variations on project budgets."
    - name: "total_adjustment_amount"
      expr: SUM(CAST(adjustment_amount AS DOUBLE))
      comment: "Total adjustment amounts across change orders — tracks net financial adjustments to contracts."
    - name: "total_gross_amount"
      expr: SUM(CAST(gross_amount AS DOUBLE))
      comment: "Total gross amount of change orders before adjustments — measures total variation value."
    - name: "total_net_amount"
      expr: SUM(CAST(net_amount AS DOUBLE))
      comment: "Total net amount of change orders after adjustments — measures actual financial impact."
    - name: "total_ld_provision_amount"
      expr: SUM(CAST(ld_provision_amount AS DOUBLE))
      comment: "Total liquidated damages provisions in change orders — quantifies delay penalty exposure from variations."
    - name: "avg_cost_impact"
      expr: AVG(CAST(cost_impact_amount AS DOUBLE))
      comment: "Average cost impact per change order — measures typical variation size."
    - name: "change_order_count"
      expr: COUNT(DISTINCT contract_change_order_id)
      comment: "Number of distinct change orders — measures variation frequency and contract stability."
    - name: "critical_change_order_count"
      expr: COUNT(DISTINCT CASE WHEN is_critical = TRUE THEN contract_change_order_id END)
      comment: "Number of critical path change orders — measures schedule risk from variations."
    - name: "approved_change_order_count"
      expr: COUNT(DISTINCT CASE WHEN contract_change_order_status = 'approved' THEN contract_change_order_id END)
      comment: "Number of approved change orders — measures variation approval rate."
    - name: "total_approved_cost_impact"
      expr: SUM(CASE WHEN contract_change_order_status = 'approved' THEN CAST(cost_impact_amount AS DOUBLE) ELSE 0 END)
      comment: "Total cost impact of approved change orders — measures actual committed variation cost."
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`contract_milestone`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Contract milestone performance KPIs tracking schedule variance, cost variance, liquidated damages triggers, and defects liability periods."
  source: "`vibe_construction_v1`.`contract`.`contract_milestone`"
  dimensions:
    - name: "contract_milestone_status"
      expr: contract_milestone_status
      comment: "Current status of the milestone (e.g., planned, in progress, completed, delayed)."
    - name: "milestone_type"
      expr: milestone_type
      comment: "Type of milestone (e.g., design approval, construction completion, handover, final certificate)."
    - name: "is_critical"
      expr: is_critical
      comment: "Flag indicating whether the milestone is on the critical path."
    - name: "ld_triggered"
      expr: ld_triggered
      comment: "Flag indicating whether liquidated damages have been triggered for this milestone."
    - name: "liquidated_damages_applicable"
      expr: liquidated_damages_applicable
      comment: "Flag indicating whether liquidated damages provisions apply to this milestone."
    - name: "outstanding_defects_flag"
      expr: outstanding_defects_flag
      comment: "Flag indicating whether there are outstanding defects for this milestone."
    - name: "performance_certificate_issued"
      expr: performance_certificate_issued
      comment: "Flag indicating whether a performance certificate has been issued for this milestone."
    - name: "compliance_status"
      expr: compliance_status
      comment: "Compliance status of the milestone (e.g., compliant, non-compliant, under review)."
    - name: "planned_year"
      expr: YEAR(planned_date)
      comment: "Year in which the milestone was originally planned."
    - name: "actual_year"
      expr: YEAR(actual_date)
      comment: "Year in which the milestone was actually completed."
  measures:
    - name: "total_milestone_value"
      expr: SUM(CAST(milestone_value AS DOUBLE))
      comment: "Total value of all milestones — measures total contracted milestone payments."
    - name: "total_cost_variance"
      expr: SUM(CAST(cost_variance_amount AS DOUBLE))
      comment: "Total cost variance across milestones — measures budget performance at milestone level."
    - name: "total_retention_amount"
      expr: SUM(CAST(retention_amount AS DOUBLE))
      comment: "Total retention amounts held at milestone level — measures working capital tied up in retentions."
    - name: "total_ld_rate_per_day"
      expr: SUM(CAST(ld_rate_per_day AS DOUBLE))
      comment: "Total liquidated damages rate per day across milestones — quantifies daily delay penalty exposure."
    - name: "avg_milestone_value"
      expr: AVG(CAST(milestone_value AS DOUBLE))
      comment: "Average value per milestone — measures typical milestone payment size."
    - name: "milestone_count"
      expr: COUNT(DISTINCT contract_milestone_id)
      comment: "Number of distinct milestones — measures contract complexity and payment structure."
    - name: "completed_milestone_count"
      expr: COUNT(DISTINCT CASE WHEN actual_date IS NOT NULL THEN contract_milestone_id END)
      comment: "Number of completed milestones — measures progress and delivery performance."
    - name: "delayed_milestone_count"
      expr: COUNT(DISTINCT CASE WHEN ld_triggered = TRUE THEN contract_milestone_id END)
      comment: "Number of milestones with liquidated damages triggered — measures schedule performance failures."
    - name: "critical_milestone_count"
      expr: COUNT(DISTINCT CASE WHEN is_critical = TRUE THEN contract_milestone_id END)
      comment: "Number of critical path milestones — measures schedule risk concentration."
    - name: "defective_milestone_count"
      expr: COUNT(DISTINCT CASE WHEN outstanding_defects_flag = TRUE THEN contract_milestone_id END)
      comment: "Number of milestones with outstanding defects — measures quality performance and rectification liability."
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`contract_payment_certificate`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Payment certification KPIs tracking certified amounts, retention deductions, liquidated damages applications, and payment cycle performance."
  source: "`vibe_construction_v1`.`contract`.`payment_certificate`"
  dimensions:
    - name: "payment_certificate_status"
      expr: payment_certificate_status
      comment: "Current status of the payment certificate (e.g., draft, certified, approved, paid)."
    - name: "payment_status"
      expr: payment_status
      comment: "Payment status (e.g., pending, paid, overdue)."
    - name: "payment_type"
      expr: payment_type
      comment: "Type of payment (e.g., progress payment, milestone payment, final payment, retention release)."
    - name: "payment_method"
      expr: payment_method
      comment: "Method of payment (e.g., bank transfer, check, electronic)."
    - name: "is_retention_applied"
      expr: is_retention_applied
      comment: "Flag indicating whether retention was applied to this certificate."
    - name: "is_ld_applied"
      expr: is_ld_applied
      comment: "Flag indicating whether liquidated damages were applied to this certificate."
    - name: "is_advance_recovered"
      expr: is_advance_recovered
      comment: "Flag indicating whether advance payment recovery was applied."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency in which the payment certificate is denominated."
    - name: "certification_year"
      expr: YEAR(certification_date)
      comment: "Year in which the payment certificate was certified."
    - name: "certification_quarter"
      expr: CONCAT('Q', QUARTER(certification_date), '-', YEAR(certification_date))
      comment: "Quarter and year in which the payment certificate was certified."
  measures:
    - name: "total_certified_amount"
      expr: SUM(CAST(certified_amount AS DOUBLE))
      comment: "Total certified payment amounts — measures gross payment value before deductions."
    - name: "total_net_amount_due"
      expr: SUM(CAST(net_amount_due AS DOUBLE))
      comment: "Total net amount due after all deductions — measures actual cash outflow to contractors."
    - name: "total_retention_amount"
      expr: SUM(CAST(retention_amount AS DOUBLE))
      comment: "Total retention amounts deducted — measures working capital withheld for defects liability."
    - name: "total_ld_deduction_amount"
      expr: SUM(CAST(ld_deduction_amount AS DOUBLE))
      comment: "Total liquidated damages deducted from payments — quantifies actual delay penalties applied."
    - name: "total_advance_recovery_amount"
      expr: SUM(CAST(advance_recovery_amount AS DOUBLE))
      comment: "Total advance payment recovery amounts — tracks repayment of mobilization advances."
    - name: "total_tax_amount"
      expr: SUM(CAST(tax_amount AS DOUBLE))
      comment: "Total tax amounts withheld or applied — measures tax liability on contractor payments."
    - name: "avg_work_progress_percent"
      expr: AVG(CAST(work_progress_percent AS DOUBLE))
      comment: "Average work progress percentage across certificates — measures overall project completion rate."
    - name: "payment_certificate_count"
      expr: COUNT(DISTINCT payment_certificate_id)
      comment: "Number of distinct payment certificates — measures payment cycle frequency and cash flow activity."
    - name: "certificates_with_ld_count"
      expr: COUNT(DISTINCT CASE WHEN is_ld_applied = TRUE THEN payment_certificate_id END)
      comment: "Number of certificates with liquidated damages applied — measures frequency of delay penalties."
    - name: "certificates_with_retention_count"
      expr: COUNT(DISTINCT CASE WHEN is_retention_applied = TRUE THEN payment_certificate_id END)
      comment: "Number of certificates with retention applied — measures retention policy application rate."
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`contract_eot_claim`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Extension of Time (EOT) claim KPIs tracking claim amounts, days claimed vs assessed, approval rates, and schedule impact."
  source: "`vibe_construction_v1`.`contract`.`eot_claim`"
  dimensions:
    - name: "claim_status"
      expr: claim_status
      comment: "Current status of the EOT claim (e.g., submitted, under review, approved, rejected)."
    - name: "claim_type"
      expr: claim_type
      comment: "Type of EOT claim (e.g., weather delay, design change, unforeseen conditions, client instruction)."
    - name: "determination_outcome"
      expr: determination_outcome
      comment: "Final determination outcome of the claim (e.g., approved, partially approved, rejected)."
    - name: "claim_is_critical"
      expr: claim_is_critical
      comment: "Flag indicating whether the claim relates to critical path activities."
    - name: "claim_priority"
      expr: claim_priority
      comment: "Priority level of the claim (e.g., high, medium, low)."
    - name: "entitlement_basis"
      expr: entitlement_basis
      comment: "Legal or contractual basis for the EOT entitlement."
    - name: "submission_year"
      expr: YEAR(claim_submission_timestamp)
      comment: "Year in which the EOT claim was submitted."
    - name: "decision_year"
      expr: YEAR(claim_decision_date)
      comment: "Year in which the EOT claim decision was made."
  measures:
    - name: "total_claim_amount"
      expr: SUM(CAST(claim_amount AS DOUBLE))
      comment: "Total claimed amounts across all EOT claims — measures financial exposure from time extension requests."
    - name: "total_claim_final_amount"
      expr: SUM(CAST(claim_final_amount AS DOUBLE))
      comment: "Total final approved claim amounts — measures actual financial impact of approved EOT claims."
    - name: "total_liquidated_damages_impact"
      expr: SUM(CAST(liquidated_damages_impact AS DOUBLE))
      comment: "Total liquidated damages impact from EOT claims — quantifies LD relief granted through time extensions."
    - name: "avg_claim_amount"
      expr: AVG(CAST(claim_amount AS DOUBLE))
      comment: "Average claim amount per EOT claim — measures typical claim size."
    - name: "eot_claim_count"
      expr: COUNT(DISTINCT eot_claim_id)
      comment: "Number of distinct EOT claims — measures frequency of time extension requests and schedule disputes."
    - name: "approved_claim_count"
      expr: COUNT(DISTINCT CASE WHEN determination_outcome = 'approved' THEN eot_claim_id END)
      comment: "Number of approved EOT claims — measures claim approval rate and contractor entitlement success."
    - name: "critical_claim_count"
      expr: COUNT(DISTINCT CASE WHEN claim_is_critical = TRUE THEN eot_claim_id END)
      comment: "Number of critical path EOT claims — measures schedule risk from time extension disputes."
    - name: "total_approved_claim_amount"
      expr: SUM(CASE WHEN determination_outcome = 'approved' THEN CAST(claim_final_amount AS DOUBLE) ELSE 0 END)
      comment: "Total approved claim amounts — measures actual financial liability from approved time extensions."
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`contract_subcontract`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Subcontract management KPIs tracking subcontract value, change order frequency, compliance status, and defects liability periods."
  source: "`vibe_construction_v1`.`contract`.`subcontract`"
  dimensions:
    - name: "subcontract_status"
      expr: subcontract_status
      comment: "Current status of the subcontract (e.g., active, completed, terminated, suspended)."
    - name: "subcontract_type"
      expr: subcontract_type
      comment: "Type of subcontract (e.g., labor only, supply and install, design and build)."
    - name: "contract_category"
      expr: contract_category
      comment: "Category of the subcontract (e.g., civil, mechanical, electrical, finishing)."
    - name: "compliance_status"
      expr: compliance_status
      comment: "Compliance status of the subcontract (e.g., compliant, non-compliant, under review)."
    - name: "risk_rating"
      expr: risk_rating
      comment: "Risk rating of the subcontract (e.g., high, medium, low)."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency in which the subcontract value is denominated."
    - name: "effective_year"
      expr: YEAR(effective_from)
      comment: "Year in which the subcontract became effective."
  measures:
    - name: "total_subcontract_value"
      expr: SUM(CAST(value_amount AS DOUBLE))
      comment: "Total subcontract value across all subcontracts — measures total subcontracted work value and supply chain exposure."
    - name: "total_liquidated_damages_amount"
      expr: SUM(CAST(liquidated_damages_amount AS DOUBLE))
      comment: "Total liquidated damages provisions in subcontracts — quantifies delay penalty exposure from subcontractors."
    - name: "avg_subcontract_value"
      expr: AVG(CAST(value_amount AS DOUBLE))
      comment: "Average subcontract value — measures typical subcontract package size."
    - name: "subcontract_count"
      expr: COUNT(DISTINCT subcontract_id)
      comment: "Number of distinct subcontracts — measures supply chain complexity and subcontractor management load."
    - name: "active_subcontract_count"
      expr: COUNT(DISTINCT CASE WHEN subcontract_status = 'active' THEN subcontract_id END)
      comment: "Number of active subcontracts — measures current subcontractor engagement level."
    - name: "non_compliant_subcontract_count"
      expr: COUNT(DISTINCT CASE WHEN compliance_status = 'non-compliant' THEN subcontract_id END)
      comment: "Number of non-compliant subcontracts — measures compliance risk and subcontractor performance issues."
    - name: "high_risk_subcontract_count"
      expr: COUNT(DISTINCT CASE WHEN risk_rating = 'high' THEN subcontract_id END)
      comment: "Number of high-risk subcontracts — measures supply chain risk concentration."
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`contract_subcontract_payment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Subcontract payment KPIs tracking payment amounts, retention, liquidated damages deductions, and payment timeliness."
  source: "`vibe_construction_v1`.`contract`.`subcontract_payment`"
  dimensions:
    - name: "subcontract_payment_status"
      expr: subcontract_payment_status
      comment: "Current status of the subcontract payment (e.g., pending, approved, paid, disputed)."
    - name: "payment_type"
      expr: payment_type
      comment: "Type of payment (e.g., progress payment, milestone payment, final payment, retention release)."
    - name: "payment_method"
      expr: payment_method
      comment: "Method of payment (e.g., bank transfer, check, electronic)."
    - name: "is_retention_applied"
      expr: is_retention_applied
      comment: "Flag indicating whether retention was applied to this payment."
    - name: "is_ld_deduction_applied"
      expr: is_ld_deduction_applied
      comment: "Flag indicating whether liquidated damages deduction was applied."
    - name: "is_late_payment"
      expr: is_late_payment
      comment: "Flag indicating whether the payment was made late (after due date)."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency in which the payment is denominated."
    - name: "payment_year"
      expr: YEAR(payment_date)
      comment: "Year in which the payment was made."
    - name: "payment_quarter"
      expr: CONCAT('Q', QUARTER(payment_date), '-', YEAR(payment_date))
      comment: "Quarter and year in which the payment was made."
  measures:
    - name: "total_gross_amount"
      expr: SUM(CAST(gross_amount AS DOUBLE))
      comment: "Total gross payment amounts to subcontractors — measures total subcontractor payment value before deductions."
    - name: "total_net_amount"
      expr: SUM(CAST(net_amount AS DOUBLE))
      comment: "Total net payment amounts to subcontractors — measures actual cash outflow to supply chain."
    - name: "total_retention_amount"
      expr: SUM(CAST(retention_amount AS DOUBLE))
      comment: "Total retention amounts withheld from subcontractors — measures working capital withheld in supply chain."
    - name: "total_ld_deduction_amount"
      expr: SUM(CAST(ld_deduction_amount AS DOUBLE))
      comment: "Total liquidated damages deducted from subcontractor payments — quantifies delay penalties applied to supply chain."
    - name: "total_adjustment_amount"
      expr: SUM(CAST(adjustment_amount AS DOUBLE))
      comment: "Total adjustment amounts in subcontractor payments — tracks payment variations and corrections."
    - name: "avg_retention_percent"
      expr: AVG(CAST(retention_percent AS DOUBLE))
      comment: "Average retention percentage applied to subcontractor payments — measures typical retention policy."
    - name: "subcontract_payment_count"
      expr: COUNT(DISTINCT subcontract_payment_id)
      comment: "Number of distinct subcontract payments — measures payment cycle frequency and supply chain cash flow activity."
    - name: "late_payment_count"
      expr: COUNT(DISTINCT CASE WHEN is_late_payment = TRUE THEN subcontract_payment_id END)
      comment: "Number of late payments to subcontractors — measures payment timeliness and supply chain relationship health."
    - name: "payments_with_ld_count"
      expr: COUNT(DISTINCT CASE WHEN is_ld_deduction_applied = TRUE THEN subcontract_payment_id END)
      comment: "Number of payments with liquidated damages deductions — measures frequency of subcontractor delay penalties."
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`contract_bond_guarantee`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Bond and guarantee KPIs tracking bond amounts, expiry management, call events, and compliance status."
  source: "`vibe_construction_v1`.`contract`.`bond_guarantee`"
  dimensions:
    - name: "bond_guarantee_status"
      expr: bond_guarantee_status
      comment: "Current status of the bond or guarantee (e.g., active, expired, called, released)."
    - name: "bond_type"
      expr: bond_type
      comment: "Type of bond or guarantee (e.g., performance bond, advance payment guarantee, retention bond, bid bond)."
    - name: "guarantee_purpose"
      expr: guarantee_purpose
      comment: "Purpose of the guarantee (e.g., performance security, payment security, warranty security)."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency in which the bond amount is denominated."
    - name: "jurisdiction"
      expr: jurisdiction
      comment: "Legal jurisdiction governing the bond or guarantee."
    - name: "issue_year"
      expr: YEAR(issue_date)
      comment: "Year in which the bond or guarantee was issued."
    - name: "expiry_year"
      expr: YEAR(expiry_date)
      comment: "Year in which the bond or guarantee expires."
  measures:
    - name: "total_bond_amount"
      expr: SUM(CAST(bond_amount AS DOUBLE))
      comment: "Total bond and guarantee amounts — measures total financial security held and bonding capacity utilization."
    - name: "avg_bond_amount"
      expr: AVG(CAST(bond_amount AS DOUBLE))
      comment: "Average bond amount — measures typical bond size and security requirements."
    - name: "avg_retention_percentage"
      expr: AVG(CAST(retention_percentage AS DOUBLE))
      comment: "Average retention percentage associated with bonds — measures typical retention policy linked to bonds."
    - name: "bond_guarantee_count"
      expr: COUNT(DISTINCT bond_guarantee_id)
      comment: "Number of distinct bonds and guarantees — measures bonding complexity and security instrument management load."
    - name: "active_bond_count"
      expr: COUNT(DISTINCT CASE WHEN bond_guarantee_status = 'active' THEN bond_guarantee_id END)
      comment: "Number of active bonds and guarantees — measures current bonding exposure and security in force."
    - name: "called_bond_count"
      expr: COUNT(DISTINCT CASE WHEN call_date IS NOT NULL THEN bond_guarantee_id END)
      comment: "Number of bonds called — measures contractor default frequency and security claim events."
    - name: "expired_bond_count"
      expr: COUNT(DISTINCT CASE WHEN bond_guarantee_status = 'expired' THEN bond_guarantee_id END)
      comment: "Number of expired bonds — measures bond renewal and extension management requirements."
$$;