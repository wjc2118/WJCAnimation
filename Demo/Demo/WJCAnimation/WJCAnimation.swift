//
//  UIView+WJCAnimation.swift
//  stringExten
//
//  Created by Mac-os on 16/8/23.
//  Copyright © 2016年 risen. All rights reserved.
//

import UIKit

public struct WJCGroupAnimation {
    init( views: [UIView]) {
        self.views = views
    }
    
    fileprivate let views: [UIView]
}

extension Array where Element: UIView {
    public var wjc: WJCGroupAnimation {
        return WJCGroupAnimation(views: self)
    }
}

public enum CircleMode {
    case sameTime
    case inTurn
    case delay(_: TimeInterval)
}

public enum MoveMode {
    case horizontal
    case vertical
}

extension WJCGroupAnimation {
    
    // MARK: ------------circle------------
    
    public func circleOpen(arcCenter: CGPoint, radius: CGFloat, startAngle: CGFloat, maxDegree: CGFloat, marginDegree: CGFloat, clockwise: Bool, duration: TimeInterval, mode: CircleMode) {
        let anim = CAKeyframeAnimation()
        anim.calculationMode = kCAAnimationCubicPaced
        anim.keyPath = "position"
        
        let maxAngle = maxDegree / 180.0 * CGFloat.pi
        let marginAngle = marginDegree / 180.0 * CGFloat.pi
        let eachAngle = (maxAngle - 2 * marginAngle) / CGFloat(views.count - 1)
        
        // 以下替换注释
        
        for (idx, view) in views.enumerated() {
            
            let endAngle: CGFloat = marginAngle + CGFloat(idx) * eachAngle + startAngle
            
            let path = CGMutablePath()
            path.addArc(center: arcCenter, radius: radius, startAngle: startAngle, endAngle: endAngle, clockwise: !clockwise)
            anim.path = path
            
            switch mode {
            case .sameTime:
                anim.duration = duration
                view.layer.position = path.currentPoint
                if view.layer.opacity < 0.1 {
                    view.layer.opacity = 1.0
                }
            case .inTurn:
                let maxMoveAngle = maxAngle - marginAngle
                anim.duration = Double((marginAngle + eachAngle * CGFloat(idx)) / maxMoveAngle) * duration
                view.layer.position = path.currentPoint
                if view.layer.opacity < 0.1 {
                    view.layer.opacity = 1.0
                }
            case let .delay(second):
                let maxMoveAngle = maxAngle - marginAngle
                anim.duration = Double((marginAngle + eachAngle * CGFloat(idx)) / maxMoveAngle) * duration
                let delay = second * Double(idx)
                anim.beginTime = CACurrentMediaTime() + delay
                
                DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + delay, execute: {
                    view.layer.position = path.currentPoint
                    if view.layer.opacity < 0.1 {
                        view.layer.opacity = 1.0
                    }
                })
            }
            
            view.layer.add(anim, forKey: "circle")
        }
        
//        func sameTime() {
//            
//            for (idx, view) in views.enumerated() {
//                
//                let endAngle: CGFloat = marginAngle + CGFloat(idx) * eachAngle + startAngle
//                
//                let path = CGMutablePath()
//                path.addArc(center: arcCenter, radius: radius, startAngle: startAngle, endAngle: endAngle, clockwise: !clockwise)
//                anim.path = path
//                
//                anim.duration = duration
//                view.layer.position = path.currentPoint
//                if view.layer.opacity < 0.1 {
//                    view.layer.opacity = 1.0
//                }
//
//                view.layer.add(anim, forKey: "circle")
//            }
//        }
//
//        func inTurn() {
//            
//            for (idx, view) in views.enumerated() {
//                
//                let endAngle: CGFloat = marginAngle + CGFloat(idx) * eachAngle + startAngle
//                
//                let path = CGMutablePath()
//                path.addArc(center: arcCenter, radius: radius, startAngle: startAngle, endAngle: endAngle, clockwise: !clockwise)
//                anim.path = path
        //
//                let totalMoveAngle = maxAngle - marginAngle
//                anim.duration = Double((marginAngle + eachAngle * CGFloat(idx)) / totalMoveAngle) * duration
//                view.layer.position = path.currentPoint
//                if view.layer.opacity < 0.1 {
//                    view.layer.opacity = 1.0
//                }
//
//                view.layer.add(anim, forKey: "circle")
//            }
//        }
//        
//        func delay(_ second: TimeInterval) {
//            
//            for (idx, view) in views.enumerated() {
//                
//                let endAngle: CGFloat = marginAngle + CGFloat(idx) * eachAngle + startAngle
//                
//                let path = CGMutablePath()
//                path.addArc(center: arcCenter, radius: radius, startAngle: startAngle, endAngle: endAngle, clockwise: !clockwise)
//                anim.path = path
//
//                let totalMoveAngle = maxAngle - marginAngle
//                anim.duration = Double((marginAngle + eachAngle * CGFloat(idx)) / totalMoveAngle) * duration
//
//                let delay = second * Double(idx)
//                anim.beginTime = CACurrentMediaTime() + delay
//                
//                DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + delay, execute: {
//                    view.layer.position = path.currentPoint
//                    if view.layer.opacity < 0.1 {
//                        view.layer.opacity = 1.0
//                    }
//                })
//
//                view.layer.add(anim, forKey: "circle")
//            }
//        }
//        
//        switch mode {
//        case .sameTime:
//            sameTime()
//        case .inTurn:
//            inTurn()
//        case let .delay(second):
//            delay(second)
//        }
        
    }
    
    public func circleClose(arcCenter: CGPoint, radius: CGFloat, endAngle: CGFloat, maxDegree: CGFloat, marginDegree: CGFloat, clockwise: Bool, duration: TimeInterval, mode: CircleMode) {
        let anim = CAKeyframeAnimation()
        anim.keyPath = "position"
        anim.calculationMode = kCAAnimationCubicPaced
        
        let maxAngle = maxDegree / 180.0 * CGFloat.pi
        let marginAngle = marginDegree / 180.0 * CGFloat.pi
        let eachAngle = (maxAngle - 2 * marginAngle) / CGFloat(views.count - 1)
        
        for (idx, view) in views.enumerated() {
            
            let startAngle: CGFloat = marginAngle + CGFloat(idx) * eachAngle + endAngle
            
            let path = CGMutablePath()
            path.addArc(center: arcCenter, radius: radius, startAngle: startAngle, endAngle: endAngle, clockwise: !clockwise)
            anim.path = path
            
            switch mode {
            case .sameTime:
                anim.duration = duration
                view.layer.position = path.currentPoint
                DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + duration, execute: {
                    view.layer.opacity = 0.0
                })
            case .inTurn:
                let maxMoveAngle = maxAngle - marginAngle
                anim.duration = Double((marginAngle + eachAngle * CGFloat(idx)) / maxMoveAngle) * duration
                view.layer.position = path.currentPoint
                DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + duration, execute: {
                    view.layer.opacity = 0.0
                })
            case let .delay(second):
                let maxMoveAngle = maxAngle - marginAngle
                anim.duration = Double((marginAngle + eachAngle * CGFloat(idx)) / maxMoveAngle) * duration
                
                let delay = second * Double(idx)
                anim.beginTime = CACurrentMediaTime() + delay
                
                DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + delay, execute: {
                    view.layer.position = path.currentPoint
                    view.layer.opacity = 0.0
                })
            }
            
            view.layer.add(anim, forKey: "circle")
        }
    }
    
    //MARK: ---------------------------
    
    public func circleOpenEqually(arcCenter: CGPoint, radius: CGFloat, startAngle: CGFloat, maxDegree: CGFloat, clockwise: Bool, duration: TimeInterval, mode: CircleMode) {
        circleOpen(arcCenter: arcCenter, radius: radius, startAngle: startAngle, maxDegree: maxDegree, marginDegree: maxDegree / CGFloat(views.count + 1), clockwise: clockwise, duration: duration, mode: mode)
    }
    
    public func circleCloseEqually(arcCenter: CGPoint, radius: CGFloat, endAngle: CGFloat, maxDegree: CGFloat, clockwise: Bool, duration: TimeInterval, mode: CircleMode) {
        circleClose(arcCenter: arcCenter, radius: radius, endAngle: endAngle, maxDegree: maxDegree, marginDegree: maxDegree / CGFloat(views.count + 1), clockwise: clockwise, duration: duration, mode: mode)
    }
    
    // MARK: ------------opacity------------
    
    public func circleOpenOpacity(arcCenter: CGPoint, radius: CGFloat, startAngle: CGFloat, maxDegree: CGFloat, marginDegree: CGFloat, clockwise: Bool, duration: TimeInterval, mode: CircleMode) {
        
        let showAnim = CABasicAnimation(keyPath: "opacity")
        showAnim.fromValue = 0.0
        showAnim.toValue = 1.0
        showAnim.duration = duration
        
        let groupAnim = CAAnimationGroup()
        groupAnim.duration = duration
        groupAnim.animations = [showAnim]
        
        let maxAngle = maxDegree / 180.0 * CGFloat.pi
        let marginAngle = marginDegree / 180.0 * CGFloat.pi
        let eachAngle = (maxAngle - 2 * marginAngle) / CGFloat(views.count - 1)
        
        for (idx, view) in views.enumerated() {
            
            let anim = CAKeyframeAnimation()
            anim.calculationMode = kCAAnimationCubicPaced
            anim.keyPath = "position"
            
            let endAngle: CGFloat = marginAngle + CGFloat(idx) * eachAngle + startAngle
            let path = CGMutablePath()
            path.addArc(center: arcCenter, radius: radius, startAngle: startAngle, endAngle: endAngle, clockwise: !clockwise)
            anim.path = path
            groupAnim.animations?.append(anim)
            
            switch mode {
            case .sameTime:
                view.layer.position = path.currentPoint
                if view.layer.opacity < 0.1 {
                    view.layer.opacity = 1.0
                }
            case .inTurn:
                
                let totalMoveAngle = maxAngle - marginAngle
                anim.duration = Double((marginAngle + eachAngle * CGFloat(idx)) / totalMoveAngle) * duration
                
                view.layer.position = path.currentPoint
                if view.layer.opacity < 0.1 {
                    view.layer.opacity = 1.0
                }
            case let .delay(second):
                
                let totalMoveAngle = maxAngle - marginAngle
                anim.duration = Double((marginAngle + eachAngle * CGFloat(idx)) / totalMoveAngle) * duration
                
                let delay = second * Double(idx)
                groupAnim.beginTime = CACurrentMediaTime() + delay
                
                DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + delay, execute: {
                    view.layer.position = path.currentPoint
                    if view.layer.opacity < 0.1 {
                        view.layer.opacity = 1.0
                    }
                })
            }
            
            view.layer.add(groupAnim, forKey: "group")
        }
    }
    
    public func circleCloseOpacity(arcCenter: CGPoint, radius: CGFloat, endAngle: CGFloat, maxDegree: CGFloat, marginDegree: CGFloat, clockwise: Bool, duration: TimeInterval, mode: CircleMode) {
        
        let showAnim = CABasicAnimation(keyPath: "opacity")
        showAnim.fromValue = 1.0
        showAnim.toValue = 0.0
        showAnim.duration = duration
        
        let group = CAAnimationGroup()
        group.duration = duration
        group.animations = [showAnim]
        
        let maxAngle = maxDegree / 180.0 * CGFloat.pi
        let marginAngle = marginDegree / 180.0 * CGFloat.pi
        let eachAngle = (maxAngle - 2 * marginAngle) / CGFloat(views.count - 1)
        
        for (idx, view) in views.enumerated() {
            let anim = CAKeyframeAnimation()
            anim.calculationMode = kCAAnimationCubicPaced
            anim.keyPath = "position"
            
            let startAngle: CGFloat = marginAngle + CGFloat(idx) * eachAngle + endAngle
            let path = CGMutablePath()
            path.addArc(center: arcCenter, radius: radius, startAngle: startAngle, endAngle: endAngle, clockwise: !clockwise)
            anim.path = path
            group.animations?.append(anim)
            
            switch mode {
            case .sameTime:
                view.layer.position = path.currentPoint
                view.layer.opacity = 0.0
            case .inTurn:
                
                let maxMoveAngle = maxAngle - marginAngle
                anim.duration = Double((marginAngle + eachAngle * CGFloat(idx)) / maxMoveAngle) * duration
                view.layer.position = path.currentPoint
                view.layer.opacity = 0.0
            case let .delay(second):
                
                let maxMoveAngle = maxAngle - marginAngle
                anim.duration = Double((marginAngle + eachAngle * CGFloat(idx)) / maxMoveAngle) * duration
                
                let delay = second * Double(idx)
                group.beginTime = CACurrentMediaTime() + delay
                
                DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + delay, execute: {
                    view.layer.position = path.currentPoint
                    view.layer.opacity = 0.0
                })
            }
            
            view.layer.add(group, forKey: "group")
        }
    }
    
    // MARK: ------------items------------
    
    public func itemsShow(origin: CGPoint, tx: CGFloat, ty: CGFloat, space: CGFloat, duration: TimeInterval, delay: TimeInterval , mode: MoveMode) {
        
        let showAnim = CABasicAnimation(keyPath: "opacity")
        showAnim.fromValue = 0.0
        showAnim.toValue = 1.0
        
        let group = CAAnimationGroup()
        group.duration = duration
        
        var totalHeight: CGFloat = 0.0
        for (idx, view) in views.enumerated() {
            
            if idx == 0 {
                view.frame.origin = origin
            } else {
                totalHeight += views[idx-1].frame.height
                view.frame.origin = CGPoint(x: origin.x, y: origin.y + space * CGFloat(idx) + totalHeight)
            }
            
            let moveAnim = CABasicAnimation(keyPath: "position")
            moveAnim.fromValue = NSValue(cgPoint: view.layer.position)
            moveAnim.toValue = NSValue(cgPoint: CGPoint(x: view.layer.position.x + tx, y: view.layer.position.y + ty))
            moveAnim.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseIn)
            
            group.animations = [showAnim, moveAnim]
            group.beginTime = CACurrentMediaTime() + delay * Double(idx)
            view.layer.add(group, forKey: nil)
            
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + delay * Double(idx), execute: {
                view.layer.opacity = 1.0
                view.layer.position = (moveAnim.toValue as! NSValue).cgPointValue
            })
        }
    }
    
    public func itemsHide() {
        
    }
    
    // MARK: private
    
    
    
}

