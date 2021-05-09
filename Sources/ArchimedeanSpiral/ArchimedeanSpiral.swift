//
//  ArchimedeanSpiral.swift
//  Hundred-Syllable Mantra WatchKit Extension
//
//  Created by Chen Hai Teng on 1/22/21.
//  Copyright © 2021 Chen-Hai Teng. All rights reserved.
//

import Foundation
import CoreGraphics
import CoreGraphicsExtension

public struct ArchimedeanSpiral {
    public var innerRadius: CGFloat
    public var radiusSpacing: CGFloat
    public var spacing: CGFloat
    
    public init<T: BinaryFloatingPoint>(innerRadius: T, radiusSpacing: T, spacing: T) {
        self.innerRadius = CGFloat(innerRadius)
        self.radiusSpacing = CGFloat(radiusSpacing)
        self.spacing = CGFloat(spacing)
    }
    
    public func equidistantPoints(start: CGAngle, num: Int) -> [CGPolarPoint] {
        guard num > 0 else {
            return []
        }
        var angle = start
        let a = innerRadius
        let b = 0.5*radiusSpacing/CGFloat.pi
        var radius = a + b*angle.radians
        
        // Note: the range of acos should be -1...1
        // It means 1.0 - pow(d/radius, 2)*0.5 should be in range -1...1
        // This statements ensure the initial radius located in the range.
        if radius*2.0 < self.spacing {
            radius = self.spacing/2.0
        }
        var points: [CGPolarPoint] = [CGPolarPoint(radius: radius, angle: start)]
        for _ in 1..<num {
            let delta = approxRadian(radius: radius)
            angle += delta
            radius = a + b*angle.radians
            points.append(CGPolarPoint(radius: radius, angle: angle))
        }
        return points
    }
    
    // Law of consine
    // d^2 = r1^2 + r2^2 - 2*r1*r2*cosθ
    // cosθ = (r1^2 + r2^2 - d^2)/2r1*r2
    // since r1 ≅ r2, use r1 replace r2
    // cosθ = (2r1^2 - d^2)/2r1^2 = 1 - 0.5*(d/r1)^2
    // θ = acos(1 - 0.5*(d/r1)^2)
    
    private func approxRadian(radius: CGFloat) -> CGAngle {
        let d = self.spacing
        // Note: the range of acos should be -1...1
        // It means 1.0 - pow(d/radius, 2)*0.5 should be in range -1...1
        // This statements ensure the initial radius located in the range.
//        let r = (radius*2.0 < d) ? d/2.0 : radius
        
        let θ = acos(1.0 - pow(d/radius, 2)*0.5)
        return CGAngle.radians(θ)
    }
}
