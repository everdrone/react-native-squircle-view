//
//  RNSquircleView.swift
//  RNSquircleView
//
//  Created by Giorgio on 24/10/2018.
//  Copyright © 2018 Facebook. All rights reserved.
//

import Foundation
import UIKit

@IBDesignable
class SquircleView : UIView {
    
    let containerView = UIView()
    
    // FIXME: make borderView borders CSS compilant
    let borderView = UIView()
    
    // style properties
    var bckColor : UIColor = .clear
    var shdColor : CGColor = UIColor.black.cgColor
    var shdOpacity : Float = 0
    var shdOffsetX : CGFloat = 0
    var shdOffsetY : CGFloat = 0
    var shdRadius : CGFloat = 0
    
    var brdColor : CGColor = UIColor.black.cgColor
    var brdWidth : CGFloat = 0
    
    let path = UIBezierPath()
    var c : [CGFloat] = [0, 0, 0, 0, 0, 0, 0, 0]
    var interpolatePath : Bool = true
    
    var radii : [String: CGFloat] = [
        "topLeft": 0,
        "topRight": 0,
        "bottomRight": 0,
        "bottomLeft": 0
    ]
    
    static let coeffs : [CGFloat] = [
        0.046412805499999994,
        0.133566352,
        0.22071989825,
        0.348614185,
        0.5115771475,
        0.67454011,
        0.8609766075,
        1.1579757175
    ]
    
    static let normals : [CGFloat] = [
        0.049745972799999996,
        0.1365289826,
        0.22331199200000001,
        0.34713204000000003,
        0.495280188,
        0.643428336,
        0.815904584,
        1.0
    ]
    
    var minPoint : CGFloat = 0
    var maxPoint : CGFloat = 0
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(containerView)
        addSubview(borderView)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        
        minPoint = min(frame.width, frame.height) / (2.0 * SquircleView.coeffs[7])
        maxPoint = min(frame.width, frame.height) / 2.0
        
        self.drawPath()
        
        // ensure clear background
        backgroundColor = .clear
        layer.backgroundColor = UIColor.clear.cgColor
        isOpaque = false
        layer.isOpaque = false
        
        // let squirclePath = UIBezierPath(ovalIn: rect)
        let maskShape = CAShapeLayer()
        maskShape.path = path.cgPath
        
        containerView.frame = rect
        
        borderView.frame = rect
        let borderLayer = CAShapeLayer()
        borderLayer.path = path.cgPath
        borderLayer.isOpaque = false
        borderLayer.fillColor = UIColor.clear.cgColor
        borderLayer.strokeColor = brdColor
        borderLayer.lineWidth = brdWidth
        containerView.layer.addSublayer(borderLayer)
        
        // test color
        containerView.backgroundColor = bckColor
        
        // mask the view
        containerView.layer.mask = maskShape
        
