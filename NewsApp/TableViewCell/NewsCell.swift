//
//  NewsCell.swift
//  NewsApp
//
//  Created by Aayushi Bhagat on 12/10/23.
//

import UIKit

class NewsCell: UITableViewCell {
  
  static let reuseIdentifier = "NewsCell"
  
  //MARK: - IBOutlets
  
  @IBOutlet weak var titleLabel: UILabel!
  @IBOutlet weak var descriptionLabel: UILabel!
  @IBOutlet weak var authorLabel: UILabel!
  @IBOutlet weak var publishedByLabel: UILabel!
  @IBOutlet weak var newsImageView: UIImageView!
  
  override func awakeFromNib() {
    super.awakeFromNib()
  }
  
  override func setSelected(_ selected: Bool, animated: Bool) {
    super.setSelected(selected, animated: animated)
  }
  
  func configureData(data: Articles) {
    titleLabel.text = data.title
    descriptionLabel.text = data.content
    if let author = data.author {
      self.authorLabel.text = author.isEmpty ? "" : "by \(author)"
    }
    publishedByLabel.text = String().UTCToLocal(dateStr: data.publishedAt)
    newsImageView.setImage(data.urlToImage ?? "", placeholderImage: UIImage(named: "placeholder"))
  }
}
