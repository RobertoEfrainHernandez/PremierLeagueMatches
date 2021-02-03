//
//  SVGImageSupport.swift
//  PremierLeagueMatches
//
//  Created by Roberto Hernandez on 1/26/21.
//

import SwiftUI
import SDWebImageSVGCoder

struct SVGImage: UIViewRepresentable {
  let url: URL
  
  func makeUIView(context: Context) -> UIImageView {
    let SVGCoder = SDImageSVGCoder.shared
    SDImageCodersManager.shared.addCoder(SVGCoder)
    let imageView = ScaledHeightImageView()
    imageView.sd_setImage(with: url)
    imageView.contentMode = .scaleAspectFit
    return imageView
  }
  
  func updateUIView(_ uiView: UIImageView, context: Context) {}
}

class ScaledHeightImageView: UIImageView {
  override var intrinsicContentSize: CGSize {
    if let myImage = self.image {
      let myImageWidth = myImage.size.width
      let myImageHeight = myImage.size.height
      let myViewWidth = self.frame.size.width
      
      let ratio = myViewWidth/myImageWidth/2
      let scaledHeight = myImageHeight * ratio
      
      return CGSize(width: myViewWidth, height: scaledHeight)
    }
    
    return CGSize(width: -1.0, height: -1.0)
  }
}
