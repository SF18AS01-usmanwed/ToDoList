//
//  ToDoCell.swift
//  ToDoList
//
//  Created by Ousmane Ouedraogo on 3/22/19.
//  Copyright © 2019 Aseel Alshohatee. All rights reserved.
//

import UIKit;

protocol ToDoCellDelegate: class {
    func checkmarkTapped(sender: ToDoCell);
}

class ToDoCell: UITableViewCell {
    var delegate: ToDoCellDelegate? = nil;
    @IBOutlet weak var isCompleteButton: UIButton!;
    @IBOutlet weak var titleLabel: UILabel!;
    
    override func awakeFromNib() {
        super.awakeFromNib();
       
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated);

        // Configure the view for the selected state.
    }
    
    @IBAction func completeButtonTapped(_ sender: UIButton) {  
        delegate?.checkmarkTapped(sender: self);
    }
}
