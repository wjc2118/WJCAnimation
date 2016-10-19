//
//  UIImage+WJC.swift
//  stringExten
//
//  Created by Mac-os on 16/8/12.
//  Copyright © 2016年 risen. All rights reserved.
//

import UIKit

public extension UIImage {
    
    convenience init(wjc_original: String) {
        self.init(named: wjc_original)!
        withRenderingMode(.alwaysOriginal)
    }
    
    class func wjc_image(color: UIColor, size: CGSize) -> UIImage {
        UIGraphicsBeginImageContextWithOptions(size, false, 0.0)
        color.set()
        UIRectFill(CGRect(origin: CGPoint(x: 0, y: 0), size: size))
        let img = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return img!
    }
    
    func wjc_roundImage() -> UIImage {
        UIGraphicsBeginImageContextWithOptions(self.size, false, 0.0)
        let ctx = UIGraphicsGetCurrentContext();
        let rect = CGRect(origin: CGPoint(x: 0, y: 0), size: self.size)
        ctx?.addEllipse(in: rect);
        ctx?.clip();
        self.draw(in: rect)
        let img = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return img!
    }
    
    func wjc_cornerRadius(_ cornerRadius: Float) -> UIImage {
        UIGraphicsBeginImageContextWithOptions(self.size, false, 0.0)
        let rect = CGRect(origin: CGPoint(x: 0, y: 0), size: self.size)
        UIBezierPath(roundedRect: rect, cornerRadius: CGFloat(cornerRadius)).addClip()
        self.draw(in: rect)
        let img = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return img!
    }
    
    func wjc_scale(_ scale: CGFloat) -> UIImage {
        let size = CGSize(width: self.size.width * scale, height: self.size.height * scale)
        UIGraphicsBeginImageContextWithOptions(size, false, 0.0)
        self.draw(in: CGRect(origin: CGPoint(x: 0, y: 0), size: size))
        let img = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return img!
    }
    
    class func wjc_scrollView(_ scrollView: UIScrollView) -> UIImage {
        let originalContentOffset = scrollView.contentOffset
        let originalFrame = scrollView.frame
        
        scrollView.contentOffset = CGPoint()
        scrollView.frame = CGRect(origin: CGPoint(x: 0, y: 0), size: scrollView.contentSize)
        
        UIGraphicsBeginImageContextWithOptions(scrollView.contentSize, false, 0.0)
        scrollView.layer.render(in: UIGraphicsGetCurrentContext()!)
        let img = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        scrollView.contentOffset = originalContentOffset
        scrollView.frame = originalFrame
        
        return img!
    }
    
    func wjc_subimage(rect: CGRect) -> UIImage {
        return UIImage(cgImage: cgImage!.cropping(to: rect)!)
    }
    
    
    
    
    
    
    
}
