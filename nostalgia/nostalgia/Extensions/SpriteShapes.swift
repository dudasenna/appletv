//
//  SpriteShapes.swift
//  nostalgia
//
//  Created by Eduarda Senna on 31/05/21.
//

import Foundation
import SwiftUI
import CoreGraphics
import UIKit
import SpriteKit

/// Converts from degrees to radians.
public func radians(fromDegrees: Double) -> CGFloat {
    return CGFloat(fromDegrees * (Double.pi / 180.0))
}

/*
 (!) UIBezierPath uses radians to specify angles.
     The above function converts from degrees.

 (!) When drawing arcs with UIBezierPath,
     the 0º point is at the 3 o'clock position.

              270º
               |
       180º —— + ——  0º
               |
              90º
 
*/
/// Creates a CGPath, used to create a custom shape.

public func oddShape() -> CGPath {
    let path = UIBezierPath()
    let leftCircleCenter = CGPoint(x: 40, y: 40)
    let rightCircleCenter = CGPoint(x: 160, y: 40)
    let boxTopLeft = leftCircleCenter
    let boxTopRight = rightCircleCenter
    let boxBottomRight = CGPoint(x: 160, y: 160)
    let boxBottomLeft = CGPoint(x: 40, y: 160)
    path.addArc(withCenter: leftCircleCenter,
                radius: 40,
                startAngle: radians(fromDegrees: 90),
                endAngle: radians(fromDegrees: 0),
                clockwise: true)
    path.addLine(to: rightCircleCenter)
    path.addArc(withCenter: rightCircleCenter,
                radius: 40,
                startAngle: radians(fromDegrees: 180),
                endAngle: radians(fromDegrees: 90),
                clockwise: true)
    path.addLine(to: boxBottomRight)
    path.addLine(to: boxBottomLeft)
    path.addLine(to: boxTopLeft)
    path.close()
    return path.cgPath
}

public extension UIColor {
    /// Creates a new, lighter color, where 1.0 is the lightest and 0.0 is no change.
    func lighter(percent: Double = 0.2) -> UIColor {
        return withBrightness(percent: 1 + percent)
    }
    
    /// Creates a new, darker color, where 1.0 is darkest and 0.0 is no change.
    func darker(percent: Double = 0.2) -> UIColor {
        return withBrightness(percent: 1 - percent)
    }
    
    /// Creates a new Color with the given transparency, where 0.0  is completely transparent and 1.0 is completely opaque.
    func withAlpha(alpha: Double) -> UIColor {
        return self.withAlphaComponent(CGFloat(alpha))
    }
    
    /// Creates a new Color with the given brightness, where 0.0 is the darkest and 1.0 is the brightest.
    private func withBrightness(percent: Double) -> UIColor {
        var cappedPercent = min(percent, 1.0)
        cappedPercent = max(0.0, percent)
        
        var hue: CGFloat = 0.0
        var saturation: CGFloat = 0.0
        var brightness: CGFloat = 0.0
        var alpha: CGFloat = 0.0
        self.getHue(&hue, saturation: &saturation, brightness: &brightness, alpha: &alpha)
        
        return UIColor(hue: CGFloat(Double(hue)), saturation: CGFloat(Double(saturation)), brightness: CGFloat(Double(brightness) * cappedPercent), alpha: CGFloat(Double(alpha)))
    }
    
    /// Picks a random color.
    static func random() -> UIColor {
        let uint32MaxAsFloat = Float(UInt32.max)
        let red = Double(Float(arc4random()) / uint32MaxAsFloat)
        let blue = Double(Float(arc4random()) / uint32MaxAsFloat)
        let green = Double(Float(arc4random()) / uint32MaxAsFloat)
        
        return UIColor(red: CGFloat(red), green: CGFloat(green), blue: CGFloat(blue), alpha: 1.0)
    }
}

public extension Point {
    /// Selects a random point within the radius of a circle.
    func randomPoint(in radius: Double) -> Point {
        let alpha = 2 * Double.pi * Double.random(in: 0...radius)
        let r = radius * sqrt(Double.random(in: 0...radius))
        let x = r * cos(alpha) + self.x
        let y = r * sin(alpha) + self.y
        return Point(x: x, y: y)
    }
}

public extension Graphic {
    /// Creates a slight pulsing animation on a graphic.
    func pulse() {
        let currentScale = self.scale
        let scaleUp = SKAction.scale(by: 1.15, duration: 0.15)
        let scaleBack = SKAction.scale(to: CGFloat(currentScale), duration: 0.075)
        let sequence = SKAction.sequence([scaleUp, scaleBack])
        self.run(sequence)
    }
    
    /// Makes the current graphic draggable.
    var isDraggable: Bool {
        get {
            if self.hasHandler(forInteraction: .drag) {
                return true
            } else {
                return false
            }
            
        } set {
            if newValue {
                let handler: (Touch)->Void = {touch in
                    self.location = touch.position
                }
                self.setHandler(for: .drag, handler: handler)
            } else {
                self.removeHandler(forInteraction: .drag)
            }
        }
    }
}

public extension Sprite {
    /// Makes the current graphic draggable.
    var isDraggable: Bool {
        get {
            if self.hasHandler(forInteraction: .drag) {
                return true
            } else {
                return false
            }
            
        } set {
            if newValue {
                let handler: (Touch)->Void = {touch in
                    self.location = touch.position
                }
                self.setHandler(for: .drag, handler: handler)
            } else {
                self.removeHandler(forInteraction: .drag)
            }
        }
    }
}
