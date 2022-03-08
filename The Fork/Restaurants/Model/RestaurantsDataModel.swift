//
//  RestaurantsDataModel.swift
//  The Fork
//
//  Created by Charbel Mattar on 08/03/2022.
//

import Foundation
import RealmSwift
import SwiftyJSON
/**
Restaurants data model used to manipulate restaurant data from and out of the DB
*/

public class RestaurantsDataModel {
    
    static let shared = RestaurantsDataModel()
        
    // Get the default Realm
    let realm = try! Realm()
    
    // MARK: - add/update new restaurant
    
    public func addOrReplace(restaurant: RestaurantModel) {
        
        // Persist your data easily
        try! realm.write {
            if let localItem = self.getItem(uuid: restaurant.uuid){
                realm.delete(localItem)
            }
            realm.add(restaurant)
        }
    }
    
    public func getAllSortedBy(sortingType: String) -> Array<RestaurantModel> {
        
        var ascending = true
        if(sortingType == "rating"){
            ascending = false
        }
        let restaurants = realm.objects(RestaurantModel.self).sorted(byKeyPath: sortingType, ascending: ascending)
        
        return Array(restaurants);
    }
    
    public func getItem(uuid: String) -> RestaurantModel? {
        
        guard let restaurant = realm.object(ofType: RestaurantModel.self, forPrimaryKey: uuid) else { return nil }
        
        return restaurant;
    }
    
    public func setFavorite(uuid: String, isFav: String){
        
        guard let restaurant = realm.object(ofType: RestaurantModel.self, forPrimaryKey: uuid) else { return }
        try! realm.write {
            restaurant.isFav = isFav
        }
    }
    
    public func fetchRestaurants(completion: @escaping (Int) -> Void) {

        NetworkManager.shared.get(url: "https://alanflament.github.io/TFTest/test.json") { result in
            print(result as Any)
            if let data = result {
                let items = data["data"].arrayValue
                for item in items {
                    let uuid = item["uuid"].stringValue
                    let restaurant = RestaurantModel()
                    if let localRestaurant = self.getItem(uuid: uuid){
                        restaurant.isFav = localRestaurant.isFav
                    }
                    restaurant.uuid = uuid
                    restaurant.name = item["name"].stringValue
                    let address = item["address"].dictionaryValue
                    if let street = address["street"]{
                        restaurant.address = street.stringValue
                        if let postalCode = address["postalCode"]{
                            restaurant.address += " \(postalCode.stringValue)"
                        }
                        if let locality = address["locality"]{
                            restaurant.address += ", \(locality.stringValue)"
                        }
                    }
                    let aggregateRatings = item["aggregateRatings"].dictionaryValue
                    if let rating = aggregateRatings["thefork"] {
                        restaurant.rating = rating["ratingValue"].stringValue
                    }
                    let images = item["mainPhoto"].dictionaryValue
                    if let image = images["612x344"]{
                        restaurant.image = image.stringValue
                    }
                    self.addOrReplace(restaurant: restaurant)
                }
                completion(1)
                return
            }
            completion(0)
        }
    }
}

