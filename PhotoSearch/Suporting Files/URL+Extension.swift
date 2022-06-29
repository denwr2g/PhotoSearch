//
//  URL+Extension.swift
//  PhotoSearch
//
//  Created by deniss.lobacs on 16/05/2022.
//

import Foundation

public func withCategory(_ category: String) -> URL? {
    var urlComponents = URLComponents()
    urlComponents.scheme = "https"
    urlComponents.host = "pixabay.com"
    urlComponents.path = "/api"
    
    urlComponents.queryItems = [
        URLQueryItem(name: "key", value: "27439897-fae459fea4d7dd9cfe502e801"),
        URLQueryItem(name: "q", value: category),
        URLQueryItem(name: "image_type", value: "photo"),
        URLQueryItem(name: "per_page", value: "20")
    ]
    
    return urlComponents.url
}


