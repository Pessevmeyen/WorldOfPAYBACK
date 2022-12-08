//
//  MockAPI.swift
//  WorldOfPAYBACK
//
//  Created by Furkan Eruçar on 5.12.2022.
//

import Foundation

//class MockApiFilesLoader {
//
////    func loadApiFiles() -> [Transactions] {
////        let paths = Bundle.main.paths(forResourcesOfType: "json", inDirectory: "")
////        let mockPaths = paths.filter { $0.components(separatedBy: "/").last?.hasPrefix("@Mock") == true }
////        return mockPaths.compactMap { generateModel(for: $0) }
////    }
////
////    private func generateModel(for path: String) -> Transactions? {
////        guard let data = try? Data(contentsOf: URL(fileURLWithPath: path)),
////              let mockyJSON = try? JSONDecoder().decode(MockyJSON.self, from: data)
////        else { return nil }
////        return Transactions(items: [Item])
////    }
//
//}

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
        randomInt = 2
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


