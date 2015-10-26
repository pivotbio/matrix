require 'bundler'
Bundler.require

require './lib/decode_plate.rb'

## database stuff

class MatrixScanner < Sinatra::Base

  set :root, File.dirname(__FILE__)
  enable :logging

  configure :development do
    @db_url = ENV['DATABASE_URL'] || 'postgres://localhost:5432/matrix_development'
    @db = Sequel.connect @db_url
  end

  configure :production do
    @db_url = ENV['DATABASE_URL']
    @db = Sequel.connect @db_url
  end

  configure :test do
    @db_url = ENV['DATABASE_URL'] || 'postgres://localhost:5432/matrix_test'
    @db = Sequel.connect @db_url
    # run migrations in test config block instead of in spec_helper because we
    # need to be able to access @db_url which is not initialized yet in
    # spec_helper :\
    Sequel.extension :migration
    migrations = File.join(File.expand_path(File.dirname(__FILE__)), 'migrations')
    Sequel::Migrator.run(@db, migrations)
  end

  # require AFTER running migrations
  require './models.rb'
end

