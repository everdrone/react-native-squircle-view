require "json"

json = File.read(File.join(__dir__, "../package.json"))
package = JSON.parse(json, symbolize_names: true)

Pod::Spec.new do |s|
  s.name         = package[:name]
  s.version      = package[:version]
  s.summary      = package[:description]
  s.description  = package[:description]
  s.homepage     = package[:repository][:url]
  s.license      = package[:license]
  s.author       = { "author" => package[:author] }
  s.platform     = :ios, "7.0"
  s.source       = { git: package[:repository][:url], tag: 'master' }
  s.source_files  = "ios/**/*.{h,m,swift}"
  s.requires_arc = true

  s.dependency "React"
end
