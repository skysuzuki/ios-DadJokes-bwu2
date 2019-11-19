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
}

struct Colors {
    
    static let sharedColors = Colors()
    
    let babyBlue = UIColor(red: 168, green: 208, blue: 230)
    let darkerBlue = UIColor(red: 55, green: 71, blue: 133)
    let darkestBlue = UIColor(red: 36, green: 48, blue: 94)
    let tan = UIColor(red: 248, green: 233, blue: 161)
    let salmon = UIColor(red: 247, green: 108, blue: 108)
}
