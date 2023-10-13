//
//  APIService.swift
//  NewsApp
//
//  Created by Aayushi Bhagat on 12/10/23.
//

import Foundation

class APIService {
  
  func getNewsList(completion: @escaping ([Articles]) -> ()) {
    
    let apiUrl = "https://newsapi.org/v2/top-headlines?country=us&apiKey=1afb4edce8b34a0bb29c53965712864a"
    let url = URL(string: apiUrl)!
    URLSession.shared.dataTask(with: url) { (data, response, error) in
      
      DispatchQueue.main.async {
        if let error = error {
          print(error.localizedDescription)
          return
        }
        
        guard let data = data else {
          print("Invalid data or response")
          return
        }
        
        do {
          let items = try JSONDecoder().decode(NewsModel.self, from: data)
          completion(items.articles)
        } catch {
          print(error.localizedDescription)
        }
      }
    } .resume()
  }
  
}