        // add shadows
        layer.shadowColor = shdColor
        layer.shadowOpacity = shdOpacity
        layer.shadowOffset = CGSize(width: shdOffsetX, height: shdOffsetY)
        layer.shadowRadius = shdRadius
    }
    
    override func didAddSubview(_ subview: UIView) {
        if subview != containerView && subview != borderView {
            let newSubview = subview
            subview.removeFromSuperview()
            containerView.addSubview(newSubview)
        }
    }
    
    private func lerp(y0: CGFloat, y1: CGFloat, x: CGFloat) -> CGFloat {
        return y0 + x * (y1 - y0)
    }
    
    private func normalizeRadius(corner: String) -> CGFloat {
        var n : CGFloat = radii[corner] ?? 0
        
        if interpolatePath {
            n = n > maxPoint ? maxPoint : n
        } else {
            n = n > minPoint ? minPoint : n
        }
        
        return n
    }
    
    private func interpolationAmount(corner: String) -> CGFloat {
        let n = normalizeRadius(corner: corner)
        
        let l = (n - minPoint) / (maxPoint - minPoint)
        
        return l
    }
    
    private func drawCorner(corner: String, biasX: CGFloat, biasY: CGFloat, invertX: Bool, invertY: Bool, swap: Bool) {
        let n = normalizeRadius(corner: corner)
        
        let l = interpolationAmount(corner: corner)
        
        if interpolatePath {
            for (i, _) in SquircleView.coeffs.enumerated() {
                c[i] = lerp(y0: SquircleView.coeffs[i], y1: SquircleView.normals[i], x: l)
            }
        } else {
            for (i, _) in SquircleView.coeffs.enumerated() {
                c[i] = SquircleView.coeffs[i]
            }
        }
        
        var u : [CGFloat] = [
            n * c[1], n * c[4],
            0, n * c[6],
            n * c[0], n * c[5],
            n * c[4], n * c[1],
            n * c[2], n * c[3],
            n * c[3], n * c[2],
            n * c[7], 0,
            n * c[5], n * c[0],
            n * c[6], 0
        ]
        
        if swap {
            for (i, _) in u.enumerated() where i % 2 == 0 {
                u.swapAt(i, i + 1)
            }
        }
        
        let ix : CGFloat = invertX ? -1.0 : 1.0
        let iy : CGFloat = invertY ? -1.0 : 1.0
        let bx = biasX
        let by = biasY
        
        path.addCurve(
            to: CGPoint(x: bx + ix * u[0], y: by + iy * u[1]),
            controlPoint1: CGPoint(x: bx + ix * u[2], y: by + iy * u[3]),
            controlPoint2: CGPoint(x: bx + ix * u[4], y: by + iy * u[5]))
        path.addCurve(
            to: CGPoint(x: bx + ix * u[6], y: by + iy * u[7]),
            controlPoint1: CGPoint(x: bx + ix * u[8], y: by + iy * u[9]),
            controlPoint2: CGPoint(x: bx + ix * u[10], y: by + iy * u[11])
        )
        path.addCurve(
            to: CGPoint(x: bx + ix * u[12], y: by + iy * u[13]),
            controlPoint1: CGPoint(x: bx + ix * u[14], y: by + iy * u[15]),
            controlPoint2: CGPoint(x: bx + ix * u[16], y: by + iy * u[17])
        )
    }
    
    private func drawPath() {
        let w = frame.size.width
        let h = frame.size.height
        
        // starting points for each curve set
        let ptls = lerp(y0: SquircleView.coeffs[7], y1: 1.0, x: interpolationAmount(corner: "topLeft"))
        let tls = CGPoint(x: 0, y: ptls * normalizeRadius(corner: "topLeft"))
        
        let ptrs = lerp(y0: SquircleView.coeffs[7], y1: 1.0, x: interpolationAmount(corner: "topRight"))
        let trs = CGPoint(x: w - ptrs * normalizeRadius(corner: "topRight"), y: 0)
        
        let pbrs = lerp(y0: SquircleView.coeffs[7], y1: 1.0, x: interpolationAmount(corner: "bottomRight"))
        let brs = CGPoint(x: w, y: h - pbrs * normalizeRadius(corner: "bottomRight"))
        
        let pbls = lerp(y0: SquircleView.coeffs[7], y1: 1.0, x: interpolationAmount(corner: "bottomLeft"))
        let bls = CGPoint(x: pbls * normalizeRadius(corner: "bottomLeft"), y: h)
        
        path.move(to: tls)
        self.drawCorner(corner: "topLeft", biasX: 0, biasY: 0, invertX: false, invertY: false, swap: false)
        
        path.addLine(to: trs)
        self.drawCorner(corner: "topRight", biasX: w, biasY: 0, invertX: true, invertY: false, swap: true)
        
        path.addLine(to: brs)
        self.drawCorner(corner: "bottomRight", biasX: w, biasY: h, invertX: true, invertY: true, swap: false)
        
        path.addLine(to: bls)
        self.drawCorner(corner: "bottomLeft", biasX: 0, biasY: h, invertX: false, invertY: true, swap: true)
        
        path.close()
    }
    
    @objc public func setBckColor(_ color: NSNumber) {
        self.bckColor = RCTConvert.uiColor(color)
    }
    
    @objc public func setShdColor(_ color: NSNumber) {
        self.shdColor = RCTConvert.cgColor(color)
    }
    
    @objc public func setShdOpacity(_ opacity: Float) {
        self.shdOpacity = opacity
    }
    
    @objc public func setShdOffsetX(_ offset: CGFloat) {
        self.shdOffsetX = offset
    }
    
    @objc public func setShdOffsetY(_ offset: CGFloat) {
        self.shdOffsetY = offset
    }
    
    @objc public func setShdRadius(_ radius: CGFloat) {
        self.shdRadius = radius
    }
    
    @objc public func setBrdColor(_ color: NSNumber) {
        self.brdColor = RCTConvert.cgColor(color)
    }
    
    @objc public func setBrdWidth(_ width: CGFloat) {
        self.brdWidth = width * 2.0
    }
    
    @objc public func setBrdRadius(_ radius: CGFloat) {
        self.radii = [
            "topLeft": radius,
            "topRight": radius,
            "bottomRight": radius,
            "bottomLeft": radius
        ]
    }
    
    @objc public func setBrdTopLeftRadius(_ radius: CGFloat) {
        self.radii["topLeft"] = radius
    }
    
    @objc public func setBrdTopRightRadius(_ radius: CGFloat) {
        self.radii["topRight"] = radius
    }
    
    @objc public func setBrdBottomRightRadius(_ radius: CGFloat) {
        self.radii["bottomRight"] = radius
    }
    
    @objc public func setBrdBottomLeftRadius(_ radius: CGFloat) {
        self.radii["bottomLeft"] = radius
    }
    
    @objc public func setInterpolatePath(_ interpolate: NSNumber) {
        self.interpolatePath = RCTConvert.bool(interpolate)
    }
    
}


@objc(SquircleViewManager)
class SquircleViewManager: RCTViewManager {
    override func view() -> UIView! {
        let squircle = SquircleView()
        return squircle
    }
    
    override static func requiresMainQueueSetup() -> Bool {
        return true
    }
}
