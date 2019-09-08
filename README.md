<h1>shopAR for iOS</h2>

<h2>Overview</h2>
	
	shopAR allows you to upload .scn files through our React app accessible at shoppar.herokuapp.com/. Files are stored by our API using AWS s3, and our CocoaPod enables interaction with these services for easy in-app retrieval and display.

	shopAR provides an example project that includes a ViewController that enables you to view .scn objects in Augmented Reality. If your app does not already have AR capabilities, instructions for easy integration of this file are below.

<h3> Pod Installation </h3>

1. Add the following line to the Podfile:
	pod "shopAR", "~> 1.5"
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
5. When an item’s button is pressed, create an instance of the ARPopUpViewController, pass it the desired url String, and present it.

![Screenshots of Demo Project](https://github.com/thefishstick/shopAR/blob/master/IMG_9023.JPG)
![Screenshots of Demo Project](https://github.com/thefishstick/shopAR/blob/master/IMG_9024.JPG)

