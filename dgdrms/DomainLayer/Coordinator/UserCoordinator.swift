//
//  MainFlowCoordinator.swift
//  dgdrms
//
//  Created by 08APO0516 on 18/01/2018.
//  Copyright © 2018 jca. All rights reserved.
//

import Foundation
import UIKit

class  UserCoordinator {

    // MARK: - Singleton handler
    static let shared =  UserCoordinator()

    var userNC:UserNC = UserNC.instantiate(fromAppStoryboard: .user)

    // MARK: - Public/Helpers
    @discardableResult func start() -> UIViewController {

       return self.presentUserSettings()
    }

    // MARK: - Private / Internal
    func presentUserSettings() -> UIViewController {
      //  DispatchQueue.main.async {

            let userVC = UserSettingsVC.instantiate(fromAppStoryboard: .user)

            self.userNC.viewControllers = [userVC]

            return userNC
            /*
            if let appDelegate  = UIApplication.shared.delegate as? AppDelegate,
                let window = appDelegate.window {
                window.rootViewController = self.mainNC
            } else {
                print("Therse no ViewController set as initial in main.storyboard")
            }*/
       // }
    }

}
