//
//  MakePiggyBankAPI.swift
//  AKKIN
//
//  Created by 신종원 on 10/6/24.
//

import Foundation
import Moya

enum MakePiggyBankAPI {
    case postPiggyBank(request: MakePiggyBankRequest)
}

extension MakePiggyBankAPI: TargetType {
    
    var path: String {
        switch self {
        case .postPiggyBank:
            return URLConst.piggyBank
        }
    }

    var method: Moya.Method {
        switch self {
        case .postPiggyBank:
            return .post
        }
    }

    var task: Moya.Task {
        switch self {
        case .postPiggyBank(let request):
            return .requestJSONEncodable(request)
        }
    }
}

