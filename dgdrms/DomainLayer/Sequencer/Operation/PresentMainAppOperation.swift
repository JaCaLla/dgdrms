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

            MainFlowCoordinator.shared.start()
            self.state = .Finished
        }
    }
}
