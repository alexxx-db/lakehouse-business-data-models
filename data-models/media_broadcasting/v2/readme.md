# Media_Broadcasting Lakehouse Data Models

**Version 2** | Generated on June 30, 2026 at 06:38 AM

**Industry:** 

## Table of Contents

- [Business Description](#business-description)
- [Model Scope Variations](#model-scope-variations)
  - [MVM (Minimum Viable Model)](#mvm-minimum-viable-model--v2_mvm)
  - [ECM (Expanded Coverage Model)](#ecm-expanded-coverage-model--v2_ecm)
- [Head-to-Head Comparison](#head-to-head-comparison)
- [Model Metrics Comparison](#model-metrics-comparison)
- [Domain & Product Comparison](#domain--product-comparison)
  - [Advertising](#domain-advertising)
  - [Audience](#domain-audience)
  - [Billing](#domain-billing)
  - [Compliance](#domain-compliance)
  - [Content](#domain-content)
  - [Distribution](#domain-distribution)
  - [Finance](#domain-finance)
  - [Mediaasset](#domain-mediaasset)
  - [Partner](#domain-partner)
  - [Production](#domain-production)
  - [Rights](#domain-rights)
  - [Sales](#domain-sales)
  - [Scheduling](#domain-scheduling)
  - [Subscriber](#domain-subscriber)
  - [Talent](#domain-talent)
  - [Technology](#domain-technology)
  - [Workforce](#domain-workforce)


## Business Description

media broadcasting industry enterprise data model.

## Model Scope Variations

This data model is available in **two scope variations** — the **MVM (Minimum Viable Model)** and the **ECM (Expanded Coverage Model)** — each designed for different organizational needs and use cases. Both models share the same attribute depth per table; the difference is in breadth (number of domains and tables).

### MVM (Minimum Viable Model) — `v2_mvm`

The **MVM** is a production-ready, core data model that covers all essential business functions with full attribute depth. It is the recommended starting point for organizations that want to deploy quickly and expand incrementally. The MVM is ideal for:

- **Small-to-Mid Businesses** — A thin, efficient model for organizations that need a complete but focused data platform without the overhead of corporate back-office domains
- **Production-Ready Foundation** — Deploy to production from day one and grow by adding domains as business needs evolve
- **Proof-of-Concept & Demos** — Quick deployment for stakeholder presentations and proof-of-concept engagements
- **Targeted Analytics** — Focused analytical workloads centered on core business processes
- **Rapid Onboarding** — Simplified structure for teams getting started with the data platform
- **Development & Testing** — Lightweight model for development environments and integration testing

The MVM prioritizes **Operations** and **Business** division domains, excludes corporate/back-office functions, minimizes association (many-to-many bridge) tables, and relies on direct foreign key relationships for simplicity. Every table in the MVM has the **same attribute depth** as the ECM.

### ECM (Expanded Coverage Model) — `v2_ecm`

The **ECM** is a comprehensive, full-coverage data model that covers the complete breadth of business operations, including corporate functions, detailed audit trails, association tables, and granular reference data. It is designed for:

- **Enterprise-Scale Organizations** — Complete data platform for large-scale enterprises with complex operations
- **Full-Coverage Data Warehousing** — Lakehouse model supporting all business units and divisions
- **Regulatory & Compliance** — Includes audit, legal, and compliance domains required for governance
- **Cross-Functional Analytics** — Enables analysis across all divisions including HR, Finance, IT, and more

The ECM includes all domains from the MVM plus additional **Corporate/Supporting** division domains, many-to-many association tables, helper/lookup tables, and expanded attribute coverage.


## Head-to-Head Comparison

| Dimension | MVM (Minimum Viable Model) | ECM (Expanded Coverage Model) |
|---|---|---|
| **Folder Convention** | `v2/mvm` | `v2/ecm` |
| **Target Organization** | Small-to-mid businesses, startups, focused teams | Large enterprises, complex multi-division organizations |
| **Domain Coverage** | Core operations + business domains | All domains including corporate back-office |
| **Divisions Included** | Operations, Business | Operations, Business, Corporate |
| **Attribute Depth** | Full (same as ECM) | Full |
| **M:N Associations** | Minimized (direct FKs preferred) | Comprehensive junction tables |
| **Growth Path** | Start here, enlarge to ECM as needed | Complete from day one |
| **Best For** | Quick production deployments, focused analytics, POC, growing businesses | Organization-wide analytics, compliance, global operations |

## Model Metrics Comparison

| Metric | MVM (Minimum Viable Model) | ECM (Expanded Coverage Model) |
|---|---|---|
| Domains | 11 | 17 |
| Subdomains | 28 | 73 |
| Products (Tables) | 107 | 545 |
| Attributes (Columns) | 4357 | 20376 |
| Foreign Keys | 601 | 2700 |
| Avg Attributes/Product | 40.7 | 37.4 |

## Domain & Product Comparison

<a id="domain-advertising"></a>
### advertising

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| campaign_creative | ad_campaign | ✅ | ❌ | Excluded from MVM |
| campaign_creative | ad_creative | ✅ | ❌ | Excluded from MVM |
| campaign_creative | campaign | ✅ | ❌ | Excluded from MVM |
| campaign_creative | creative | ✅ | ✅ |  |
| campaign_targeting | advertising_campaign | ❌ | ✅ | MVM only (stub or new) |
| inventory_pricing | ad_inventory | ✅ | ✅ |  |
| inventory_pricing | ad_placement | ✅ | ❌ | Excluded from MVM |
| inventory_pricing | ad_type_ref | ✅ | ❌ | Excluded from MVM |
| inventory_pricing | inventory_type_ref | ✅ | ❌ | Excluded from MVM |
| inventory_pricing | placement | ✅ | ✅ |  |
| inventory_pricing | rate_card | ✅ | ✅ |  |
| performance_analytics | ad_performance | ✅ | ❌ | Excluded from MVM |
| performance_analytics | click | ✅ | ✅ |  |
| performance_analytics | conversion | ✅ | ✅ |  |
| performance_analytics | impression | ✅ | ✅ |  |
| targeting_delivery | ad_targeting | ✅ | ❌ | Excluded from MVM |
| targeting_delivery | frequency_cap | ✅ | ❌ | Excluded from MVM |
| targeting_delivery | targeting_rule | ✅ | ✅ |  |

<a id="domain-audience"></a>
### audience

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| audience_measurement | clean_room_match | ✅ | ❌ | Excluded from MVM |
| audience_measurement | cross_platform_measurement | ✅ | ✅ |  |
| audience_measurement | dsp_usage_report | ✅ | ❌ | Excluded from MVM |
| audience_measurement | engagement_event | ✅ | ✅ |  |
| audience_measurement | measurement_methodology | ✅ | ❌ | Excluded from MVM |
| audience_measurement | measurement_source_ref | ✅ | ❌ | Excluded from MVM |
| audience_measurement | nielsen_rating | ✅ | ✅ |  |
| audience_measurement | panel | ✅ | ✅ |  |
| audience_measurement | reach_frequency_report | ✅ | ✅ |  |
| audience_measurement | sweeps_period | ✅ | ❌ | Excluded from MVM |
| audience_measurement | viewability_record | ✅ | ❌ | Excluded from MVM |
| audience_measurement | viewership_record | ✅ | ✅ |  |
| personalization_features | content_feature_vector | ✅ | ❌ | Excluded from MVM |
| personalization_features | viewer_feature_vector | ✅ | ❌ | Excluded from MVM |
| segment_insights | audience_profile | ✅ | ✅ |  |
| segment_insights | demographic_category_ref | ✅ | ❌ | Excluded from MVM |
| segment_insights | demographic_segment | ✅ | ✅ |  |
| segment_insights | demographic_type_ref | ✅ | ❌ | Excluded from MVM |
| segment_insights | market_coverage | ✅ | ❌ | Excluded from MVM |
| segment_insights | market_distribution_agreement | ✅ | ❌ | Excluded from MVM |
| segment_insights | segment | ✅ | ❌ | Excluded from MVM |
| segment_insights | segment_regulatory_compliance | ✅ | ❌ | Excluded from MVM |
| segment_insights | talent_demographic_appeal | ✅ | ❌ | Excluded from MVM |

<a id="domain-billing"></a>
### billing

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| account_configuration | billing_account | ✅ | ❌ | Domain not in MVM |
| account_configuration | billing_product | ✅ | ❌ | Domain not in MVM |
| account_configuration | communication_template | ✅ | ❌ | Domain not in MVM |
| account_configuration | cycle | ✅ | ❌ | Domain not in MVM |
| account_configuration | invoice_status_ref | ✅ | ❌ | Domain not in MVM |
| account_configuration | run | ✅ | ❌ | Domain not in MVM |
| invoice_management | ad_billing_order | ✅ | ❌ | Domain not in MVM |
| invoice_management | ad_billing_reconciliation | ✅ | ❌ | Domain not in MVM |
| invoice_management | billing_carriage_fee_invoice | ✅ | ❌ | Domain not in MVM |
| invoice_management | credit_memo | ✅ | ❌ | Domain not in MVM |
| invoice_management | invoice | ✅ | ❌ | Domain not in MVM |
| invoice_management | invoice_line | ✅ | ❌ | Domain not in MVM |
| invoice_management | subscription_invoice | ✅ | ❌ | Domain not in MVM |
| invoice_management | syndication_license_fee | ✅ | ❌ | Domain not in MVM |
| payment_collections | billing_dispute | ✅ | ❌ | Domain not in MVM |
| payment_collections | dunning_event | ✅ | ❌ | Domain not in MVM |
| payment_collections | payment | ✅ | ❌ | Domain not in MVM |
| payment_collections | payment_allocation | ✅ | ❌ | Domain not in MVM |
| payment_collections | payment_method | ✅ | ❌ | Domain not in MVM |
| payment_collections | payment_method_type_ref | ✅ | ❌ | Domain not in MVM |
| payment_collections | payment_status_ref | ✅ | ❌ | Domain not in MVM |
| payment_collections | refund | ✅ | ❌ | Domain not in MVM |
| payment_collections | write_off | ✅ | ❌ | Domain not in MVM |
| revenue_tax | revenue_recognition_schedule | ✅ | ❌ | Domain not in MVM |
| revenue_tax | tax_record | ✅ | ❌ | Domain not in MVM |

<a id="domain-compliance"></a>
### compliance

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| audit_risk | audit | ✅ | ❌ | Domain not in MVM |
| audit_risk | audit_finding | ✅ | ❌ | Domain not in MVM |
| audit_risk | incident | ✅ | ❌ | Domain not in MVM |
| audit_risk | incident_severity_ref | ✅ | ❌ | Domain not in MVM |
| audit_risk | sox_control | ✅ | ❌ | Domain not in MVM |
| content_standards | accessibility_obligation | ✅ | ❌ | Domain not in MVM |
| content_standards | ad_standards_clearance | ✅ | ❌ | Domain not in MVM |
| content_standards | closed_caption_record | ✅ | ❌ | Domain not in MVM |
| content_standards | content_rating | ✅ | ❌ | Domain not in MVM |
| content_standards | correction_record | ✅ | ❌ | Domain not in MVM |
| content_standards | eas_log | ✅ | ❌ | Domain not in MVM |
| content_standards | political_ad_record | ✅ | ❌ | Domain not in MVM |
| content_standards | technical_standard_cert | ✅ | ❌ | Domain not in MVM |
| facility_governance | facility_compliance | ✅ | ❌ | Domain not in MVM |
| facility_governance | facility_compliance_obligation | ✅ | ❌ | Domain not in MVM |
| licensing_filings | broadcast_license | ✅ | ❌ | Domain not in MVM |
| licensing_filings | calendar | ✅ | ❌ | Domain not in MVM |
| licensing_filings | filing_status_ref | ✅ | ❌ | Domain not in MVM |
| licensing_filings | license_renewal | ✅ | ❌ | Domain not in MVM |
| licensing_filings | public_inspection_file | ✅ | ❌ | Domain not in MVM |
| licensing_filings | regulatory_body_ref | ✅ | ❌ | Domain not in MVM |
| licensing_filings | regulatory_change | ✅ | ❌ | Domain not in MVM |
| licensing_filings | regulatory_filing | ✅ | ❌ | Domain not in MVM |
| licensing_filings | regulatory_obligation | ✅ | ❌ | Domain not in MVM |
| privacy_consent | anti_piracy_takedown | ✅ | ❌ | Domain not in MVM |
| privacy_consent | compliance_consent_record | ✅ | ❌ | Domain not in MVM |
| privacy_consent | compliance_watermark_forensic_match | ✅ | ❌ | Domain not in MVM |
| privacy_consent | coppa_declaration | ✅ | ❌ | Domain not in MVM |
| privacy_consent | privacy_request | ✅ | ❌ | Domain not in MVM |

<a id="domain-content"></a>
### content

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| catalog_master | composition | ✅ | ❌ | Excluded from MVM |
| catalog_master | content_episode | ✅ | ✅ |  |
| catalog_master | content_library | ✅ | ❌ | Excluded from MVM |
| catalog_master | content_portfolio | ✅ | ❌ | Excluded from MVM |
| catalog_master | identifier | ✅ | ❌ | Excluded from MVM |
| catalog_master | master_recording | ✅ | ❌ | Excluded from MVM |
| catalog_master | podcast_episode | ✅ | ❌ | Excluded from MVM |
| catalog_master | podcast_show | ✅ | ❌ | Excluded from MVM |
| catalog_master | release | ✅ | ❌ | Excluded from MVM |
| catalog_master | season | ✅ | ✅ |  |
| catalog_master | series | ✅ | ✅ |  |
| catalog_master | taxonomy | ✅ | ❌ | Excluded from MVM |
| catalog_master | title | ✅ | ✅ |  |
| catalog_master | title_relationship | ✅ | ❌ | Excluded from MVM |
| catalog_master | version | ✅ | ✅ |  |
| catalog_master | vod_library | ✅ | ❌ | Excluded from MVM |
| credits_talent | athlete | ✅ | ❌ | Excluded from MVM |
| credits_talent | credit | ✅ | ❌ | Excluded from MVM |
| credits_talent | news_story | ✅ | ❌ | Excluded from MVM |
| credits_talent | series_crew_assignment | ✅ | ❌ | Excluded from MVM |
| credits_talent | series_talent_credit | ✅ | ❌ | Excluded from MVM |
| credits_talent | sports_competition | ✅ | ❌ | Excluded from MVM |
| credits_talent | sports_event | ✅ | ❌ | Excluded from MVM |
| credits_talent | sports_league | ✅ | ❌ | Excluded from MVM |
| credits_talent | sports_team | ✅ | ❌ | Excluded from MVM |
| credits_talent | talent_credit | ✅ | ✅ |  |
| credits_talent | voice_actor_assignment | ✅ | ❌ | Excluded from MVM |
| distribution_lifecycle | distribution_package | ✅ | ❌ | Excluded from MVM |
| distribution_lifecycle | dubbing_session | ✅ | ❌ | Excluded from MVM |
| distribution_lifecycle | episode_transmission | ✅ | ❌ | Excluded from MVM |
| distribution_lifecycle | ingest_event | ✅ | ❌ | Excluded from MVM |
| distribution_lifecycle | lifecycle_event | ✅ | ✅ |  |
| distribution_lifecycle | localization | ✅ | ❌ | Excluded from MVM |
| distribution_lifecycle | package | ✅ | ✅ |  |
| distribution_lifecycle | package_inclusion | ✅ | ❌ | Excluded from MVM |
| distribution_lifecycle | podcast_dynamic_ad_insertion | ✅ | ❌ | Excluded from MVM |
| distribution_lifecycle | title_asset_usage | ✅ | ❌ | Excluded from MVM |
| distribution_lifecycle | windowing_plan | ✅ | ❌ | Excluded from MVM |
| distribution_packaging | package_title | ❌ | ✅ | MVM only (stub or new) |
| editorial_metadata | artwork | ✅ | ✅ |  |
| editorial_metadata | audio_format_ref | ✅ | ❌ | Excluded from MVM |
| editorial_metadata | color_format_ref | ✅ | ❌ | Excluded from MVM |
| editorial_metadata | content_status_ref | ✅ | ❌ | Excluded from MVM |
| editorial_metadata | content_type_ref | ✅ | ❌ | Excluded from MVM |
| editorial_metadata | country_ref | ✅ | ❌ | Excluded from MVM |
| editorial_metadata | episode_type_ref | ✅ | ❌ | Excluded from MVM |
| editorial_metadata | genre | ✅ | ✅ |  |
| editorial_metadata | hdr_format_ref | ✅ | ❌ | Excluded from MVM |
| editorial_metadata | language_ref | ✅ | ❌ | Excluded from MVM |
| editorial_metadata | metadata_profile | ✅ | ❌ | Excluded from MVM |
| editorial_metadata | rating | ✅ | ✅ |  |
| editorial_metadata | resolution_ref | ✅ | ❌ | Excluded from MVM |
| editorial_metadata | series_status_ref | ✅ | ❌ | Excluded from MVM |
| editorial_metadata | series_type_ref | ✅ | ❌ | Excluded from MVM |
| editorial_metadata | tag | ✅ | ❌ | Excluded from MVM |
| editorial_metadata | video_resolution_ref | ✅ | ❌ | Excluded from MVM |
| rights_clearance | acquisition | ✅ | ✅ |  |
| rights_clearance | billing_line | ✅ | ❌ | Excluded from MVM |
| rights_clearance | compliance_finding | ✅ | ❌ | Excluded from MVM |
| rights_clearance | content_clearance | ✅ | ❌ | Excluded from MVM |
| rights_clearance | content_provenance | ✅ | ❌ | Excluded from MVM |
| rights_clearance | genre_buy_agreement | ✅ | ❌ | Excluded from MVM |
| rights_clearance | title_rights_grant | ✅ | ❌ | Excluded from MVM |

<a id="domain-distribution"></a>
### distribution

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| carriage_partnerships | affiliate_station | ✅ | ❌ | Excluded from MVM |
| carriage_partnerships | carriage_agreement | ✅ | ✅ |  |
| carriage_partnerships | channel_lineup | ✅ | ❌ | Excluded from MVM |
| carriage_partnerships | deal | ✅ | ✅ |  |
| carriage_partnerships | distribution_carriage_fee_invoice | ✅ | ❌ | Excluded from MVM |
| carriage_partnerships | distribution_local_avail_inventory | ✅ | ❌ | Excluded from MVM |
| carriage_partnerships | distribution_network_clearance | ✅ | ❌ | Excluded from MVM |
| carriage_partnerships | distribution_partner | ✅ | ❌ | Excluded from MVM |
| carriage_partnerships | platform_distribution_agreement | ✅ | ❌ | Excluded from MVM |
| carriage_partnerships | release_window | ✅ | ❌ | Excluded from MVM |
| carriage_partnerships | retransmission_consent | ✅ | ❌ | Excluded from MVM |
| carriage_partnerships | subscriber_count_report | ✅ | ❌ | Excluded from MVM |
| content_delivery | betting_data_feed | ✅ | ❌ | Excluded from MVM |
| content_delivery | cdn_configuration | ✅ | ❌ | Excluded from MVM |
| content_delivery | channel_compliance | ✅ | ❌ | Excluded from MVM |
| content_delivery | clip_distribution_event | ✅ | ❌ | Excluded from MVM |
| content_delivery | content_delivery_order | ✅ | ✅ |  |
| content_delivery | dai_session | ✅ | ❌ | Excluded from MVM |
| content_delivery | delivery_channel | ✅ | ✅ |  |
| content_delivery | delivery_event | ✅ | ✅ |  |
| content_delivery | delivery_sla | ✅ | ❌ | Excluded from MVM |
| content_delivery | drm_policy | ✅ | ❌ | Excluded from MVM |
| content_delivery | drm_type_ref | ✅ | ❌ | Excluded from MVM |
| content_delivery | multi_angle_feed | ✅ | ❌ | Excluded from MVM |
| content_delivery | playout | ✅ | ❌ | Excluded from MVM |
| content_delivery | playout_feed | ✅ | ❌ | Excluded from MVM |
| content_delivery | signal_route | ✅ | ❌ | Excluded from MVM |
| content_delivery | sla_breach | ✅ | ❌ | Excluded from MVM |
| content_delivery | social_distribution_outlet | ✅ | ❌ | Excluded from MVM |
| partner_agreements | partner | ❌ | ✅ | In ECM under domain(s): partner |
| platform_operations | ab_test_assignment | ✅ | ❌ | Excluded from MVM |
| platform_operations | abr_profile | ✅ | ❌ | Excluded from MVM |
| platform_operations | api_endpoint | ✅ | ❌ | Excluded from MVM |
| platform_operations | app_version | ✅ | ❌ | Excluded from MVM |
| platform_operations | dai_configuration | ✅ | ❌ | Excluded from MVM |
| platform_operations | device_type | ✅ | ❌ | Excluded from MVM |
| platform_operations | device_type_category_ref | ✅ | ❌ | Excluded from MVM |
| platform_operations | endpoint_allocation | ✅ | ❌ | Excluded from MVM |
| platform_operations | feature_flag | ✅ | ❌ | Excluded from MVM |
| platform_operations | frequency_cap_state | ✅ | ❌ | Excluded from MVM |
| platform_operations | ott_platform | ✅ | ✅ |  |
| platform_operations | personalization_engine | ✅ | ❌ | Excluded from MVM |
| platform_operations | platform_type_ref | ✅ | ❌ | Excluded from MVM |
| platform_operations | playback_session | ✅ | ✅ |  |
| platform_operations | qos_event | ✅ | ❌ | Excluded from MVM |
| platform_operations | recommendation_event | ✅ | ❌ | Excluded from MVM |
| platform_operations | sla_definition | ✅ | ❌ | Excluded from MVM |
| platform_operations | sla_performance | ✅ | ❌ | Excluded from MVM |
| platform_operations | streaming_endpoint | ✅ | ✅ |  |

<a id="domain-finance"></a>
### finance

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| budget_planning | budget_version | ✅ | ❌ | Domain not in MVM |
| budget_planning | obligation_gl_mapping | ✅ | ❌ | Domain not in MVM |
| budget_planning | production_budget | ✅ | ❌ | Domain not in MVM |
| capital_assets | capex_project | ✅ | ❌ | Domain not in MVM |
| capital_assets | depreciation_run | ✅ | ❌ | Domain not in MVM |
| capital_assets | depreciation_schedule | ✅ | ❌ | Domain not in MVM |
| capital_assets | fixed_asset | ✅ | ❌ | Domain not in MVM |
| capital_assets | project_assignment | ✅ | ❌ | Domain not in MVM |
| general_accounting | account_type_ref | ✅ | ❌ | Domain not in MVM |
| general_accounting | accounts_payable | ✅ | ❌ | Domain not in MVM |
| general_accounting | chart_of_accounts | ✅ | ❌ | Domain not in MVM |
| general_accounting | cost_allocation | ✅ | ❌ | Domain not in MVM |
| general_accounting | cost_center | ✅ | ❌ | Domain not in MVM |
| general_accounting | cost_center_authorization | ✅ | ❌ | Domain not in MVM |
| general_accounting | cost_center_obligation_allocation | ✅ | ❌ | Domain not in MVM |
| general_accounting | currency_ref | ✅ | ❌ | Domain not in MVM |
| general_accounting | ebitda_snapshot | ✅ | ❌ | Domain not in MVM |
| general_accounting | facility_cost_allocation | ✅ | ❌ | Domain not in MVM |
| general_accounting | facility_legal_assignment | ✅ | ❌ | Domain not in MVM |
| general_accounting | financial_reconciliation | ✅ | ❌ | Domain not in MVM |
| general_accounting | general_ledger | ✅ | ❌ | Domain not in MVM |
| general_accounting | intercompany_transaction | ✅ | ❌ | Domain not in MVM |
| general_accounting | journal_entry | ✅ | ❌ | Domain not in MVM |
| general_accounting | legal_entity | ✅ | ❌ | Domain not in MVM |
| general_accounting | period_close | ✅ | ❌ | Domain not in MVM |
| general_accounting | profit_center | ✅ | ❌ | Domain not in MVM |
| general_accounting | recurring_entry_template | ✅ | ❌ | Domain not in MVM |
| general_accounting | source_document | ✅ | ❌ | Domain not in MVM |
| general_accounting | tax_posting | ✅ | ❌ | Domain not in MVM |
| revenue_recognition | accounts_receivable | ✅ | ❌ | Domain not in MVM |
| revenue_recognition | revenue_recognition_event | ✅ | ❌ | Domain not in MVM |
| revenue_recognition | revenue_stream | ✅ | ❌ | Domain not in MVM |

<a id="domain-mediaasset"></a>
### mediaasset

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| asset_catalog | asset_collection | ✅ | ❌ | Excluded from MVM |
| asset_catalog | asset_status_ref | ✅ | ❌ | Excluded from MVM |
| asset_catalog | asset_version | ✅ | ✅ |  |
| asset_catalog | collection_membership | ✅ | ❌ | Excluded from MVM |
| asset_catalog | format_migration | ✅ | ❌ | Excluded from MVM |
| asset_catalog | format_specification | ✅ | ❌ | Excluded from MVM |
| asset_catalog | media_asset | ✅ | ✅ |  |
| media_processing | asset_access_request | ✅ | ❌ | Excluded from MVM |
| media_processing | asset_lifecycle_event | ✅ | ❌ | Excluded from MVM |
| media_processing | ingest_job | ✅ | ✅ |  |
| media_processing | qc_inspection | ✅ | ✅ |  |
| media_processing | transcode_job | ✅ | ✅ |  |
| rights_compliance | asset_legal_hold | ✅ | ❌ | Excluded from MVM |
| rights_compliance | asset_rights_grant | ✅ | ❌ | Excluded from MVM |
| rights_compliance | deal_asset_license | ✅ | ❌ | Excluded from MVM |
| rights_compliance | legal_hold | ✅ | ❌ | Excluded from MVM |
| rights_compliance | mediaasset_watermark_forensic_match | ✅ | ❌ | Excluded from MVM |
| rights_compliance | syndication_inventory | ✅ | ❌ | Excluded from MVM |
| storage_archival | archive_record | ✅ | ✅ |  |
| storage_archival | asset_storage_assignment | ✅ | ✅ |  |
| storage_archival | retention_policy | ✅ | ❌ | Excluded from MVM |
| storage_archival | storage_location | ✅ | ✅ |  |
| storage_archival | storage_tier_ref | ✅ | ❌ | Excluded from MVM |

<a id="domain-partner"></a>
### partner

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| deal_lifecycle | acquisition_deal | ✅ | ❌ | Domain not in MVM |
| deal_lifecycle | acquisition_deal_line | ✅ | ❌ | Domain not in MVM |
| deal_lifecycle | affiliate_agreement | ✅ | ❌ | Domain not in MVM |
| deal_lifecycle | coproduction_agreement | ✅ | ❌ | Domain not in MVM |
| deal_lifecycle | deal_amendment | ✅ | ❌ | Domain not in MVM |
| deal_lifecycle | deal_negotiation | ✅ | ❌ | Domain not in MVM |
| deal_lifecycle | deal_status_ref | ✅ | ❌ | Domain not in MVM |
| deal_lifecycle | distribution_agreement | ✅ | ❌ | Domain not in MVM |
| deal_lifecycle | partner_agreement | ✅ | ❌ | Domain not in MVM |
| deal_lifecycle | partner_deal_approval | ✅ | ❌ | Domain not in MVM |
| deal_lifecycle | renewal | ✅ | ❌ | Domain not in MVM |
| deal_lifecycle | syndication_agreement | ✅ | ❌ | Domain not in MVM |
| financial_settlement | carriage_fee_schedule | ✅ | ❌ | Domain not in MVM |
| financial_settlement | payment_schedule | ✅ | ❌ | Domain not in MVM |
| financial_settlement | payment_term | ✅ | ❌ | Domain not in MVM |
| obligation_management | deal_compliance_obligation | ✅ | ❌ | Domain not in MVM |
| obligation_management | delivery_obligation | ✅ | ❌ | Domain not in MVM |
| obligation_management | license_ownership | ✅ | ❌ | Domain not in MVM |
| obligation_management | minimum_guarantee | ✅ | ❌ | Domain not in MVM |
| obligation_management | partner_audit_event | ✅ | ❌ | Domain not in MVM |
| obligation_management | partner_content_window | ✅ | ❌ | Domain not in MVM |
| obligation_management | partner_dispute | ✅ | ❌ | Domain not in MVM |
| obligation_management | performance_obligation | ✅ | ❌ | Domain not in MVM |
| obligation_management | territory_grant | ✅ | ❌ | Domain not in MVM |
| partner_registry | partner | ✅ | ❌ | Domain not in MVM |
| partner_registry | partner_contact | ✅ | ❌ | Domain not in MVM |
| partner_registry | partner_pro_affiliation | ✅ | ❌ | Domain not in MVM |
| partner_registry | partner_type_ref | ✅ | ❌ | Domain not in MVM |
| partner_registry | publisher | ✅ | ❌ | Domain not in MVM |
| partner_registry | vendor | ✅ | ❌ | Domain not in MVM |

<a id="domain-production"></a>
### production

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| compliance_clearance | production_clearance | ✅ | ❌ | Excluded from MVM |
| compliance_clearance | production_dubbing_session | ✅ | ❌ | Excluded from MVM |
| compliance_clearance | production_voice_actor_assignment | ✅ | ❌ | Excluded from MVM |
| compliance_clearance | rating_submission | ✅ | ❌ | Excluded from MVM |
| cost_control | budget | ✅ | ✅ |  |
| cost_control | budget_line | ✅ | ✅ |  |
| cost_control | budget_status_ref | ✅ | ❌ | Excluded from MVM |
| cost_control | cost_transaction | ✅ | ✅ |  |
| cost_control | episode_sponsorship | ✅ | ❌ | Excluded from MVM |
| cost_control | insurance_policy | ✅ | ❌ | Excluded from MVM |
| cost_control | project_sponsorship | ✅ | ❌ | Excluded from MVM |
| post_quality | deliverable | ✅ | ✅ |  |
| post_quality | format_spec | ✅ | ❌ | Excluded from MVM |
| post_quality | ingest_record | ✅ | ❌ | Excluded from MVM |
| post_quality | post_production_task | ✅ | ❌ | Excluded from MVM |
| post_quality | qc_review | ✅ | ✅ |  |
| post_quality | qc_status_ref | ✅ | ❌ | Excluded from MVM |
| post_quality | vfx_shot | ✅ | ❌ | Excluded from MVM |
| production_operations | broadcast | ✅ | ❌ | Excluded from MVM |
| production_operations | call_sheet | ✅ | ❌ | Excluded from MVM |
| production_operations | daily_production_report | ✅ | ❌ | Excluded from MVM |
| production_operations | shoot_day | ✅ | ❌ | Excluded from MVM |
| production_operations | shoot_schedule | ✅ | ❌ | Excluded from MVM |
| project_planning | milestone | ✅ | ✅ |  |
| project_planning | production_episode | ✅ | ✅ |  |
| project_planning | project | ✅ | ✅ |  |
| project_planning | project_status_ref | ✅ | ❌ | Excluded from MVM |
| project_planning | script | ✅ | ✅ |  |
| resource_allocation | crew_assignment | ✅ | ✅ |  |
| resource_allocation | equipment_allocation | ✅ | ❌ | Excluded from MVM |
| resource_allocation | equipment_item | ✅ | ❌ | Excluded from MVM |
| resource_allocation | equipment_type | ✅ | ❌ | Excluded from MVM |
| resource_allocation | facility_booking | ✅ | ❌ | Excluded from MVM |
| resource_allocation | location | ✅ | ❌ | Excluded from MVM |
| resource_allocation | rental_agreement | ✅ | ❌ | Excluded from MVM |

<a id="domain-rights"></a>
### rights

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| compliance_audit | clearance_request | ✅ | ✅ |  |
| compliance_audit | conflict | ✅ | ❌ | Excluded from MVM |
| compliance_audit | rights_audit_event | ✅ | ❌ | Excluded from MVM |
| compliance_audit | rights_audit_session | ✅ | ❌ | Excluded from MVM |
| licensing_agreements | holder | ✅ | ✅ |  |
| licensing_agreements | license_agreement | ✅ | ✅ |  |
| licensing_agreements | license_amendment | ✅ | ❌ | Excluded from MVM |
| licensing_agreements | license_fee_schedule | ✅ | ❌ | Excluded from MVM |
| licensing_agreements | music_sync_license | ✅ | ✅ |  |
| licensing_agreements | rights_syndication_deal | ✅ | ❌ | Excluded from MVM |
| reference_data | exploitation_type_ref | ✅ | ❌ | Excluded from MVM |
| reference_data | grant_type_ref | ✅ | ❌ | Excluded from MVM |
| reference_data | license_status_ref | ✅ | ❌ | Excluded from MVM |
| reference_data | rights_pro_affiliation | ✅ | ❌ | Excluded from MVM |
| reference_data | rights_status_ref | ✅ | ❌ | Excluded from MVM |
| reference_data | rights_type_ref | ✅ | ❌ | Excluded from MVM |
| rights_entitlement | event_blackout_rule | ✅ | ❌ | Excluded from MVM |
| rights_entitlement | grant | ✅ | ✅ |  |
| rights_entitlement | holdback | ✅ | ✅ |  |
| rights_entitlement | rights_availability_window | ✅ | ❌ | Excluded from MVM |
| rights_entitlement | rights_blackout_rule | ✅ | ❌ | Excluded from MVM |
| rights_entitlement | rights_content_window | ✅ | ❌ | Excluded from MVM |
| rights_entitlement | rights_territory | ✅ | ❌ | Excluded from MVM |
| royalty_settlement | exploitation_report | ✅ | ❌ | Excluded from MVM |
| royalty_settlement | mechanical_royalty_report | ✅ | ❌ | Excluded from MVM |
| royalty_settlement | neighbouring_rights_claim | ✅ | ❌ | Excluded from MVM |
| royalty_settlement | residual | ✅ | ✅ |  |
| royalty_settlement | royalty_rule | ✅ | ✅ |  |
| royalty_settlement | royalty_statement | ✅ | ✅ |  |
| royalty_settlement | royalty_statement_line | ✅ | ✅ |  |

<a id="domain-sales"></a>
### sales

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| account_management | advertiser | ✅ | ✅ |  |
| account_management | agency_commission | ✅ | ❌ | Excluded from MVM |
| account_management | brand | ✅ | ❌ | Excluded from MVM |
| account_management | facility_service_agreement | ✅ | ❌ | Excluded from MVM |
| account_management | sales_account | ✅ | ❌ | Excluded from MVM |
| account_management | sales_agency | ✅ | ✅ |  |
| account_management | sales_contact | ✅ | ❌ | Excluded from MVM |
| ad_sales | ad_order | ✅ | ✅ |  |
| ad_sales | ad_order_line | ✅ | ✅ |  |
| ad_sales | ad_sales_order | ✅ | ❌ | Excluded from MVM |
| ad_sales | campaign_funding | ✅ | ❌ | Excluded from MVM |
| ad_sales | order_line | ✅ | ❌ | Excluded from MVM |
| ad_sales | sales_campaign | ✅ | ✅ |  |
| ad_sales | sales_scatter_order | ✅ | ❌ | Excluded from MVM |
| ad_sales | scatter_order | ✅ | ❌ | Excluded from MVM |
| ad_sales | sponsorship | ✅ | ❌ | Excluded from MVM |
| client_management | account | ❌ | ✅ | MVM only (stub or new) |
| deal_negotiation | advertiser_commitments | ✅ | ❌ | Excluded from MVM |
| deal_negotiation | carriage_deal | ✅ | ❌ | Excluded from MVM |
| deal_negotiation | content_license_deal | ✅ | ❌ | Excluded from MVM |
| deal_negotiation | opportunity | ✅ | ✅ |  |
| deal_negotiation | proposal | ✅ | ✅ |  |
| deal_negotiation | proposal_distribution | ✅ | ❌ | Excluded from MVM |
| deal_negotiation | proposal_line | ✅ | ✅ |  |
| deal_negotiation | rfp | ✅ | ❌ | Excluded from MVM |
| deal_negotiation | sales_proposal | ✅ | ❌ | Excluded from MVM |
| deal_negotiation | sales_syndication_deal | ✅ | ❌ | Excluded from MVM |
| deal_negotiation | upfront_commitment | ✅ | ❌ | Excluded from MVM |
| deal_negotiation | upfront_deal | ✅ | ✅ |  |
| deal_negotiation | upfront_option_exercise | ✅ | ❌ | Excluded from MVM |
| inventory_delivery | ad_pod | ✅ | ❌ | Excluded from MVM |
| inventory_delivery | ad_spot | ✅ | ✅ |  |
| inventory_delivery | advertising_audience_guarantee | ✅ | ❌ | Excluded from MVM |
| inventory_delivery | affidavit | ✅ | ❌ | Excluded from MVM |
| inventory_delivery | avail | ✅ | ❌ | Excluded from MVM |
| inventory_delivery | impression_delivery | ✅ | ❌ | Excluded from MVM |
| inventory_delivery | isci_creative | ✅ | ❌ | Excluded from MVM |
| inventory_delivery | makegood | ✅ | ❌ | Excluded from MVM |
| inventory_delivery | political_ad_disclosure | ✅ | ❌ | Excluded from MVM |
| inventory_delivery | sales_local_avail_inventory | ✅ | ❌ | Excluded from MVM |
| programmatic_trading | bid_request | ✅ | ❌ | Excluded from MVM |
| programmatic_trading | bid_response | ✅ | ❌ | Excluded from MVM |
| programmatic_trading | dai_event | ✅ | ❌ | Excluded from MVM |
| programmatic_trading | dsp | ✅ | ❌ | Excluded from MVM |
| programmatic_trading | exchange | ✅ | ❌ | Excluded from MVM |
| programmatic_trading | private_marketplace_deal | ✅ | ❌ | Excluded from MVM |
| programmatic_trading | ssp | ✅ | ❌ | Excluded from MVM |
| revenue_operations | campaign_status_ref | ✅ | ❌ | Excluded from MVM |
| revenue_operations | forecast | ✅ | ❌ | Excluded from MVM |
| revenue_operations | order_status_ref | ✅ | ❌ | Excluded from MVM |
| revenue_operations | proposal_status_ref | ✅ | ❌ | Excluded from MVM |
| revenue_operations | rep | ✅ | ❌ | Excluded from MVM |
| revenue_operations | sales_deal_approval | ✅ | ❌ | Excluded from MVM |
| revenue_operations | sales_product | ✅ | ❌ | Excluded from MVM |
| revenue_operations | sales_team | ✅ | ❌ | Excluded from MVM |
| revenue_operations | sales_territory | ✅ | ❌ | Excluded from MVM |

<a id="domain-scheduling"></a>
### scheduling

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| carriage_distribution | channel_allocation | ✅ | ❌ | Excluded from MVM |
| carriage_distribution | channel_carriage | ✅ | ❌ | Excluded from MVM |
| carriage_distribution | channel_license | ✅ | ✅ |  |
| carriage_distribution | channel_targeting | ✅ | ❌ | Excluded from MVM |
| carriage_distribution | scheduling_local_avail_inventory | ✅ | ❌ | Excluded from MVM |
| carriage_distribution | scheduling_network_clearance | ✅ | ❌ | Excluded from MVM |
| channel_programming | channel | ✅ | ✅ |  |
| channel_programming | daypart | ✅ | ✅ |  |
| channel_programming | epg_entry | ✅ | ✅ |  |
| channel_programming | program_rundown | ✅ | ✅ |  |
| channel_programming | program_schedule | ✅ | ✅ |  |
| channel_programming | rundown_item | ✅ | ✅ |  |
| channel_programming | schedule_slot | ✅ | ✅ |  |
| channel_programming | schedule_status_ref | ✅ | ❌ | Excluded from MVM |
| channel_programming | scheduling_availability_window | ✅ | ❌ | Excluded from MVM |
| channel_programming | simulcast_config | ✅ | ❌ | Excluded from MVM |
| playout_operations | ad_break | ✅ | ✅ |  |
| playout_operations | channel_abr_assignment | ✅ | ❌ | Excluded from MVM |
| playout_operations | channel_asset_playout | ✅ | ❌ | Excluded from MVM |
| playout_operations | daypart_assignment | ✅ | ❌ | Excluded from MVM |
| playout_operations | playout_event | ✅ | ✅ |  |
| playout_operations | scheduling_blackout_rule | ✅ | ❌ | Excluded from MVM |
| playout_operations | scte_marker | ✅ | ❌ | Excluded from MVM |

<a id="domain-subscriber"></a>
### subscriber

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| account_identity | device_registration | ✅ | ✅ |  |
| account_identity | household | ✅ | ✅ |  |
| account_identity | mvpd_affiliation | ✅ | ❌ | Excluded from MVM |
| account_identity | parental_control | ✅ | ❌ | Excluded from MVM |
| account_identity | subscriber | ✅ | ✅ |  |
| account_identity | viewer_profile | ✅ | ✅ |  |
| engagement_support | communication_preference | ✅ | ❌ | Excluded from MVM |
| engagement_support | csat_survey | ✅ | ❌ | Excluded from MVM |
| engagement_support | subscriber_consent_record | ✅ | ❌ | Excluded from MVM |
| engagement_support | support_case | ✅ | ❌ | Excluded from MVM |
| offer_monetization | offer | ✅ | ❌ | Excluded from MVM |
| offer_monetization | offer_redemption | ✅ | ❌ | Excluded from MVM |
| offer_monetization | payment_instrument | ✅ | ✅ |  |
| offer_monetization | win_back_offer | ✅ | ❌ | Excluded from MVM |
| subscription_lifecycle | add_on | ✅ | ❌ | Excluded from MVM |
| subscription_lifecycle | churn_event | ✅ | ✅ |  |
| subscription_lifecycle | churn_reason_ref | ✅ | ❌ | Excluded from MVM |
| subscription_lifecycle | entitlement | ✅ | ✅ |  |
| subscription_lifecycle | subscription | ✅ | ✅ |  |
| subscription_lifecycle | subscription_change | ✅ | ❌ | Excluded from MVM |
| subscription_lifecycle | subscription_plan | ✅ | ✅ |  |
| subscription_lifecycle | subscription_status_ref | ✅ | ❌ | Excluded from MVM |

<a id="domain-talent"></a>
### talent

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| compensation_residuals | bonus_trigger | ✅ | ❌ | Excluded from MVM |
| compensation_residuals | cba_rate_card | ✅ | ❌ | Excluded from MVM |
| compensation_residuals | compensation_structure | ✅ | ✅ |  |
| compensation_residuals | deferred_compensation | ✅ | ❌ | Excluded from MVM |
| compensation_residuals | participation_definition | ✅ | ❌ | Excluded from MVM |
| compensation_residuals | participation_statement | ✅ | ❌ | Excluded from MVM |
| compensation_residuals | pension_health_contribution | ✅ | ❌ | Excluded from MVM |
| compensation_residuals | residual_eligibility | ✅ | ✅ |  |
| compensation_residuals | residual_payment | ✅ | ✅ |  |
| contract_engagement | clearance | ❌ | ✅ | MVM only (stub or new) |
| contract_management | contract | ✅ | ✅ |  |
| contract_management | contract_amendment | ✅ | ❌ | Excluded from MVM |
| contract_management | contract_option | ✅ | ❌ | Excluded from MVM |
| contract_management | contract_status_ref | ✅ | ❌ | Excluded from MVM |
| contract_management | deal_memo | ✅ | ✅ |  |
| contract_management | endorsement_deal | ✅ | ❌ | Excluded from MVM |
| contract_management | exclusivity_clause | ✅ | ❌ | Excluded from MVM |
| contract_management | usage_right | ✅ | ❌ | Excluded from MVM |
| scheduling_clearance | appearance_schedule | ✅ | ❌ | Excluded from MVM |
| scheduling_clearance | availability | ✅ | ❌ | Excluded from MVM |
| scheduling_clearance | credit_attribution | ✅ | ❌ | Excluded from MVM |
| scheduling_clearance | facility_access | ✅ | ❌ | Excluded from MVM |
| scheduling_clearance | talent_clearance | ✅ | ❌ | Excluded from MVM |
| scheduling_clearance | talent_grievance | ✅ | ❌ | Excluded from MVM |
| talent_identity | guild_affiliation | ✅ | ❌ | Excluded from MVM |
| talent_identity | guild_ref | ✅ | ❌ | Excluded from MVM |
| talent_identity | guild_type_ref | ✅ | ❌ | Excluded from MVM |
| talent_identity | partner_relationship | ✅ | ❌ | Excluded from MVM |
| talent_identity | representation_agreement | ✅ | ✅ |  |
| talent_identity | role | ✅ | ✅ |  |
| talent_identity | talent_agency | ✅ | ✅ |  |
| talent_identity | talent_athlete | ✅ | ❌ | Excluded from MVM |
| talent_identity | talent_profile | ✅ | ✅ |  |
| talent_identity | talent_sports_team | ✅ | ❌ | Excluded from MVM |

<a id="domain-technology"></a>
### technology

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| asset_maintenance | capacity_plan | ✅ | ❌ | Domain not in MVM |
| asset_maintenance | equipment_status_ref | ✅ | ❌ | Domain not in MVM |
| asset_maintenance | maintenance_schedule | ✅ | ❌ | Domain not in MVM |
| asset_maintenance | maintenance_work_order | ✅ | ❌ | Domain not in MVM |
| asset_maintenance | tech_asset_lifecycle | ✅ | ❌ | Domain not in MVM |
| asset_maintenance | tech_change_request | ✅ | ❌ | Domain not in MVM |
| broadcast_infrastructure | broadcast_facility | ✅ | ❌ | Domain not in MVM |
| broadcast_infrastructure | broadcast_standard | ✅ | ❌ | Domain not in MVM |
| broadcast_infrastructure | encoder_config | ✅ | ❌ | Domain not in MVM |
| broadcast_infrastructure | it_asset | ✅ | ❌ | Domain not in MVM |
| broadcast_infrastructure | network_circuit | ✅ | ❌ | Domain not in MVM |
| broadcast_infrastructure | satellite_transponder | ✅ | ❌ | Domain not in MVM |
| broadcast_infrastructure | signal_path | ✅ | ❌ | Domain not in MVM |
| broadcast_infrastructure | studio_facility | ✅ | ❌ | Domain not in MVM |
| broadcast_infrastructure | transmission_equipment | ✅ | ❌ | Domain not in MVM |
| operations_monitoring | alert_severity_ref | ✅ | ❌ | Domain not in MVM |
| operations_monitoring | knowledge_article | ✅ | ❌ | Domain not in MVM |
| operations_monitoring | noc_alert | ✅ | ❌ | Domain not in MVM |
| operations_monitoring | noc_monitor | ✅ | ❌ | Domain not in MVM |
| operations_monitoring | outage_record | ✅ | ❌ | Domain not in MVM |
| operations_monitoring | tech_incident | ✅ | ❌ | Domain not in MVM |
| operations_monitoring | tech_problem | ✅ | ❌ | Domain not in MVM |
| vendor_governance | equipment_procurement | ✅ | ❌ | Domain not in MVM |
| vendor_governance | sla_performance_record | ✅ | ❌ | Domain not in MVM |
| vendor_governance | software_license | ✅ | ❌ | Domain not in MVM |
| vendor_governance | tech_project | ✅ | ❌ | Domain not in MVM |
| vendor_governance | tech_sla | ✅ | ❌ | Domain not in MVM |
| vendor_governance | vendor_contract | ✅ | ❌ | Domain not in MVM |

<a id="domain-workforce"></a>
### workforce

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| compensation_benefits | benefit_enrollment | ✅ | ❌ | Domain not in MVM |
| compensation_benefits | benefit_plan | ✅ | ❌ | Domain not in MVM |
| compensation_benefits | compensation_plan | ✅ | ❌ | Domain not in MVM |
| compensation_benefits | leave_balance | ✅ | ❌ | Domain not in MVM |
| compensation_benefits | leave_request | ✅ | ❌ | Domain not in MVM |
| compensation_benefits | leave_type_ref | ✅ | ❌ | Domain not in MVM |
| compensation_benefits | payroll_record | ✅ | ❌ | Domain not in MVM |
| employee_relations | disciplinary_action | ✅ | ❌ | Domain not in MVM |
| employee_relations | workforce_grievance | ✅ | ❌ | Domain not in MVM |
| talent_development | applicant | ✅ | ❌ | Domain not in MVM |
| talent_development | certification | ✅ | ❌ | Domain not in MVM |
| talent_development | course_requirement | ✅ | ❌ | Domain not in MVM |
| talent_development | goal | ✅ | ❌ | Domain not in MVM |
| talent_development | headcount_plan | ✅ | ❌ | Domain not in MVM |
| talent_development | interview_event | ✅ | ❌ | Domain not in MVM |
| talent_development | onboarding_task | ✅ | ❌ | Domain not in MVM |
| talent_development | performance_review | ✅ | ❌ | Domain not in MVM |
| talent_development | requisition | ✅ | ❌ | Domain not in MVM |
| talent_development | training_course | ✅ | ❌ | Domain not in MVM |
| talent_development | training_enrollment | ✅ | ❌ | Domain not in MVM |
| time_scheduling | timesheet | ✅ | ❌ | Domain not in MVM |
| time_scheduling | work_schedule | ✅ | ❌ | Domain not in MVM |
| workforce_administration | employee | ✅ | ❌ | Domain not in MVM |
| workforce_administration | employment_record | ✅ | ❌ | Domain not in MVM |
| workforce_administration | employment_status_ref | ✅ | ❌ | Domain not in MVM |
| workforce_administration | job_profile | ✅ | ❌ | Domain not in MVM |
| workforce_administration | org_unit | ✅ | ❌ | Domain not in MVM |
| workforce_administration | position | ✅ | ❌ | Domain not in MVM |
| workforce_administration | separation_record | ✅ | ❌ | Domain not in MVM |
| workforce_administration | union_membership | ✅ | ❌ | Domain not in MVM |
