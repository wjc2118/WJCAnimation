//
//  UIColor+WJC.swift
//  stringExten
//
//  Created by Mac-os on 16/8/12.
//  Copyright © 2016年 risen. All rights reserved.
//

import UIKit

public struct WJCColor {
    fileprivate let color: UIColor
    init(_ color: UIColor) {
        self.color = color
    }
}

extension WJCColor {
    
}

public extension UIColor {
    
    public var wjc: WJCColor {
        return WJCColor(self)
    }
    
    convenience init(wjc_hex: UInt) {
        if wjc_hex <= 0xFFFFFF {
            self.init(wjc_hex: Int(wjc_hex), alpha: 1)
        } else if wjc_hex <= 0xFFFFFFFF {
            self.init(colorLiteralRed: Float((wjc_hex & 0xFF0000) >> 16) / 255.0, green: Float((wjc_hex & 0xFF00) >> 8) / 255.0, blue: Float(wjc_hex & 0xFF) / 255.0, alpha: Float((wjc_hex & 0xFF000000) >> 24) / 255.0)
        } else {
            self.init(white: 0, alpha: 0)
        }
    }
    
    convenience init(wjc_hex: Int, alpha: Float) {
        guard wjc_hex <= 0xFFFFFF else {
            self.init(white: 0, alpha: 0); return
        }
        
        self.init(colorLiteralRed: Float((wjc_hex & 0xFF0000) >> 16) / 255.0, green: Float((wjc_hex & 0xFF00) >> 8) / 255.0, blue: Float(wjc_hex & 0xFF) / 255.0, alpha: alpha)
    }
    
    convenience init(wjc_hexString: String) {
        var hex: UInt32 = 0
        let scanner = Scanner(string: wjc_hexString)
        scanner.charactersToBeSkipped = CharacterSet(charactersIn: "#")
        
        guard scanner.scanHexInt32(&hex) else {
            self.init(white: 0, alpha: 0); return
        }
        
        self.init(wjc_hex: UInt(hex))
    }
    
    convenience init(r: Int, g: Int, b: Int) {
        self.init(colorLiteralRed: Float(r) / 255.0, green: Float(g) / 255.0, blue: Float(b) / 255.0, alpha: 1)
    }
    
    class func wjc_randomColor() -> Self {
        return self.init(colorLiteralRed: Float(Int(arc4random_uniform(256))) / 255.0, green: Float(Int(arc4random_uniform(256))) / 255.0, blue: Float(Int(arc4random_uniform(256))) / 255.0, alpha: 1)
    }
    
}
