//
//  File.swift
//  
//
//  Created by Philip on 27.10.2023.
//

import Alamofire
import Foundation

final public class AlamofireClient: NetworkClienting {

    public init() {}

    public func execute<Response: Decodable>(request: URLRequest) async throws -> Response {
        print(request.url!)
        let result = await AF
            .request(request, interceptor: BearerAuthenticationInterceptor())
            .serializingData()
            .response
            .result
        do {
            switch result {
            case .success(let data):
                return try JSONDecoder().decode(Response.self, from: data)
            case .failure(let error):
                throw error
            }
        } catch {
            throw(error)
        }
    }
}
