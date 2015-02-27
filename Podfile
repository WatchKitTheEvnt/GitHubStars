platform :ios, '8.0'
inhibit_all_warnings!

xcodeproj 'GitHubStars/GitHubStars.xcodeproj'

target 'GitHubStars' do
	pod 'OctoKit', :podspec=> 'OctoKit.podspec.json'
	pod 'ISO8601DateFormatter' , :git => 'https://github.com/ieduardogf/iso-8601-date-formatter.git'
	pod 'GHMarkdownParser'
end

target 'GitHubStarsTests' do
	pod 'OctoKit', :podspec=> 'OctoKit.podspec.json'
end