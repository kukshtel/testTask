//
//  NetworkService.swift
//  IKTestTask
//
//  Created by Kukshtel I. on 8/5/19.
//  Copyright © 2019 Kukshtel I. All rights reserved.
//

import Foundation


protocol NetworkServiceProtocol {
    
    func searchRequest(text: String, completion: @escaping ([ITunesStoreModel])-> Void)
    
}

class NetworkService: NetworkServiceProtocol {
    
    weak var task: URLSessionDataTask?
    
    func searchRequest(text: String, completion: @escaping ([ITunesStoreModel])-> Void) {
        
        task?.cancel()
        
        var components = URLComponents()
        components.scheme = "https"
        components.host = "itunes.apple.com"
        components.path = "/search"
        components.queryItems = [
            URLQueryItem(name: "term", value: text)
        ]
        guard let url = components.url else { return }
        let session = URLSession.shared
        
        let newTask = session.dataTask(with: url) { (data, response, error) in
            if let data = data {
                do {
                    let json = try JSONSerialization.jsonObject(with: data, options: []) as! [String : AnyObject]
                    if let searchResults = json["results"] as? [[String: AnyObject]] {
                        let models = ITunesStoreModelParser.parse(json: searchResults)
                        DispatchQueue.main.async {
                            completion(models.sorted(by: { (first, second) -> Bool in
                                return first.name < second.name }))
                        }
                    }
                } catch {
                    print(error)
                }
            }
            if error != nil {
                print(error!.localizedDescription)
            }
        }

        task = newTask
        task?.resume()
        
    }
}

struct ITunesStoreModelParser {
        
        static func parse(json: [[String: AnyObject]]) -> [ITunesStoreModel] {
            var resultArray = [ITunesStoreModel]()
            for dict in json {
                guard let name = dict["trackName"] as? String else { continue }
                guard let kind = dict["kind"] as? String else { continue }
                guard let image = dict["artworkUrl100"] as? String else { continue }
                let resultModel = ITunesStoreModel(name: name, kind: kind, imageUrl: image)
                resultArray.append(resultModel)
            }
        return resultArray
        }
        
}
