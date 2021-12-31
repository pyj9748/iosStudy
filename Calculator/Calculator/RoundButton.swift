//
//  RoundButton.swift
//  Calculator
//
//  Created by young june Park on 2021/12/31.
//

import UIKit
@IBDesignable
class RoundButton: UIButton {

    @IBInspectable var isRound : Bool = false {
        
        didSet{
            if isRound{
                
                self.layer.cornerRadius = self.frame.height / 2
            }
            
        }
        
    }

}
