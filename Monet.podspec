Pod::Spec.new do |s|
s.name = "Monet"
s.version = "2.0.1"
s.summary = "Theme manager to simplify app appearences"
s.homepage = "https://github.com/Digipolitan/monet"
s.authors = "Digipolitan"
s.source = { :git => "https://github.com/Digipolitan/monet.git", :tag => "v#{s.version}" }
s.license = { :type => "BSD", :file => "LICENSE" }
s.source_files = 'Sources/**/*.{swift,h}'
s.ios.deployment_target = '9.0'
s.tvos.deployment_target = '9.0'
s.swift_version = '5.0'
s.dependency 'ObjectMapper', '~> 3.4'
end
