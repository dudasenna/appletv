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

let sizeMultipliers = [0.2, 0.3, 0.4]

func chooseShape (randomNumber: Int, multiplierIndex: Int) -> SKShapeNode {
    switch randomNumber {
    case 1:
        return createTriangle(multiplierIndex: multiplierIndex)
    case 2:
        return createSquare(multiplierIndex: multiplierIndex)
    case 3:
        return createPentagon(multiplierIndex: multiplierIndex)
    case 4:
        return createHexagon(multiplierIndex: multiplierIndex)
    case 5:
        return createHeptagon(multiplierIndex: multiplierIndex)
    case 6:
        return createOctagon(multiplierIndex: multiplierIndex)
    default:
        return createSquare(multiplierIndex: multiplierIndex)
    }
}

func createTriangle (multiplierIndex: Int) -> SKShapeNode {
    
    let multiplier = sizeMultipliers[multiplierIndex]
    
    var trianglePoints = [CGPoint(x: multiplier * 0, y: multiplier * 0),
                          CGPoint(x: multiplier * 250, y: multiplier * 435),
                          CGPoint(x: multiplier * 500, y: multiplier * 0),
                          CGPoint(x: multiplier * 0, y: multiplier * 0),]

    let triangleShape = SKShapeNode(points: &trianglePoints, count: trianglePoints.count)
    
    triangleShape.fillColor = .yellowColor
    triangleShape.strokeColor = .yellowColor
    
    return triangleShape
}

func createSquare (multiplierIndex: Int) -> SKShapeNode {
    
    let multiplier = sizeMultipliers[multiplierIndex]
    
    var squarePoints = [CGPoint(x: multiplier * 0, y: multiplier * 0),
                          CGPoint(x: multiplier * 0, y: multiplier * 400),
                          CGPoint(x: multiplier * 400, y: multiplier * 400),
                          CGPoint(x: multiplier * 400, y: multiplier * 0),
                          CGPoint(x: multiplier * 0, y: multiplier * 0)]

    let squareShape = SKShapeNode(points: &squarePoints, count: squarePoints.count)
    
    squareShape.fillColor = .pinkColor
    squareShape.strokeColor = .pinkColor
    
    return squareShape
}

func createPentagon (multiplierIndex: Int) -> SKShapeNode {
    
    let multiplier = sizeMultipliers[multiplierIndex]
    
    var pentagonPoints = [CGPoint(x: multiplier * 0, y: multiplier * 0),
                          CGPoint(x: multiplier * -108, y: multiplier * 333),
                          CGPoint(x: multiplier * 175, y: multiplier * 540),
                          CGPoint(x: multiplier * 458, y: multiplier * 333),
                          CGPoint(x: multiplier * 350, y: multiplier * 0),
                          CGPoint(x: multiplier * 0, y: multiplier * 0)]

    let pentagonShape = SKShapeNode(points: &pentagonPoints, count: pentagonPoints.count)
    
    pentagonShape.fillColor = .blueColor
    pentagonShape.strokeColor = .blueColor
    
    return pentagonShape
}

func createHexagon (multiplierIndex: Int) -> SKShapeNode {
    
    let multiplier = sizeMultipliers[multiplierIndex]
    
    var hexagonPoints = [CGPoint(x: multiplier * 0, y: multiplier * 0),
                          CGPoint(x: multiplier * -150, y: multiplier * 260),
                          CGPoint(x: multiplier * 0, y: multiplier * 520),
                          CGPoint(x: multiplier * 300, y: multiplier * 520),
                          CGPoint(x: multiplier * 450, y: multiplier * 260),
                          CGPoint(x: multiplier * 300, y: multiplier * 0),
                          CGPoint(x: multiplier * 0, y: multiplier * 0),]
    
    let hexagonShape = SKShapeNode(points: &hexagonPoints, count: hexagonPoints.count)
    
    hexagonShape.fillColor = .greenColor
    hexagonShape.strokeColor = .greenColor
    
    return hexagonShape
}

func createHeptagon (multiplierIndex: Int) -> SKShapeNode {
    
    let multiplier = sizeMultipliers[multiplierIndex]
    
    var heptagonPoints = [CGPoint(x: multiplier * 0, y: multiplier * 0),
                          CGPoint(x: multiplier * -156, y: multiplier * 196),
                          CGPoint(x: multiplier * -100, y: multiplier * 440),
                          CGPoint(x: multiplier * 126, y: multiplier * 548),
                          CGPoint(x: multiplier * 350, y: multiplier * 440),
                          CGPoint(x: multiplier * 407, y: multiplier * 196),
                          CGPoint(x: multiplier * 250, y: multiplier * 0),
                          CGPoint(x: multiplier * 0, y: multiplier * 0),]
    
    let heptagonShape = SKShapeNode(points: &heptagonPoints, count: heptagonPoints.count)
    
    heptagonShape.fillColor = .orangeColor
    heptagonShape.strokeColor = .orangeColor
    
    return heptagonShape
}

func createOctagon (multiplierIndex: Int) -> SKShapeNode {
    
    let multiplier = sizeMultipliers[multiplierIndex]
    
    var octagonPoints = [CGPoint(x: multiplier * 0, y: multiplier * 0),
                          CGPoint(x: multiplier * -142, y: multiplier * 142),
                          CGPoint(x: multiplier * -142, y: multiplier * 342),
                          CGPoint(x: multiplier * 0, y: multiplier * 483),
                          CGPoint(x: multiplier * 200, y: multiplier * 483),
                          CGPoint(x: multiplier * 342, y: multiplier * 342),
                          CGPoint(x: multiplier * 342, y: multiplier * 142),
                          CGPoint(x: multiplier * 200, y: multiplier * 0),
                          CGPoint(x: multiplier * 0, y: multiplier * 0),]
    
    let octagonShape = SKShapeNode(points: &octagonPoints, count: octagonPoints.count)
    
    octagonShape.fillColor = .purpleColor
    octagonShape.strokeColor = .purpleColor
    
    return octagonShape
}
