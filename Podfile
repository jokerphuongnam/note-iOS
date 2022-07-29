# Uncomment the next line to define a global platform for your project
platform :ios, '12.0'

def notesManager
  # Rx
  pod 'RxSwift', '6.0.0'
  pod 'RxCocoa', '6.0.0'
  # Kingfisher
  pod 'Kingfisher', '~> 7.0'
  # SwiftGen
  pod 'SwiftGen', '~> 6.0'
  # Swinject
  pod 'Swinject', '~> 2.7.0'
  pod 'SwinjectAutoregistration', '~> 2.7.0'
  # Alamofire
  pod 'Alamofire', '~> 5.5.0'
end

target 'NotesManager' do
    # Comment the next line if you don't want to use dynamic frameworks
    use_frameworks!

    # Pods for NotesManager
    notesManager
    target 'NotesManager Staging' do
      use_frameworks!
    end
    
    target 'NotesManager StagingTests' do
      inherit! :search_paths
      # Pods for testing
      pod 'Mocker', '~> 2.5.4'
      pod 'RxTest', '6.0.0'
      pod 'RxBlocking', '6.0.0'
    end

end
