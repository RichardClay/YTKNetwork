Pod::Spec.new do |s|

  s.name         = "YTKNetwork"
  s.version      = "4.1.7"
  s.summary      = "YTKNetwork is a high level request util based on AFNetworking."
  s.homepage     = "http://uugit.uupt.com/CommonLib/YTKNetwork.git"
  s.license      = "MIT"
  s.author       = {
                    "tangqiao" => "tangqiao@fenbi.com",
                    "lancy" => "lancy@fenbi.com",
                    "maojj" => "maojj@fenbi.com",
                    "liujl" => "liujl@fenbi.com",
                    "shangcr" => "shangcr@fenbi.com"
 }
  s.source        = { :git => "http://uugit.uupt.com/CommonLib/YTKNetwork.git", :tag => s.version.to_s }
  s.source_files  = "YTKNetwork/*.{h,m}"
  s.requires_arc  = true
  s.private_header_files = "YTKNetwork/YTKNetworkPrivate.h"
  s.ios.deployment_target = "9.0"
  s.framework = "CFNetwork"

  s.dependency "AFNetworking/NSURLSession", "~> 4.0"
  s.dependency 'AlicloudHTTPDNS'
end
