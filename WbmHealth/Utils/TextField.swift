//
//  TextField.swift
//  Quiz
//
//  Created by Zeeshan Ashraf on 26/11/2018.
//  Copyright © 2018 Zeeshan Ashraf. All rights reserved.
//

import Foundation
import UIKit

class TextField: UITextField {

    let padding  = UIEdgeInsets(top: 0, left: 5, bottom: 0, right: 5)
    
    override open func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
    
    override open func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
    
    override open func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
    
        
    
}
