//
//  CircleImage.swift
//  Landmarks
//
//  Created by Александр Гаврилов on 06.08.2022.
//

import SwiftUI

struct CircleImage: View {
    var body: some View {
        Image("DMC")
            .clipShape(Circle())
            .overlay {
                Circle().stroke(.white, lineWidth: 4)
            }
            .shadow(radius: 7)
    }
}

struct CircleImage_Previews: PreviewProvider {
    static var previews: some View {
        CircleImage()
    }
}
