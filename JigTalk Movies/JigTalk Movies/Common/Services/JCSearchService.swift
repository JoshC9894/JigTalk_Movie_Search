//
//  JCSearchService.swift
//  JigTalk Movies
//
//  Created by Joshua Colley on 22/01/2020.
//  Copyright © 2020 Joshua Colley. All rights reserved.
//

import Foundation

protocol JCSearchServiceProtocol {
    func search(query: String, completion: @escaping (JCServerResponse<[JCSearchResult]>) -> Void)
}

class JCSearchService: JCSearchServiceProtocol {
    static let shared: JCSearchServiceProtocol = JCSearchService()
    private let networkManager: JCNetworkManager = JCNetworkManager.shared
    
    func search(query: String, completion: @escaping (JCServerResponse<[JCSearchResult]>) -> Void) {
        let url = JCEndpoint.searchBy(title: query).path
        networkManager.request(url: url, type: .get) { (response) in
            switch response {
            case .success(let data):
                guard let models = try? JSONDecoder().decode([JCSearchResult].self, from: data) else {
                    completion(JCServerResponse.failed(JCServerError())); return
                }
                completion(JCServerResponse.success(models))
                
            case .failed(let error):
                completion(JCServerResponse.failed(error)); return
            }
        }
    }
}

struct JCEndpoint {
    let path: String
}

extension JCEndpoint {
    init(endpoint: String) {
        let key = JCEndpoint.getAPIKey()
        self.path = "http://www.omdbapi.com/?\(endpoint)&apikey=\(key)"
    }
    
    private static func getAPIKey() -> String {
        guard let key = Bundle.main.infoDictionary?["apiKey"] as? String else {
            return ""
        }
        return key
    }
}

extension JCEndpoint {
    static func searchBy(title: String) -> JCEndpoint {
        return JCEndpoint(endpoint: "t=\(title)")
    }
}
