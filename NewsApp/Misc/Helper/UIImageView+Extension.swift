//
//  UIImageView+Extension.swift
//  NewsApp
//
//  Created by Aayushi Bhagat on 12/10/23.
//

import Foundation
import Kingfisher

extension UIImageView {
  
  func setImage(with url: URL) {
    self.kf.indicatorType = .activity
    self.kf.setImage(with: url)
  }
  
  func setImage(with url: URL, size: CGSize) {
    
    let processor = ResizingImageProcessor(referenceSize: size, mode: .aspectFill)
    
    self.kf.indicatorType = .activity
    self.kf.setImage(with: url, options: [.processor(processor)])
  }
  
  func cancelDownload() {
    self.kf.cancelDownloadTask()
  }
  
  func setImageWithPlaceholder(with url: URL?, placeholderImage: UIImage) {
    self.kf.setImage(with: url, placeholder: placeholderImage)
  }
  
  func setImage(_ imageUrl: String, placeholderImage: UIImage?, indicatorType: IndicatorType = .activity) {
    self.kf.indicatorType = indicatorType
    self.kf.setImage(
      with: URL.init(string: imageUrl.encodedURL()),
      placeholder: placeholderImage ?? nil,
      options: nil,
      progressBlock: nil) { //(image, error, type, url) in
        result in
        switch result {
        case .success(_):
          break
          
        case .failure(_):
          break
        }
      }
  }
  
}
