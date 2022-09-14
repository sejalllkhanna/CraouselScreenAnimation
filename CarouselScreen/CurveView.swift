//
//  CurveView.swift
//  CarouselScreen
//
//  Created by Apple on 27/11/21.
//

import UIKit

class CurveView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func draw(_ rect: CGRect) {

       
        var path = UIBezierPath()
       path.move(to:CGPoint(x: self.frame.size.width, y: self.frame.size.height))
        
        
        path = UIBezierPath(arcCenter: CGPoint(x: self.frame.size.width, y: self.frame.size.height),
                            radius: self.frame.size.height,
                            startAngle: -Double.pi,
                            endAngle: Double.pi/2,
                            clockwise: true)
        path.close()

        
        let shapeLayer = CAShapeLayer()
        shapeLayer.path = path.cgPath
        self.layer.mask = shapeLayer
        
    

    }
    
    func setBGColor(color: UIColor) {
        self.backgroundColor = color
    }
    
}
