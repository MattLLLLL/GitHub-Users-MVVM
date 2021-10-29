//
//  UserVM.swift
//  GitHub-Users-MVVM
//
//  Created by Matt Liu on 2021/10/29.
//

import Foundation



class UserViewModel {
    
    var users: Observable<[Users]> = Observable([])
    var userInfo: Observable<UserInfo> = Observable(nil)
        
    func getUsers(page: Int) {
        let url = URL(string: "https://api.github.com/users?&per_page=\(page)")
        var req = URLRequest(url: url!)
        req.httpMethod = "GET"
        
        URLSession.shared.dataTask(with: req) { data, res, error in
            if error != nil {
                return
            }
            do {
                let resData = try JSONDecoder().decode([Users].self, from: data!)
                self.users.value = resData
            } catch (let err) {
                print(err)
            }
        }.resume()
    }
    
    func getUserInfo(login: String) {
        let url = URL(string: "https://api.github.com/users/\(login)")
        var req = URLRequest(url: url!)
        req.httpMethod = "GET"
        
        URLSession.shared.dataTask(with: req) { data, res, error in
            if error != nil {
                return
            }
            do {
                let resData = try JSONDecoder().decode(UserInfo.self, from: data!)
                self.userInfo.value = resData
            } catch (let err) {
                print(err)
            }
        }.resume()
    }
}
