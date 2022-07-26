//
//  iCaloriesApp.swift
//  iCalories
//
//  Created by Александр Гаврилов on 26.06.2022.
//

import SwiftUI

@main
struct iCaloriesApp: App {
    @StateObject private var dataController = DataController()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, dataController.container.viewContext)
        }
    }
}
