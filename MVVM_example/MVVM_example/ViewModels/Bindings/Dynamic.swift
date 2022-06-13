//
//  Dynamic.swift
//  MVVM_example
//
//  Created by Александр Гаврилов on 13.06.2022.
//

import Foundation

// dynamic - класс, который занимается биндингом пользовательского интерфейса и модели данных
class Dynamic<T> {
    typealias Listener = (T) -> Void
    private var listener: Listener?
    
    func bind(_ listener: Listener?) {
        self.listener = listener
    }
    
    var value: T {
        didSet {
            listener?(value)
        }
    }
    
    init(_ v: T) {
        value = v
    }
}
