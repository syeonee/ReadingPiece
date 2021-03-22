//
//  FireCrackerScene.swift
//  ReadingPiece
//
//  Created by HanaHan on 2021/03/16.
//

import Foundation
import SpriteKit

class FireCrackerScene: SKScene {

    override func didMove(to view: SKView) {
        setScene(view)
        setNode()
    }

    override func didApplyConstraints() {
        guard let view = view else { return }
        scene?.size = view.frame.size
    }
    private func setScene(_ view: SKView) {
         backgroundColor = .clear
         scene?.anchorPoint = CGPoint(x: 0.5, y: 1)
         scene?.scaleMode = .aspectFill
     }

     private func setNode() {
        guard let redFireNode = SKEmitterNode(fileNamed: "RedFirecracker") else { return }
        guard let purpleFireNode = SKEmitterNode(fileNamed: "PurpleFirecracker") else { return }
        guard let greenFireNode = SKEmitterNode(fileNamed: "Firecracker") else { return }
        purpleFireNode.position = .zero
        redFireNode.position = .zero
        greenFireNode.position = .zero
        scene?.addChild(greenFireNode)
        scene?.addChild(purpleFireNode)
        scene?.addChild(redFireNode)
     }
 }
