/// Здесь будет рассмотрен шаблон делегирования. Примером будет ведение статистики в мессенджере по типу сообщений (аудиофайлы, картинки и тд). Базовый тип будет отвечать только за передачу сообщения, а сбор статистики будет осуществляться типом-делегатом

import Foundation

// протокол сообщения
protocol MessageProtocol {
    var text: String? { get set }
    var image: Data? { get set }
    var audio: Data? { get set }
    var video: Data? { get set }
    var sendDate: Date? { get set }
    var senderId: UInt { get set }
}

// структура сообщения
struct Message: MessageProtocol {
    var text: String?
    var image: Data?
    var audio: Data?
    var video: Data?
    var sendDate: Date?
    var senderId: UInt
}

// протокол делегата статистики
protocol StatisticDelegate: AnyObject {
    func handle(message: MessageProtocol)
}

// протокол мессенджера
// все зависимости между сущностями осуществляются через протоколы
protocol MessengerProtocol {
    // все сообщения
    var messages: [MessageProtocol] { get set }
    // делегат статистики
    var statisticDelegate: StatisticDelegate? { get set }
    
    init()
    
    // получить сообщение
    mutating func receive(message: MessageProtocol)
    // отправить сообщение
    mutating func send(message: MessageProtocol)
}

// структура делегата статистики
//struct StatisticManager: StatisticDelegate {
//    func handle(message: MessageProtocol) {
//        // обработка сообщения
//        print("Обработка сообщения от User # \(message.senderId) завершена")
//    }
//}

// структура мессенджера
struct Messenger: MessengerProtocol {
    var messages: [MessageProtocol]
    var statisticDelegate: StatisticDelegate?
    
    init() {
        messages = []
    }
    
    mutating func receive(message: MessageProtocol) {
        statisticDelegate?.handle(message: message)
        messages.append(message)
        // ..
        // приём сообщения
        // ..
    }
    
    mutating func send(message: MessageProtocol) {
        statisticDelegate?.handle(message: message)
        messages.append(message)
        // ..
        // отправка сообщения
        // ..
    }
}

// теперь при использовании методов send и receive делегат будет вести статистику, но это произойдёт только в том случае, если делегат инициализирован свойству statisticDelegate
//var messenger = Messenger()
//messenger.statisticDelegate = StatisticManager()
//messenger.send(message: Message(text: "Hola Amigo!", sendDate: Date(), senderId: 10))


// расширение позволяет использовать в качестве делегата саму структуру Messenger
//extension Messenger: StatisticDelegate {
//    func handle(message: MessageProtocol) {
//        print("Обработка сообщения от User # \(message.senderId) завершена")
//    }
//}

//var newMessenger = Messenger()
//newMessenger.statisticDelegate = newMessenger.self

// если сам тип данных(Messenger) является делегатом и при этом реализован как структура, то при передаче значения свойству statisticDelegate создаётся копия структуры, то есть значения, хранящиеся в messenger и в statisticDelegate - 2 разные копии
//newMessenger.send(message: Message(text: "Hello Moto", sendDate: Date(), senderId: 28))
//newMessenger.messages.count
//(newMessenger.statisticDelegate as! Messenger).messages.count

// способ этого избежать - реализация мессенджера с помощью класса с некоторыми правками:
// 1. Для избежания утечек памяти свойство statisticDelegate будет weak
// 2. Протокол StatisticDelegate пометим с помощью ключевого слова class(или AnyObject, так как слабая ссылка может быть только на reference type класс)
// 3. В реализации класса Messenger не должно быть использовано слово mutating(которое используется только в структурах)

class MessengerClass: MessengerProtocol {
    var messages: [MessageProtocol]
    weak var statisticDelegate: StatisticDelegate?
    
    required init() {
        messages = []
    }
    
    func receive(message: MessageProtocol) {
        statisticDelegate?.handle(message: message)
        messages.append(message)
        // ..
        // приём сообщения
        // ..
    }
    
    func send(message: MessageProtocol) {
        statisticDelegate?.handle(message: message)
        messages.append(message)
        // ..
        // отправка сообщения
        // ..
    }
}

extension MessengerClass: StatisticDelegate {
    func handle(message: MessageProtocol) {
        print("Обработка сообщения от User # \(message.senderId) завершена")
    }
}

var messengerClass = MessengerClass()
messengerClass.statisticDelegate = messengerClass.self
messengerClass.send(message: Message(text: "Hello Moto", sendDate: Date(), senderId: 28))
messengerClass.messages.count
(messengerClass.statisticDelegate as! MessengerClass).messages.count
