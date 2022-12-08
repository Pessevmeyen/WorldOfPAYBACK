//
//  Alert.swift
//  WorldOfPAYBACK
//
//  Created by Furkan Eruçar on 6.12.2022.
//

import Foundation

enum Alert {
    
    enum Fetch {
        
        struct Request {
            let alertTitle: String?
            let alertMessage: String?
            let actionTitle: String?
        }
        
        struct Response {
            let alertTitle: String?
            let alertMessage: String?
            let actionTitle: String?
        }
    }
}
