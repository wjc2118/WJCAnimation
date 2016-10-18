//
//  UIView+WJCAnimation.swift
//  stringExten
//
//  Created by Mac-os on 16/8/23.
//  Copyright © 2016年 risen. All rights reserved.
//

import UIKit

public class WJCAnimation {
    init(views: [UIView]) {
        self.views = views
    }
    
//    deinit {
//        print("deinit")
//    }
    
    fileprivate let views: [UIView]
}

extension Array where Element: UIView {
    public var wjc: WJCAnimation {
        return WJCAnimation(views: self)
    }
}

extension WJCAnimation {
    
    public func circleOpen(arcCenter: CGPoint, radius: CGFloat, startAngle: CGFloat, maxAngle: CGFloat, clockwise: Bool, duration: TimeInterval) {
        let anim = CAKeyframeAnimation()
        anim.duration = duration
        anim.calculationMode = kCAAnimationCubicPaced
        anim.keyPath = "position"
        
        let showAnim = viewShow(true, duration: duration)
        
        let groupAnim = CAAnimationGroup()
        
        for (idx, view) in views.enumerated() {
            view.alpha = view.alpha < 0.01 ? 1.0 : view.alpha
            let endAngle: CGFloat = CGFloat(idx + 1) * (maxAngle / CGFloat(views.count + 1)) + startAngle
            let path = CGMutablePath()
            path.addArc(center: arcCenter, radius: radius, startAngle: startAngle, endAngle: endAngle, clockwise: !clockwise)
            anim.path = path
            view.layer.add(anim, forKey: "circle")
//            groupAnim.animations = [anim, showAnim]
            groupAnim.duration = duration
//            view.layer.add(groupAnim, forKey: "group")
            
            view.layer.position = path.currentPoint
            
        }
    }
    
    public func circleClose(arcCenter: CGPoint, radius: CGFloat, endAngle: CGFloat, maxAngle: CGFloat, clockwise: Bool, duration: TimeInterval) {
        let anim = CAKeyframeAnimation()
        anim.duration = duration
        anim.calculationMode = kCAAnimationCubicPaced
        anim.keyPath = "position"
        
        for (idx, view) in views.enumerated() {
            let startAngle: CGFloat = CGFloat(idx + 1) * (maxAngle / CGFloat(views.count + 1)) + endAngle
            let path = CGMutablePath()
            path.addArc(center: arcCenter, radius: radius, startAngle: startAngle, endAngle: endAngle, clockwise: !clockwise)
            anim.path = path
            view.layer.add(anim, forKey: "circle")
            view.layer.position = path.currentPoint
            
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + duration, execute: { 
                view.alpha = 0.0
            })
        }
    }
    
    // MARK: ----------------------------
    
    public func circleOpen(arcCenter: CGPoint, radius: CGFloat, startAngle: CGFloat, maxAngle: CGFloat, marginDegree: CGFloat, clockwise: Bool, duration: TimeInterval) {
        let anim = CAKeyframeAnimation()
        anim.duration = duration
        anim.calculationMode = kCAAnimationCubicPaced
        anim.keyPath = "position"
        
        for (idx, view) in views.enumerated() {
            view.alpha = view.alpha < 0.01 ? 1.0 : view.alpha
            
            let marginAngle = marginDegree / 180.0 * CGFloat.pi
            let eachAngle = (maxAngle - 2 * marginAngle) / CGFloat(views.count - 1)
            let endAngle: CGFloat = marginAngle + CGFloat(idx) * eachAngle + startAngle
            
            let path = CGMutablePath()
            path.addArc(center: arcCenter, radius: radius, startAngle: startAngle, endAngle: endAngle, clockwise: !clockwise)
            anim.path = path
            view.layer.add(anim, forKey: "circle")
            view.layer.position = path.currentPoint
        }
    }
    
    public func circleClose(arcCenter: CGPoint, radius: CGFloat, endAngle: CGFloat, maxAngle: CGFloat, marginDegree: CGFloat, clockwise: Bool, duration: TimeInterval) {
        let anim = CAKeyframeAnimation()
        anim.duration = duration
        anim.calculationMode = kCAAnimationCubicPaced
        anim.keyPath = "position"
        
        for (idx, view) in views.enumerated() {
            let marginAngle = marginDegree / 180.0 * CGFloat.pi
            let eachAngle = (maxAngle - 2 * marginAngle) / CGFloat(views.count - 1)
            let startAngle: CGFloat = marginAngle + CGFloat(idx) * eachAngle + endAngle
            
            let path = CGMutablePath()
            path.addArc(center: arcCenter, radius: radius, startAngle: startAngle, endAngle: endAngle, clockwise: !clockwise)
            anim.path = path
            view.layer.add(anim, forKey: "circle")
            view.layer.position = path.currentPoint
            
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + duration, execute: {
                view.alpha = 0.0
            })
        }
        
    }
    
    // MARK: ----------------------------
    
    public func showItems() {
        
    }
    
    // MARK: private
    
    private func viewShow(_ show: Bool, duration: TimeInterval) -> CABasicAnimation {
        
        let anim = CABasicAnimation(keyPath: "opacity")
        anim.duration = duration
        if show {
            anim.fromValue = 0.0
            anim.toValue = 1.0
        } else {
            
            anim.fromValue = 1.0
            anim.toValue = 0.0
        }
        return anim
    }
    
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

