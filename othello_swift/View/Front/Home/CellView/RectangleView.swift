//
//  RectangleView.swift
//  othelloSwift
//
//  Created by Kazuki on 2020/08/03.
//  Copyright © 2020 susu. All rights reserved.
//

import Foundation
import UIKit

@IBDesignable
class RectangleView: UIView {
    @IBInspectable var borderColor: UIColor? = .black
    @IBInspectable var borderWidth: CGFloat = 3
    @IBInspectable var fillColor: UIColor? = .clear
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    private func initViews() {
        self.isOpaque = false // must be transparent
    }
    
    func createPathInIdentity() -> UIBezierPath {
        UIBezierPath(rect: CGRect(x: 0, y: 0, width: 1, height: 1))
    }
    
    private lazy var path = self.createPathInIdentity()
    private func createPath(for size: CGSize) -> UIBezierPath {
        let path = self.createPathInIdentity()
        let transform = CGAffineTransform.identity
            .scaledBy(x: size.width, y: size.height)
        path.apply(transform)
        return path
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.path = self.createPath(for: self.frame.size)
    }

    override open func draw(_ frame: CGRect) {
        let path = self.path
        
        if let fillColor = self.fillColor {
            fillColor.setFill()
            path.fill()
        }
        
        if let borderColor = self.borderColor {
            borderColor.setStroke()
            path.lineWidth = 2
            path.stroke()
        }
    }
}
