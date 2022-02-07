//
//  ContentView.swift
//  RGBApp
//
//  Created by Александр Гаврилов on 06.02.2022.
//

import SwiftUI

// структура ContentView - определяет интерфейс приложения, т.е. это базовое родительское представление, внутрь которого могут входить другие представления
// протокол View - основа любого графического элемента в SwiftUI
struct ContentView: View {
    
    // свойства для хранения компонентов цвета
    // с помощью @State помечаются свойства, при изменении которых графический интерфейс приложения должен перерисоваться
    @State var redComponent: Double = 0.5
    @State var greenComponent: Double = 0.5
    @State var blueComponent: Double = 0.5
    // то, что возвращает свойство body - то будет выводиться на экран устройства
    var body: some View {
        // VStack - вртикальный стэк
//        VStack(content: {
//
//        })
        // упрощение конструкции вверху
        VStack {
            Text("Gavrbot's test color App")
                .font(.title)
                .fontWeight(.semibold)
            // value указывает на свойство, но так как оно помечено как @State, то слайдер должен изменять его, поэтому необходимо указать $
            Slider(value: $redComponent)
            Slider(value: $greenComponent)
            Slider(value: $blueComponent)
            Color(red: redComponent, green: greenComponent, blue: blueComponent)
            
            Text("Gavrbot")
                .font(.title)
                .fontWeight(.bold)
                .foregroundColor(Color(red: redComponent, green: greenComponent, blue: blueComponent))

        }
        .padding(/*@START_MENU_TOKEN@*/.all, 10.0/*@END_MENU_TOKEN@*/)
    }
}

// структура ContentView_Previews - выводит в Canvas View
// этому способствует протокол PreviewProvider, который вместе с подписанными на него структурами  определяет только то, как что будет отображено в качестве предпросмотра на Canvas, они никак не влияют на интерфейс самого приложения на эмуляторе
struct ContentView_Previews: PreviewProvider {
    // всё, что находится в свойстве previews, будет отображено на экране, в данном случае ContentView
    static var previews: some View {
        ContentView()
.previewInterfaceOrientation(.portrait)
    }
}

// пример создания второго ContentView
struct SecondContentView_Previews: PreviewProvider {
    static var previews: some View {
        Text("Second Screen")
    }
}
