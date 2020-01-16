//  MIT License

//  Copyright (c) 2020 Haik Aslanyan

//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:

//  The above copyright notice and this permission notice shall be included in all
//  copies or substantial portions of the Software.

//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
//  SOFTWARE.

import SwiftUI
import Combine

class FeedManager: ObservableObject {
  
  @Published var mode = Mode.fetching
  @Published var items = [ObjectVideo]()
  
  func fetchItems() {
    let parameters =  ["part": "contentDetails", "chart": "mostPopular", "regionCode": "US", "maxResults": "50"]
    fetch(of: ObjectFeed.self, parameters:  parameters) {[weak self] result in
      switch result {
        case .success(let feedItems):
          let ids = String(feedItems.map{$0.id}.reduce("", {$0 + "," + $1}).dropFirst().dropLast())
          self?.fetch(of: ObjectVideo.self, parameters: ["part": "snippet", "id": ids], completion: {[weak self] response in
            switch response {
              case .failure(_):
                DispatchQueue.main.async {[weak self] in
                  self?.mode = .error
              }
              case .success(let videoItems):
                DispatchQueue.main.async {[weak self] in
                  self?.items = videoItems
                  self?.mode = .completed
              }
            }
          })
        case .failure(_):
          DispatchQueue.main.async {[weak self] in
            self?.mode = .error
        }
      }
    }
  }
  
  
  private func fetch<T: Decodable>(of type: T.Type, parameters: [String: Any], completion: @escaping (Result<[T], NetworkError>) -> Void) {
    URLSession.shared.dataTask(with: URLBuilder.url(parameters: parameters)) { (data, _, _) in
      guard let data = data else { completion(.failure(NetworkError())); return }
      let decoder = JSONDecoder()
      decoder.dateDecodingStrategy = .formatted(DateFormatter.iso8601Full)
      guard let item = try? decoder.decode(ObjectContainer<T>.self, from: data) else {
        completion(.failure(NetworkError()))
        return
      }
      completion(.success(item.items))
    }.resume()
  }
  
  init() {}
}

extension FeedManager {
  enum Mode {
    case fetching
    case error
    case completed
  }
  
  private struct NetworkError: Error {}
}
