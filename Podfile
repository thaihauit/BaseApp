# Uncomment this line to define a global platform for your project
install! 'cocoapods',
:deterministic_uuids => false

def ui
    pod 'Cosmos', '~>8.0.2'
    pod 'SDWebImage', '~>3.8.2'
    pod 'FSImageViewer', '~>3.4'
    pod 'BaiduMapKit', '~>3.2.1'
    pod 'GoogleMaps', '~>2.2.0'
    pod 'PagingMenuController', '~>2.2.0'
end

def networking
    pod 'Alamofire', '~>4.4.0'
    pod 'OHHTTPStubs/Swift', '~>5.2.3'
    pod 'OHHTTPStubs/JSON', '~>5.2.3'
    pod 'OHHTTPStubs/NSURLSession', '~>5.2.3'
end

def database
    pod 'RealmSwift', '~>2.4.4'
end

def utilities
    pod 'DateTools', '~>2.0.0'
    pod 'SwiftyJSON', '~>3.1.4'
    pod 'SwiftyAttributes', '~>3.1.0'
end

def tracking
    pod 'Fabric', '~>1.6.11'
    pod 'Crashlytics', '~>3.8.4'
    pod 'Mixpanel', '~>3.1.2'
end

def pattern
    pod 'Bolts-Swift', '~>1.3.0'
end

def animation
    pod 'pop', '~>1.0.9'
end

def chat
    pod 'PubNub', '~>4.5.15'
end

def amazonS3Upload
    pod 'AWSS3', '~>2.5.2'
end

target 'BaseApp' do
    platform :ios, '9.0'
    use_frameworks!
    ui
    networking
    database
    utilities
    tracking
    pattern
    animation
    chat
    amazonS3Upload
end

