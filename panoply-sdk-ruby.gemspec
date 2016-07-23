Gem::Specification.new do |spec|
  spec.name          = "panoply-sdk-ruby"
  spec.version       = "0.1.0"
  spec.authors       = ["Panoply"]
  spec.email         = ["support@panoply.io"]

  spec.summary       = "Send data to the Panoply.io platform."
  spec.description   = "This SDK allows users to push arbitrary data objects to the Panoply.io platform. You can obtain the required API KEY & SECRET via the platform when you select 'Panoply SDK' as a data source."
  spec.license       = "MIT"

  spec.files         = ["lib/panoply-sdk-ruby.rb"]
  spec.post_install_message = "Formerly known as 'color-sdk-ruby'"
end

