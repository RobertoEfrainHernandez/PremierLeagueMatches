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
  @Binding var image: UIImage
  
  func makeUIView(context: Context) -> UIImageView {
    let SVGCoder = SDImageSVGCoder.shared
    SDImageCodersManager.shared.addCoder(SVGCoder)
    let imageView = UIImageView()
    imageView.sd_setImage(with: url)
    guard let image = imageView.image else { preconditionFailure("Invalid Image") }
    self.image = image
    return imageView
  }
  
  func updateUIView(_ uiView: UIImageView, context: Context) {
    
  }
}
