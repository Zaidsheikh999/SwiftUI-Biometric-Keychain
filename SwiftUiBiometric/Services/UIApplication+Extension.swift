//
//  UIApplication+Extension.swift
//  SwiftUiBiometric
//
//  Created by Zaid Sheikh on 12/06/2023.
//

import UIKit

extension UIApplication {
    func endEditing() {
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
