//
//  NewsViewController.swift
//  NewsApp
//
//  Created by Aayushi Bhagat on 12/10/23.
//

import UIKit
import CoreData

class NewsViewController: UIViewController {
  
  // MARK: - IBOutlets
  
  @IBOutlet weak var tableView: UITableView!
  
  // MARK: - Properties
  
  let viewModel = NewsViewModel()
  
  // MARK: - ViewController's View Lifecycle
  
  override func viewDidLoad() {
    super.viewDidLoad()
    configureUI()
    bindingData()
  }
  
  // MARK: - Private Methods
  
  private func configureUI () {
    viewModel.getNewsList()
  }
  
  private func bindingData() {
    viewModel.bindViewModelToController = {
      self.tableView.reloadData()
    }
  }
  
}

// MARK: - UITableViewDataSource

extension NewsViewController: UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    viewModel.newsModelData?.count ?? 0
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard let newsCell = tableView.dequeueReusableCell(withIdentifier: NewsCell.reuseIdentifier) as? NewsCell else { return UITableViewCell() }
    
    guard let item = viewModel.newsModelData?[indexPath.row] else { return newsCell }
    newsCell.configureData(data: item)
    return newsCell
  }
}

// MARK: - UITableViewDelegate

extension NewsViewController: UITableViewDelegate {
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    let detailViewController = self.storyboard?.instantiateViewController(withIdentifier: "DetailViewController") as! DetailViewController
    detailViewController.viewModel.url = viewModel.newsModelData?[indexPath.row].url
    self.navigationController?.pushViewController(detailViewController, animated: true)
  }
}
