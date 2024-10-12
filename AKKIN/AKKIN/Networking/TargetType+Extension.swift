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
            "Authorization": "Bearer eyJhbGciOiJIUzUxMiJ9.eyJlbWFpbCI6ImppeXV1bkBnbWFpbC5jb20iLCJyb2xlcyI6WyJST0xFX0FETUlOIl0sImlhdCI6MTcyODI0NDIwMSwiZXhwIjoxOTQ5MDAzNDAxfQ.PLTuT8wkehSPGACzRxiNTmmbE27kkd0f2mEOuYXXFgXgU-m18OlBeHvLgGTMvPz4fu8a9qmRd7WG7jd7dDmVbw"
        ]
        return header
    }
}
