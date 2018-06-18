# Uncomment the next line to define a global platform for your project
# platform :ios, '9.0'

def shared_pods
  # Comment the next line if you're not using Swift and don't want to use dynamic frameworks
  use_frameworks!
  
  # Networking
  pod 'Alamofire', '~> 4.7.2'

  # QA and CI
  pod 'SwiftLint', '~> 0.16.1'
  pod 'R.swift', '~> 3.3.0'

  # UI
  pod 'MBProgressHUD', '~> 1.1.0'
 end

target 'dgdrms' do
  # Comment the next line if you're not using Swift and don't want to use dynamic frameworks
  use_frameworks!

  # Pods for dgdrms
   shared_pods

  target 'dgdrmsTests' do
    inherit! :search_paths
    # Pods for testing
  end

end
