//
//  File 2.swift
//  
//
//  Created by Philip on 27.10.2023.
//

import Alamofire
import Foundation

struct BearerAuthenticationInterceptor: RequestInterceptor {

    let accessToken = "eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiJmNDM2ZmUwYWU0NWY0MTU1YzUzNjdiOGE2NTdjNGY1MSIsInN1YiI6IjY1MzI3YTlkZWZlMzdjMDEzYjQ1ZWNmMiIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.XuG0avH-4kWNCAWxCYprHvboYoNtSupvJu1DpwvxkLM"

    func adapt(_ urlRequest: URLRequest, for session: Session, completion: @escaping (Result<URLRequest, Error>) -> Void) {
        var urlRequest = urlRequest
        urlRequest.headers.add(.authorization(bearerToken: accessToken))
        completion(.success(urlRequest))
    }
}
