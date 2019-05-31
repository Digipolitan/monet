workspace 'Monet.xcworkspace'

## Frameworks targets
abstract_target 'Frameworks' do
	use_frameworks!

	pod 'ObjectMapper', '~> 3.4', :inhibit_warnings => true

	target 'Monet-iOS' do
		platform :ios, '9.0'
	end

	target 'Monet-tvOS' do
		platform :tvos, '9.0'
	end
end

## Tests targets
abstract_target 'Tests' do
	use_frameworks!

	target 'MonetTests-iOS' do
		platform :ios, '9.0'
	end

	target 'MonetTests-tvOS' do
		platform :tvos, '9.0'
	end
end

## Samples targets
abstract_target 'Samples' do
	use_frameworks!

	target 'MonetSample-iOS' do
		project 'Samples/MonetSample-iOS/MonetSample-iOS'
		platform :ios, '9.0'
	end

	target 'MonetSample-tvOS' do
		project 'Samples/MonetSample-tvOS/MonetSample-tvOS'
		platform :tvos, '9.0'
	end
end
