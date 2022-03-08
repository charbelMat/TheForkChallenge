//
//  NetworkManager.swift
//  The Fork
//
//  Created by Charbel Mattar on 08/03/2022.
//

import Foundation
import Alamofire
import SwiftyJSON

/**
 RestaurantsDataModel used to make network requests
*/

public class NetworkManager {
    
    static let shared = NetworkManager()
    
    // MARK: - perform a get request
    
    func get(url: String, completion: @escaping (JSON?) -> Void) {

        AF.request(url, method: .get).validate().responseData { response in
            if let data = response.data {
                let json = try? JSON(data: data)
                completion(json)
            }else{
                completion(nil)
            }
        }
    }
    
}
