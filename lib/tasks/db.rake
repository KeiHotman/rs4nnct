namespace :db do
  task seed: :environment do
    if ENV['ver']
      seed_file = File.join(Rails.root, 'db', 'seeds', "#{ENV['ver']}.rb")
    else
      seed_file = File.join(Rails.root, 'db', 'seeds.rb')
    end
    load(seed_file)
  end
end
