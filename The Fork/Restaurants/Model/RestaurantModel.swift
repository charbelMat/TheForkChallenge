//
//  RestaurantModel.swift
//  The Fork
//
//  Created by Charbel Mattar on 08/03/2022.
//

import RealmSwift

/**
Realm Object used to store the restaurant data
*/

public class RestaurantModel: Object {
    
    @objc dynamic var uuid: String  = ""
    @objc dynamic var name: String  = ""
    @objc dynamic var image: String = ""
    @objc dynamic var address: String  = ""
    @objc dynamic var rating: String = ""
    @objc dynamic var isFav: String = "0"
    
    public override class func primaryKey() -> String? {
        return "uuid"
    }
}
