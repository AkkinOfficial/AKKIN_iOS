//
//  AddExpenseModel.swift
//  AKKIN
//
//  Created by 성현주 on 9/22/24.
//

import Foundation
import UIKit

class ExpenseInfo {
    static let shared = ExpenseInfo()
    var icon: String?
    var amount: String = ""
    var category: String = ""
    var content: String = ""
    var memo: String = ""
    var date: String = ""
    private init() { }
}
