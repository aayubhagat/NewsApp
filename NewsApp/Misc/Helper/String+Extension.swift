//
//  String+Extension.swift
//  NewsApp
//
//  Created by Aayushi Bhagat on 12/10/23.
//

import Foundation

extension String {
  func encodedURL() -> (String) {
    return self.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)!
  }
  
  func UTCToLocal(dateStr: String) -> String? {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
    dateFormatter.timeZone = TimeZone(abbreviation: "UTC")
    
    if let date = dateFormatter.date(from: dateStr) {
      dateFormatter.timeZone = TimeZone.current
      dateFormatter.dateFormat = "dd MMM yyyy hh:mm a"
      dateFormatter.amSymbol = "AM"
      dateFormatter.pmSymbol = "PM"
      
      return dateFormatter.string(from: date)
    }
    return nil
  }
}
