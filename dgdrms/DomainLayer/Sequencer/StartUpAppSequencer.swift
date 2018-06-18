//
//  StartUpAppSequencer.swift
//
//

import Foundation
import UIKit

class  StartUpAppSequencer {

    static let shared =  StartUpAppSequencer()

    fileprivate let operationQueue = OperationQueue()

    private init() {} //This prevents others from using the default '()' initializer for this class.

    func start() {
        let presentMainAppOperation = PresentMainAppOperation()

        let operations = [presentMainAppOperation]

        // Add operation dependencies
        operationQueue.addOperations(operations, waitUntilFinished: false)
    }
}
