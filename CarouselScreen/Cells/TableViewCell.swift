//
//  TableViewCell.swift
//  CarouselScreen
//
//  Created by Apple on 23/11/21.
//

import UIKit

class TableViewCell: UITableViewCell {
    
    @IBOutlet weak var AmountLabel: UILabel!
    @IBOutlet weak var DayLabel: UILabel!
    @IBOutlet weak var UserNameLabel: UILabel!
    @IBOutlet weak var iconImage: UIImageView!
    @IBOutlet weak var BankNameLabel: UILabel!
    @IBOutlet weak var iconView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        iconView.layer.cornerRadius = iconView.frame.width/2
        iconView.layer.borderWidth = 0.5
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func SetData(amountLabel: String, userNameLabel:String, dayLabel: String) {
        AmountLabel.text = amountLabel
        UserNameLabel.text = userNameLabel
        DayLabel.text = dayLabel
    }
}


extension UIImageView {
    public func imageFromServerURL(urlString: String, PlaceHolderImage:UIImage) {
        
        if self.image == nil{
            self.image = PlaceHolderImage
        }
        
        URLSession.shared.dataTask(with: NSURL(string: urlString)! as URL, completionHandler: { (data, response, error) -> Void in
            
            if error != nil {
                print(error ?? "No Error")
                return
            }
            DispatchQueue.main.async(execute: { () -> Void in
                let image = UIImage(data: data!)
                self.image = image
            })
            
        }).resume()
    }}
