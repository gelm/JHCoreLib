Pod::Spec.new do |s|
  s.name = "JHCoreLib"
  s.version = "0.1.0"
  s.summary = "A short description of JHCoreLib."
  s.license = {"type"=>"MIT", "file"=>"LICENSE"}
  s.authors = {"gelm"=>"351038343@qq.com"}
  s.homepage = "https://github.com/gelm/JHCoreLib"
  s.description = "TODO: Add long description of the pod here."
  s.source = { :path => '.' }

  s.ios.deployment_target    = '8.0'
  s.ios.vendored_framework   = 'ios/JHCoreLib.framework'
end
