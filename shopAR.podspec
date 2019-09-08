#
#  Be sure to run `pod spec lint shopAR.podspec' to ensure this is a
#  valid spec and to remove all comments including this before submitting the spec.
#
#  To learn more about Podspec attributes see https://guides.cocoapods.org/syntax/podspec.html
#  To see working Podspecs in the CocoaPods repo see https://github.com/CocoaPods/Specs/
#

Pod::Spec.new do |spec|

  # ―――  Spec Metadata  ―――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  #
  #  These will help people to find your library, and whilst it
  #  can feel like a chore to fill in it's definitely to your advantage. The
  #  summary should be tweet-length, and the description more in depth.
  #

  spec.name         = "shopAR"
  spec.version      = "1.5"
  spec.summary      = "shopAR enables retail-based iOS apps to easily integrate Augmented Reality product-viewing at the touch of a button."

  # This description is used to generate tags and improve search results.
  #   * Think: What does it do? Why did you write it? What is the focus?
  #   * Try to keep it short, snappy and to the point.
  #   * Write the description between the DESC delimiters below.
  #   * Finally, don't worry about the indent, CocoaPods strips it!

spec.screenshots = [ './IMG_9023.JPG', './IMG_9024.JPG', './IMG_9025.JPG']

  spec.description  = <<-DESC
shopAR for iOS

Overview
	
shopAR allows you to upload .scn files through our React app accessible at shoppar.herokuapp.com/. Files are stored by our API using AWS s3, and our CocoaPod enables interaction with these services for easy in-app retrieval and display.

shopAR provides an example project that includes a ViewController that enables you to view .scn objects in Augmented Reality. If your app does not already have AR capabilities, instructions for easy integration of this file are below.

Pod Installation

1. Add the following line to the Podfile:
   pod "ShopApp_Shopify", "~> 1.0"
2. Install the dependencies:
   pod install

AR ViewController Installation

1. Drag ARPopUpViewController.swift into your build target directory.
2. In Main.storyboard (or your app’s primary storyboard), add a new ViewController and set its class to ARPopUpViewController.
3. Add the below tag to your app’s info.plist:
   <key>NSCameraUsageDescription</key>
   <string>For Augemented Reality</string>

Usage

1. Upload a .scn file at shoppar.herokuapp.com/
2. Import shopAR atop your file and create an instance with var shop = shopAR()
   **For the following steps, we highly recommend you closely follow the shopAR Example project included. There you can find code for the steps described here.**
3. In your desired file’s viewDidLoad(), call shop.fetchObject(user_id, file_id) for each file_id that you uploaded online. Here, file_id refers to the exact name of the file you uploaded. User_id is a constant found in the shopAR example until login functionality is finalized at shoppar.herokuapp.com/.
4. Save each returned url String from fetchObject(). All of this should be done in viewDidLoad().
5. When an item’s button is pressed, create an instance of the ARPopUpViewController, pass it the desired url String, and present it
                   DESC

  spec.homepage     = "https://github.com/thefishstick/shopAR"
  # spec.screenshots  = "www.example.com/screenshots_1.gif", "www.example.com/screenshots_2.gif"


  # ―――  Spec License  ――――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  #
  #  Licensing your code is important. See https://choosealicense.com for more info.
  #  CocoaPods will detect a license file if there is a named LICENSE*
  #  Popular ones are 'MIT', 'BSD' and 'Apache License, Version 2.0'.
  #

  spec.license      = "MIT"
  # spec.license      = { :type => "MIT", :file => "LICENSE" }


  # ――― Author Metadata  ――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  #
  #  Specify the authors of the library, with email addresses. Email addresses
  #  of the authors are extracted from the SCM log. E.g. $ git log. CocoaPods also
  #  accepts just a name if you'd rather not provide an email address.
  #
  #  Specify a social_media_url where others can refer to, for example a twitter
  #  profile URL.
  #

  #spec.author             = { "" => "" }
  spec.authors = { 'Johan Todi' => 'johantodi1999@gmail.com',
                 'Max Model' => 'maxmodel99@gmail.com' }
  # spec.authors            = { "" => "" }
  # spec.social_media_url   = "https://twitter.com/"

  # ――― Platform Specifics ――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  #
  #  If this Pod runs only on iOS or OS X, then specify the platform and
  #  the deployment target. You can optionally include the target after the platform.
  #

  spec.platform     = :ios
  spec.platform     = :ios, "11.3"

  #  When using multiple platforms
  # spec.ios.deployment_target = "5.0"
  # spec.osx.deployment_target = "10.7"
  # spec.watchos.deployment_target = "2.0"
  # spec.tvos.deployment_target = "9.0"


  # ――― Source Location ―――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  #
  #  Specify the location from where the source should be retrieved.
  #  Supports git, hg, bzr, svn and HTTP.
  #

  spec.source       = { :git => "https://github.com/thefishstick/shopAR.git", :tag => "#{spec.version}" }


  # ――― Source Code ―――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  #
  #  CocoaPods is smart about how it includes source code. For source files
  #  giving a folder will include any swift, h, m, mm, c & cpp files.
  #  For header files it will include any header in the folder.
  #  Not including the public_header_files will make all headers public.
  #

  spec.source_files  = "shopAR", "shopAR/**/*.{h,m}"
  spec.exclude_files = "shopAR/Exclude"

  # spec.public_header_files = "shopAR/**/*.h"


  # ――― Resources ―――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  #
  #  A list of resources included with the Pod. These are copied into the
  #  target bundle with a build phase script. Anything else will be cleaned.
  #  You can preserve files from being cleaned, please don't preserve
  #  non-essential files like tests, examples and documentation.
  #

  # spec.resource  = "icon.png"
  # spec.resources = "Resources/*.png"

  # spec.preserve_paths = "FilesToSave", "MoreFilesToSave"


  # ――― Project Linking ―――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  #
  #  Link your library with frameworks, or libraries. Libraries do not include
  #  the lib prefix of their name.
  #

  # spec.framework  = "SomeFramework"
  # spec.frameworks = "SomeFramework", "AnotherFramework"

  # spec.library   = "iconv"
  # spec.libraries = "iconv", "xml2"


  # ――― Project Settings ――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  #
  #  If your library depends on compiler flags you can set them in the xcconfig hash
  #  where they will only apply to your library. If you depend on other Podspecs
  #  you can include multiple dependencies to ensure it works.

  # spec.requires_arc = true

  # spec.xcconfig = { "HEADER_SEARCH_PATHS" => "$(SDKROOT)/usr/include/libxml2" }
  # spec.dependency "JSONKit", "~> 1.4"

end
