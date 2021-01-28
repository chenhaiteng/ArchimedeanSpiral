//
//  ArchimedeanSpiral.swift
//  Hundred-Syllable Mantra WatchKit Extension
//
//  Created by Chen Hai Teng on 1/22/21.
//  Copyright © 2021 Chen-Hai Teng. All rights reserved.
//

import Foundation
import CoreGraphics

public struct CGAngle {
    public var radians: CGFloat
    
    public var degrees: CGFloat {
        radians*180/CGFloat.pi
    }

    @inlinable public init() {
        radians = 0
    }

    @inlinable public init<T: BinaryFloatingPoint>(radians: T) {
        self.radians = CGFloat(radians)
    }
    
    @inlinable public init<T: BinaryFloatingPoint>(degrees: T) {
        self.radians = CGFloat(degrees)*CGFloat.pi/180
    }
    
    @inlinable public static func radians<T: BinaryFloatingPoint>(_ radians: T) -> CGAngle {
        CGAngle(radians: radians)
    }
    
    @inlinable public static func degrees<T: BinaryFloatingPoint>(_ degrees: T) -> CGAngle {
        CGAngle(degrees: degrees)
    }
    
    public static func +(lhs:CGAngle, rhs: CGAngle) -> CGAngle {
        CGAngle(radians: lhs.radians + rhs.radians)
    }
    
    public static func +=(lhs: inout CGAngle, rhs: CGAngle) {
        lhs.radians += rhs.radians
    }
}

public struct CGPolarPoint {
    public var radius: CGFloat
    public var cgangle: CGAngle
}

extension CGPolarPoint {
    public var cgpoint: CGPoint {
        CGPoint(x: radius*cos(cgangle.radians), y: radius*sin(cgangle.radians))
    }
}

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
        var points: [CGPolarPoint] = [CGPolarPoint(radius: radius, cgangle: start)]
        for _ in 1..<num {
            let delta = approxRadian(radius: radius)
            angle += delta
            radius = a + b*angle.radians
            points.append(CGPolarPoint(radius: radius, cgangle: angle))
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
        let θ = acos(1.0 - pow(d/radius, 2)*0.5)
        return CGAngle.radians(θ)
    }
}
