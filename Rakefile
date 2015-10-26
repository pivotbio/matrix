require './environment.rb'

namespace :db do
  desc 'migrate the database'
  task :migrate do
    @db_url = ENV['DATABASE_URL'] || 'postgres://localhost:5432/matrix_development'
    @db = Sequel.connect @db_url
    Sequel.extension :migration
    migrations = File.join(File.expand_path(File.dirname(__FILE__)), 'migrations')
    Sequel::Migrator.run(@db, migrations)
  end
end
