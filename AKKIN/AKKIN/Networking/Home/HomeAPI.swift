//
//  HomeAPI.swift
//  AKKIN
//
//  Created by 성현주 on 10/6/24.
//

import Foundation
import Moya

enum HomeAPI {
    case getExpenseSummary(type: String)
}

extension HomeAPI: TargetType {
    var path: String {
        switch self {
        case .getExpenseSummary:
            return URLConst.homeExpensesSummary
        }
    }

    var method: Moya.Method {
        switch self {
        case .getExpenseSummary:
            return .get
        }
    }

    var task: Moya.Task {
        switch self {
        case .getExpenseSummary(let type):
            return .requestParameters(parameters: ["type": type], encoding: URLEncoding.queryString)
        }
    }

//    //헤더에 임의로 추가해뒀습니다 
//    var headers: [String: String]? {
//        return [
//            "Content-Type": "application/json",
//            "Authorization": "Bearer eyJhbGciOiJIUzUxMiJ9.eyJlbWFpbCI6ImpyNm52eTg2eDVAcHJpdmF0ZXJlbGF5LmFwcGxlaWQuY29tIiwicm9sZXMiOlsiUk9MRV9VU0VSIl0sImlhdCI6MTczMTIzODEzOCwiZXhwIjoxNzMxMjQ1MzM4fQ.f55h7wNHtXNPQ42iqrbrYxGonfhmD8ONuG5J1YhBfnj00qUQzPBq3FE7QE6h6w7ytyi7rraXwx8bhpIbV0oIdg"
//        ]
//    }
}
