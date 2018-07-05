//
//  UserSettingsVC.swift
//  dgdrms
//
//  Created by 08APO0516 on 26/06/2018.
//  Copyright © 2018 jca. All rights reserved.
//

import UIKit

class UserSettingsVC: UIViewController {

    // MARK: - IBOutlet
    @IBOutlet weak var userSettingsV: UserSettingsV!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self._setupPresenter()
        self._fetchUserSettings()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    // MARK: - Private/Internal
    func _setupPresenter() {
        self.title = R.string.localizable.user_settings_title.key.localized
    }
    
    func _fetchUserSettings() {
        
        UserUseCase.getUserSettings(onComplete: { [weak self] user, currencies in
            DispatchQueue.main.async {
                guard let weakSelf = self else { return }
                weakSelf.userSettingsV.userAndCurrency = (user,currencies)
            }
        }) {
            // TODO: Present native alert informing about the error.
        }

    }

}
