RSpec.configure do |config|
    config.before(:suite) do
        DatabaseCleaner.strategy = :truncation
        DatabaseCleaner.clean_with(:truncation)
    end

    config.before do
        DatabaseCleaner.strategy = :transaction
        DatabaseCleaner.start
    end

    config.append_after do
        DatabaseCleaner.clean
    end
end
