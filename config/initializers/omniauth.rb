Rails.application.config.middleware.use OmniAuth::Builder do
  provider :facebook, '296979527082467', '4e9f397a9bfd8e532ae5ff0dd3e453c9', scope: "email,publish_stream"
end