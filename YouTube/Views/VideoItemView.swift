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

struct VideoItemView: View {
  
  let video: ObjectVideo
  
  
  var body: some View {
    VStack {
      Image("preview")
        .resizable()
        .scaledToFit()
        .clipped()
      HStack(spacing: 10) {
        Image("preview")
          .resizable()
          .frame(width: 50, height: 50, alignment: .center)
          .clipShape(Circle())
        VStack(alignment: .leading, spacing: 5) {
          Text("sdgasgdadsgasdg sdasdfads sfasdf \n g sgd sgs gd sdg sdg sg s dgs dgs dg sdg sg sg s dgsd gs dg ").font(.subheadline).lineLimit(2)
          Text("sdgasgdadsgasdg").padding(.leading, 5)
          .font(.caption)
        }
      }.padding(.horizontal, 5)
    }
  }
  
  init(_ video: ObjectVideo) {
    self.video = video
  }
}

struct FeedItemView_Previews: PreviewProvider {
  static var previews: some View {
    VideoItemView()
  }
}
