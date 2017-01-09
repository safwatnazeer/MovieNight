//
//  BasicElements.swift
//  MovieNight
//
//  Created by Safwat Shenouda on 28/10/2016.
//  Copyright © 2016 Safwat Shenouda. All rights reserved.
//

import Foundation

struct Genre {
    let id: Int
    let name: String
}

struct Movie {
    let id: Int
    let title: String
}

struct Actor {
    let id: Int
    let name: String
    let profilePath: String
    
}

enum UsersList {
    case noOne
    case firstUser
    case secondUser
}

struct MovieVote {
    var title: String
    var vote1: Bool
    var vote2: Bool
}
