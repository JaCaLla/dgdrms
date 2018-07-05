//
//  DateSelectorTVC.swift
//  dgdrms
//
//  Created by 08APO0516 on 27/06/2018.
//  Copyright © 2018 jca. All rights reserved.
//

import UIKit

class DateSelectorTVC: UITableViewCell {

    // MARK: - IBOutlet
    @IBOutlet weak var pckDateSelector: UIDatePicker!
    
    // MARK: - Callback
    var onValueChanged: (Date) -> Void = { _ in }
    
    // MARK: - Public attributes
    var user:User? {
        didSet {
            self._refreshView()
        }
    }
    
    // MARK: - Lifecycle
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    // MARK: - Private/Internal
    func _refreshView() {
        
    }
}
