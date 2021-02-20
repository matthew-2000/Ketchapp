//
//  KetchupTableViewCell.swift
//  Ketchapp
//
//  Created by Matteo Ercolino on 11/02/21.
//

import UIKit

class KetchupTableViewCell: UITableViewCell {

    @IBOutlet weak var nomeLabel: UILabel!
    @IBOutlet weak var taskCountLabel: UILabel!
    var ketchup: KetchupModel!
    var actionBlock: (() -> Void)? = nil
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func startClick(_ sender: Any) {
        actionBlock!()
    }

}
