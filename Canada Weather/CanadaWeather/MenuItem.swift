//
//  MenuItem.swift
//  XMLParsingDemo
//
//  Created by Jeya Balaji on 02/11/16.
//  Copyright © 2016. All rights reserved.
//

import Foundation
import CoreData

class MenuItem: NSManagedObject {
    @NSManaged var name:String?
    @NSManaged var detail:String?
    @NSManaged var price:String?
//    @NSManaged var url:String?
//    @NSManaged var city:String?
//    @NSManaged var province:String?
    
}