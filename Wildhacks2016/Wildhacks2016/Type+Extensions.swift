//
//  Type+Extensions.swift
//  SelectPlayer
//
//  Created by Wyatt Mufson on 9/11/16.
//  Copyright © 2016 Wyatt Mufson. All rights reserved.
//

import UIKit
import MapKit

extension Bool {
    mutating func invert(){
        self = !self
    }
}

extension Int {
    var boolValue:Bool{
        get {
            if self >= 1 {
                return true
            } else {
                return false
            }
        }
        
    }
}

extension Date {
    func hours(from date: Date) -> Int {
        return Calendar.current.dateComponents([.hour], from: date, to: self).hour ?? 0
    }
}

extension String {
    
    subscript (i: Int) -> Character {
        return self[self.index(startIndex, offsetBy: i)]
    }
    
    subscript (i: Int) -> String {
        return String(self[i] as Character)
    }
    
    subscript (r: Range<Int>) -> String {
        let start = self.index(startIndex, offsetBy: r.lowerBound) //startIndex.advancedBy(r.lowerBound)
        let end = self.index(start, offsetBy: r.upperBound - r.lowerBound)//start.advancedBy(r.upperBound - r.lowerBound)
        return self[Range(start ..< end)]
    }
}

extension UIColor {
    func colorFromHex(hexValue:String, alpha: CGFloat)->UIColor{
        
        let redHex = hexValue[0..<2]
        let greenHex = hexValue[2..<4]
        let blueHex = hexValue[4..<6]

        let redInt = UInt8(strtoul(redHex, nil, 16))
        let greenInt = UInt8(strtoul(greenHex, nil, 16))
        let blueInt = UInt8(strtoul(blueHex, nil, 16))

        let red : CGFloat = CGFloat(redInt) / 255.0
        let green : CGFloat = CGFloat(greenInt) / 255.0
        let blue : CGFloat = CGFloat(blueInt) / 255.0

        return UIColor(red: red, green: green, blue: blue, alpha: alpha)
        
    }
}
