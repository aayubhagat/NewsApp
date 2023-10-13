//
//  NewsViewModel.swift
//  NewsApp
//
//  Created by Aayushi Bhagat on 12/10/23.
//

import Foundation
import CoreData
import Reachability

class NewsViewModel {
  
  // MARK: - Properties
  
  private var apiService = APIService()
  
  var newsModelData: [Articles]? {
    didSet {
      self.bindViewModelToController()
    }
  }
  
  var bindViewModelToController: (() -> ()) = {}
  
  private func saveNewsToCoreData(_ model: Articles) {
    let entity = NSEntityDescription.entity(forEntityName: "News", in: appDelegate.persistentContainer.viewContext)
    let news = NSManagedObject(entity: entity!, insertInto: appDelegate.persistentContainer.viewContext)
    news.setValue(model.content, forKey: "content")
    news.setValue(model.title, forKey: "title")
    news.setValue(model.urlToImage, forKey: "image")
    news.setValue(model.author, forKey: "author")
    news.setValue(model.url, forKey: "detailUrl")
    news.setValue(model.publishedAt, forKey: "publishedAt")
    
    do {
      try appDelegate.persistentContainer.viewContext.save()
    } catch {
      print("Failed saving")
    }
  }
  
  func fetchNewsFromCoreData() {
    do {
      let request = NSFetchRequest<NSFetchRequestResult>(entityName: "News")
      let news = try appDelegate.persistentContainer.viewContext.fetch(request) as! [News]
      var model = [Articles]()
      for data in news {
        model.append(Articles(data.title ?? "", author: data.author ?? "", content: data.content ?? "", urlToImage: data.image ?? "", url: data.detailUrl ?? "", publishedAt: data.publishedAt ?? ""))
      }
      self.newsModelData = model
    }
    catch {
    }
  }
  
  // MARK: - API
  
  func getNewsList() {
    let reachability = try! Reachability()
    if reachability.connection == .unavailable {
      fetchNewsFromCoreData()
    } else {
      apiService.getNewsList() { news in
        self.newsModelData = news
        self.newsModelData?.forEach({ latestNews in
          self.saveNewsToCoreData(latestNews)
        })
      }
    }
  }
}
