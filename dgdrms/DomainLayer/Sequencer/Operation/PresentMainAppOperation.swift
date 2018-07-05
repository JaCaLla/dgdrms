//
//  PresentMainAppOperation.swift
//
//
//

import Foundation
import UIKit

class PresentMainAppOperation: ConcurrentOperation {

    override init() {
        super.init()
    }

    override func main() {
        DispatchQueue.main.async {

            DispatchQueue.main.async {

                let mainTabBarController = MainTabBarController.instantiate(fromAppStoryboard: .main)
                mainTabBarController.viewControllers = [MainFlowCoordinator.shared.start(),
                UserCoordinator.shared.start(),
                VehicleListCoordinator.shared.start()]
                mainTabBarController.modalTransitionStyle = .crossDissolve
                
                
                
                let appDelegate  = UIApplication.shared.delegate as! AppDelegate
                appDelegate.window!.rootViewController?.present(mainTabBarController, animated: true, completion: nil)
                
                
                self.state = .Finished
            }
        }
    }
}
