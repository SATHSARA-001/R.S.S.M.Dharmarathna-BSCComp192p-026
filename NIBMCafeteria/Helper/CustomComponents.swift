//
//  CustomComponents.swift
//  NIBMCafeteria
//
//  Created by Sathsara Maduranga on 2021-02-24.
//

import Foundation
import UIKit


class CustomButton: UIButton {
    @IBInspectable var color :UIColor = .white {
        didSet {
            setNeedsDisplay()
        }
    }
    
    @IBInspectable var background :UIColor = #colorLiteral(red: 0.1921439171, green: 0.469352901, blue: 0.8385232687, alpha: 1) {
        didSet {
            setNeedsDisplay()
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.layer.masksToBounds = true
        self.layer.cornerRadius = self.frame.height / 2
        self.layer.borderWidth = 1
        self.layer.borderColor = color.cgColor
        self.backgroundColor = background
        self.setTitleColor(color, for: .normal)
    }
}
