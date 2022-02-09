//
//  ViewController.swift
//  RequestDemoApp
//
//  Created by Александр Гаврилов on 09.02.2022.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let url = "https://api.unsplash.com/photos/random/?client_id=<secret_key>"
        getData(from: url)

    }
    
    private func getData(from url: String) {
        // запускаем URL сессию, где в замыкании обрабатываем json
        let task = URLSession.shared.dataTask(with: URL(string: url)! , completionHandler: { data, response, error in
            
            guard let data = data, error == nil else {
                print("something went wrong")
                return
            }
            
            var result: Response?
            do {
                // декодируем json в структуру Response
                result = try JSONDecoder().decode(Response.self, from: data)
            } catch {
                print("failed to convert \(error.localizedDescription )")
            }
            
            guard let json = result else {
                 return
            }
            // выводим полученные поля
            print(json.id)
            print(json.created_at)
            print(json.updated_at)
        })
        task.resume()
    }
}

// структура ответа, протокол Codable позволяет использовать
struct Response: Codable {
    let id: String
    let created_at: String
    let updated_at: String
}

/* response json in browser
 {
    "id": "CICSh-hB-lM",
    "created_at": "2022-01-21T10:41:37-05:00",
    "updated_at": "2022-02-09T04:29:32-05:00",
 }
 */
