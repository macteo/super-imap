# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20180321140556) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"
  enable_extension "hstore"

  create_table "accounts_users", id: false, force: true do |t|
    t.integer "user_id",    null: false
    t.integer "account_id", null: false
  end

  add_index "accounts_users", ["account_id", "user_id"], name: "index_accounts_users_on_account_id_and_user_id", unique: true, using: :btree
  add_index "accounts_users", ["user_id", "account_id"], name: "index_accounts_users_on_user_id_and_account_id", using: :btree

  create_table "active_admin_comments", force: true do |t|
    t.string   "namespace"
    t.text     "body"
    t.string   "resource_id",   null: false
    t.string   "resource_type", null: false
    t.integer  "author_id"
    t.string   "author_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "active_admin_comments", ["author_type", "author_id"], name: "index_active_admin_comments_on_author_type_and_author_id", using: :btree
  add_index "active_admin_comments", ["namespace"], name: "index_active_admin_comments_on_namespace", using: :btree
  add_index "active_admin_comments", ["resource_type", "resource_id"], name: "index_active_admin_comments_on_resource_type_and_resource_id", using: :btree

  create_table "admin_users", force: true do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.datetime "locked_at"
  end

  add_index "admin_users", ["email"], name: "index_admin_users_on_email", unique: true, using: :btree
  add_index "admin_users", ["reset_password_token"], name: "index_admin_users_on_reset_password_token", unique: true, using: :btree

  create_table "api_keys", force: true do |t|
    t.integer  "account_id"
    t.string   "token"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "api_keys", ["account_id"], name: "index_api_keys_on_account_id", using: :btree

  create_table "ar_internal_metadata", primary_key: "key", force: true do |t|
    t.string   "value"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "authorized_facebook_pages", force: true do |t|
    t.integer  "account_id"
    t.string   "page_id"
    t.string   "token"
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "authorized_facebook_pages", ["account_id"], name: "index_authorized_facebook_pages_on_account_id", using: :btree

  create_table "automation_sequences", force: true do |t|
    t.string   "title"
    t.decimal  "open_rate",             default: 0.0
    t.decimal  "click_rate",            default: 0.0
    t.integer  "subscribers_count",     default: 0
    t.integer  "messages_count",        default: 0
    t.string   "creator_type"
    t.integer  "creator_id"
    t.datetime "created_at",                            null: false
    t.datetime "updated_at",                            null: false
    t.integer  "account_id"
    t.integer  "status",                default: 0
    t.integer  "delivery_hour"
    t.boolean  "dont_send_on_weekends", default: false
  end

  add_index "automation_sequences", ["account_id"], name: "index_automation_sequences_on_account_id", using: :btree
  add_index "automation_sequences", ["creator_type", "creator_id"], name: "index_automation_sequences_on_creator_type_and_creator_id", using: :btree

  create_table "automation_subscribers", force: true do |t|
    t.integer  "person_id"
    t.integer  "sequence_id"
    t.integer  "next_action_id"
    t.datetime "next_action_at"
    t.integer  "status"
    t.datetime "created_at",                     null: false
    t.datetime "updated_at",                     null: false
    t.boolean  "processing",     default: false
  end

  add_index "automation_subscribers", ["next_action_id"], name: "index_automation_subscribers_on_next_action_id", using: :btree
  add_index "automation_subscribers", ["person_id"], name: "index_automation_subscribers_on_person_id", using: :btree
  add_index "automation_subscribers", ["sequence_id"], name: "index_automation_subscribers_on_sequence_id", using: :btree

  create_table "automation_triggers", force: true do |t|
    t.integer  "account_id"
    t.string   "triggable_type"
    t.integer  "triggable_id"
    t.string   "type",            limit: 50
    t.hstore   "additional_data"
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
    t.integer  "direction"
  end

  add_index "automation_triggers", ["account_id"], name: "index_automation_triggers_on_account_id", using: :btree
  add_index "automation_triggers", ["triggable_type", "triggable_id"], name: "index_automation_triggers_on_triggable_type_and_triggable_id", using: :btree

  create_table "automation_web_notifications", force: true do |t|
    t.integer  "account_id"
    t.integer  "segment_id"
    t.string   "title",                             null: false
    t.integer  "status",            default: 1,     null: false
    t.integer  "trigger",                           null: false
    t.integer  "position",                          null: false
    t.integer  "display_frequency",                 null: false
    t.text     "body",                              null: false
    t.integer  "total_views",       default: 0,     null: false
    t.integer  "unique_views",      default: 0,     null: false
    t.integer  "total_clicks",      default: 0,     null: false
    t.decimal  "click_rate",        default: 0.0,   null: false
    t.integer  "display",           default: 0,     null: false
    t.string   "text_color",                        null: false
    t.string   "background_color",                  null: false
    t.boolean  "display_limit",     default: false, null: false
    t.string   "display_paths",     default: [],                 array: true
    t.string   "string",            default: [],                 array: true
    t.hstore   "details"
    t.datetime "created_at",                        null: false
    t.datetime "updated_at",                        null: false
  end

  add_index "automation_web_notifications", ["account_id"], name: "index_automation_web_notifications_on_account_id", using: :btree
  add_index "automation_web_notifications", ["segment_id"], name: "index_automation_web_notifications_on_segment_id", using: :btree

  create_table "billing_charges", force: true do |t|
    t.integer  "account_id"
    t.integer  "payment_method",              default: 0
    t.integer  "status",                      default: 0
    t.integer  "type",                        default: 0
    t.string   "description"
    t.decimal  "amount",                      default: 0.0
    t.decimal  "tax",                         default: 0.0
    t.integer  "tax_percentage",              default: 0
    t.string   "currency",          limit: 5
    t.hstore   "details",                     default: {},  null: false
    t.datetime "created_at",                                null: false
    t.datetime "updated_at",                                null: false
    t.integer  "subscription_id"
    t.integer  "plan_id"
    t.integer  "payment_processor",           default: 0
  end

  add_index "billing_charges", ["account_id"], name: "index_billing_charges_on_account_id", using: :btree
  add_index "billing_charges", ["plan_id"], name: "index_billing_charges_on_plan_id", using: :btree
  add_index "billing_charges", ["subscription_id"], name: "index_billing_charges_on_subscription_id", using: :btree

  create_table "billing_credit_cards", force: true do |t|
    t.integer  "subscription_id"
    t.string   "type",            limit: 20
    t.string   "last_four",       limit: 5
    t.hstore   "processor_data"
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
  end

  add_index "billing_credit_cards", ["subscription_id"], name: "index_billing_credit_cards_on_subscription_id", using: :btree

  create_table "billing_credit_movements", force: true do |t|
    t.integer  "account_id"
    t.integer  "charge_id"
    t.decimal  "amount"
    t.decimal  "previous_balance"
    t.string   "description"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
  end

  add_index "billing_credit_movements", ["account_id"], name: "index_billing_credit_movements_on_account_id", using: :btree
  add_index "billing_credit_movements", ["charge_id"], name: "index_billing_credit_movements_on_charge_id", using: :btree

  create_table "billing_plans", force: true do |t|
    t.string   "name",           limit: 100
    t.string   "description"
    t.integer  "min_contacts",               default: 0
    t.string   "currency",       limit: 5
    t.decimal  "amount",                     default: 0.0
    t.decimal  "tax",                        default: 0.0
    t.integer  "tax_percentage",             default: 0
    t.datetime "created_at",                               null: false
    t.datetime "updated_at",                               null: false
  end

  create_table "billing_subscriptions", force: true do |t|
    t.integer  "account_id"
    t.integer  "plan_id"
    t.integer  "status",                           default: 0
    t.string   "currency",               limit: 5, default: "USD"
    t.integer  "payment_processor",                default: 0
    t.date     "next_invoice_at"
    t.date     "next_charge_attempt_at"
    t.hstore   "details",                          default: {},    null: false
    t.datetime "created_at",                                       null: false
    t.datetime "updated_at",                                       null: false
    t.string   "billing_email",                    default: "",    null: false
  end

  add_index "billing_subscriptions", ["account_id"], name: "index_billing_subscriptions_on_account_id", using: :btree
  add_index "billing_subscriptions", ["plan_id"], name: "index_billing_subscriptions_on_plan_id", using: :btree

  create_table "bounces", force: true do |t|
    t.string   "email"
    t.string   "reason"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "bounces_campaigns", force: true do |t|
    t.integer "campaign_id", limit: 8
    t.integer "bounce_id",   limit: 8
  end

  add_index "bounces_campaigns", ["bounce_id"], name: "index_bounces_campaigns_on_bounce_id", using: :btree
  add_index "bounces_campaigns", ["campaign_id"], name: "index_bounces_campaigns_on_campaign_id", using: :btree

  create_table "campaigns_spam_reports", force: true do |t|
    t.integer "campaign_id",    limit: 8
    t.integer "spam_report_id", limit: 8
  end

  add_index "campaigns_spam_reports", ["campaign_id"], name: "index_campaigns_spam_reports_on_campaign_id", using: :btree
  add_index "campaigns_spam_reports", ["spam_report_id"], name: "index_campaigns_spam_reports_on_spam_report_id", using: :btree

  create_table "comments", force: true do |t|
    t.text     "body"
    t.integer  "person_id"
    t.integer  "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "comments", ["person_id"], name: "index_comments_on_person_id", using: :btree
  add_index "comments", ["user_id"], name: "index_comments_on_user_id", using: :btree

  create_table "custom_attribute_logs", force: true do |t|
    t.integer  "person_id"
    t.integer  "custom_attribute_id"
    t.string   "value"
    t.datetime "created_at",          null: false
    t.datetime "updated_at",          null: false
  end

  add_index "custom_attribute_logs", ["custom_attribute_id"], name: "index_custom_attribute_logs_on_custom_attribute_id", using: :btree
  add_index "custom_attribute_logs", ["person_id"], name: "index_custom_attribute_logs_on_person_id", using: :btree

  create_table "custom_attribute_values", force: true do |t|
    t.integer  "custom_attribute_id"
    t.string   "value"
    t.integer  "person_id"
    t.datetime "created_at",          null: false
    t.datetime "updated_at",          null: false
  end

  add_index "custom_attribute_values", ["custom_attribute_id"], name: "index_custom_attribute_values_on_custom_attribute_id", using: :btree
  add_index "custom_attribute_values", ["person_id"], name: "index_custom_attribute_values_on_person_id", using: :btree

  create_table "custom_attributes", force: true do |t|
    t.integer  "account_id"
    t.string   "name",        limit: 100
    t.text     "description"
    t.integer  "type"
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
  end

  add_index "custom_attributes", ["account_id"], name: "index_custom_attributes_on_account_id", using: :btree

  create_table "event_logs", force: true do |t|
    t.datetime "occurred_at"
    t.hstore   "metadata"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.integer  "person_event_id"
    t.integer  "account_id"
  end

  add_index "event_logs", ["account_id", "created_at"], name: "index_event_logs_on_account_id_and_created_at", using: :btree
  add_index "event_logs", ["account_id"], name: "index_event_logs_on_account_id", using: :btree
  add_index "event_logs", ["created_at"], name: "index_event_logs_on_created_at", using: :btree
  add_index "event_logs", ["person_event_id", "created_at"], name: "index_event_logs_on_person_event_id_and_created_at", using: :btree
  add_index "event_logs", ["person_event_id"], name: "index_event_logs_on_person_event_id", using: :btree

  create_table "events", force: true do |t|
    t.integer  "account_id"
    t.string   "slug"
    t.text     "description"
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
    t.boolean  "archived",    default: false
  end

  add_index "events", ["account_id"], name: "index_events_on_account_id", using: :btree

  create_table "imap_daemon_heartbeats", force: true do |t|
    t.string   "tag"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "imap_providers", force: true do |t|
    t.string   "code"
    t.string   "title"
    t.integer  "partner_connections_count"
    t.string   "imap_host"
    t.integer  "imap_port"
    t.boolean  "imap_use_ssl"
    t.string   "oauth2_grant_type"
    t.string   "oauth2_scope"
    t.string   "oauth2_site"
    t.string   "oauth2_token_method"
    t.string   "oauth2_token_url"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "type"
    t.string   "oauth2_authorize_url"
    t.string   "oauth2_response_type"
    t.string   "oauth2_access_type"
    t.string   "oauth2_approval_prompt"
    t.string   "smtp_host"
    t.integer  "smtp_port"
    t.string   "smtp_domain"
    t.boolean  "smtp_enable_starttls_auto"
  end

  create_table "mail_logs", force: true do |t|
    t.integer  "user_id"
    t.string   "message_id"
    t.integer  "transmit_logs_count",            default: 0
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "sha1",                limit: 40
  end

  add_index "mail_logs", ["user_id", "message_id"], name: "index_mail_logs_on_user_id_and_message_id", using: :btree
  add_index "mail_logs", ["user_id", "sha1"], name: "index_mail_logs_on_user_id_and_sha1", using: :btree
  add_index "mail_logs", ["user_id"], name: "index_mail_logs_on_user_id", using: :btree

  create_table "message_clicks", force: true do |t|
    t.integer  "message_id"
    t.string   "url"
    t.string   "ip",         limit: 20
    t.datetime "created_at",            null: false
    t.datetime "updated_at",            null: false
  end

  add_index "message_clicks", ["message_id"], name: "index_message_clicks_on_message_id", using: :btree

  create_table "message_opens", force: true do |t|
    t.integer  "message_id"
    t.string   "ip",         limit: 20
    t.datetime "created_at",            null: false
    t.datetime "updated_at",            null: false
  end

  add_index "message_opens", ["message_id"], name: "index_message_opens_on_message_id", using: :btree

  create_table "messages", force: true do |t|
    t.integer  "account_id"
    t.integer  "person_id"
    t.integer  "user_id"
    t.integer  "type"
    t.integer  "direction"
    t.integer  "source"
    t.boolean  "seen",                 default: false
    t.text     "body"
    t.hstore   "details"
    t.datetime "created_at",                           null: false
    t.datetime "updated_at",                           null: false
    t.integer  "message_opens_count",  default: 0
    t.integer  "message_clicks_count", default: 0
    t.boolean  "clicked",              default: false
  end

  add_index "messages", ["account_id", "created_at"], name: "index_messages_on_account_id_and_created_at", using: :btree
  add_index "messages", ["account_id"], name: "index_messages_on_account_id", using: :btree
  add_index "messages", ["person_id"], name: "index_messages_on_person_id", using: :btree
  add_index "messages", ["user_id"], name: "index_messages_on_user_id", using: :btree

  create_table "meta_attribute_logs", force: true do |t|
    t.integer  "event_log_id"
    t.integer  "person_meta_attribute_id"
    t.string   "value"
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
  end

  add_index "meta_attribute_logs", ["event_log_id"], name: "index_meta_attribute_logs_on_event_log_id", using: :btree
  add_index "meta_attribute_logs", ["person_meta_attribute_id"], name: "index_meta_attribute_logs_on_person_meta_attribute_id", using: :btree

  create_table "meta_attributes", force: true do |t|
    t.integer  "account_id"
    t.string   "name",        limit: 100
    t.text     "description"
    t.integer  "type"
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
  end

  add_index "meta_attributes", ["account_id"], name: "index_meta_attributes_on_account_id", using: :btree

  create_table "partner_connections", force: true do |t|
    t.integer  "partner_id"
    t.integer  "imap_provider_id"
    t.integer  "users_count",          default: 0
    t.string   "oauth2_client_id"
    t.string   "oauth2_client_secret"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "type"
  end

  add_index "partner_connections", ["imap_provider_id"], name: "index_partner_connections_on_imap_provider_id", using: :btree
  add_index "partner_connections", ["partner_id"], name: "index_partner_connections_on_partner_id", using: :btree

  create_table "partners", force: true do |t|
    t.string   "api_key"
    t.string   "name"
    t.string   "new_mail_webhook"
    t.integer  "partner_connections_count", default: 0
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "success_url"
    t.string   "failure_url"
    t.string   "user_connected_webhook"
    t.string   "user_disconnected_webhook"
  end

  create_table "people", force: true do |t|
    t.integer  "account_id"
    t.string   "user_id"
    t.string   "email"
    t.datetime "first_seen_at"
    t.datetime "last_seen_at"
    t.datetime "created_at",                        null: false
    t.datetime "updated_at",                        null: false
    t.hstore   "custom_attributes", default: {},    null: false
    t.boolean  "unsubscribed",      default: false
    t.datetime "unsubscribed_at"
    t.boolean  "archived",          default: false, null: false
    t.string   "unsubscribed_from"
    t.string   "first_name"
    t.string   "last_name"
    t.integer  "num_sessions",      default: 0
  end

  add_index "people", ["account_id", "created_at"], name: "index_people_on_account_id_and_created_at", using: :btree
  add_index "people", ["account_id"], name: "index_people_on_account_id", using: :btree
  add_index "people", ["first_seen_at"], name: "index_people_on_first_seen_at", using: :btree
  add_index "people", ["last_seen_at"], name: "index_people_on_last_seen_at", using: :btree

  create_table "people_segments_segments", id: false, force: true do |t|
    t.integer "segment_id", null: false
    t.integer "person_id",  null: false
  end

  add_index "people_segments_segments", ["person_id", "segment_id"], name: "index_people_segments_segments_on_person_id_and_segment_id", using: :btree
  add_index "people_segments_segments", ["segment_id", "person_id"], name: "index_people_segments_segments_on_segment_id_and_person_id", unique: true, using: :btree

  create_table "person_activities", force: true do |t|
    t.integer  "person_id"
    t.string   "reference_type"
    t.integer  "reference_id"
    t.integer  "action"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
  end

  add_index "person_activities", ["person_id"], name: "index_person_activities_on_person_id", using: :btree
  add_index "person_activities", ["reference_type", "reference_id"], name: "index_person_activities_on_reference_type_and_reference_id", using: :btree

  create_table "person_events", force: true do |t|
    t.integer  "person_id"
    t.integer  "event_id"
    t.integer  "event_logs_count",  default: 0
    t.datetime "first_occurred_at"
    t.datetime "last_occurred_at"
    t.datetime "created_at",                    null: false
    t.datetime "updated_at",                    null: false
  end

  add_index "person_events", ["event_id"], name: "index_person_events_on_event_id", using: :btree
  add_index "person_events", ["person_id"], name: "index_person_events_on_person_id", using: :btree

  create_table "person_ids", force: true do |t|
    t.integer  "account_id"
    t.integer  "person_id"
    t.string   "pid",        limit: 20
    t.datetime "created_at",            null: false
    t.datetime "updated_at",            null: false
  end

  add_index "person_ids", ["account_id"], name: "index_person_ids_on_account_id", using: :btree
  add_index "person_ids", ["person_id"], name: "index_person_ids_on_person_id", using: :btree
  add_index "person_ids", ["pid"], name: "index_person_ids_on_pid", using: :btree

  create_table "person_meta_attributes", force: true do |t|
    t.integer  "person_id"
    t.integer  "meta_attribute_id"
    t.string   "first_value"
    t.string   "last_value"
    t.integer  "meta_attribute_logs_count"
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
  end

  add_index "person_meta_attributes", ["meta_attribute_id"], name: "index_person_meta_attributes_on_meta_attribute_id", using: :btree
  add_index "person_meta_attributes", ["person_id"], name: "index_person_meta_attributes_on_person_id", using: :btree

  create_table "segments_filters", force: true do |t|
    t.integer  "segment_id"
    t.integer  "matcher"
    t.hstore   "additional_data"
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
    t.string   "type",            limit: 50
    t.integer  "rule_id"
  end

  add_index "segments_filters", ["rule_id"], name: "index_segments_filters_on_rule_id", using: :btree
  add_index "segments_filters", ["segment_id"], name: "index_segments_filters_on_segment_id", using: :btree

  create_table "segments_rules", force: true do |t|
    t.integer  "segment_id"
    t.string   "type",       limit: 100
    t.integer  "direction"
    t.hstore   "details"
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  add_index "segments_rules", ["segment_id"], name: "index_segments_rules_on_segment_id", using: :btree

  create_table "segments_segments", force: true do |t|
    t.integer  "account_id"
    t.string   "name"
    t.datetime "created_at",                        null: false
    t.datetime "updated_at",                        null: false
    t.boolean  "archived",          default: false, null: false
    t.boolean  "match_all_filters", default: true
    t.boolean  "reloading_people",  default: false
    t.string   "description"
  end

  add_index "segments_segments", ["account_id"], name: "index_segments_segments_on_account_id", using: :btree

  create_table "spam_reports", force: true do |t|
    t.string   "email"
    t.string   "ip"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "super_imap_users", force: true do |t|
    t.integer  "partner_connection_id"
    t.string   "email"
    t.string   "tag"
    t.integer  "mail_logs_count",       default: 0
    t.datetime "last_email_at"
    t.integer  "last_uid"
    t.string   "last_uid_validity"
    t.datetime "last_internal_date"
    t.string   "login_username"
    t.string   "login_password"
    t.string   "oauth2_refresh_token"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "archived",              default: false
    t.string   "type"
    t.datetime "connected_at"
    t.datetime "last_login_at"
    t.boolean  "enable_tracer",         default: false
  end

  add_index "super_imap_users", ["partner_connection_id"], name: "index_super_imap_users_on_partner_connection_id", using: :btree

  create_table "tracer_logs", force: true do |t|
    t.integer  "user_id"
    t.string   "uid",         limit: 20
    t.datetime "detected_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "tracer_logs", ["uid"], name: "index_tracer_logs_on_uid", using: :btree
  add_index "tracer_logs", ["user_id"], name: "index_tracer_logs_on_user_id", using: :btree

  create_table "transmit_logs", force: true do |t|
    t.integer  "mail_log_id"
    t.integer  "response_code"
    t.string   "response_body", limit: 1024
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "transmit_logs", ["mail_log_id"], name: "index_transmit_logs_on_mail_log_id", using: :btree

  create_table "users", force: true do |t|
    t.string   "email",                             default: "",    null: false
    t.string   "encrypted_password",                default: "",    null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                     default: 0,     null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                                        null: false
    t.datetime "updated_at",                                        null: false
    t.integer  "current_account_id"
    t.hstore   "settings",                          default: {},    null: false
    t.string   "timezone",               limit: 50
    t.boolean  "admin",                             default: false
    t.string   "mobile"
    t.string   "first_name"
    t.string   "list_size"
    t.string   "country",                limit: 3
    t.string   "last_name"
  end

  add_index "users", ["current_account_id"], name: "index_users_on_current_account_id", using: :btree
  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

  create_table "zapier_subscriptions", force: true do |t|
    t.integer  "account_id"
    t.string   "target_url"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "zapier_subscriptions", ["account_id"], name: "index_zapier_subscriptions_on_account_id", using: :btree

end
