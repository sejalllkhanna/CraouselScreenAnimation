//
//  ViewController.swift
//  CrossAnimation
//
//  Created by Apple on 22/11/21.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var FirstView: UIView!
    @IBOutlet weak var SecondView: UIView!
    @IBOutlet weak var ThirdView: UIView!
    @IBOutlet weak var MainView: UIView!
    
    var isTapped = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.handleTap(_:)))
        MainView.addGestureRecognizer(tap)
        
//        let tapAgain = UITapGestureRecognizer(target: self, action: #selector(self.handleTapAgain(_:)))
//        MainView.addGestureRecognizer(tapAgain)
        
//        FirstView.frame.origin.x = MainView.frame.origin.x - 40
//        SecondView.frame.origin.x = MainView.frame.origin.x - 40
//        ThirdView.frame.origin.x = MainView.frame.origin.x - 40
    }
    
    @objc func handleTap(_ sender: UITapGestureRecognizer? = nil) {
        UIView.animate(withDuration: 1) {
            self.FirstView.transform = CGAffineTransform(rotationAngle: .pi/4)
            self.ThirdView.transform = CGAffineTransform(rotationAngle: -.pi/4)
            self.SecondView.transform = CGAffineTransform(scaleX: 0, y: 0)
        }
    }
    
    let shortStroke: CGPath = {
        let path = CGMutablePath()
        return path
    }()
    
}

class HamburgerButton: UIButton {
    let top: CAShapeLayer = CAShapeLayer()
    let middle: CAShapeLayer = CAShapeLayer()
    let bottom: CAShapeLayer = CAShapeLayer()

    let width: CGFloat = 18
    let height: CGFloat = 16
    let topYPosition: CGFloat = 2
    let middleYPosition: CGFloat = 7
    let bottomYPosition: CGFloat = 12
    
    
    let path = UIBezierPath()
    path.moveToPoint(CGPoint(x: 0, y: 0))
    path.addLineToPoint(CGPoint(x: width, y: 0))
    shapeLayer.path = path.CGPath

    shapeLayer.lineWidth = 2
    shapeLayer.strokeColor = UIColor.whiteColor().CGColor
}

