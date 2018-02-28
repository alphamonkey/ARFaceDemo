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
    init(geometry:ARSCNFaceGeometry) {
        
        super.init()
        self.geometry = geometry
        material.lightingModel = .physicallyBased
        material.diffuse.contents = #imageLiteral(resourceName: "halfred.png")
        material.specular.contents = UIColor.white

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
