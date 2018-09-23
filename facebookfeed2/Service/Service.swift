//
//  Service.swift
//  facebookfeed2
//
//  Created by John Martin on 9/18/18.
//  Copyright © 2018 John Martin. All rights reserved.
//

import Foundation

struct Service {

    enum PostType: String {
        case single_post
        case all_posts
    }

    private let resourceDict: [PostType: String] =  [.single_post: "post", .all_posts: "posts"]

    static let shared = Service()

    private func fetch<T>(resource: PostType, completion: @escaping (_ postDictionary: T) -> Void) {
        guard let postKey = resourceDict[resource] else { return }
        if let path = Bundle.main.path(forResource: resource.rawValue, ofType: "json"), let data = try? NSData(contentsOfFile: path, options: .dataReadingMapped) {
            if let jsonDictionary = try? JSONSerialization.jsonObject(with: data as Data, options: .mutableContainers) as? [String: Any] {
                if let postDictionary = jsonDictionary?[postKey] as? T {
                    completion(postDictionary)
                }
            }
        }
    }

    func fetchSinglePost(completion: @escaping (_ postDictionary: [String: AnyObject]) -> Void) {
        fetch(resource: .single_post, completion: completion)
    }

    func fetchPosts(completion: @escaping (_ postDictionaries: [[String: AnyObject]]) -> Void ) {
        fetch(resource: .all_posts, completion: completion)
    }
}
