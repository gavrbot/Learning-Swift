//
//  Contact.swift
//  Contacts
//
//  Created by Александр Гаврилов on 19.02.2022.
//

import Foundation

protocol ContactProtocol {
    var title: String { get set }
    var phone: String { get set }
}

struct Contact: ContactProtocol {
    var title: String
    var phone: String
}

// создаём протокол, который укажем во ViewController. Это позволит нам менять его реализацию без надобности переписывания кода, к примеру можно будет создать реализацию хранилища через CoreData, при этом код во ViewController не изменится
protocol ContactStorageProtocol {
    // загрузка контактов
    func load() -> [ContactProtocol]
    // сохранение контактов
    func save(contacts: [ContactProtocol])
}

class ContactStorage: ContactStorageProtocol {
    // ссылка на хранилище
    private var storage = UserDefaults.standard
    // ключ, по которому будет происходить сохранение хранилища
    private var storageKey = "contacts"
    
    // перечисление с ключами для записи в User Defaults
    private enum ContactKey: String {
        case title
        case phone
    }
    
    // происходит операция, обратная в save(), мы преобразуем массив словарей String:String в массив ContactProtocol
    func load() -> [ContactProtocol] {
        var resultContacts: [ContactProtocol] = []
        let contactsFromStorage = storage.array(forKey: storageKey) as? [[String:String]] ?? []
        for contact in contactsFromStorage {
            guard let title = contact[ContactKey.title.rawValue],
                  let phone = contact[ContactKey.phone.rawValue] else {
                      continue
                  }
            resultContacts.append(Contact(title: title, phone: phone))
        }
        return resultContacts
    }
    
    // здесь мы преобразуем структуру контакт в словарь String:String, который уже можно будет записать в UserDefaults.storage
    func save(contacts: [ContactProtocol]) {
        var arrayForStorage: [[String:String]] = []
        contacts.forEach{ contact in
            var newElementForStorage: Dictionary<String, String> = [:]
            newElementForStorage[ContactKey.title.rawValue] = contact.title
            newElementForStorage[ContactKey.phone.rawValue] = contact.phone
            arrayForStorage.append(newElementForStorage)
        }
        storage.set(arrayForStorage, forKey: storageKey)
    }
}
