//
//  VirtualFaceContent.swift
//  ARFaceDemo
//
//  Created by Josh Edson on 2/26/18.
//  Copyright © 2018 Josh Edson. All rights reserved.
//

import Foundation
import ARKit
protocol VirtualFaceContent {
    func update(with faceAnchor:ARFaceAnchor)
}

typealias VirtualFaceNode = SCNNode & VirtualFaceContent
