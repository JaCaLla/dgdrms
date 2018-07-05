//
//  CurrencySelectorTVC.swift
//  dgdrms
//
//  Created by 08APO0516 on 27/06/2018.
//  Copyright © 2018 jca. All rights reserved.
//

import UIKit

class CurrencySelectorTVC: UITableViewCell {

    // MARK: - IBOutlet
     @IBOutlet weak var pckCurrencySelector: UIPickerView!
    
    // MARK: - Callback
    var onValueChanged: (String) -> Void = { _ in }
    
    // MARK: - Public attributes
    var currencies:[Currency] = [] {
        didSet {
            self._refreshView()
        }
    }
    
    var user:User? {
        didSet {
            self._refreshView()
        }
    }
    
    // MARK: - Lifecyle
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self._setupView()
    }

    // MARK: - Private/Internal
    func _setupView() {
        self.pckCurrencySelector.delegate  = self
        self.pckCurrencySelector.dataSource  = self
    }
    
    func _refreshView() {
        self.pckCurrencySelector.reloadAllComponents()
    }
}

// MARK: - UIPickerViewDataSource
extension CurrencySelectorTVC: UIPickerViewDataSource {
    
     func numberOfComponents(in pickerView: UIPickerView) -> Int {
          return 1
    }
    
     func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return currencies.count
    }
}

// MARK: - UIPickerViewDelegate
extension CurrencySelectorTVC: UIPickerViewDelegate {
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return currencies[row].coin
    }
}
