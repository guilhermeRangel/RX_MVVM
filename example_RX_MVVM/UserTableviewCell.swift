//
//  UserTableviewCell.swift
//  example_RX_MVVM
//
//  Created by Guilherme Rangel on 24/07/22.
//

import UIKit

class UserTableViewCell: UITableViewCell{
  
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .value2, reuseIdentifier: "UserTableViewCell")
    }
    
    required init(coder: NSCoder) {
        fatalError("init coder fails")
    }
    
}
