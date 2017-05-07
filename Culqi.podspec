#
# Be sure to run `pod lib lint Culqi.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'Culqi'
  s.version          = '2.0'
  s.summary          = 'A short description of Culqi.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
TODO: Add long description of the pod here.
                       DESC

  s.homepage         = 'https://www.culqi.com'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
##############################################################################################
  s.author           = { 'Guillermo Saenz' => 'gsaenz@proatomicdev.com' } # <--------Change this
##############################################################################################
  s.source           = { :git => 'https://github.com/culqi/culqi-ios.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '8.0'

  s.default_subspecs= [
    "Core"
  ]

  s.subspec "Models" do |ss|
    ss.source_files = 'Culqi/CLQ{BaseModelObject,Token,IssuerIdentificationNumber,CardIssuer,Client,AntifraudDetails,Card,Charge,Outcome,FeeDetails,FeeFixed,FeeVariable,Operation,Plan,Customer,Subscription,Error,ResponseHeaders}.{h,m}'
    ss.public_header_files = 'Culqi/CLQ{BaseModelObject,Token,IssuerIdentificationNumber,CardIssuer,Client,AntifraudDetails,Card,Charge,Outcome,FeeDetails,FeeFixed,FeeVariable,Operation,Plan,Customer,Subscription,Error,ResponseHeaders}.h'
  end

  s.subspec "Networking" do |ss|
    ss.dependency 'Culqi/Models'
    ss.dependency 'AFNetworking'#, '~> 2.3'
    ss.source_files = 'Culqi/CLQ{HTTPSessionManager,WebServices}.{h,m}'
    ss.public_header_files = 'Culqi/CLQ{HTTPSessionManager,WebServices}.h'
  end

  s.subspec "Core" do |ss|
    ss.dependency 'Culqi/Networking'
    ss.source_files = 'Culqi/Culqi.{h,m}'
    ss.public_header_files = 'Culqi/Culqi.h'
  end

end
