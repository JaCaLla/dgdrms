//
//  MainFlowCoordinator.swift
//  dgdrms
//
//  Created by 08APO0516 on 18/01/2018.
//  Copyright © 2018 jca. All rights reserved.
//

import Foundation
import UIKit

class  VehicleListCoordinator {

    // MARK: - Singleton handler
    static let shared =  VehicleListCoordinator()

    var vehicleListNC:VehicleListNC = VehicleListNC.instantiate(fromAppStoryboard: .vehicleList)

    // MARK: - Public/Helpers
    @discardableResult func start() -> UIViewController {

       return self.presentUserSettings()
    }

    // MARK: - Private / Internal
    func presentUserSettings() -> UIViewController {
      //  DispatchQueue.main.async {

            let vehicleListPresenter = VehicleListPresenter.instantiate(fromAppStoryboard: .vehicleList)

            self.vehicleListNC.viewControllers = [vehicleListPresenter]

            return vehicleListNC
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
