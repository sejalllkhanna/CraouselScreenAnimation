//
//  CollectionViewCell.swift
//  CarouselScreen
//
//  Created by Apple on 23/11/21.
//

import UIKit
import Foundation

class CardsCollectionCell: UICollectionViewCell {
    
    static let identifier = "CardsCollectionCell"
    
    @IBOutlet weak var myAiCard: UIImageView!
    @IBOutlet weak var indexLabel: UILabel!
    @IBOutlet weak var ExpandedCircle: UIImageView!
    @IBOutlet weak var ExpandedCircleHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var ExpandedCircleWidthConstraint: NSLayoutConstraint!
    @IBOutlet weak var EyeViewImage: UIImageView!
    @IBOutlet weak var DetailsImage: UIImageView!
    @IBOutlet weak var ContentStackView: UIStackView!
    @IBOutlet weak var BlockImage: UIImageView!
    @IBOutlet weak var CashbackLabel: UILabel!
    @IBOutlet weak var CashbackAmount: UILabel!
    @IBOutlet weak var InterestLabel: UILabel!
    @IBOutlet weak var InterestAmount: UILabel!
    @IBOutlet weak var BlurView: UIView!
    @IBOutlet weak var TitleLabel: UILabel!
    @IBOutlet weak var ContentView: UIView!
    @IBOutlet weak var CurveView: CurveView!
    @IBOutlet weak var hamburgerButton: HamburgerButton!
    var delegate:hamBurgerButtonProtocol?
    
    
    override func awakeFromNib() {
        self.TitleLabel.frame.origin.x = self.ContentView.frame.origin.x + 300
        self.TitleLabel.frame.origin.y = self.ContentView.frame.origin.y + 300
        
        self.ContentStackView.frame.origin.x = self.ContentView.frame.origin.x + 300
        self.ContentStackView.frame.origin.y = self.ContentView.frame.origin.y + 300
        
        
        self.hamburgerButton.frame = CGRect(x: CurveView.frame.origin.x + 20, y: CurveView.frame.origin.y+40, width: 40, height: 40)
        
        self.hamburgerButton.addTarget(self, action: #selector(toggle(_:)), for:.touchUpInside)
        
        self.ExpandedCircleWidthConstraint.constant = 0
        self.ExpandedCircleHeightConstraint.constant = 0
        
        let blurEffect = UIBlurEffect(style: UIBlurEffect.Style.light)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = BlurView.bounds
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        BlurView.addSubview(blurEffectView)
        BlurView.isHidden = true
        
    }
    @objc func toggle(_ sender: AnyObject) {
        
        self.hamburgerButton.showsMenu = !self.hamburgerButton.showsMenu
        delegate?.isShowMenuTrue(showMenu: hamburgerButton.showsMenu)
        if hamburgerButton.showsMenu{
            UIView.animate(withDuration: 0.5) {
                
                self.ExpandedCircleWidthConstraint.constant = 130
                self.ExpandedCircleHeightConstraint.constant = 130
                
                self.EyeViewImage.frame.origin.x = self.ExpandedCircle.frame.origin.x + 90
                self.EyeViewImage.frame.origin.y = self.ExpandedCircle.frame.origin.y + 20
                
                self.DetailsImage.frame.origin.x = self.ExpandedCircle.frame.origin.x + 40
                self.DetailsImage.frame.origin.y = self.ExpandedCircle.frame.origin.y + 50
                
                self.BlockImage.frame.origin.x = self.ExpandedCircle.frame.origin.x + 10
                self.BlockImage.frame.origin.y = self.ExpandedCircle.frame.origin.y + 95
                
                self.TitleLabel.frame.origin.x = self.ContentView.frame.origin.x + 10
                self.TitleLabel.frame.origin.y = self.ContentView.frame.origin.y + 20
                
                self.ContentStackView.frame.origin.x = self.ContentView.frame.origin.x + 10
                self.ContentStackView.frame.origin.y = self.ContentView.frame.origin.y + 60
                self.CurveView.backgroundColor = UIColor(red: 34/255.0, green: 37/255.0, blue: 73/255.0, alpha: 1)
                self.layoutIfNeeded()
            }
            BlurView.isHidden = false
            
        }else{
            UIView.animate(withDuration: 0.5) {
                self.ExpandedCircleWidthConstraint.constant = 0
                self.ExpandedCircleHeightConstraint.constant = 0
                
                self.TitleLabel.frame.origin.x = self.ContentView.frame.origin.x + 300
                self.TitleLabel.frame.origin.y = self.ContentView.frame.origin.y + 300
                
                self.ContentStackView.frame.origin.x = self.ContentView.frame.origin.x + 300
                self.ContentStackView.frame.origin.y = self.ContentView.frame.origin.y + 300
                self.CurveView.backgroundColor = .white
                self.layoutIfNeeded()
            }
            BlurView.isHidden = true
        }
    }
    override func draw(_ rect: CGRect) {
        
    }
}

