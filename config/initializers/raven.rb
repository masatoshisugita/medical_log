# frozen_string_literal: true

Raven.configure do |config|
  config.dsn = 'https://871fda0e90af490495863cac1c2fc886:d78be310a25e4f2f962ad206982d983a@o414573.ingest.sentry.io/5304703'
  config.environments = %w[test development]
end
