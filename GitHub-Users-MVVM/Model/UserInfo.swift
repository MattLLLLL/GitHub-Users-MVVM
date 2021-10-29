//
//  UserInfo.swift
//  GitHub-Users-MVVM
//
//  Created by Matt Liu on 2021/10/29.
//

import Foundation

struct UserInfo: Codable {
    var name: String? 
    var location: String?
    var blog: String?
    var avatar_url: String?
    var login: String?
    var followers: Int?
    var following: Int?
    var email: String?
}
