//
//  RadioCell.swift
//  Amanaksa
//
//  Created by mac on 3/8/20.
//  Copyright © 2020 mac. All rights reserved.
//

import UIKit
import BEMCheckBox

protocol RadioCellDelegate:NSObjectProtocol {
    func didTapRadioButton(cell:RadioCell)
}

class RadioCell: UITableViewCell{
    
    @IBOutlet weak var itemNameLabel: UILabel!
    @IBOutlet weak var itemDesciptionLabel: UILabel!
    @IBOutlet weak var radioButton: UIButton!
    
    weak var delegate:RadioCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    
    override var isSelected: Bool{
        didSet{
            self.radioButton.setImage(isSelected ? UIImage(named: "selected")?.withRenderingMode(.alwaysTemplate) : nil, for: .normal)
            self.radioButton.tintColor = UIColor.buttonBackgroundColor
        }
    }
    
    func setupCell(item:Item){
        itemNameLabel.text = item.name
        itemDesciptionLabel.text = item.description
    }
    
    @IBAction func selectCell(_ sender: UIButton) {
        delegate?.didTapRadioButton(cell: self)
    }
    
    
}

extension RadioCell:RadioCellView{
    func displayTitle(title: String) {
        itemNameLabel.text = title
    }
    
    func displayTitleAR(title: String) {
        itemNameLabel.text = title
    }
    
    func displayDesc(desc: String) {
        itemDesciptionLabel.text = desc
    }
    
    func displayDescAR(desc: String) {
        itemDesciptionLabel.text = desc
    }
}
