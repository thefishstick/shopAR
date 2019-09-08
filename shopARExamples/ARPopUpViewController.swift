//
//  ViewController.swift
//  SimpleARKitDemo
//
//  Created by Jayven N on 29/9/2017.
//  Copyright © 2017 AppCoda. All rights reserved.
//




// Instructions for installation:
//    1) Drag this file into your build target (with Main.storyboard and other ViewController.swift files, etc.
//    2) In Main.storyboard (or whatever your storyboard is), drag and drop a new ViewController. Set its class to this file's class, ARPopUpViewController
//    3) Go into your info.plist and add this tag:
//          <key>NSCameraUsageDescription</key>
//          <string>For Augemented Reality</string>
//       Add those as two consecutive lines below <key>CFBundleDevelopmentRegion</key>
//       <string>$(DEVELOPMENT_LANGUAGE)</string>

// Usage:
//    1) Pick ViewController from which to present the ARPopUpViewController.
//    2) Declare variable for fileUrl:         var fileUrl : String = ""
//    3) Import shopAR up top. Then in viewDidLoad(), add:
//         shop.fetchObject(user_id: "johan", file_id: "vase.scn") {
//              myUrl in //(userID: "johan", objectID: "vase.scn")
//              self.fileUrl = myUrl
//              print(self.fileUrl)
//         }
//       This will save to fileUrl the downloadable .scn file url given
//       user_id and file_id (file_id is typically file name)
//    4) Finally, in whatever button you desire to have trigger the AR display,
//       on press, run:
//            if let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "displayARObject") as? ARPopUpViewController
//            {
//                vc.url = fileUrl
//                present(vc, animated: true, completion: nil)
//            }
//    5) Take care to substitute the name "Main" for your storyboard if not called "Main".


import UIKit
import ARKit

public class ARPopUpViewController: UIViewController, URLSessionDelegate, URLSessionDownloadDelegate {
    
    // Initialize sceneView to put on top of ARPopUpViewController to display AR Objects
    var sceneView = ARSCNView()
    
    // Url passed in with accessible link to download .scn file
    var url: String = ""
    
    // File ending used to save download .scn file
    var file_ending = ""
    
