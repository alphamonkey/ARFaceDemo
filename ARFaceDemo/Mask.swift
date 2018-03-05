//
//  Mask.swift
//  ARFaceDemo
//
//  Created by Josh Edson on 2/26/18.
//  Copyright © 2018 Josh Edson. All rights reserved.
//

import Foundation
import SceneKit
import ARKit
class Mask:SCNNode {
    var nose:SCNNode?
    init(geometry:ARSCNFaceGeometry) {
        
        super.init()
        self.geometry = geometry
        material.lightingModel = .physicallyBased
        material.diffuse.contents = #imageLiteral(resourceName: "halfred.png")
        material.specular.contents = UIColor.white
        createNose()
        createEyes()
    }
    init(device:MTLDevice) {
        super.init()
        let maskGeometry = ARSCNFaceGeometry(device: device)
        self.geometry = maskGeometry
    }
    func createEyes() {
        
        let emitterNode1 = SCNNode(geometry: nil)
        let emitterNode2 = SCNNode(geometry: nil)
        emitterNode1.name = "emitter1"
        emitterNode2.name = "emitter2"
        
        let emitter1 = SCNParticleSystem(named: "RedEye.scnp", inDirectory: nil)
        let emitter2 = SCNParticleSystem(named: "RedEye.scnp", inDirectory: nil)
        
        emitterNode1.position = SCNVector3(-0.032, 0.0275, 0.03)
        emitterNode2.position = SCNVector3(0.032, 0.0275, 0.03)
        
        emitterNode1.addParticleSystem(emitter1!)
        emitterNode2.addParticleSystem(emitter2!)

        self.addChildNode(emitterNode1)
        self.addChildNode(emitterNode2)
    }
    
    func createNose() {
        let sphere = SCNSphere(radius: 0.025)
        sphere.materials.first!.diffuse.contents = UIColor.red
        sphere.materials.first!.lightingModel = .physicallyBased
        let node = SCNNode(geometry: sphere)
        node.position.y = 0.00
        node.position.z = 0.06
        node.renderingOrder = -1
        self.nose = node
        
        if let nose = self.nose {
            self.addChildNode(nose)
        }
 
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("\(#function) has not been implemented")
    }
    var material:SCNMaterial! {
        return geometry!.materials.first!
    }
}

extension Mask:VirtualFaceContent {
    func update(with faceAnchor: ARFaceAnchor) {
        guard let faceGeometry = self.geometry as? ARSCNFaceGeometry else {
            return
        }
        faceGeometry.update(from: faceAnchor.geometry)
    }
}
