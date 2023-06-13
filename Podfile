# Uncomment the next line to define a global platform for your project
platform :ios, '12.0'
use_frameworks!
inhibit_all_warnings!

def visual_pods
  pod 'SDWebImage'
  pod 'SkeletonView'
  pod 'SnapKit', '~> 5.6.0'
end

def helper_pods
  pod 'SwiftGen', '~> 6.0'
end

def google_pods
  pod "youtube-ios-player-helper", "~> 1.0.4"
end

target 'TMDB' do
  visual_pods
  helper_pods
  google_pods
end
