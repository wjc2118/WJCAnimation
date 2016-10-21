//
//  ViewController.swift
//  stringExten
//
//  Created by Mac-os on 16/8/10.
//  Copyright © 2016年 risen. All rights reserved.
//

import UIKit
import Metal

class ViewController: UIViewController {
    
    let radius: CGFloat = 200.0
    
    fileprivate lazy var btn: UIButton = {
        let btn = UIButton(frame: CGRect(x: 20/*(self.view.frame.width - 50) * 0.5*/, y: 150, width: 50, height: 50))
        
        let img = UIImage.wjc.color(UIColor.green, size: CGSize(width: 50, height: 50)).wjc.roundImage
        btn.setBackgroundImage(img, for: .normal)
        btn.addTarget(self, action: #selector(click), for: .touchUpInside)
        btn.adjustsImageWhenHighlighted = false
        return btn
    }()
    
    fileprivate lazy var startPoint: CGPoint = CGPoint(x: self.btn.frame.minX, y: self.btn.frame.minY - self.radius)
    
    
    fileprivate lazy var btns: [UIButton] = {
        var arr = [UIButton]()
        for i in 1...5 {
            let btn: UIButton = self.oneBtn()
            btn.tag = i
            arr.append(btn)
        }
        return arr
    }()
    
    fileprivate func oneBtn() -> UIButton {
        
        let btn = UIButton(frame: CGRect(origin: CGPoint.zero/*self.startPoint*/, size: self.btn.frame.size))
        let img = UIImage.wjc.color(UIColor.wjc.randomColor, size: CGSize(width: 50, height: 50)).wjc.roundImage
        btn.setBackgroundImage(img, for: .normal)
        btn.alpha = 0.0
        btn.addTarget(self, action: #selector(ViewController.oneBtnClick(menuBtn:)), for: .touchUpInside)
        return btn
    }
    
    fileprivate func oneItem() -> UIButton {
        
        let item = UIButton(frame: CGRect(origin: CGPoint.zero, size: CGSize(width: 150, height: 40)))
        item.setTitle("XXXXXX", for: .normal)
        item.backgroundColor = UIColor.wjc.randomColor
        item.alpha = 0.0
        item.addTarget(self, action: #selector(ViewController.ItemClick(item:)), for: .touchUpInside)
        return item
    }
    
    fileprivate lazy var items: [UIButton] = {
        var a = [UIButton]()
        for i in 1...5 {
            let b: UIButton = self.oneItem()
            b.tag = i
            a.append(b)
        }
        return a
    }()
    
    lazy var subView: UIImageView = {
        let v = UIImageView(frame: CGRect(x: 100, y: 300, width: 100, height: 100))
        v.image = UIImage.wjc.color(UIColor.red, size: CGSize(width: 100, height: 100))
        return v
    }()
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        
        view.addSubview(btn)
//        print(self.items)
//        view.addSubview(subView)
        
        
//        UIViewAutoresizing
        
    }
    
    func click() {
        
        
        
        
        
//        var transform = CATransform3DIdentity
//        transform.m34 = -4.0 / 1000.0
//        transform = CATransform3DRotate(transform, CGFloat.pi, 0, 1, 0)
//        subView.layer.transform = transform
//        
//        let anim = CABasicAnimation(keyPath: "transform")
//        anim.fromValue = NSValue(caTransform3D: CATransform3DIdentity)
//        anim.toValue = NSValue(caTransform3D: transform)
//        anim.duration = 5
//        
//        let move = CABasicAnimation(keyPath: "position")
//        move.byValue = NSValue(cgPoint: CGPoint(x: 100, y: 0))
//        
//        let group = CAAnimationGroup()
//        group.duration = 5
//        group.animations = [anim, move]
//        
//        subView.layer.add(group, forKey: nil)
////
//        
////        let anim = CATransition()
////        anim.type = "oglFlip"
////        anim.subtype = "fromRight"
////        anim.duration = 5
////        subView.layer.add(anim, forKey: nil)
//        
//        return
        
        btns.forEach { (b) in
            self.view.addSubview(b)
        }
        
        let dura = 0.5
        let arcCenter = CGPoint(x: btn.center.x - 100, y: btn.center.y)
        
        openMenu(btns, arcCenter: arcCenter, radius: radius, duration: dura)
        
        
    }
    
    func oneBtnClick(menuBtn: UIButton) {
        
        switch menuBtn.tag {
        case 5:
            
            let duration = 0.5
            let delay = 0.1
            
            items.wjc.itemsMove(tx: 0, ty: 100, duration: duration, delay: delay, state: .hide(completion: {
                _, v in
                v.removeFromSuperview()
            }))
            
            let time = duration + delay * Double(items.count - 1) - 0.5
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + time, execute: {
                let arcCenter = CGPoint(x: self.btn.center.x - 100, y: self.btn.center.y)
                self.closeMenu(self.btns, arcCenter: arcCenter, radius: self.radius, duration: 0.5)
            })
            
        case 1:
            
            items.forEach({ b in
                self.view.addSubview(b)
            })
            
            let maxX = self.btns[2].frame.maxX
            let origin = CGPoint(x: maxX - 80, y: self.btns[0].frame.minY)
            
            items.wjc.itemsMove(tx: 100, ty: 0, duration: 0.5, delay: 0.1, state: .show(origin: origin, space: 10))
            
        case 2:break
            
        default:
            print(menuBtn.tag)
        }
    }
    
    func ItemClick(item: UIButton) {
        print(item.tag)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
//        closeMenu(btns, arcCenter: self.btn.center, radius: radius, duration: 2)
        print(view.subviews.count)
        
    }
    
    fileprivate func openMenu(_ menu: [UIView], arcCenter: CGPoint, radius: CGFloat, duration: TimeInterval) {
        
        menu.wjc.circle(arcCenter: arcCenter, radius: radius, maxDegree: 90.0, marginDegree: 15.0, clockwise: true, duration: duration, delay: 0.0, opacity: true, mode: .inTurn, state: .open(startAngle: -CGFloat.pi * 0.5 * 0.5))
     
        
    }
    
    fileprivate func closeMenu(_ menu: [UIView], arcCenter: CGPoint, radius: CGFloat, duration: TimeInterval) {
        
        menu.wjc.circle(arcCenter: arcCenter, radius: radius, maxDegree: 60.0, marginDegree: 0.0, clockwise: false, duration: duration, delay: 0.0, opacity: true, mode: .inTurn, state: .close(endAngle: -CGFloat.pi * 0.5 * 0.5 + 15.0 / 180.0 * CGFloat.pi, completion: { (_, v) in
            v.removeFromSuperview()
        }))
        
        
        
//        menu.wjc.circleCloseEqually(arcCenter: arcCenter, radius: radius, endAngle: -CGFloat.pi * 0.5, maxAngle: CGFloat.pi, clockwise: false, duration: duration, mode: .delay(0.2))
        
//        menu.wjc.circleCloseOpacity(arcCenter: arcCenter, radius: radius, endAngle: -CGFloat.pi * 0.5 * 0.5 + 15.0 / 180.0 * CGFloat.pi, maxDegree: 60.0, marginDegree: 0.0, clockwise: false, duration: duration, delay: 0.0, mode: .inTurn, completion: nil)
        
//        menu.wjc.circleClose(arcCenter: arcCenter, radius: radius, endAngle: -CGFloat.pi * 0.5 - 36 / 180 * CGFloat.pi, maxAngle: CGFloat.pi * 2, marginDegree: 36.0, clockwise: false, duration: duration, mode: .sameTime)
    }
    
    
    func sum(_ n: UInt) -> UInt {
        
        //        var clo: (UInt, UInt) -> UInt = {
        //            n, a in
        //            if n == 0 {
        //                return a
        //            }
        //            return clo(10, 0)
        //        }
        //
        //        return clo(n, 0)
        
        func sunIn(_ n: UInt, a:UInt) -> UInt {
            if n == 0 {
                return a
            }
            return sunIn(n - 1, a: a + n)
        }
        
        return sunIn(n, a: 0)
    }
    
    fileprivate func add2(_ a: Int) -> (Int) -> (Int) -> Int {
        return {
            let b = a + $0
            return {
                b + $0
            }
        }
    }
    
    fileprivate func add2(_ a: Int) -> (Int) -> Int {
        return {
            return a + $0
        }
    }
    
    //    func add(a: Int)(b: Int) -> Int {
    //        return a + b
    //    }
    
    func fourChainedFunctions(_ a: Int, b: Int, c: Int, d: Int) -> Int {
        return a + b + c + d
    }
    
    func log<T>(_ message: T) -> Void {
        print(message)
    }
    
    
    
    
}

















