//
//  AddChallengesAPI.swift
//  AKKIN
//
//  Created by 성현주 on 10/8/24.
//

import Foundation
import Moya

enum AddChallengesAPI {
    case postChallenges(request: AddChallengesRequest)}

extension AddChallengesAPI: TargetType {
    var path: String {
        switch self {
        case .postChallenges:
            return URLConst.addChallenges
        }
    }

    var method: Moya.Method {
        switch self {
        case .postChallenges:
            return .post
        }
    }

    var task: Moya.Task {
        switch self {
        case .postChallenges(let request):
            return .requestJSONEncodable(request)
        }
    }

    var headers: [String: String]? {
        return [
            "Content-Type": "application/json",
            "Authorization": "Bearer eyJhbGciOiJIUzUxMiJ9.eyJlbWFpbCI6ImpyNm52eTg2eDVAcHJpdmF0ZXJlbGF5LmFwcGxlaWQuY29tIiwicm9sZXMiOlsiUk9MRV9VU0VSIl0sImlhdCI6MTczMTIzODEzOCwiZXhwIjoxNzMxMjQ1MzM4fQ.f55h7wNHtXNPQ42iqrbrYxGonfhmD8ONuG5J1YhBfnj00qUQzPBq3FE7QE6h6w7ytyi7rraXwx8bhpIbV0oIdg"
        ]
    }

}

