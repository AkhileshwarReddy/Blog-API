RSpec.configure do |config|
    config.before(:suite) do 
        DatabaseCleaner.clean_with :truncation, except: %w(ar_internal_metadata)
    end

    config.before(:each) do
        DatabaseCleaner.strategy = :transaction
    end

    config.before(:each) do
        DatabaseCleaner.start
    end

    config.after(:each) do
        DatabaseCleaner.lean
    end
end
