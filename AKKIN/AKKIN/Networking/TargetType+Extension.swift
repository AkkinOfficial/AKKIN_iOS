//
//  TargetType+Extension.swift
//  AKKIN
//
//  Created by MK-Mac-413 on 2023/09/04.
//

import Foundation

import Moya

extension TargetType {
    var baseURL: URL {
        //TODO: - baseURL congfig로 이동
        URL(string: URLConst.base)!
    }
    
    var headers: [String : String]? {
        let header = [
            "Content-Type": "application/json",
            "Authorization": "Bearer eyJhbGciOiJIUzUxMiJ9.eyJlbWFpbCI6ImpyNm52eTg2eDVAcHJpdmF0ZXJlbGF5LmFwcGxlaWQuY29tIiwicm9sZXMiOlsiUk9MRV9VU0VSIl0sImlhdCI6MTczMTIzODEzOCwiZXhwIjoxNzMxMjQ1MzM4fQ.f55h7wNHtXNPQ42iqrbrYxGonfhmD8ONuG5J1YhBfnj00qUQzPBq3FE7QE6h6w7ytyi7rraXwx8bhpIbV0oIdg"
        ]
        return header
    }
}
