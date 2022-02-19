//
//  AuthView.swift
//  Chat2chat
//
//  Created by Oleksiy on 27.04.2021.
//

import UIKit

protocol AuthView: UIView {
    func setTextFieldDelegate(delegate: UITextFieldDelegate)
    func getTextField(tag: Int) -> UITextField?
    func addConstrains()
}
