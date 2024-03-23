//
//  DocumentsImageView.swift
//  MyCarrrr
//
//  Created by Сергей Васильев on 23.03.2024.
//

import Foundation
import SwiftUI

struct DocumentsImageView: View {
    
    @State var image: UIImage
    
    var body: some View {
        Image(uiImage: image)
            .resizable()
            .frame(width: 100, height: 100)
    }
}
