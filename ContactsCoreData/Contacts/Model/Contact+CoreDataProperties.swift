//
//  Contact+CoreDataProperties.swift
//  Contacts
//
//  Created by Александр Гаврилов on 23.06.2022.
//
//

import Foundation
import CoreData


extension Contact {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Contact> {
        return NSFetchRequest<Contact>(entityName: "Contact")
    }

    @NSManaged public var phone: String?
    @NSManaged public var title: String?

}

extension Contact : Identifiable {

}
