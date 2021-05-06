//
//  Comment.swift
//  Bitirme
//
//  Created by Başak Ertuğrul on 6.05.2021.
//

import Foundation

class Comment {
    var id: String
    var name: String
    var commentText: String

    init(id: String, name: String, email: String, commentText: String) {
        self.id = id
        self.name = name
        self.commentText = commentText
    }
}
