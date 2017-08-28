//
//  Plane.swift
//  ArkitTest
//
//  Created by Patrick on 24/07/2017.
//  Copyright © 2017 0xDD. All rights reserved.
//


import Foundation
import ARKit

class Plane: SCNNode {
    
    var anchor: ARPlaneAnchor
    var planeGeometry: SCNPlane
    
    init(_ anchor: ARPlaneAnchor) {
        self.anchor = anchor
        
        let pGeometry = SCNPlane(width: CGFloat(anchor.extent.x), height: CGFloat(anchor.extent.z))
        self.planeGeometry = pGeometry
        
        super.init()
        
        let material = SCNMaterial()
        let grid = UIImage(named: "tron_grid.png")
        
        material.diffuse.contents = grid
        material.isDoubleSided = true
        self.planeGeometry.materials = [material]
        
        let planeNode : SCNNode = SCNNode(geometry:self.planeGeometry)
        planeNode.position = SCNVector3Make(anchor.center.x, 0, anchor.center.z)
        
        planeNode.transform = SCNMatrix4MakeRotation( Float.pi / 2.0, 1.0, 0.0, 0.0)
        
        self.setTextureScale()
        self.addChildNode(planeNode)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func update(_ anchor: ARPlaneAnchor) {
        self.planeGeometry.width = CGFloat(anchor.extent.x)
        self.planeGeometry.height = CGFloat(anchor.extent.z)
        self.position = SCNVector3Make(anchor.center.x, 0, anchor.center.z)
        
        self.setTextureScale()
    }
    
    func setTextureScale() {
        
        let width : CGFloat = self.planeGeometry.width
        let height : CGFloat = self.planeGeometry.height
        
        let material : SCNMaterial = self.planeGeometry.materials.first!
        material.diffuse.contentsTransform = SCNMatrix4MakeScale(Float(width), Float(height), 1)
        material.diffuse.wrapS = SCNWrapMode.repeat
        material.diffuse.wrapT = SCNWrapMode.repeat
    }
    
}
