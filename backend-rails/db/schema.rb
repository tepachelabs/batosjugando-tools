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

ActiveRecord::Schema.define(version: 2020_06_26_231341) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

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

# Could not dump table "publish_jobs" because of following StandardError
#   Unknown type 'published_job_status' for column 'status'

  add_foreign_key "publish_configurations", "admin_users"
  add_foreign_key "publish_jobs", "podcast_episodes", on_delete: :cascade
end
