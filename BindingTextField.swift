//
//  BindingTextField.swift
//  WeatherMVVM
//
//  Created by Jean Paull on 19/08/20.
//  Copyright © 2020 Jean Paull. All rights reserved.
//

import UIKit

class BindingTextField: UITextField {
    
    var textChangeClouser: (String)->() = {_ in }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    func bind(callback: @escaping(String)->Void){
        self.textChangeClouser = callback
    }
    
    func commonInit() {
        self.addTarget(self, action: #selector(self.textFieldChange(_:)), for: .editingChanged)
    }
    
    @objc func textFieldChange(_ textField:UITextField){
        if let text = textField.text {
            self.textChangeClouser(text)
        }
    }
    
}
