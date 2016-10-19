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
        let img = UIImage.wjc_image(color: UIColor.green, size: CGSize(width: 50, height: 50)).wjc_roundImage()
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
        let img = UIImage.wjc_image(color: UIColor.wjc_randomColor(), size: CGSize(width: 50, height: 50)).wjc_roundImage()
        btn.setBackgroundImage(img, for: .normal)
        btn.alpha = 0.0
        view.addSubview(btn)
        btn.addTarget(self, action: #selector(ViewController.oneBtnClick(menuBtn:)), for: .touchUpInside)
        return btn
    }
    
    fileprivate func oneItem() -> UIButton {
        
        let item = UIButton(frame: CGRect(origin: CGPoint.zero, size: CGSize(width: 150, height: 40)))
        item.setTitle("XXXXXX", for: .normal)
        item.backgroundColor = UIColor.wjc_randomColor()
        item.alpha = 0.0
        view.addSubview(item)
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
    
    lazy var subView: UIView = {
        let v = UIView(frame: CGRect(x: 100, y: 300, width: 50, height: 50))
        v.backgroundColor = UIColor.blue
        return v
    }()
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        
        view.addSubview(btn)
//        print(self.items)
//        view.addSubview(subView)
    }
    
    @objc func click() {
        
        let dura = 0.5
        let arcCenter = CGPoint(x: btn.center.x - 100, y: btn.center.y)
        
        openMenu(btns, arcCenter: arcCenter, radius: radius, duration: dura)

        
    }
    
    @objc func oneBtnClick(menuBtn: UIButton) {
        
        switch menuBtn.tag {
        case 5:
            let arcCenter = CGPoint(x: btn.center.x - 100, y: btn.center.y)
            closeMenu(btns, arcCenter: arcCenter, radius: radius, duration: 0.5)
        case 1:
            let maxX = self.btns[2].frame.maxX
            let origin = CGPoint(x: maxX - 80, y: self.btns[0].frame.minY)
            items.wjc.itemsShow(origin: origin, tx: 100, ty: 0, space: 10, duration: 0.5, delay: 0.2, mode: .horizontal)
        default:
            print(menuBtn.tag)
        }
    }
    
    @objc func ItemClick(item: UIButton) {
        print(item.tag)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
//        closeMenu(btns, arcCenter: self.btn.center, radius: radius, duration: 2)
    }
    
    fileprivate func openMenu(_ menu: [UIView], arcCenter: CGPoint, radius: CGFloat, duration: TimeInterval) {
        
//        menu.wjc.circleOpen(arcCenter: arcCenter, radius: radius, startAngle: -CGFloat.pi * 0.5, maxAngle: CGFloat.pi, marginDegree: 15.0, clockwise: true, duration: 5.0, mode: .sameTime)
        
//        menu.wjc.circleOpenEqually(arcCenter: arcCenter, radius: radius, startAngle: -CGFloat.pi * 0.5, maxAngle: CGFloat.pi, clockwise: true, duration: duration, mode: .delay(0.3))
        
        menu.wjc.circleOpenOpacity(arcCenter: arcCenter, radius: radius, startAngle: -CGFloat.pi * 0.5 * 0.5/* + 15.0 / 180.0 * CGFloat.pi*/, maxDegree: 90.0, marginDegree: 15.0, clockwise: true, duration: duration, mode: .inTurn)
        
//        menu.wjc.circleOpen(arcCenter: arcCenter, radius: radius, startAngle: -CGFloat.pi * 0.5 - 36 / 180 * CGFloat.pi, maxAngle: CGFloat.pi * 2, marginDegree: 36.0, clockwise: true, duration: duration, mode: .inTurn)
        
        
    }
    
    fileprivate func closeMenu(_ menu: [UIView], arcCenter: CGPoint, radius: CGFloat, duration: TimeInterval) {
        
//        menu.wjc.circleClose(arcCenter: arcCenter, radius: radius, endAngle: -CGFloat.pi * 0.5, maxAngle: CGFloat.pi, marginDegree: 15.0, clockwise: false, duration: 5.0, mode: .sameTime)
        
//        menu.wjc.circleCloseEqually(arcCenter: arcCenter, radius: radius, endAngle: -CGFloat.pi * 0.5, maxAngle: CGFloat.pi, clockwise: false, duration: duration, mode: .delay(0.2))
        
        menu.wjc.circleCloseOpacity(arcCenter: arcCenter, radius: radius, endAngle: -CGFloat.pi * 0.5 * 0.5 + 15.0 / 180.0 * CGFloat.pi, maxDegree: 60.0, marginDegree: 0.0, clockwise: false, duration: duration, mode: .inTurn)
        
//        menu.wjc.circleClose(arcCenter: arcCenter, radius: radius, endAngle: -CGFloat.pi * 0.5 - 36 / 180 * CGFloat.pi, maxAngle: CGFloat.pi * 2, marginDegree: 36.0, clockwise: false, duration: duration, mode: .sameTime)
    }
    
    
    @objc func sum(_ n: UInt) -> UInt {
        
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

















