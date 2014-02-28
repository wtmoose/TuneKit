Pod::Spec.new do |s|
  s.name         = "TuneKit"
  s.version      = "0.0.1"
  s.summary      = "TuneKit lets you modify the look and feel of
                   your app in real time."

  s.description  = <<-DESC
                   TuneKit lets you modify the look and feel of
                   your app in real time. Tune animations, colors, etc.
                   and get instant feedback.
                   DESC
  s.homepage     = ""
  s.license      = { :type => 'MIT' }
  s.author       = { "Timothy Moose" => "wtm@tractablelabs.com" }
  s.platform     = :ios, '7.0'
  #s.source       = { :git => "", :tag => "0.0.1" }
  s.source_files  = 'TuneKit/**/*.{h,m,pch}'
  #s.public_header_files = 'TuneKit/**/TKTuneKit.h'
  s.resources 	 = ['TuneKit/**/*.{png,storyboard,xib}']
  s.dependency 'TLIndexPathTools'
  s.dependency 'OBSlider'
  s.requires_arc = true
end
