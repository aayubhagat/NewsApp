//
//  NewsModel.swift
//  NewsApp
//
//  Created by Aayushi Bhagat on 12/10/23.
//

import Foundation

struct NewsModel: Decodable {
  var articles: [Articles]!
}

struct Articles: Decodable {
  var title : String!
  var author: String!
  var content: String!
  var urlToImage: String!
  var url: String!
  var publishedAt: String!
  
  init(_ title: String, author: String, content: String, urlToImage: String, url: String, publishedAt: String) {
    self.title = title
    self.author = author
    self.content = content
    self.urlToImage = urlToImage
    self.url = url
    self.publishedAt = publishedAt
  }
  
}
