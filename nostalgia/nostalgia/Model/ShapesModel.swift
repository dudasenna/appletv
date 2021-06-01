//
//  ShapesModel.swift
//  nostalgia
//
//  Created by Eduarda Senna on 01/06/21.
//

import Foundation
import CoreGraphics
import SpriteKit
import GameplayKit

let sizeMultipliers = [0.3, 0.5, 0.7]

func createTriangle (multiplierIndex: Int) -> SKShapeNode {
    
    let multiplier = sizeMultipliers[multiplierIndex]
    
    var trianglePoints = [CGPoint(x: multiplier * 0, y: multiplier * 0),
                          CGPoint(x: multiplier * 100, y: multiplier * 174),
                          CGPoint(x: multiplier * 200, y: multiplier * 0),
                          CGPoint(x: multiplier * 0, y: multiplier * 0),]

    let triangleShape = SKShapeNode(points: &trianglePoints, count: trianglePoints.count)
    
    triangleShape.fillColor = .yellowColor
    triangleShape.strokeColor = .white
//    triangleShape.glowWidth = 0.5
    
    return triangleShape
}

func createSquare (multiplierIndex: Int) -> SKShapeNode {
    
    let multiplier = sizeMultipliers[multiplierIndex]
    
    var squarePoints = [CGPoint(x: multiplier * 0, y: multiplier * 0),
                          CGPoint(x: multiplier * 0, y: multiplier * 200),
                          CGPoint(x: multiplier * 200, y: multiplier * 200),
                          CGPoint(x: multiplier * 200, y: multiplier * 0),
                          CGPoint(x: multiplier * 0, y: multiplier * 0)]

    let squareShape = SKShapeNode(points: &squarePoints, count: squarePoints.count)
    
    squareShape.fillColor = .pinkColor
    
    return squareShape
}

func createPentagon (multiplierIndex: Int) -> SKShapeNode {
    
    let multiplier = sizeMultipliers[multiplierIndex]
    
    var pentagonPoints = [CGPoint(x: multiplier * 0, y: multiplier * 0),
                          CGPoint(x: multiplier * -30, y: multiplier * 95),
                          CGPoint(x: multiplier * 50, y: multiplier * 150),
                          CGPoint(x: multiplier * 130, y: multiplier * 95),
                          CGPoint(x: multiplier * 100, y: multiplier * 0),
                          CGPoint(x: multiplier * 0, y: multiplier * 0)]

    let pentagonShape = SKShapeNode(points: &pentagonPoints, count: pentagonPoints.count)
    
    pentagonShape.fillColor = .blueColor
    
    return pentagonShape
}

func createHexagon (multiplierIndex: Int) -> SKShapeNode {
    
    let multiplier = sizeMultipliers[multiplierIndex]
    
    var hexagonPoints = [CGPoint(x: multiplier * 0, y: multiplier * 0),
                          CGPoint(x: multiplier * -50, y: multiplier * 87),
                          CGPoint(x: multiplier * 0, y: multiplier * 173),
                          CGPoint(x: multiplier * 100, y: multiplier * 173),
                          CGPoint(x: multiplier * 150, y: multiplier * 87),
                          CGPoint(x: multiplier * 100, y: multiplier * 0),
                          CGPoint(x: multiplier * 0, y: multiplier * 0),]
    
    let hexagonShape = SKShapeNode(points: &hexagonPoints, count: hexagonPoints.count)
    
    hexagonShape.fillColor = .greenColor
    
    return hexagonShape
}

func createHeptagon (multiplierIndex: Int) -> SKShapeNode {
    
    let multiplier = sizeMultipliers[multiplierIndex]
    
    var heptagonPoints = [CGPoint(x: multiplier * 0, y: multiplier * 0),
                          CGPoint(x: multiplier * -62, y: multiplier * 78),
                          CGPoint(x: multiplier * -40, y: multiplier * 176),
                          CGPoint(x: multiplier * 50, y: multiplier * 219),
                          CGPoint(x: multiplier * 140, y: multiplier * 176),
                          CGPoint(x: multiplier * 162, y: multiplier * 78),
                          CGPoint(x: multiplier * 100, y: multiplier * 0),
                          CGPoint(x: multiplier * 0, y: multiplier * 0),]
    
    let heptagonShape = SKShapeNode(points: &heptagonPoints, count: heptagonPoints.count)
    
    heptagonShape.fillColor = .orangeColor
    
    return heptagonShape
}

func createOctagon (multiplierIndex: Int) -> SKShapeNode {
    
    let multiplier = sizeMultipliers[multiplierIndex]
    
    var octagonPoints = [CGPoint(x: multiplier * 0, y: multiplier * 0),
                          CGPoint(x: multiplier * -70, y: multiplier * 70),
                          CGPoint(x: multiplier * -70, y: multiplier * 171),
                          CGPoint(x: multiplier * 0, y: multiplier * 241),
                          CGPoint(x: multiplier * 100, y: multiplier * 241),
                          CGPoint(x: multiplier * 171, y: multiplier * 170),
                          CGPoint(x: multiplier * 171, y: multiplier * 70),
                          CGPoint(x: multiplier * 100, y: multiplier * 0),
                          CGPoint(x: multiplier * 0, y: multiplier * 0),]
    
    let octagonShape = SKShapeNode(points: &octagonPoints, count: octagonPoints.count)
    
    octagonShape.fillColor = .purpleColor
    
    return octagonShape
}
