//
//  MockAPI.swift
//  WorldOfPAYBACK
//
//  Created by Furkan Eruçar on 5.12.2022.
//

import UIKit
import SwiftyJSON

struct NetworkManager {
    
    static let shared = NetworkManager()
    let decoder = JSONDecoder()
    
    private init() {}
    
    func fetch<T: Codable>(encode model: T.Type, completion: @escaping ((Result<T, Error>) -> Void)) { //bi şeyi fetch edicem ve buna T diyorum.
        
        var randomInt = Int.random(in: 1...10)
        print(randomInt)
        var realURL: URL?

        if randomInt % 2 == 0 {
            guard let path = Bundle.main.path(forResource: "transaction-response", ofType: "json") else { return }
            let url = URL(fileURLWithPath: path)
            realURL = url
        } else {
            realURL = URL(fileURLWithPath: "")
        }
        
        do {
            let data = try Data(contentsOf: realURL!, options: .alwaysMapped)
            let json = try decoder.decode(model.self, from: data)
            completion(.success(json))
        } catch {
            completion(.failure(error.self))
        }
    }
}


