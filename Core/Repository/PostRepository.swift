//
//  PostRepository.swift
//  otoklixSubmition
//
//  Created by Developer Xabdaz on 16/01/22.
//

import Foundation
enum PostRepository {
    class GetPost: ApiRequest<PostResponse> {
        init() {
            super.init(resource: "posts")
        }
    }
}
