//
//  MainFlowCoordinator.swift
//  tempos21test
//
//  Created by 08APO0516 on 18/01/2018.
//  Copyright © 2018 jca. All rights reserved.
//

import Foundation
import UIKit

class  MainFlowCoordinator {

    // MARK: - Singleton handler
    static let shared =  MainFlowCoordinator()

    var mainNC:MainNC = MainNC.instantiate(fromAppStoryboard: .main)

    // MARK: - Public/Helpers
    func start() {

        self.presentMain()
    }

    // MARK: - Private / Internal
    func presentMain() {
        DispatchQueue.main.async {

            let mainVC = MainVC.instantiate(fromAppStoryboard: .main)
            /*
             pointsListPresenter.onSeletedDetailedPoint = { [weak self] detailedPoint in
             guard let weakSelf = self else { return }
             weakSelf.present(detailedPoint: detailedPoint)
             }
             */
            self.mainNC.viewControllers = [mainVC]

            if let appDelegate  = UIApplication.shared.delegate as? AppDelegate,
                let window = appDelegate.window {
                window.rootViewController = self.mainNC
            } else {
                print("Therse no ViewController set as initial in main.storyboard")
            }
        }
    }
    /*
     func present(detailedPoint:Point) {
     let detailPointPresenter = DetailPointPresenter.instantiate(fromAppStoryboard: .main)
     detailPointPresenter.detailPoint = detailedPoint
     self.mainNC.pushViewController(detailPointPresenter, animated: true)
     }*/
}
