//
//  ViewController.swift
//  DOTLoaderANimation
//
//  Created by Apple on 25/11/21.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        showAnimatingDotsInImageView()
    }
    func showAnimatingDotsInImageView() {
            
            let lay = CAReplicatorLayer()
            lay.frame = CGRect(x: 0, y: 8, width: 50, height: 50) //yPos == 12
            let circle = CALayer()
            circle.frame = CGRect(x: 0, y: 0, width: 7, height: 7)
            circle.cornerRadius = circle.frame.width / 2
            circle.backgroundColor = UIColor(red: 110/255.0, green: 110/255.0, blue: 110/255.0, alpha: 1).cgColor//lightGray.cgColor //UIColor.black.cgColor
            lay.addSublayer(circle)
            lay.instanceCount = 3
            lay.instanceTransform = CATransform3DMakeTranslation(10, 0, 0)
            let anim = CABasicAnimation(keyPath: #keyPath(CALayer.opacity))
            anim.fromValue = 1.0
            anim.toValue = 0.2
            anim.duration = 1
            anim.repeatCount = .infinity
            circle.add(anim, forKey: nil)
            lay.instanceDelay = anim.duration / Double(lay.instanceCount)
            
            imageView.layer.addSublayer(lay)
        }

}

