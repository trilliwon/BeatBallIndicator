Pod::Spec.new do |s|
  s.name             = 'BeatBallIndicator'
  s.version          = '0.1.1'
  s.summary          = 'Activity Indicator'

  s.description      = 'This is a simple activity indicatory for iOS. It is copy of NVAcitivityIndicator type ballBeat 18'

  s.homepage         = 'https://github.com/trilliwon/BeatBallIndicator'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'trilliwon' => 'trilliwon@gmail.com' }
  s.source           = { :git => 'https://github.com/trilliwon/BeatBallIndicator.git', :tag => s.version.to_s }
  s.social_media_url = 'https://facebook.com/trilliwon'

  s.ios.deployment_target = '8.0'
  s.source_files = 'Source/*'
end
