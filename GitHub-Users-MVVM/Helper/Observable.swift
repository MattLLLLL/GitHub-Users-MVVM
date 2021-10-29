//
//  Observable.swift
//  GitHub-Users-MVVM
//
//  Created by Matt Liu on 2021/10/29.
//

import Foundation

class Observable<T> {
    var value: T? {
        didSet {
            listener?(value)
        }
    }
    
    private var listener: ((T?) -> Void)?
    
    init(_ value: T?) {
        self.value = value
    }
    
    func bind(_ listener: @escaping (T?) -> Void) {
        //listener(value)
        self.listener = listener
    }
}
