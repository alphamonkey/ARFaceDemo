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
        createFaceGeometry()
        restartExperience()
    
    }

    func restartExperience() {
        
        guard ARFaceTrackingConfiguration.isSupported else { return }
        let configuration = ARFaceTrackingConfiguration()
        configuration.isLightEstimationEnabled = true
        session.run(configuration, options: [.resetTracking, .removeExistingAnchors])
    }
    
    func createFaceGeometry() {
        
        guard let device = sceneView.device else {
            return
        }
        let mask = Mask(device: device)
        contentUpdater.virtualFaceNode = mask

    }


}

extension ViewController:ARSessionDelegate {
    
    func sessionInterruptionEnded(_ session: ARSession) {
        DispatchQueue.main.async {
            self.restartExperience()
        }
    }
    
    func session(_ session: ARSession, didFailWithError error: Error) {
        guard error is ARError else { return }
        let error = error as NSError
        let messages = [error.localizedDescription, error.localizedFailureReason, error.localizedRecoverySuggestion].flatMap { ($0) }
        let errorString = messages.joined(separator: "\n")
        print(errorString)
    }
}
