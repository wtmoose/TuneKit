Pod::Spec.new do |s|
  s.name         = "TuneKit"
  s.version      = "0.0.1"
  s.summary      = "Tune Kit lets you tune your app in real time."

  s.description  = <<-DESC
                   Tune Kit is an experimental project and is subject to drastic API changes.
                   Unless you want to be on the bleeding edge, check back later.
                   DESC
  s.homepage     = ""
  s.license      = { :type => 'MIT' }
  s.author       = { "Timothy Moose" => "wtm@tractablelabs.com" }
  s.platform     = :ios, '7.0'
  #s.source       = { :git => "", :tag => "0.0.1" }
  s.source_files  = 'TuneKit/**/*.{h,m}'
  #s.public_header_files = 'TuneKit/**/TKTuneKit.h'
  #s.resource_bundle = { 'TuneKit' => ['TuneKit/Resources/*.png', 'TuneKit/TuneKit.storyboard'] }
  s.resources 	 = ['TuneKit/**/*.{png,storyboard,xib}']
  s.dependency 'TLIndexPathTools'
  s.requires_arc = true
end
