//
//  MakePiggyBankModel.swift
//  AKKIN
//
//  Created by 신종원 on 10/6/24.
//

import Foundation
import UIKit

class MakePiggyBankInfo {
    static let shared = MakePiggyBankInfo()
    var startDate: String?
    var endDate: String?
    var goalAmount: Int = 0
    var name: String = ""
    var memo: String = ""
    var emoji: String = ""

    private init() { }
}
