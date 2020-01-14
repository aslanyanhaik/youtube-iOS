//
//  PlaceholderView.swift
//  YouTube
//
//  Created by Haik Aslanyan on 1/14/20.
//  Copyright © 2020 Haik Aslanyan. All rights reserved.
//

import SwiftUI

struct PlaceholderView: View {
  
  let placeholder: ObjectPlaceholder
  
  
  var body: some View {
    ZStack {
      Color(.systemGray5).edgesIgnoringSafeArea(.all)
      VStack {
        NavigationHeaderView()
        VStack {
          Spacer()
          Image(systemName: placeholder.imageName)
            .resizable()
            .scaledToFit()
            .frame(width: 100, height: 150, alignment: .center)
            .padding(.bottom)
            .foregroundColor(Color(.systemGray2))
          Text(placeholder.titleText)
            .font(.headline)
            .fontWeight(.bold)
            .padding(.bottom)
          Text(placeholder.descriptionText)
            .font(.footnote)
            .foregroundColor(.gray)
            .multilineTextAlignment(.center)
            .padding(EdgeInsets(top: 0, leading: 30, bottom: 0, trailing: 30))
          if placeholder.shouldShowSignInButton {
            Button(action: {}) {
              Text("Sign In".uppercased()).fontWeight(.regular)
                .font(.headline)
                .padding(EdgeInsets(top: 10, leading: 18, bottom: 10, trailing: 18))
                .background(Color.blue)
                .cornerRadius(3)
                .foregroundColor(.black)
            }.padding()
          }
          Spacer()
        }
      }
    }
  }
}

struct PlaceholderView_Previews: PreviewProvider {
  static var previews: some View {
    PlaceholderView(placeholder: ObjectPlaceholder.library)
  }
}
