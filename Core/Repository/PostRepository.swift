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

    class GetDetail: ApiRequest<EXPostModel> {
        init(id: String) {
            super.init(resource: "posts/\(id)")
        }
    }

    class DeleteDetail: ApiRequest<EXPostModel> {
        init(id: String) {
            super.init(resource: "posts/\(id)", method: .delete)
        }
    }

    class CreatePost: ApiRequest<EXPostModel> {
        init(params: [String: AnyObject]) {
            super.init(
                resource: "posts",
                method: .post,
                expectedCode: 200,
                json: params.json
            )
        }
    }

    class EditPost: ApiRequest<EXPostModel> {
        init(params: [String: AnyObject], id: String) {
            super.init(
                resource: "posts/\(id)",
                method: .put,
                expectedCode: 200,
                json: params.json
            )
        }
    }
}
