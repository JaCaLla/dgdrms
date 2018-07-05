//
//  UserSettingsTVCTableViewCell.swift
//  dgdrms
//
//  Created by 08APO0516 on 27/06/2018.
//  Copyright © 2018 jca. All rights reserved.
//

import UIKit

class UserSettingsTVC: UITableViewCell {

    // MARK: - IBOutlet
    @IBOutlet weak var txtValue: UITextField!
    
    // MARK: - Callback
    var onValueChanged: (String) -> Void = { _ in }
    
    // MARK: - Public attributes
    var userAttributeValue = ""
    var userSettingAttribute:UserSettingAttribute = .name {
        didSet {
            self._refreshView()
        }
    }
    
    // MARK: - Lifecycle
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self._setupView()
    }

    // MARK: - Private/Internal
    private func _setupView() {
    
        txtValue.delegate = self
        txtValue.textAlignment = .right
      //  txtValue.font = BaristaFonts.Alarms.AlarmAttributeNameFont
        txtValue.placeholder = "edit_alarm_label_alarm_name_hint".localized
      //  txtValue.textColor = BaristaColors.MachineSettings.ValueColor
    }
    
    private func _refreshView() {
        
    }
}

extension UserSettingsTVC:UITextFieldDelegate {
    
}
