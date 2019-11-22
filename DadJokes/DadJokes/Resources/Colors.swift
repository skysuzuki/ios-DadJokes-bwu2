//
//  Colors.swift
//  DadJokes
//
//  Created by Lambda_School_Loaner_204 on 11/19/19.
//  Copyright © 2019 Lambda School. All rights reserved.
//

import Foundation
import UIKit

extension UIColor {
    convenience init(red: Int, green: Int, blue: Int) {
        let newRed = CGFloat(red) / 255
        let newGreen = CGFloat(green) / 255
        let newBlue = CGFloat(blue) / 255
        
        self.init(red: newRed, green: newGreen, blue: newBlue, alpha: 1.0)
    }
    
    func lighter(by percentage: CGFloat) -> UIColor? {
        return self.adjust(by: abs(percentage))
    }
    
    func adjust(by percentage: CGFloat = 30.0) -> UIColor? {
        var red: CGFloat = 0, green: CGFloat = 0, blue: CGFloat = 0, alpha: CGFloat = 0
        if self.getRed(&red, green: &green, blue: &blue, alpha: &alpha) {
            return UIColor(red: min(red + percentage/100, 1.0),
                           green: min(green + percentage/100, 1.0),
                           blue: min(blue + percentage/100, 1.0),
                           alpha: alpha)
        } else {
            return nil
        }
    }
}

struct Colors {
    
    static let babyBlue = UIColor(red: 168, green: 208, blue: 230)
    static let veryLightBlue = UIColor(red: 168, green: 208, blue: 230).lighter(by: 13.0)
    static let darkerBlue = UIColor(red: 55, green: 71, blue: 133)
    static let darkestBlue = UIColor(red: 36, green: 48, blue: 94)
    static let tan = UIColor(red: 248, green: 233, blue: 161)
    static let salmon = UIColor(red: 247, green: 108, blue: 108)
}
