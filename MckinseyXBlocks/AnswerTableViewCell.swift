//
//  AnswerTableViewCell.swift
//  MckinseyXBlocks
//
//  Created by Shafqat Muneer on 8/19/17.
//  Copyright © 2017 Salman Jamil. All rights reserved.
//

import UIKit

class AnswerTableViewCell: UITableViewCell {

    @IBOutlet weak var optionCardView: UIView!
    @IBOutlet weak var optionResultDetailView: UIView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        optionCardView.addShadow()
        
        
        let topBorder: CALayer = CALayer()
        topBorder.frame = CGRect(x: 0, y: 0, width: optionResultDetailView.frame.size.width, height: 1) //CGRect(0.0, 0.0, cellView.frame.size.width, 3.0)
        topBorder.backgroundColor = UIColor(red: 247/255, green: 192/255, blue: 202/255, alpha: 1.0).cgColor
        optionResultDetailView.layer.addSublayer(topBorder)
        
        
        let bottomBorder: CALayer = CALayer()
        bottomBorder.frame = CGRect(x: 0, y: optionResultDetailView.frame.size.height - 1, width: optionResultDetailView.frame.size.width, height: 1) //CGRect(0.0, 0.0, cellView.frame.size.width, 3.0)
        bottomBorder.backgroundColor = UIColor(red: 247/255, green: 192/255, blue: 202/255, alpha: 1.0).cgColor
        optionResultDetailView.layer.addSublayer(bottomBorder)
        
        
        
        optionResultDetailView.backgroundColor = UIColor(red: 246/255, green: 224/255, blue: 228/255, alpha: 1.0)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}