    // Variables for help with downloading .scn file from s3
    var loading: UIAlertController!
    var loadingIndicator: UIActivityIndicatorView!
    var downloadString: String = "Downloading"
    
    
    public func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask, didFinishDownloadingTo location: URL) {
        //1. Remove The Loading View
        loading.dismiss(animated: true, completion: nil)
        
        //2. Create The Filename
        let fileURL = getDocumentsDirectory().appendingPathComponent("\(self.file_ending).scn")
        
        //3. Copy It To The Documents Directory
        do {
            try FileManager.default.copyItem(at: location, to: fileURL)
            print("Successfuly Saved File \(fileURL)")
        } catch {
            print("Error Saving: \(error)")
        }
    }
    
    
    public func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask,
                    didWriteData bytesWritten: Int64,
                    totalBytesWritten: Int64,
                    totalBytesExpectedToWrite: Int64) {
        
        // Display download progress
        print("Downloaded \(totalBytesWritten) / Of \(totalBytesExpectedToWrite) Bytes")
        DispatchQueue.main.async {
            self.loading.message = "Downloaded \(totalBytesWritten) / Of \(totalBytesExpectedToWrite) Bytes"
        }
    }
    
    
    override public func viewDidLoad() {
        // Add sceneView as parents subview
        self.view.addSubview(sceneView)
        
        //add autolayout contstraints
        sceneView.translatesAutoresizingMaskIntoConstraints = false
        sceneView.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
        sceneView.leftAnchor.constraint(equalTo: self.view.leftAnchor).isActive = true
        sceneView.rightAnchor.constraint(equalTo: self.view.rightAnchor).isActive = true
        sceneView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
        
        super.viewDidLoad()
        
        // Generate random file ending for downloaded .scn file so there's no overwriting
        self.file_ending = UUID().uuidString
        print("fileending:", self.file_ending)
        
        // Begin downloading the .scn file and saving to documents
        self.downloadSceneTask(url: URL(string: url)!)
        
        // Tap gesture recognizer for adding objects to sceneview
        addTapGestureToSceneView()
    }
    
    
    override public func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    override public func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let configuration = ARWorldTrackingConfiguration()
        sceneView.session.run(configuration)
    }
    
    
    override public func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        sceneView.session.pause()
    }
    
    
    // Function called to place AR Object in sceneview
    public func addObject(x: Float = 0, y: Float = 0, z: Float = -0.2) {

        // Retrieve path where file will be downloaded
        let downloadedScenePath = getDocumentsDirectory().appendingPathComponent("\(self.file_ending).scn")
        
        // Initialize a scene with downloaded url to add to sceneView
        let scene = try! SCNScene(url: downloadedScenePath, options: nil)
        
        // Initialize scnnode to hold placed objects
        let modelHolderNode = SCNNode()
        let nodeArray = scene.rootNode.childNodes
        for childNode in nodeArray {
            modelHolderNode.addChildNode(childNode as SCNNode)
        }
        modelHolderNode.position = SCNVector3(x, y, z)
        
        // Until textures are worked out/uploaded, cast shadow on object to make it visible
        modelHolderNode.castsShadow = true
        
        // Add children nodes that comprise the 3d image
        self.sceneView.scene.rootNode.addChildNode(modelHolderNode)
    }
    
    
    // Downloads a SCNFile From A Remote URL
    public func downloadSceneTask(url: URL){
        // Create The Download Session
        let downloadSession = URLSession(configuration: URLSession.shared.configuration, delegate: self, delegateQueue: nil)
        
        // Create The Download Task & Run It
        let downloadTask = downloadSession.downloadTask(with: url)
        downloadTask.resume()
        
        // Show The Progress Bar
        DispatchQueue.main.async {
            self.loading = UIAlertController(title: nil, message: self.downloadString , preferredStyle: .alert)
            let loadingIndicator = UIActivityIndicatorView(frame: CGRect(x: 10, y: 5, width: 50, height: 50))
            loadingIndicator.hidesWhenStopped = true
            loadingIndicator.style = UIActivityIndicatorView.Style.gray
            loadingIndicator.startAnimating();
            
            self.loading.view.addSubview(loadingIndicator)
            self.present(self.loading, animated: true, completion: nil)
        }
    }
    
    
    // In preparation for saving .scn file
    public func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let documentsDirectory = paths[0]
        return documentsDirectory
    }
    
    
    // Gesture  recognizer for adding AR Objects
    public func addTapGestureToSceneView() {
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(ARPopUpViewController.didTap(withGestureRecognizer:)))
        sceneView.addGestureRecognizer(tapGestureRecognizer)
    }
    
    
    // Selector function for above gesture recognizer, calling addObject to actually place objects
    @objc public func didTap(withGestureRecognizer recognizer: UIGestureRecognizer) {
        let tapLocation = recognizer.location(in: sceneView)
        let hitTestResults = sceneView.hitTest(tapLocation)
        
        guard let node = hitTestResults.first?.node else {
            
            let hitTestResultsWithFeaturePoints = sceneView.hitTest(tapLocation, types: .featurePoint)
            
            if let hitTestResultWithFeaturePoints = hitTestResultsWithFeaturePoints.first {
                let translation = hitTestResultWithFeaturePoints.worldTransform.translation
                addObject(x: translation.x, y: translation.y, z: translation.z)
            }
            
            return
        }
        node.removeFromParentNode()
    }
}


// Helper for location calculating
public extension float4x4 {
    var translation: float3 {
        let translation = self.columns.3
        return float3(translation.x, translation.y, translation.z)
    }
}
