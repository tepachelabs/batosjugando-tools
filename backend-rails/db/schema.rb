# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2021_01_08_001521) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  # These are custom enum types that must be created before they can be used in the schema definition
  create_enum "published_job_status", ["published", "unpublished", "in_progress", "failed"]

  create_table "active_admin_comments", force: :cascade do |t|
    t.string "namespace"
    t.text "body"
    t.string "resource_type"
    t.bigint "resource_id"
    t.string "author_type"
    t.bigint "author_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["author_type", "author_id"], name: "index_active_admin_comments_on_author_type_and_author_id"
    t.index ["namespace"], name: "index_active_admin_comments_on_namespace"
    t.index ["resource_type", "resource_id"], name: "index_active_admin_comments_on_resource_type_and_resource_id"
  end

  create_table "admin_users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_admin_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_admin_users_on_reset_password_token", unique: true
  end

  create_table "juegathon_events", force: :cascade do |t|
    t.string "name"
    t.datetime "start_datetime"
    t.datetime "end_datetime"
    t.decimal "total_donation", precision: 10, scale: 2
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "juegathon_participants", force: :cascade do |t|
    t.string "name"
    t.string "avatar_url"
    t.string "description"
    t.string "email"
    t.string "favorite_game"
    t.string "twitter_username"
    t.string "twitch_username"
    t.string "other_link"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_juegathon_participants_on_email"
  end

  create_table "juegathon_participations", force: :cascade do |t|
    t.bigint "juegathon_participants_id"
    t.bigint "juegathon_events_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["juegathon_events_id"], name: "index_juegathon_participations_on_juegathon_events_id"
    t.index ["juegathon_participants_id"], name: "index_juegathon_participations_on_juegathon_participants_id"
  end

  create_table "last_published", force: :cascade do |t|
    t.string "twitter_username"
    t.string "last_tweet_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "name"
    t.string "podcast_episode_url"
    t.index ["podcast_episode_url"], name: "index_last_published_on_podcast_episode_url", unique: true
    t.index ["twitter_username"], name: "index_last_published_on_twitter_username", unique: true
  end

  create_table "podcast_episodes", force: :cascade do |t|
    t.string "title"
    t.text "description"
    t.string "url"
    t.string "audio_url"
    t.integer "season"
    t.integer "episode"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "publish_configurations", force: :cascade do |t|
    t.string "reddit_token"
    t.string "reddit_refresh_token"
    t.string "twitter_oauth_token"
    t.string "twitter_oauth_token_secret"
    t.bigint "admin_user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "discord_webhook_url"
    t.index ["admin_user_id"], name: "index_publish_configurations_on_admin_user_id"
  end

  create_table "publish_jobs", force: :cascade do |t|
    t.bigint "podcast_episode_id"
    t.string "platform"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.enum "status", default: "unpublished", as: "published_job_status"
    t.string "published_url"
    t.text "message"
    t.index ["podcast_episode_id", "platform"], name: "index_publish_jobs_on_podcast_episode_id_and_platform", unique: true
    t.index ["podcast_episode_id"], name: "index_publish_jobs_on_podcast_episode_id"
    t.index ["status"], name: "index_publish_jobs_on_status"
  end

  add_foreign_key "juegathon_participations", "juegathon_events", column: "juegathon_events_id"
  add_foreign_key "juegathon_participations", "juegathon_participants", column: "juegathon_participants_id"
  add_foreign_key "publish_configurations", "admin_users"
  add_foreign_key "publish_jobs", "podcast_episodes", on_delete: :cascade
end
