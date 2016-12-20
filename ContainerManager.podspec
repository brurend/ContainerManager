Pod::Spec.new do |s|
  s.name             = "ContainerManager"
  s.version          = "2.0.1"
  s.summary          = "Helper classes to ContainerView usage with IE in Swift."
  s.description      = <<-DESC
ContainerManager helps you with linking more than one ViewController to the same ContainerView with segues in the Interface Builder in Swift.
                       DESC
  s.homepage         = "https://github.com/brurend/ContainerManager"
  s.license          = 'MIT'
  s.author           = { "brurend" => "brurend@hotmail.com" }
  s.source           = { :git => "https://github.com/brurend/ContainerManager.git", :tag => s.version.to_s }
  s.platform     = :ios, '8.3'
  s.requires_arc = true
  s.source_files = "ContainerManager/*"
end
