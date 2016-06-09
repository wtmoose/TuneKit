Pod::Spec.new do |s|
  s.name         = "TuneKit"
  s.version      = "0.0.1"
  s.summary      = "TuneKit lets you modify the look and feel of
                   your iOS app in real time."

  s.description  = <<-DESC
                   TuneKit creates on-the-fly control panels to modify the look 
                   and feel of your iOS app in real time.. Tune animations, 
                   colors, etc. and get instant feedback.
                   DESC
  s.homepage     = "tractablelabs.com"
  s.license      = { :type => 'MIT' }
  s.author       = { "Timothy Moose" => "wtm@tractablelabs.com" }
  s.platform     = :ios, '7.0'
  s.source       = { :git => "", :tag => "0.0.1" }
  s.source_files  = 'TuneKit/**/*.{h,m,pch}'
  #s.public_header_files = 'TuneKit/**/TKTuneKit.h'
  s.resources 	 = ['TuneKit/**/*.{storyboard,xib,xcassets}']
  s.dependency 'TLIndexPathTools'
  s.dependency 'OBSlider'
  s.requires_arc = true

  s.subspec "core" do |ss|
  end

  s.subspec "pop" do |ss|
    ss.dependency 'pop', '~> 1.0'
    ss.source_files = "Extensions/Pop"
  end

  s.subspec "AHEasing" do |ss|
    ss.dependency 'AHEasing', '~> 1.1'
    ss.source_files = "Extensions/AHEasing"
  end

  s.subspec "TLLayoutTransitioning" do |ss|
    ss.dependency 'TLLayoutTransitioning', '~> 1.0.0'
    ss.source_files = "Extensions/TLLayoutTransitioning"
  end

  s.subspec "RBBAnimation" do |ss|
    ss.dependency 'RBBAnimation', '~> 0.4.0'
    ss.source_files = "Extensions/RBBAnimation"
  end

end
