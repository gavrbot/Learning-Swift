//
//  ContentView.swift
//  Landmarks
//
//  Created by Александр Гаврилов on 06.08.2022.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack(alignment: .leading){
            Text(/*@START_MENU_TOKEN@*/"Placeholder"/*@END_MENU_TOKEN@*/)
                .font(.title)
            HStack {
                Text("Nice app bro")
                    .font(.subheadline)
                Spacer()
                Text("Really")
                    .font(.subheadline)
            }
        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