/*
public class WJCAnimation {
    init(_ view: UIView) {
        self.view = view
    }
    
    deinit {
        print("deinit")
    }
    
    fileprivate let view: UIView
    
    lazy fileprivate var group: CAAnimationGroup = {
        let g = CAAnimationGroup()
        g.animations = []
        g.duration = 0.0
        return g
    }()
    
    lazy fileprivate var states: [AnimationState] = {
        return []
    }()
}

extension UIView {
    
    public var wjc: WJCAnimation {
        return WJCAnimation(self)
    }
    
    public func wjc_actionForLayer(_ layer: CALayer, forKey event: String) -> CAAction? {
        if needSwizzled {
            return nil
        }
        return wjc_actionForLayer(layer, forKey: event)
    }
  
    override open class func initialize() {
        self.methodSwizzling(self, originalSelector: #selector(UIView.action(for:forKey:)), swizzledSelector: #selector(UIView.wjc_actionForLayer(_:forKey:)))
    }
    
    fileprivate class func methodSwizzling(_ cls: AnyClass, originalSelector: Selector, swizzledSelector: Selector) -> Void {
        struct Static {
            static var token: Int = 0
        }
        
    // TODO: dispatch once
        
       /* dispatch_once(&Static.token) {
            let originalMethod = class_getInstanceMethod(cls, originalSelector)
            let overrideMethod = class_getInstanceMethod(cls, swizzledSelector)
            
            if class_addMethod(cls, originalSelector, method_getImplementation(overrideMethod), method_getTypeEncoding(overrideMethod)) {
                class_replaceMethod(cls, swizzledSelector, method_getImplementation(originalMethod), method_getTypeEncoding(originalMethod))
            } else {
                method_exchangeImplementations(originalMethod, overrideMethod)
            }
        }*/
    }
    
}

