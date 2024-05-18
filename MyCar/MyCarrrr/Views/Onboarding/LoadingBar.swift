//
//  LoadingBar.swift
//  MyCarrrr
//
//  Created by Сергей Васильев on 18.05.2024.
//

import Foundation
import SwiftUI

struct LoadingBar: View {
    
    var progress:CGFloat
    
    var body: some View {
        GeometryReader{ geometry in
            ZStack(alignment:.leading){
                Rectangle()
                    .foregroundColor(Color.red.opacity(0.5))
                    .cornerRadius(5)
                Rectangle().frame(width: geometry.size.width * self.progress,height: 10,alignment: .leading)
                    .foregroundColor(.blue)
                    .cornerRadius(5)
            }
        }
    }
}
