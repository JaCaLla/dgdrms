//
//  UserSettingsV.swift
//  dgdrms
//
//  Created by 08APO0516 on 27/06/2018.
//  Copyright © 2018 jca. All rights reserved.
//

import UIKit

enum UserSettingAttribute: Int {
    case name
    case surename
    case dateOfBirth
    case currency
    case count    // This attribute MUST be always at the end!
    
    func isName() -> Bool                    { return self == .name }
    
    func placeholder() -> String {
        switch self {
        case .name: return  R.string.localizable.user_settings_title.key.localized
        case .surename: return  R.string.localizable.user_settings_title.key.localized
        default: return ""
        }
    }
}

class UserSettingsV: UITableView {

    // MARK: - Public attributes
    var userAndCurrency:(User?,[Currency])? {
        didSet {
            self._refreshView()
        }
    }
    
    // MARK:  - Private attributes
    private var newUser:User = User(name: "", surename: "", dateOfBirth: Date(), currency: "")
    
    // MARK: - Lifecycle
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self._setupView()
        self._refreshView()
    }
    
    

    // MARK: - Private/Internal
    func _setupView() {
        self.dataSource = self
    }
    
    func _refreshView() {
        self.reloadData()
    }
}

extension UserSettingsV: UITableViewDataSource {
    // MARK: - UITableViewDataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return UserSettingAttribute.count.rawValue
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let userSettingAttribute = UserSettingAttribute(rawValue: indexPath.row),
              let _user = userAndCurrency?.0,
              let _currencies = userAndCurrency?.1 else {
            return UITableViewCell()
        }
        
        switch userSettingAttribute {
        case .name,.surename:
            return configureUserSettingsCell(tableView: tableView,userSettingAttribute:userSettingAttribute,user:_user)
        case .dateOfBirth:
            return configureDateSelectorCell(tableView: tableView, userSettingAttribute: userSettingAttribute, user: _user)
        case .currency:
            return configureCurrencySelectorCell(tableView: tableView,userSettingAttribute: userSettingAttribute, currencies:_currencies,user:_user)
        default: return UITableViewCell()
        }
    }
    
    func configureUserSettingsCell(tableView: UITableView,userSettingAttribute:UserSettingAttribute,user:User) -> UserSettingsTVC {
        guard let userSettingsTVC:UserSettingsTVC = tableView.dequeueReusableCell(withIdentifier: R.reuseIdentifier.userSettingsTVC.identifier) as? UserSettingsTVC else {
            return UserSettingsTVC()
        }
        
        userSettingsTVC.userAttributeValue =  userSettingAttribute.isName() ? user.name : user.surename
        userSettingsTVC.onValueChanged = { [weak self] value in
                    guard let weakSelf = self else { return }
            if userSettingAttribute.isName() {
                weakSelf.newUser.name = value
            } else {
                weakSelf.newUser.surename = value
            }
            
        }

        return userSettingsTVC
    }
    
    func configureCurrencySelectorCell(tableView: UITableView,userSettingAttribute:UserSettingAttribute,currencies:[Currency],user:User) -> CurrencySelectorTVC {
        
        guard let currencySelectorTVC:CurrencySelectorTVC = tableView.dequeueReusableCell(withIdentifier: R.reuseIdentifier.currencySelectorTVC.identifier) as? CurrencySelectorTVC else {
            return CurrencySelectorTVC()
        }
        
        currencySelectorTVC.currencies = currencies
        currencySelectorTVC.user = user
        currencySelectorTVC.onValueChanged = { [weak self] value in
            guard let weakSelf = self else { return }
                weakSelf.newUser.currency = value
        }
        
        return currencySelectorTVC
    }
    
    func configureDateSelectorCell(tableView: UITableView,userSettingAttribute:UserSettingAttribute,user:User) -> DateSelectorTVC {
        
        guard let dateSelectorTVC:DateSelectorTVC = tableView.dequeueReusableCell(withIdentifier: R.reuseIdentifier.dateSelectorTVC.identifier) as? DateSelectorTVC else {
            return DateSelectorTVC()
        }
        
        dateSelectorTVC.user = user
        dateSelectorTVC.onValueChanged = { [weak self] value in
            guard let weakSelf = self else { return }
            weakSelf.newUser.dateOfBirth = value
        }
        
        return dateSelectorTVC
    }
    
}
