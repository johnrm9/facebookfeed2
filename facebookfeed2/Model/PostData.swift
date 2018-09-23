//
//  PostData.swift
//  facebookfeed2
//
//  Created by John Martin on 9/22/18.
//  Copyright © 2018 John Martin. All rights reserved.
//

import Foundation

class PostData {
    private var posts = [Post]()

    init() {
        Service.shared.fetchPosts { (postDictionaries) in
            postDictionaries.forEach { (postDictionary) in
                let post = Post()
                post.setValuesForKeys(postDictionary)
                self.posts.append(post)
            }
        }
    }

    subscript(row: Int) -> Post {
        get {
            return posts[row]
        }
        set {
            posts[row] = newValue
        }
    }

    var count: Int {
        return posts.count
    }
}
//        Service.shared.fetchSinglePost { (postDictionary) in
//            let post = Post()
//            post.setValuesForKeys(postDictionary)
//            self.posts = [post]
//        }
//
//        Service.shared.fetchPosts { (postDictionaries) in
//            postDictionaries.forEach { (postDictionary) in
//                let post = Post()
//                post.setValuesForKeys(postDictionary)
//                self.posts.append(post)
//            }
//        }

//        let postMark = Post()
//        postMark.name = "Mark Zuckerberg"
//        postMark.statusText = "Meanwhile, Beast turned to the dark side."
//        postMark.profileImageName = "zuckprofile"
//        postMark.statusImageName = "zuckdog"
//        postMark.numLikes = 400
//        postMark.numComments = 123
//        postMark.location = Location(city: "Bumfuk Egypt" )
//        postMark.statusImageUrl = "https://s3-us-west-2.amazonaws.com/letsbuildthatapp/mark_zuckerberg_background.jpg"
//
//        let postSteve = Post()
//        postSteve.name = "Steve Jobs"
//        postSteve.statusText = """
//        Design is not just what it looks like and feels like. Design is how it works.
//
//        Being the richest man in the cemetery doesn't matter to me. Going to bed at night saying we've done something wonderful, that's what matters to me.
//
//        Sometimes when you innovate, you make mistakes. It is best to admit them quickly, and get on with improving your other innovations.
//        """
//        postSteve.profileImageName = "steve_profile"
//        postSteve.statusImageName = "steve_status"
//        postSteve.numLikes = 1000
//        postSteve.numComments = 5500
//        postSteve.location = Location(city: "Cupertino")
//        postSteve.statusImageUrl = "https://s3-us-west-2.amazonaws.com/letsbuildthatapp/steve_jobs_background.jpg"
//
//        let postGandhi = Post()
//        postGandhi.name = "Mahatma Gandhi"
//        postGandhi.statusText = "Live as if you were to die tomorrow; learn as if you were to live forever.\n" +
//            "The weak can never forgive. Forgiveness is the attribute of the strong.\n" +
//        "Happiness is when what you think, what you say, and what you do are in harmony."
//        postGandhi.profileImageName = "gandhi_profile"
//        postGandhi.statusImageName = "gandhi_status"
//        postGandhi.numLikes = 333
//        postGandhi.numComments = 10.7 * 1000 as NSNumber
//        postGandhi.location = Location(city: "Calcutta")
//        postGandhi.statusImageUrl = "https://s3-us-west-2.amazonaws.com/letsbuildthatapp/gandhi_status.jpg"

//        let postTim = Post()
//        postTim.name = "Tim Cook"
//        postTim.statusText = """
//                             The worst thing in the world that can happen to you if
//                             you're an engineer that has given his life to something
//                             is for someone to rip it off and put their name on it.
//                            """
//        postTim.profileImageName = "tim_profile"
//        //postTim.statusImageName = "tim_status"
//        postTim.numLikes = 528
//        postTim.numComments =  12.8 * 1000 as NSNumber
//        postTim.location = Location(city: "Cupertino")
//        postTim.statuImageUrl = "https://s3-us-west-2.amazonaws.com/letsbuildthatapp/tim_cook_status.jpg"

//        let postDon = Post()
//        postDon.name = "Donald J. Trump"
//        postDon.profileImageName = "don_profile"
//        postDon.statusText = "An ’extremely credible source’ has called my office and told me that Barack Obama’s birth certificate is a fraud."
//        postDon.statusImageName = nil
//        postDon.numLikes = 666
//        postDon.numComments = 13.99 * 1000 as NSNumber
//        postDon.location = Location(city: "Washington, DC")
//        postDon.statusImageUrl = "https://s3-us-west-2.amazonaws.com/letsbuildthatapp/donald_trump_status.jpg"
//
//        posts += [postMark]
//        posts += [postSteve]
//        posts += [postGandhi]
//        //        posts += [postTim]
//        posts += [postDon]
