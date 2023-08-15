//
//  ViewController.swift
//  Poke3D
//
//  Created by Mobeen Riaz on 14/08/2023.
//

import UIKit
import SceneKit
import ARKit

class ViewController: UIViewController, ARSCNViewDelegate {

    @IBOutlet var sceneView: ARSCNView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set the view's delegate
        sceneView.delegate = self
        
        // Show statistics such as fps and timing information
        sceneView.showsStatistics = true
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Create a session configuration
        let configuration = ARWorldTrackingConfiguration()
        
        if let imageToTrack = ARReferenceImage.referenceImages(inGroupNamed: "Cards", bundle: .main){
            
            configuration.detectionImages = imageToTrack
            
            configuration.maximumNumberOfTrackedImages = 2
        }

        // Run the view's session
        sceneView.session.run(configuration)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // Pause the view's session
        sceneView.session.pause()
    }

    // MARK: - ARSCNViewDelegate
  
    func renderer(_ renderer: SCNSceneRenderer, nodeFor anchor: ARAnchor) -> SCNNode? {
        
        let node = SCNNode()
        
        if let imageAnchor = anchor as? ARImageAnchor {
            
            let plane = SCNPlane(width: imageAnchor.referenceImage.physicalSize.width, height: imageAnchor.referenceImage.physicalSize.height)
            
            plane.firstMaterial?.diffuse.contents = UIColor(white: 1.0, alpha: 0.5)
            let planeNode = SCNNode(geometry: plane)
            
            planeNode.eulerAngles.x = -.pi / 2
            
            
            let anchorImage = imageAnchor.referenceImage.name
            
            
            var scn = ""
 
            if anchorImage == "pral-card" {
                if let OddishScene = SCNScene(named: "art.scnassets/Oddish.scn") {
                    if let oddishNode = OddishScene.rootNode.childNodes.first {
                        oddishNode.eulerAngles.x = .pi
                        planeNode.addChildNode(oddishNode)
                    }
                }
            }
            
            if anchorImage == "cnic-card" {
                if let OddishScene = SCNScene(named: "art.scnassets/eevee.scn") {
                    if let oddishNode = OddishScene.rootNode.childNodes.first {
                        oddishNode.eulerAngles.x = .pi / 2
                        planeNode.addChildNode(oddishNode)
                    }
                }
            }
            
            node.addChildNode(planeNode)

            
        }
        
        sceneView.autoenablesDefaultLighting = true
        
        return node
    }
}
