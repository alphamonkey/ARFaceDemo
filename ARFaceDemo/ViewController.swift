//
//  ViewController.swift
//  ARFaceDemo
//
//  Created by Josh Edson on 2/26/18.
//  Copyright © 2018 Josh Edson. All rights reserved.
//

import UIKit
import SceneKit
import ARKit
class ViewController: UIViewController {


    @IBOutlet weak var sceneView: ARSCNView!
    
    let contentUpdater = VirtualContentUpdater()
    var session:ARSession {
        return sceneView.session
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        sceneView.delegate = contentUpdater
        session.delegate = self
        sceneView.automaticallyUpdatesLighting = true
        //createBackgroundPlane()
        createFaceGeometry()
        restartExperience()
        
        
        
    }
    func createBackgroundPlane() {
        let planeGeometry = SCNPlane(width: 1000.0, height: 1000.0)
        planeGeometry.materials.first!.diffuse.contents = UIColor.black
        let planeNode = SCNNode(geometry: planeGeometry)
        //planeNode.rotation = SCNVector4(0.0, -M_PI, 0.0, 1.0)
        planeNode.position = SCNVector3(0.0, 0.0, -1.0)
        sceneView.scene.rootNode.addChildNode(planeNode)
    }
    func restartExperience() {
        guard ARFaceTrackingConfiguration.isSupported else { return }
        let configuration = ARFaceTrackingConfiguration()
        configuration.isLightEstimationEnabled = true
        session.run(configuration, options: [.resetTracking, .removeExistingAnchors])
    }
    func createFaceGeometry() {
        let device = sceneView.device!
        let maskGeometry = ARSCNFaceGeometry(device: device)!
        let sphere = SCNSphere(radius: 0.025)
        sphere.materials.first!.diffuse.contents = UIColor.red
        sphere.materials.first!.lightingModel = .physicallyBased
        let node = SCNNode(geometry: sphere)
        node.position.y = 0.00
        node.position.z = 0.06
        node.renderingOrder = -1
        
        contentUpdater.virtualFaceNode = Mask(geometry: maskGeometry)
        contentUpdater.virtualFaceNode?.addChildNode(node)
    }


}

extension ViewController:ARSessionDelegate {
    
}