extension WJCAnimation {
    
    public var begin: WJCAnimation {
        
        self.view.layer.add(self.group, forKey: nil)
//        self.view.layer.position = CGPoint(x: 250, y: 200)
//        print(self.group.animations!)
        
        for state in self.states {
            state.layer.setValue(state.newValue, forKeyPath: state.keyPath)
            print(state.oldValue)
            print(state.newValue)
        }
        
        return self
    }
    
    public var then: WJCAnimation {
        
        return self
    }
    
    fileprivate func addToGroup(_ anim: CAAnimation) {
        self.group.animations?.append(anim)
        self.group.duration += anim.duration
    }
    
    fileprivate func addBasicAnimationState(_ anim: CABasicAnimation) {
        var state: AnimationState = AnimationState(layer: self.view.layer, keyPath: anim.keyPath!)
        state.newValue = anim.toValue as AnyObject?
        self.states.append(state)
    }
    
    // MARK: - translation
    
    func translation(_ duration: TimeInterval) -> (_ x: CGFloat, _ y: CGFloat) -> WJCAnimation {
        return {
            let anim = CABasicAnimation()
            anim.keyPath = "position"
            anim.duration = duration
            anim.fromValue = NSValue(cgPoint: self.view.layer.position)
            anim.toValue = NSValue(cgPoint: CGPoint(x: self.view.layer.position.x + $0, y: self.view.layer.position.y + $1))
//            self.view.layer.addAnimation(anim, forKey: nil)
//            self.view.layer.position = CGPoint(x: self.view.layer.position.x + $0, y: self.view.layer.position.y + $1)
            
            self.addToGroup(anim)
            self.addBasicAnimationState(anim)
            
            
//            CATransaction.begin()
//            CATransaction.setAnimationDuration(duration)
//            needSwizzled = true
//            self.view.layer.position = CGPoint(x: self.view.layer.position.x + $0, y: self.view.layer.position.y + $1)
//            needSwizzled = false
//            CATransaction.commit()
            
            
            
            return self
        }
    }
    
/*    func translation(duration: TimeInterval) -> (_ x: CGFloat) -> WJCAnimation {
        return {
            return self.translation(duration)($0, 0)
            //return self.translation(duration)(x: $0, y: 0)
        }
    }
    
    func translation(_ duration: TimeInterval) -> (_ y: CGFloat) -> WJCAnimation {
        return {
            return self.translation(duration)(0, $0)
        }
    }*/
    
    func translation(duration: TimeInterval, x: CGFloat) -> WJCAnimation {
        return translation(duration)(x, 0)
    }
    
    func translation(duration: TimeInterval, y: CGFloat) -> WJCAnimation {
        return translation(duration)(0, y)
    }
    
    // MARK: - color
    
    func color(_ color: UIColor, duration: TimeInterval) -> WJCAnimation {
        CATransaction.begin()
        CATransaction.setAnimationDuration(duration)
        needSwizzled = true
        self.view.layer.backgroundColor = color.cgColor
        needSwizzled = false
        CATransaction.commit()
        return self
    }
}


// MARK: - private

private var needSwizzled: Bool = false

//var context: UnsafePointer<Void> = nil
//
//let context: UnsafePointer<Void> = &context

private struct AnimationState {
    var layer: CALayer
    var keyPath: String
    var oldValue: AnyObject
    var newValue: AnyObject? = nil
    
    init(layer: CALayer, keyPath: String) {
        self.layer = layer
        self.keyPath = keyPath
        self.oldValue = layer.value(forKeyPath: keyPath)! as AnyObject
    }
    
    
    
    
}
*/

