namespace :db do
  task seed: :environment do
    seed_file = File.join(Rails.root, 'db', 'seeds', "#{ENV['version']}.rb")
    load(seed_file)
  end
end
