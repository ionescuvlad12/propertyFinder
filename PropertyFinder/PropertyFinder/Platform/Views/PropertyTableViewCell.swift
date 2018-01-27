//
//  PropertyTableViewCell.swift
//  PropertyFinder
//
//  Created by Ionescu Vlad on 27/01/2018.
//  Copyright © 2018 Ionescu Vlad. All rights reserved.
//

import UIKit

class PropertyTableViewCell: UITableViewCell {
    
    static let ID = "PropertyCell"
    
    @IBOutlet weak var thumbnailImageView: UIImageView!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var badsLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
extension PropertyTableViewCell: PropertyListItemView {
    func display(price: Double) {
        priceLabel.text = "\(price) AED"
    }
    
    func display(beds: Int) {
        badsLabel.text = "\(beds) Bedrooms"
    }
    
    func display(thumbnailImage: UIImage) {
        thumbnailImageView.image = thumbnailImage
    }
}
