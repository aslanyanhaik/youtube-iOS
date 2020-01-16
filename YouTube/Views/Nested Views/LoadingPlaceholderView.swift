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

struct LoadingPlaceholderView: View {
  
  @State var fillPoint = Double(0)
  
  
  var animation: Animation {
    Animation.linear(duration: 0.8).repeatForever(autoreverses: false)
  }
  
  
  var body: some View {
    Ring(fillPoint)
      .stroke(Color.red, lineWidth: 5)
      .frame(width: 100, height: 100, alignment: .center)
      .onAppear {
        withAnimation(self.animation) {
          self.fillPoint = 0.5
        }
    }
  }
}

struct LoadingPlaceholderView_Previews: PreviewProvider {
  static var previews: some View {
    LoadingPlaceholderView()
  }
}


struct Ring: Shape {
  
  var fillPoint: Double
    
  var animatableData: Double {
    get { fillPoint}
    set { fillPoint = newValue }
  }
  
  func path(in rect: CGRect) -> Path {
    let start = Double(0)
    let end = 360 * fillPoint
    var path = Path()
    path.addArc(center: CGPoint(x: rect.midX, y: rect.midY), radius: rect.width / 2, startAngle: .degrees(start), endAngle: .degrees(end), clockwise: false)
    return path
  }
  
  init(_ fillPoint: Double) {
    self.fillPoint = fillPoint
  }
  
  
}
