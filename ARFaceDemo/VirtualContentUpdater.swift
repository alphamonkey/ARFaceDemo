//
//  VirtualContentUpdater.swift
//  ARFaceDemo
//
//  Created by Josh Edson on 2/26/18.
//  Copyright © 2018 Josh Edson. All rights reserved.
//

import UIKit
import SceneKit
import ARKit
class VirtualContentUpdater: NSObject, ARSCNViewDelegate {
    var virtualFaceNode:VirtualFaceNode? {
        didSet {
            setupFaceGeometry()
        }
    }
    private var faceNode:SCNNode?
    
    func setupFaceGeometry() {
        guard let node = faceNode else {return}
        for child in node.childNodes {
            child.removeFromParentNode()
        }
        if let content = virtualFaceNode {
            node.addChildNode(content)
        }
    }
    
    func renderer(_ renderer: SCNSceneRenderer, didAdd node: SCNNode, for anchor: ARAnchor) {
        guard let _ = anchor as? ARFaceAnchor else {return}
        
        faceNode = node
        setupFaceGeometry()
    }
    
    func renderer(_ renderer: SCNSceneRenderer, didUpdate node: SCNNode, for anchor: ARAnchor) {
        guard let faceAnchor = anchor as? ARFaceAnchor else {return}
        virtualFaceNode?.update(with: faceAnchor)
        if let leftEmitter = virtualFaceNode?.childNode(withName: "emitter1", recursively: true)?.particleSystems?.first,
            let rightEmitter = virtualFaceNode?.childNode(withName: "emitter2", recursively: true)?.particleSystems?.first,
            let brow = faceAnchor.blendShapes[ARFaceAnchor.BlendShapeLocation.browDownLeft]?.doubleValue

        {
            
            var browAmount = (CGFloat(brow) - 0.75) / 12.0
            if(browAmount < 0.001) {
                browAmount = 0.001
            }
            leftEmitter.particleLifeSpan = 1.0 + browAmount * 10.0
            rightEmitter.particleLifeSpan = 1.0 + browAmount * 10.0
           // print(browAmount)
            leftEmitter.particleSize = browAmount
            rightEmitter.particleSize = browAmount
  
            
        }
        
    }
}
