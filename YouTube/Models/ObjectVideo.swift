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

import Combine
import Foundation

struct ObjectVideo: Identifiable, Decodable {
  
  let id: String
  var imageURLString: String {
    "https://img.youtube.com/vi/\(id)/hqdefault.jpg"
  }
  var title: String {
    snippet.title
  }
  var description: String {
    snippet.description
  }
  var channelTitle: String {
    snippet.channelTitle
  }
  var channelId: String {
    snippet.channelId
  }
  lazy var publishedDate: String = {
    let formatter = DateFormatter()
    formatter.dateStyle = .short
    return formatter.string(from: snippet.publishedAt)
  }()
  private let snippet: ObjectSnippet
}

extension ObjectVideo {
  private struct ObjectSnippet: Decodable {
    let publishedAt: Date
    let channelId: String
    let title: String
    let description: String
    let channelTitle: String
  }
}




