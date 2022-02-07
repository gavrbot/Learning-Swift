import Foundation

let randomNumber = String(arc4random_uniform(50))

print("Матнакаш загадал случайное число, попробуй отгадать")

let message = [
    "start": "Ваша pop-it'ка:",
    "need more":"Бери больще",
    "need less":"Бери меньще",
    "win":"Повезло-повезло"
]

var userNumber: String = ""

repeat {
    print(message["start"]!)
    userNumber = readLine() ?? ""
    if userNumber < randomNumber {
        print(message["need more"]!)
    } else if userNumber > randomNumber {
        print(message["need less"]!)
    }
} while userNumber != randomNumber

print(message["win"]!)
