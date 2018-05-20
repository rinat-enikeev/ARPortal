//
//  ViewController.swift
//  ARPortal
//
//  Created by Rinat Enikeev on 20/05/2018.
//  Copyright © 2018 Rinat Enikeev. All rights reserved.
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

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Create a session configuration
        let configuration = ARWorldTrackingConfiguration()
        configuration.planeDetection = .horizontal
        // Run the view's session
        sceneView.session.run(configuration)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // Pause the view's session
        sceneView.session.pause()
    }
    
    func renderer(_ renderer: SCNSceneRenderer, didAdd node: SCNNode, for anchor: ARAnchor) {
        if anchor is ARPlaneAnchor {
            let planeAncor = anchor as! ARPlaneAnchor
            let plane = SCNPlane(width: CGFloat(planeAncor.extent.x), height: CGFloat(planeAncor.extent.z))
            let planeNode = SCNNode()
            planeNode.position = SCNVector3(x: planeAncor.center.x, y: 0, z: planeAncor.center.z)
            planeNode.transform = SCNMatrix4MakeRotation(-Float.pi/2, 1, 0, 0)
            
            let gridMaterial = SCNMaterial()
            gridMaterial.diffuse.contents = UIImage(named: "art.scnassets/grid.png")
            plane.materials = [gridMaterial]

            planeNode.geometry = plane
            node.addChildNode(planeNode)
        } else {
            return
        }
    }
    
}
