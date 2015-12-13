//
//  ViewController.swift
//  iOS_Final
//
//  Created by Zhihe, Jing on 12/1/15.
//  Copyright © 2015 Zhihe, Jing. All rights reserved.
//

import UIKit
import SceneKit

class ViewController: UIViewController {

    // MARK: property
    @IBOutlet weak var sceneView: SCNView!
    // Geometry
    var geometryNode: SCNNode = SCNNode()
    
    // Gestures
    var currentAngle: Float = 0.0
    
    override func viewDidLoad() {
  
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        sceneSetup()
    }
    
    // MARK: scene
    func sceneSetup(){
        //let scene = SCNScene()
        let scene = SCNScene(named: "art.scnassets/ship.scn")!
        let ambientLightNode = SCNNode()
        ambientLightNode.light = SCNLight()
        ambientLightNode.light!.type = SCNLightTypeAmbient
        ambientLightNode.light!.color = UIColor(white: 0.67, alpha: 1.0)
        scene.rootNode.addChildNode(ambientLightNode)
        
        let omniLightNode = SCNNode()
        omniLightNode.light = SCNLight()
        omniLightNode.light!.type = SCNLightTypeOmni
        omniLightNode.light!.color = UIColor(white: 0.75, alpha: 1.0)
        omniLightNode.position = SCNVector3Make(0, 50, 50)
        scene.rootNode.addChildNode(omniLightNode)
        
        let cameraNode = SCNNode()
        cameraNode.camera = SCNCamera()
        cameraNode.position = SCNVector3Make(0, 0, 20)
        scene.rootNode.addChildNode(cameraNode)
        
        /*
        let boxGeometry = SCNBox(width: 10.0, height: 10.0, length: 10.0, chamferRadius: 1.0)
        let boxNode = SCNNode(geometry: boxGeometry)
        scene.rootNode.addChildNode(boxNode)
        
        geometryNode = boxNode
        */
        
        //let ball = scene.rootNode.childNodeWithName("Pokeball", recursively: true)!
        /*
        let panRecognizer = UIPanGestureRecognizer(target: self, action: "panGesture:")
        sceneView.addGestureRecognizer(panRecognizer)
        */

     
        sceneView.scene = scene
        //sceneView.autoenablesDefaultLighting = true
        sceneView.allowsCameraControl = true
        sceneView.showsStatistics = true
        let tapGesture = UITapGestureRecognizer(target: self, action: "handleTap:")
        sceneView.addGestureRecognizer(tapGesture)

    }
    
    func handleTap(gestureRecognize: UIGestureRecognizer) {
        // check what nodes are tapped
        let p = gestureRecognize.locationInView(sceneView)
        let hitResults = sceneView.hitTest(p, options: nil)
        // check that we clicked on at least one object
        if hitResults.count > 0 {
            // retrieved the first clicked object
            let result: AnyObject! = hitResults[0]
            
            // get its material
            let material = result.node!.geometry!.firstMaterial!
            
            // highlight it
            SCNTransaction.begin()
            SCNTransaction.setAnimationDuration(0.5)
            
            // on completion - unhighlight
            SCNTransaction.setCompletionBlock {
                SCNTransaction.begin()
                SCNTransaction.setAnimationDuration(0.5)
                
                material.emission.contents = UIColor.blackColor()
                
                SCNTransaction.commit()
            }
            
            material.emission.contents = UIColor.redColor()
            
            SCNTransaction.commit()
        }
    }

    
    func panGesture(sender: UIPanGestureRecognizer) {
        let translation = sender.translationInView(sender.view!)
        var newAngle = (Float)(translation.x)*(Float)(M_PI)/180.0
        newAngle += currentAngle
        
        geometryNode.transform = SCNMatrix4MakeRotation(newAngle, 0, 1, 0)
        
        if(sender.state == UIGestureRecognizerState.Ended) {
            currentAngle = newAngle
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

