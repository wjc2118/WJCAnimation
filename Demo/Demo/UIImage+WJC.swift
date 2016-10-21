//
//  UIImage+WJC.swift
//  stringExten
//
//  Created by Mac-os on 16/8/12.
//  Copyright © 2016年 risen. All rights reserved.
//

import UIKit

public struct WJCImage {
    let image: UIImage?
}

extension WJCImage {
    
    public func color(_ color: UIColor, size: CGSize) -> UIImage {
        UIGraphicsBeginImageContextWithOptions(size, false, 0.0)
        color.set()
        UIRectFill(CGRect(origin: CGPoint.zero, size: size))
        let img = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        return img
    }
    
    public var roundImage: UIImage {
        guard (self.image != nil) else {
            return UIImage()
        }
        UIGraphicsBeginImageContextWithOptions(self.image!.size, false, 0.0)
        let ctx = UIGraphicsGetCurrentContext();
        let rect = CGRect(origin: CGPoint(x: 0, y: 0), size: self.image!.size)
        ctx?.addEllipse(in: rect);
        ctx?.clip();
        self.image!.draw(in: rect)
        let img = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        return img
    }
    
    public func cornerRadius(_ cornerRadius: Float) -> UIImage {
        guard self.image != nil else {
            return UIImage()
        }
        UIGraphicsBeginImageContextWithOptions(self.image!.size, false, 0.0)
        let rect = CGRect(origin: CGPoint(x: 0, y: 0), size: self.image!.size)
        UIBezierPath(roundedRect: rect, cornerRadius: CGFloat(cornerRadius)).addClip()
        self.image!.draw(in: rect)
        let img = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        return img
    }
    
    public func scale(_ scale: CGFloat) -> UIImage {
        guard self.image != nil else {
            return UIImage()
        }
        let size = CGSize(width: self.image!.size.width * scale, height: self.image!.size.height * scale)
        UIGraphicsBeginImageContextWithOptions(size, false, 0.0)
        self.image!.draw(in: CGRect(origin: CGPoint(x: 0, y: 0), size: size))
        let img = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        return img
    }
    
    public func subimage(rect: CGRect) -> UIImage {
        guard self.image != nil else {
            return UIImage()
        }
        return UIImage(cgImage: self.image!.cgImage!.cropping(to: rect)!)
    }
    
    public func scrollView(_ scrollView: UIScrollView) -> UIImage {
        
        let originalContentOffset = scrollView.contentOffset
        let originalFrame = scrollView.frame
        
        scrollView.contentOffset = CGPoint()
        scrollView.frame = CGRect(origin: CGPoint(x: 0, y: 0), size: scrollView.contentSize)
        
        UIGraphicsBeginImageContextWithOptions(scrollView.contentSize, false, 0.0)
        scrollView.layer.render(in: UIGraphicsGetCurrentContext()!)
        let img = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        
        scrollView.contentOffset = originalContentOffset
        scrollView.frame = originalFrame
        
        return img
    }
    
    public func original(name: String) -> UIImage {
        return UIImage(named: name)!.withRenderingMode(.alwaysOriginal)
    }
}

public extension UIImage {
    
    public class var wjc: WJCImage {
        return WJCImage(image: nil)
    }
    
    public var wjc: WJCImage {
        return WJCImage(image: self)
    }
    
//    convenience init(wjc_original: String) {
//        self.init(named: wjc_original)!
//        withRenderingMode(.alwaysOriginal)
//    }

//    class func wjc_image(color: UIColor, size: CGSize) -> UIImage {
//        UIGraphicsBeginImageContextWithOptions(size, false, 0.0)
//        color.set()
//        UIRectFill(CGRect(origin: CGPoint(x: 0, y: 0), size: size))
//        let img = UIGraphicsGetImageFromCurrentImageContext()
//        UIGraphicsEndImageContext()
//        return img!
//    }
    
//    func wjc_roundImage() -> UIImage {
//        UIGraphicsBeginImageContextWithOptions(self.size, false, 0.0)
//        let ctx = UIGraphicsGetCurrentContext();
//        let rect = CGRect(origin: CGPoint(x: 0, y: 0), size: self.size)
//        ctx?.addEllipse(in: rect);
//        ctx?.clip();
//        self.draw(in: rect)
//        let img = UIGraphicsGetImageFromCurrentImageContext()
//        UIGraphicsEndImageContext()
//        return img!
//    }
    
//    func wjc_cornerRadius(_ cornerRadius: Float) -> UIImage {
//        UIGraphicsBeginImageContextWithOptions(self.size, false, 0.0)
//        let rect = CGRect(origin: CGPoint(x: 0, y: 0), size: self.size)
//        UIBezierPath(roundedRect: rect, cornerRadius: CGFloat(cornerRadius)).addClip()
//        self.draw(in: rect)
//        let img = UIGraphicsGetImageFromCurrentImageContext()
//        UIGraphicsEndImageContext()
//        return img!
//    }
    
//    func wjc_scale(_ scale: CGFloat) -> UIImage {
//        let size = CGSize(width: self.size.width * scale, height: self.size.height * scale)
//        UIGraphicsBeginImageContextWithOptions(size, false, 0.0)
//        self.draw(in: CGRect(origin: CGPoint(x: 0, y: 0), size: size))
//        let img = UIGraphicsGetImageFromCurrentImageContext()
//        UIGraphicsEndImageContext()
//        return img!
//    }
    
//    class func wjc_scrollView(_ scrollView: UIScrollView) -> UIImage {
//        let originalContentOffset = scrollView.contentOffset
//        let originalFrame = scrollView.frame
//        
//        scrollView.contentOffset = CGPoint()
//        scrollView.frame = CGRect(origin: CGPoint(x: 0, y: 0), size: scrollView.contentSize)
//        
//        UIGraphicsBeginImageContextWithOptions(scrollView.contentSize, false, 0.0)
//        scrollView.layer.render(in: UIGraphicsGetCurrentContext()!)
//        let img = UIGraphicsGetImageFromCurrentImageContext()
//        UIGraphicsEndImageContext()
//        
//        scrollView.contentOffset = originalContentOffset
//        scrollView.frame = originalFrame
//        
//        return img!
//    }
    
//    func wjc_subimage(rect: CGRect) -> UIImage {
//        return UIImage(cgImage: cgImage!.cropping(to: rect)!)
//    }
    
    
    
    
}
