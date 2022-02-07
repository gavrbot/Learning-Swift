// Часть 6. Нетривиальные возможности Swift

// Глава 22. Перечисления (Enum)

import Foundation
import CoreGraphics
import Darwin

// перечисление - набор значений определённого типа данных, с которыми можно взаимодействовать

enum CurrencyUnit {
    case rouble, euro
}

var roubleCurrency: CurrencyUnit = .rouble
type(of: roubleCurrency)
var otherCurrency = CurrencyUnit.euro
type(of: otherCurrency)
otherCurrency = .rouble

// пример перечисления с ассоциированными параметрами
enum AdvancedCurrencyUnit {
    enum DollarCountries {
        case usa
        case canada
        case australia
    }
    case rouble(countries: [String], shortName: String)
    case euro(countries: [String], shortName: String)
    case dollar(nation: DollarCountries, shortName: String)
}

var euroCurrency: AdvancedCurrencyUnit = .euro(countries: ["German", "France"], shortName: "EUR")
var dollarCurrency: AdvancedCurrencyUnit = .dollar(nation: .usa, shortName: "USD")

var australia: AdvancedCurrencyUnit.DollarCountries = .australia

switch dollarCurrency {
case .rouble:
    print("Рубль")
case let .euro(countries, shortName):
    print("Евро. Страны \(countries). Краткое наименование: \(shortName)")
case .dollar(let nation, let shortName):
    print("Доллар \(nation). Краткое наименование: \(shortName)")
}

// пример перечисления со связанными параметрами
enum Smile: String {
    case joy = ":)"
    case laugh = ":D"
    case sorrow = ":("
    case surprise = "o_O"
}

// в данном примере значения после Меркурия инициализируются автоматически, инкрементируясь на единицу от первого заданного параметра; так как Плутон отмечен вручную, то значение у него будет 999
enum Planet: Int {
    case mercury = 1, venus, earth, mars, saturn, neptune, pluton = 999
}
Planet.mercury.rawValue
Planet.venus.rawValue
Planet.earth.rawValue
Planet.mars.rawValue
Planet.saturn.rawValue
Planet.neptune.rawValue
Planet.pluton.rawValue

// инициализатор обязательно входит в состав структуры, обозначается как init
// в параметр rawValue передаётся указатель на исходное значение в перечислении и возвращается опционал
// инициализаторы вызываются каждый раз при создании нового экземпляра перечисления, класса, структуры. Для некоторых конструкций их нужно создавать самостоятельно, для некоторых(например, перечислений) они существуют по умолчанию
var myPlanet = Planet.init(rawValue: 3)
var anotherPlanet = Planet.init(rawValue: 11)

// свойства в перечислениях должны являться только замыканиями, они не могут быть фиксированными значениями-литералами

// методы в перечислениях эквивалетны функциям

// оператор self идентичен this в Java. Он возвращает указатель на конкретный член перечисления

enum NewSmile: String {
    case joy = ":)"
    case laugh = ":D"
    case sorrow = ":("
    case surprise = "o_O"
    // вычисляемое свойство
    var description: String {return self.rawValue}
    func about() {
        print("Перечисляемое значение содержит список смайликов.")
    }
    func descriptionValue() -> NewSmile {
        return self
    }
    func descriptionRawValue() -> String {
        return self.rawValue
    }
}

var mySmile: NewSmile = .sorrow
// вычисляемое свойство должно храниться в переменной var, в случае let произойдёт ошибка
mySmile.description
mySmile.about()
mySmile.descriptionValue()
mySmile.descriptionRawValue()


enum ArithmeticExpression {
    case addition(Int, Int)
    case substraction(Int, Int)
    func evaluate() -> Int {
        switch self {
        case .addition(let left, let right):
            return left + right
        case .substraction(let left, let right):
            return left - right
        }
    }
}

var expr = ArithmeticExpression.addition(10, 14)

// перечисление, описанное выше, позволяет выполнять только бинарные операции. Для выполнения нетривиальных цепочек действий необходимо воспользоваться рекурсией для того, чтобы перечисление позволяло выполнять операции не только с Int, но и с ArithmeticExpression

enum NewArithmeticExpression {
    // указатель на конкретное значение
    case number( Int )
    // указатель на операцию сложения
    // indirect - оператор, разрешающий членам перечисления обращаться к этому перечислению
    indirect case addition(NewArithmeticExpression, NewArithmeticExpression)
    // указатель на операцию вычитания
    indirect case substraction(NewArithmeticExpression, NewArithmeticExpression)
    // метод, производящий операцию
    func evaluate(_ expression: NewArithmeticExpression? = nil) -> Int {
        // определение типа операнда(значение или операция)
        switch expression ?? self {
        case let .number(value):
            return value
        case let .addition(valueLeft, valueRight):
            return self.evaluate(valueLeft) + self.evaluate(valueRight)
        case let .substraction(valueLeft, valueRight):
            return self.evaluate(valueLeft) - self.evaluate(valueRight)
        }
    }
}
// 20 + 10 - 34
var hardExpr = NewArithmeticExpression.addition(.number(20), .substraction(.number(10), .number(34)))
hardExpr.evaluate()


// Глава 23. Структуры(Struct)

// Объявляя структуру, мы определяем новый тип данных

// свойства структуры могут быть представлены в виде любого типа данных.

// структуры имеют встроенный инициализатор init, поэтому объявлять его необязательно

// можно создать свой инициализатор, при этом созданный автоматически будет удалён

// структуры - типы-значения, т.е. при передаче экземпляра структуры от одного параметра к другому происходит его копирование

// по умолчанию методы структур, кроме init, не могут изменять значения свойств структур. Для изменения параметров в методе, перед названием метода необходимо указать ключевое слово mutating

struct PlayerInChess{
    var name: String = "Игрок"
    var wins: UInt = 0
    init(name: String) {
        self.name = name
    }
    func description() {
        print("Игрок \(self.name) имеет \(self.wins) побед")
    }
    mutating func win(count: UInt = 1) {
        self.wins += count
    }
}
var harry = PlayerInChess.init(name: "Гарри")
var tom = PlayerInChess(name: "Том")

harry.name
harry.wins
harry.wins += 1
harry.wins

var harryClone = harry
harryClone.name = "Гарри Поттер"
harry.name
harryClone.name

harry.description()
harry.win()
harry.win(count: 5)
harry.wins


// Глава 24. Классы

// Класс - ссылочный тип
// Экземпляр класса может изменять значения своих свойств var, даже если хранится в экземпляре let
// Класс имеет только пустой init(){} в отличие от структур, где он генерируется самостоятельно
// Класс позволяет определить деинициализаторы(деструкторы)
// Класс может быть приведён к другому типу
// Два класса могут быть в отношениях суперкласс-субкласс, при этом субкласс наследует и включает в себя все свойства и методы, а также может быть расширен

// Свойства type и color могут принимать значения из четко определённого перечня, определим перечисления для них,  это обеспечит корректный ввод

class Chessman {
    enum ChessmanType {
        case king, zastle, bishop, pawn, knight, queen
    }

    enum ChessmanColor {
        case white, black
    }
    
    let type: ChessmanType
    let color: ChessmanColor
    // является опционалом, так как фигура может не иметь координат, когда её нет на поле, поэтому по умолчанию nil
    var coordinates: (String, Int)? = nil
    let figureSymbol: Character
    
    init(type: ChessmanType, color: ChessmanColor, figure: Character) {
        self.type = type
        self.color = color
        self.figureSymbol = figure
    }
    
    init(type: ChessmanType, color: ChessmanColor, figure: Character, coordinates: (String, Int)) {
        self.type = type
        self.color = color
        self.figureSymbol = figure
        self.setCoordinates(char: coordinates.0, num: coordinates.1)
    }
    
    // метод установки координат
    func setCoordinates(char c: String, num n: Int) {
        self.coordinates = (c, n)
    }
    // метод убивающий фигуру
    func kill() {
        self.coordinates = nil
    }
}
var kingWhite = Chessman(type: .king, color: .white, figure: "\u{2654}")
kingWhite.setCoordinates(char: "E", num: 2)
var queenBlack = Chessman(type: .queen, color: .black, figure: "\u{2655}", coordinates: ("A", 6))
var linkToEnumType = Chessman.ChessmanType.bishop


// Глава 25. Свойства

// по типу хранения выделяют 2 типа свойств: хранимые(в структурах и классах) и вычисляемые(в перечислениях, структурах и классах)

// хранимые свойства - константа или переменная, объявленная в объектном виде, хранящая определённое значение, а также может быть ленивым, которое будет вычисляться при обращении к нему и потом не изменяться

// только lazy свойства могут обращаться к self в их теле

class AboutMan {
    var firstName = "Имя"
    var secondName = "Фамилия"
    lazy var wholeName: String = self.generateWholeName()
    
    init(firstName: String, secondName: String) {
        (self.firstName, self.secondName) = (firstName, secondName)
    }
    
    func generateWholeName() -> String {
        return self.firstName + " " + self.secondName
    }
}
var Me = AboutMan(firstName: "Александр", secondName: "Гаврилов")
Me.wholeName
Me.secondName = "Не Гаврилов"
Me.wholeName

// точно так же можно определить wholeName как ленивое замыкание, которое придётся вызывать с помощью ()
// в данном случае выражение будет иметь каждый раз разное значение при обращении к нему, так как является замыканием

class ClosureAboutMan {
    var firstName = "Имя"
    var secondName = "Фамилия"
    lazy var wholeName: ()->String = { "\(self.firstName) \(self.secondName)" }
    
    init(firstName: String, secondName: String) {
        (self.firstName, self.secondName) = (firstName, secondName)
    }
}

var otherMan = ClosureAboutMan(firstName: "Алексей", secondName: "Олейник")
otherMan.wholeName()
otherMan.secondName = "Дуров"
otherMan.wholeName()

// вычисляемые свойства - по сути те же ленивые хранимые свойства, имеющие функциональный тип и вычисляемыые при каждом доступе к нему
// вычисляемые свойства не хранят значение, а вычисляют его с помощью замыкания
// должны храниться исключительно в var и обязательно иметь оператор return

class AnotherAboutMan {
    var firstName = "Имя"
    var secondName = "Фамилия"
    var wholeName: String { return "\(self.firstName) \(self.secondName)" }
    
    init(firstName: String, secondName: String) {
        (self.firstName, self.secondName) = (firstName, secondName)
    }
}
var anotherMan = AnotherAboutMan(firstName: "Паша", secondName: "Техник")
anotherMan.wholeName
anotherMan.secondName = "Дуров"
anotherMan.wholeName


// для любого !!вычисляемого!! свойства существует возможность реализовать геттер и сеттер
// геттер срабатывает при запросе значения свойства(для корректной работы должен возвращать значения через return)
// сеттер срабатывает при попытке установить новое значение свойству

struct Circle {
    var coordinates: (x: Int, y: Int)
    var radius: Float
    var perimeter: Float {
        get{
            return 2.0 * 3.14 * self.radius
        }
        // сеттер устанавливает в параметр perimeter новое переданное значение, а также при необходимости исполняет код внутри себя
        set(newPerimeter){
            self.radius = newPerimeter / (2 * 3.14)
        }
        // альтернатива
        //set{
        //    self.radius = newValue / (2 * 3.14)
        //}
    }
}
var myNewCircle = Circle(coordinates: (0, 0), radius: 10)
myNewCircle.perimeter
myNewCircle.perimeter = 31.4
myNewCircle.radius


// наблюдатели - спец функции, которыые вызываются либо перед, либо сразу после установки нового значения !!хранимого!! свойства

struct NewCircle {
    var coordinates: (x: Int, y: Int)
    // свойство radius !!ХРАНИМОЕ!!
    var radius: Float {
        // до установки вызовется эта функция
        willSet(newValueOfRadius) {
            print("Вместо значения \(self.radius) устанавливается значение \(newValueOfRadius)")
        }
        // сразу после установки вызовется эта фукнция
        didSet(oldValueOfRadius) {
            print("Вместо значения \(oldValueOfRadius) установлено значение \(self.radius)")
        }
    }
    // свойство perimeter !!ВЫЧИСЛЯЕМОЕ!!
    var perimeter: Float {
        get{
            return 2.0 * 3.14 * self.radius
        }
        set{
            self.radius = newValue / (2 * 3.14)
        }
    }
}
var anotherCircle = NewCircle(coordinates: (0, 0), radius: 10)
anotherCircle.perimeter
anotherCircle.perimeter = 31.4 // здесь произошло изменение радиуса внутри set
anotherCircle.radius


// все описанные выше свойства имеют отношения к свойствам конкретных экземпляров

// имеется возможность создать свойство типа данных, которое будет одинаковым для всех экземпляров
// свойства типа могут быть созданы для перечислений, структур и классов
// оно может быть как хранимым, так и вычисляемым
// оно помечается ключевым словом static и обязательно должно иметь значение по умолчанию

struct AudioChannel {
    static var maxVolume = 5
    var volume: Int {
        didSet {
            if volume > AudioChannel.maxVolume {
                volume = AudioChannel.maxVolume
            }
        }
    }
}
var leftChannel = AudioChannel(volume: 2)
var rightChannel = AudioChannel(volume: 3)
rightChannel.volume = 6
rightChannel.volume
AudioChannel.maxVolume = 10 // для обращения к свойству типа используется имя типа, а не имя экземпляра
rightChannel.volume = 8
rightChannel.volume


// Глава 26. Сабскрипты

// сабскрипты доступны только для структур и классов
// сабскрипты по сути являются переопределением оператора [], с помощью которого можно организовать доступ к свойствам экземляра с использованием спец. ключей(индексов)
// входные параметры - значения, которые передаются в виде ключей
// тело сабскрипта состоит из геттера и сеттера, которые либо возвращают значение, либо устанавливают его
// сеттер не является обязательным, в таком случае в фигурных скобках будет содержаться только код для геттера
// сабскрипты поддерживают перегрузку

// класс без использования сабскрипта
class gameDesk {
    var desk: [Int: [String: Chessman]] = [:]
    init() {
        for i in 1...8 {
            desk[i] = [:]
        }
    }
    func setChessman(chess: Chessman, coordinates: (String, Int)) {
        let rowRange = 1...8
        let colRange = "A"..."Z"
        if (rowRange.contains(coordinates.1) && colRange.contains(coordinates.0)) {
            self.desk[coordinates.1]![coordinates.0] = chess
            chess.setCoordinates(char: coordinates.0, num: coordinates.1)
        } else {
            print("Coordinates out of range")
        }
    }
}
var game = gameDesk()
var someQueenBlack = Chessman(type: .queen, color: .black, figure: "\u{265B}", coordinates: ("A", 6))
game.setChessman(chess: someQueenBlack, coordinates: ("B", 2))
someQueenBlack.coordinates
game.setChessman(chess: someQueenBlack, coordinates: ("A", 3))
someQueenBlack.coordinates
game.desk

// класс с использованием сабскрипта
class GameDesk {
    var desk: [Int: [String: Chessman]] = [:]
    init() {
        for i in 1...8 {
            desk[i] = [:]
        }
    }
    subscript(alpha: String, number: Int) -> Chessman? {
        // возвращаемый тип данных как в get так и set соответствует Chessman?
        get{
            return self.desk[number]![alpha]
        }
        set{
            if let chessman = newValue {
                self.setChessman(chess: chessman, coordinates: (alpha, number))
            } else {
                self.desk[number]![alpha] = nil
            }
        }
    }
    func setChessman(chess: Chessman, coordinates: (String, Int)) {
        let rowRange = 1...8
        let colRange = "A"..."Z"
        if (rowRange.contains(coordinates.1) && colRange.contains(coordinates.0)) {
            self.desk[coordinates.1]![coordinates.0] = chess
            chess.setCoordinates(char: coordinates.0, num: coordinates.1)
        } else {
            print("Coordinates out of range")
        }
    }
}
var newGame = GameDesk()
var newQueenBlack = Chessman(type: .queen, color: .black, figure: "\u{265B}", coordinates: ("A", 6))
newGame["C", 5] = newQueenBlack
newGame["C", 5]
newGame["C", 5] = nil
newGame["C", 5]


// Глава 27. Наследование

// при наследовании все свойства и методы суперкласса становятся доступными в подклассе без их объявления
// значения наследуемых свойств могут изменяться независимо от родительского класс

class Quadruped {
    var type = ""
    var name = ""
    func walk() {
        print("walk")
    }
}

// доступ к наследуемым элементам в производном классе производится через self

class Dog: Quadruped {
    // если в подклассе набор свойств не отличается от суперкласса, то может использоваться наследуемый инициализатор
    // если определяется инициализатор с уникальными для суперкласса и подкласса значениями, то нужно не наследовать его, а создавать новый
    // в данном случае инициализатор наследуется, но дополнительно изменяется лишь одно поле, которое не определялось в суперклассе
    // и прежде чем получать доступ к наследуемым свойствам в суперклассе, необходимо вызвать инициализатор родителя
    // если в подклассе есть свойства, которых нет в суперклассе, то их необходимо указать до вызова инициализатора родительского класса
    override init() {
        super.init()
        self.type = "dog"
    }
    func bark() {
        print("woof")
    }
    func printName() {
        print(self.name)
    }
}
var dog = Dog()
dog.type = "dog"
dog.name = "Dragon Wan Helsing"
dog.walk()
dog.bark()
dog.printName()


// в классе можно переопределять свойства(super.someProperty), методы(super.someMethod()) и сабскрипты(super[someIndex])
// в наследуемом свойстве можно переопределить геттер и сеттер, а также если у свойство было "только для чтения", то из него можно сделать свойство "чтение-запись", но обратное совершить нельзя
// хранимые свойства переопределять нельзя, так как вызываемый или наследуемый инициализатор попытается установить их значения, но не сможет его найти
// субкласс не знает всех деталей реализации наследуемого свойства родительского класса(только имя и тип наследуемого свойства), поэтому необходимо всегда указывать имя и имя, и тип переопределяемого свойства
class NoisyDog: Dog {
    // с помощью override обозначается переопределние метода с родительского класса
    override func bark() {
        print("loud woof")
        // пример вызова функции bark() из суперкласса
        super.bark()
    }
}
var badDog = NoisyDog()
badDog.bark()

// модификатор final позволяет запретить переопределение элементов класса
// final class
// final var
// final func
// final subscript

// наследование позволяет заменять экземпляры определённого класса экземплярами подклассов

var animalsArray: [Quadruped] = []
var someAnimal = Quadruped()
var myDog = Dog()
var sadDog = NoisyDog()
animalsArray.append(someAnimal)
animalsArray.append(myDog)
animalsArray.append(sadDog)
type(of: animalsArray)

for item in animalsArray {
    // для проверки типа экземпляра класса используется оператор is
    if item is Dog {
        print("Yap")
    }
}

// в массиве animalsArray все элементы являются экземплярами класса Quadruped, так как это обозначено в типе массива, т.е. получив элемент Dog из массива нельзя будет вызвать метод bark()
// для того, чтобы преобразовать тип используется оператор as, а точнее as? и as!
// as? - возвращает либо экземпляр типа ИмяКласса?(опционал), либо nil
// as! - принудительно извлекает значение и возвращает экземпляр или вызывает ошибку в случае неудачи

let someDog = animalsArray[1] as! Dog
type(of: someDog)

for item in animalsArray {
    if let animal = item as? NoisyDog {
        animal.bark()
    } else if let animal = item as? Dog {
        animal.bark()
    } else {
        item.walk()
    }
}


// Глава 28. Псевдонимы Any и AnyObject

// Any - соответствует любому типу данных
// AnyObject - соответствует экземпляру любого класса

// Any позволяет создавать хранилища неопределённого типа данных

var things = [Any]()
things.append(0)
things.append(0.0)
things.append(42)
things.append("hello")
things.append((3.0, 5.0))
things.append({ (name: String) -> String in "Hello, \(name)" })

// массив содержит в себе значения разных типов данных, но при запросе конкретного элемента по индексу мы получим элемент типа Any
// Any не совместим с Hashable, поэтому использование его при сопоставлении невозможно, поэтому нельзя использовать Any в качестве, например, ключа в словаре

// приведение типа Any происходит с помозью оператора as

for thing in things {
    switch thing {
    case let someInt as Int:
        print("An integer value of \(someInt)")
    case let someDouble as Double where someDouble > 0:
        print("a positive Double value of \(someDouble)")
    case let someString as String:
        print("a String value of \"\(someString)\"")
    case let (x, y) as (Double, Double):
        print("an (x, y) point at \(x), \(y)")
    case let stringConverter as (String) -> String:
        print(stringConverter("Troll"))
    default:
        print("something else")
    }
}

// AnyObject позволяет указать на то, что в данном месте должен или может находиться экземпляр любого класса

let someObjects: [AnyObject] = [Dog(), NoisyDog(), Dog()]

// в данном случае при извлечении объекта по индексу, возвращается экземпляр класса AnyObject

// приведение типа происходит через as!

for object in someObjects {
    let animal = object as! Dog
    print(animal.type)
}

for object in someObjects as! [Dog] {
    print(object.type)
}


// Глава 29. Инициализаторы и деинициализаторы

// классы имеют встроенный пустой инициализатор init(){} - он срабатывает без ошибок только в том случае, если у класса отсутствуют свойства или у каждого свойства указаны значения по умолчанию
// структуры имеют встроенный инициализатор, проставляющий значения для всех свойств

// назначеннные инициализаторы - инициализаторы, производящие установку значений свойств
// должен существовать хотя бы один назначенный инициализатор, производящий установку свойств, и один из инициализаторов должен обязательно вызываться при создании экземпляра
// назначенный инициализатор внутри себя не может вызывать другой назначенный инициализатор
// инициализаторы наследуются от суперкласса к подклассу, и в инициализаторах подклассса можно вызывать родительские

// инициализатор может устанавливать значения констант
// внутри инициализатора необходиом установить значения свойств класса или структуры, чтобы к концу его работы все свойства имели значения(для опционалов может быть nil)

// вспомогательный инициализатор - вторичный, необязательный или поддерживающий, может использоваться для проведения настроек и обязательного вызова одного из назначенных инициализаторов

class NewDog: Quadruped {
    override init() {
        super.init()
        self.type = "dog"
    }
    convenience init(text: String) {
        self.init()
        print(text)
    }
    func bark() {
        print("woof")
    }
    func printName() {
        print(self.name)
    }
}
var someNewDog = NewDog(text: "Экземпляр класса Dog создан")


// наследование инициализаторов

// если подкласс имеет собственный назначенный инициализатор, то инициализаторы родительского класса не наследуются
// если подкласс переопределяет все назначенные инициализаторы суперкласса, то он наследует и все его вспомогательные инициализаторы

// отношения между инициализаторами

// назначенный инициализатор подкласса должен вызвать назначенный инициализатор суперкласса
// вспомогательный инициализатор должен вызывать назначенный инициализатор того же типа
// вспомогательный инициализатор в конечном счете должен вызвать назначенный инициализатор


// проваливающийся инициализатор - инициализатор, способный возвращат nil при создании экземпляра в случае некой ошибки или непрохождения определённого условия
// обозначается как init? - возвращаемое значение будет опционалом, либо nil
// в теле инициализатора обязательно должно присутстовать выражение "return nil"

class Rectangle {
    var height: Int
    var weight: Int
    init?(height h: Int, weight w: Int) {
        self.height = h
        self.weight = w
        if !(h > 0 && w > 0) {
            return nil
        }
    }
}
var rectangle = Rectangle(height: 56, weight: -1)

// в классах проваливающийся инициализатор может вернуть nil только после установки значений всех хранимых свойств. В структурах данное ограничение отсутствует
// назначенный инициализатор в подклассе может переопределить проваливающийся инициализатор суперкласса, а проваливающийся инициализатор может вызвать назначенный инициализатор того же класса

enum TemperatureUnit {
    case Kelvin, Celsius, Fahrenheit
    init?(symbol: Character) {
        switch symbol {
        case "K":
            self = .Kelvin
        case "C":
            self = .Celsius
        case "F":
            self = .Fahrenheit
        default:
            return nil
        }
    }
}
let fahrenheitUnit = TemperatureUnit(symbol: "F")

// у перечислений, члены которых имеют значения, есть встроенный проваливающийся инициализатор init?(rawValue:)

enum NewTemperatureUnit: Character {
    case Kelvin = "K", Celsius = "C", Fahrenheit = "F"
}
let celsiusUnit = NewTemperatureUnit(rawValue: "C")
celsiusUnit!.hashValue
let nothingUnit = NewTemperatureUnit(rawValue: "N")

// альтернативой init? служит init!
// init! - возвращает неявно извлеченный экземпляр объектного типа, поскольку для работы с ним не требуется извлекать опциональное значение, при этом всё ещё может возвращаться nil


// обязательный инициализатор - инициализатор, который обязательно должен быть определён во всех подклассах
// помечается с помощью ключевого слова required, кроме того это ключевое слдово необходимо указывать в инициализаторе подкласса, чтобы последующие подклассы так же его реализовывали


// деинициализаторы - присутствуют только в классах, они автоматически вызываются во время уничтожения экземпляра класса.
// самостоятельно вызвать деинициализатор нельзя, и он может существовать только один у одного класса
// с его помощью можно освободить неиспользуемые ресурсы, вывести на консоль журнал или выполнить любые другие действия
// деинициализатор суперкласса наследуется подклассом и вызывается автоматически в конце работы. Деинициализатор суперкласса вызывается всегда, даже если деинициализатор подкласса отсутствует
// экземпляр класса не удаляется, пока не закончит работу деинициализатор, поэтому все значения свойств экземпляра остаются доступными в теле деинициализатора 

class SuperClass {
    init?(isNil: Bool) {
        if isNil == true {
            return nil
        } else {
            print("Экземпляр создан")
        }
    }
    deinit {
        print("Деинициализатор суперкласса")
    }
}

class SubClass: SuperClass {
    deinit {
        print("Деинициализатор подкласса")
    }
}
var obj = SubClass(isNil: false)
obj = nil


// Глава 30. Удаление экзепляров и ARC

// экземпляр может быть удалён двумя способами:
// его самостоятельно уничтожает разработчик;
// его уничтожает Swift.

class myClass {
    var description: String
    init(description: String) {
        print("Экземпляр \(description) создан")
        self.description = description
    }
    deinit {
        print("Экземпляр \(self.description) уничтожен")
    }
}
// так как область видимости переменной myVar2 ограничена блоком if, то после выхода их этого блока переменная уничтожается
var myVar1 = myClass(description: "ОДИН")
if true {
    var myVar2 = myClass(description: "ДВА")
}

print()

// в переменной myVar11 изначально хранится ссылка на экземпляр myClass
var myVar11 = myClass(description: "ОДИН")
// теперь на этот объект указывают 2 ссылки
var myVar2 = myVar11
// создаётся новый экземпляр класса myCLass
myVar11 = myClass(description: "ДВА")
// так как вторая ссылка теперь будет указывать на второй экземпляр, все ссылки на первый экземпляр удалятся, и поэтому он удалится и в консоли выведется сообщение об уничтожении первого объекта
myVar2 = myVar11


// пример утечки памяти
class Human {
    let name: String
    var child = [Human?]()
    var father: Human?
    var mother: Human?
    init(name: String) {
        self.name = name
    }
    deinit {
        print("\(self.name) - удален")
    }
}
var Kirill: Human? = Human(name: "Кирилл")
var Olga: Human? = Human(name: "Ольга")
var Aleks: Human? = Human(name: "Алексей")
Kirill?.father = Aleks
Kirill?.mother = Olga
Aleks?.child.append(Kirill)
Olga?.child.append(Kirill)
Kirill = nil
Aleks = nil
Olga = nil
// экземпляры остаются неудалёнными даже после того, как объекты определили в nil, поскольку когда они должны были быть удалены, ссылки на них всё ещё существуют, и Swift не может понять, какие из ссылок можно удалить, а какаие нельзя


// в Swift существуют сильные и слабые ссылки
// по умолчанию при создании ссылки на объект создаётся сильная ссылка, что приводит к тому, что Swift не может принять решения о том, какую из ссылок удалить. Для решения проблемы некоторые из ссылок можно преобразовать в слабые
// слабые ссылки определяются с помощью ключевых слов weak и unowned
// weak - указывает на то, что хранящаяся в параметре ссылка может быть в автоматическом режиме на усмотрение программы заменена на nil, поэтому этот модификатор доступен только для опционалов
// unowned - модификатор, указывающий на слабую ссылку для неопциональных типов данных
// указанные ключевые слова можно использовать только для хранилища определённого экземпляра класса, т.е. нельзя указать слабую ссылку на массив экземпляров или кортеж, состоящий из экземпляров класса
class NewHuman {
    let name: String
    var child = [NewHuman?]()
    weak var father: NewHuman?
    weak var mother: NewHuman?
    init(name: String) {
        self.name = name
    }
    deinit {
        print("\(self.name) - удалён")
    }
}
var Kirill2: NewHuman? = NewHuman(name: "Кирилл")
var Olga2: NewHuman? = NewHuman(name: "Ольга")
var Aleks2: NewHuman? = NewHuman(name: "Алексей")
Kirill2?.father = Aleks2
Kirill2?.mother = Olga2
Aleks2?.child.append(Kirill2)
Olga2?.child.append(Kirill2)
Kirill2 = nil
Aleks2 = nil
Olga2 = nil
// в результате все 3 объекта будут удалены, так как после удаления слабых ссылок никаких перекрёстных ссылок не остается


// в Swift используется ARC(Automatic Reference Counting)

// сильные ссылки могут стать источником утечки памяти при их передаче в качестве входных параметров замыкания
class Man {
    var name = "Чувак"
    deinit {
        print("Объект удалён")
    }
}
var closure: (() -> ())?
if true {
    let man = Man()
    closure = {
        print(man.name)
    }
    closure!()
}
print("Программа завершена")
// несмотря на то, что переменная man объявлена внутри условного оператора, она передана по сильной ссылке в замыкание, которое является внешним по отношению к условному оператору, поэтому Swift не может принять решения об удалении этой ссылки

// для избежания такой проблемы в замыкании необходимо выполнить захват переменной, указав, что в переменной содержится слабая ссылка, таким образом, объект будет локальным как для условного оператора, так и для замыкания
var newClosure: (() -> ())?
if true {
    var newMan = Man()
    closure = {
        [unowned newMan] in
        print(newMan.name)
    }
    closure!()
}
print("Программа завершена")


// Глава 31. Опциональные цепочки

struct Room {
    let square: Int
}
class Residence {
    // свойство получит значение nil при инициализации, поскольку является опционалом
    var rooms: [Room]?
    func roomsCount() -> Int {
        if let rooms = self.rooms {
            return rooms.count
        } else {
            return 0
        }
    }
}
class Person {
    // свойство получит значение nil при инициализации, поскольку является опционалом
    var residence: Residence?
}
var man = Person()

// при этом придётся постоянно проверять, есть ли значение в свойстве residence или нет, чтобы избежать ошибку
// пример с использованием опционального связывания
if let residence = man.residence {
    if let rooms = residence.rooms {
        for oneRoom in rooms {
            print("Есть комната площадью \(oneRoom.square)")
        }
    } else {
        print("Нет комнат")
    }
} else {
    print("Нет дома")
}
// и при усложнении иерархии классов, количество условий будет разрастаться

// перепишем пример с опциональными цепочками, которые позволяют сразу написать полный путь до требуемого элемента
let room = Room(square: 10)
var residence = Residence()
residence.rooms = [room]
man.residence = residence
if let rooms = man.residence?.rooms {
    for oneRoom in rooms {
        print("Есть комната площадью \(oneRoom.square)")
    }
} else {
    print("Нет резиденции или комнат")
}

// пример установки значений через опциональные цепочки
let room1 = Room(square: 15)
let room2 = Room(square: 25)
man.residence?.rooms = [room1, room2]
// пример вызова функции через опциональные цепочки
man.residence?.roomsCount()


// Глава 32. Расширения(Extention)

// расширения добавляют функциональность к существующему объектному типу(классу, структуре, перечислению, протоколу)
// можно расширять типы данных, к исходному коду которых нет доступа

// возможности расширений:
// - добавление вычисляемых(хранимые или наблюдатели свойств выдадут ошибку) свойств экземпляра и вычисляемых свойств типа(static);
// - определение методов экземпляра и методов типа;
// - определение новых инициализаторов, сабскриптов и вложенных типов;
// - обеспечение соответствия существующего типа протоколу
// - !!! не могут изменять существующий функционал !!!
// - после добавления функционал становится доступным всем экземплярам класса вне зависимости от того, где они были объявлены

// пример расширения свойства
extension Double {
    var km: Double { return self * 1000.0 }
    var m: Double { return self }
    var cm: Double { return self / 100.0 }
    var mm: Double { return self / 1000.0 }
    var ft: Double { return self / 3.28084 }
}
let oneInch = 25.4.mm
print("Один фут - это \(oneInch) метра")
let threeFeet = 3.ft
print("Три фута - это \(threeFeet) метра")


// для классов расширения могут добавлять только новые вспомогательные инициализаторы. Попытка добавить назначенный инициализатор или деинициализатор приведёт к ошибке

// пример расширения инициализатора
struct Line {
    var pointOne: (Double, Double)
    var pointTwo: (Double, Double)
}
extension Double {
    init(line: Line) {
        self = sqrt(pow((line.pointTwo.0 - line.pointOne.0), 2) +
                    pow((line.pointTwo.1 - line.pointOne.1), 2))
    }
}
var myLine = Line (pointOne: (10, 10), pointTwo: (14, 10))
var lineLenght = Double(line: myLine)


// пример расширения метода
extension Int {
    func repetitions(task: () -> ()) {
        for _ in 0..<self {
            task()
        }
    }
}
3.repetitions {
    print("Swift can do this!")
}


// пример расширения метода, который может изменять свойства типа
extension Int {
    mutating func square() {
        self = self * self
    }
}
var someInt = 3
someInt.square()


// пример расширения сабскрипта
extension Int {
    subscript(digitIndex: Int) -> Int {
        var base = 1
        var index = digitIndex
        while index > 0 {
            base *= 10
            index -= 1
        }
        return (self / base) % 10
    }
}
123456789[0]
123456789[8]


// Глава 33. Протоколы

// Протокол содержат перечень свойств, методов, сабскриптов, которые должны быть реализованы в объектном типе(аналог интерфейсов в Java)
// Функция протокола - обеспечение целостности объектных типов, путём указания требований к их реализации

// если класс принимает не только протоколы, но и наследует некоторый класс, то имя суперкласса необходимо указать первым, а за ним указать протоколы


// Требуемые свойства

// протокол может потребовать реализовать свойство экземпляра или типа(static), имеющее конкретное имя и тип данных, при этом не указывая на вид свойства(хранимое или вычисляемое)

protocol SomeProtocol {
    // требует, чтобы у свойства был и get, и set
    var mustBeSettable: Int {get set}
    // требует, чтобы у свойства точно был get, но может быть реализован и set
    var doenNotNeedToBeSettable: Int {get}
}

protocol AnotherProtocol {
    // для указания в протоколе на свойство типа используется static
    static var someTypeProperty: Int {get set}
}

// пример протокола, который будет реализован структурой
protocol FullyNamed {
    var fullName: String {get}
}
struct NewPerson: FullyNamed {
    var fullName: String
}
let john = NewPerson(fullName: "John Wick")


// Требуемые методы

// протокол может потребовать реализацию определённого метода экземпляра или типа(static), а также изменяющий метод через mutating. Если  mutating было указано в протоколе, то необязательно писать это ключевое слово в реализации класса

protocol RandomNumberGenerator {
    // функция должна вернуть Double
    func random() -> Double
    // функция типа, возвращаемое значение остаётся за реализацией
    static func getRandomString()
    // изменяющий метод, который должен в качестве входного принимать Double
    mutating func changeValue(newValue: Double)
}


// Требуемые инициализаторы

// протокол может потребовать реализацию инициализатора, также есть возможность потребовать инициализатор для всех подклассов через required

protocol Named {
    init(name: String)
}
class NamedPerson: Named {
    var name: String
    required init(name: String) {
        self.name = name
    }
}


// протокол является типом данных, следовательно можно осуществлять проверку на соответствие прококолу через оператор is

// расширения + протоколы

// пример реализации протокола расширением
protocol TextRepresentable {
    func asText() -> String
}
extension Int: TextRepresentable {
    func asText() -> String {
        return String(self)
    }
}
5.asText()

// пример расширения протоколов
extension TextRepresentable {
    func description() -> String {
        return "Данный тип поддерживает протокол Representable"
    }
}
5.description()


// наследование протоколов

// протокол может наследовать один или более других протоколов, при этом он может добавлять новые требования поверх существующих. Тогда тип, принявший протокол к реализации, будет вынужден выполнить требования всех протоколов в структуре.

protocol SuperProtocol {
    var someValue: Int {get}
}
protocol SubProtocol: SuperProtocol {
    func someMethod()
}
struct SomeStruct: SubProtocol {
    let someValue: Int = 10
    func someMethod() {
        print("some stuff")
    }
}


// Классовые протоколы

// есть возможность ограничить протокол таким образом, чтобы его могли принимать к исполнению только классы(а не структуры или перечисления) с помощью слова AnyObject при указании протокола
protocol ClassProtocol: AnyObject {
    func someMethod()
}
class ClassCheckProtocol: ClassProtocol {
    func someMethod() {
        print("Классовый протокол")
    }
}
let checkClass = ClassCheckProtocol()
checkClass.someMethod()


// Композиция протоколов

// иногда удобно требовать реализацию сразу нескольких протоколов, для этого есть возможность создать композицию протоколов(а не создавать подпротокол, включающий в себя несколько протоколов)
protocol NewNamed {
    var name: String {get}
}
protocol Aged {
    var age: Int {get}
}
struct PersonWithComposition: NewNamed, Aged {
    var name: String
    var age: Int
}
func wishHappyBirthday(celebrator: NewNamed & Aged) {
    print("С днём рождения, \(celebrator.name)! Тебе уже \(celebrator.age)!")
}
let birthdayPerson = PersonWithComposition(name: "Джон Уик", age: 46)
wishHappyBirthday(celebrator: birthdayPerson)


// Глава 34. Разработка приложения в Xcode Playground

// Уровень доступа к объектам в Swift

// модификаторы доступа к объектам в Swift по нисходящей:
// - open, public: полная свобода использования объекта, позволяет импортировать модуль и свободно использовать его public-объекты в коде
// между ними есть следующие отличия:
//      - public-класс может иметь подклассы только в том модуле, где он был объявлен;
//      - public-члены класса могут быть переопределены(с помощью override) только в том модуле, где объявлен класс;
//      - open-класс может иметь подклассы внутри модуля, где он определён, и в модулях, импортированных в данном модуле;
//      - open-члены класса могут быть переопределены(с помощью override) в подклассе в том модуле, где класс был объявлен, а также в модулях, импортируемых в данном модуле.

// internal: данный уроверь используется, когда требуется ограничить использование объекта самим модулем, т.е. объект будет доступен во всех исходных файлах модуля, исключая его использование за пределами модуля;

// fileprivate: позволяет использовать объект только в пределах одного файла;

// private: позволяет использовать объект только в пределах конструкции, в которой он объявлен(объявленный в классе параметр не будет доступен в его расширении;

// по умолчанию все создаваемые объекты имеют модификатор internal

open class PublicClass {}
internal class InternalClass {}
fileprivate class PrivateClass {}
public var publicVar = 0
private var privateVar = 0
internal func internalFunc() {}


// Уровень доступа к типам данных в Swift

// если объект имеет вложенные объекты(класс со свойствами и методами), то уровень доступа родителя определяет уровни доступа к его членам, т.е. если вы укажете уровень private -> всего его члены по умолчанию будут иметь уровень доступа private. Для уровней доступа public и internal по умолчанию уровень доступа членов - internal

public class SomePublicClass { // public класс
    public var somePublicProperty = 0 // public свойство
    var someInternalProperty = 0 // internal свойство
    fileprivate func somePrivateMethod() {} // fileprivate метод
}
class SomeInternalClass { // internal класс
    var someInternalProperty = 0 // internal свойство
    private func somePrivateMethod() {} // private метод
}
private class SomePrivateClass { // private класс
    var somePrivateProperty = 0 // private свойство
    func somePrivateMethod() {} // private метод
}
// при наследовании уровень доступа подкласса не может быть выше уровня доступа суперкласса

// если создаётся кортеж, то указывать тип данных нельзя, он проставляется автоматически по самому строгому

// уровень доступа к функции определяется самым строгим уровнем типов аргументов и типа возвращаемого значения


// Глава 35. Универсальные шаблоны(generic)

// универсальные шаблоны позволяют создавать конструкции без привязки к конкретному типу данных

// функция свапа интов
func swapTwoInts(a: inout Int, b: inout Int) {
    let tempA = a
    a = b
    b = tempA
}
var fInt = 1
var sInt = 2
swapTwoInts(a: &fInt, b: &sInt)
fInt
sInt
// пример универсальной функции свапа
func swapTwoValues<T>(a: inout T, b: inout T) {
    let tempA = a
    a = b
    b = tempA
}
var firstString = "one"
var secondString = "two"
swapTwoValues(a: &firstString, b: &secondString)
firstString
secondString

// пример типа интового стэка
struct IntStack {
    var items = [Int]()
    mutating func push(_ item: Int) {
        items.append(item)
    }
    mutating func pop() -> Int {
        return items.removeLast()
    }
}
// пример стэка универсального типа
struct Stack<T> {
    var items = [T]()
    mutating func push(_ item: T) {
        items.append(item)
    }
    mutating func pop() -> T {
        return items.removeLast()
    }
}
var stackOfStrings = Stack<String>()
stackOfStrings.push("uno")
stackOfStrings.push("dos")
let fromTheTop = stackOfStrings.pop()

// стэк без необходимости указания типа данных при создании
struct NewStack<T> {
    var items = [T]()
    init(){}
    init(_ elements: T...) {
        self.items = elements
    }
    mutating func push(_ item: T) {
        items.append(item)
    }
    mutating func pop() -> T {
        return items.removeLast()
    }
}
var stackOfInt = NewStack(1, 2, 3, 4, 5)
type(of: stackOfInt)
var newStackOfStrings = NewStack<String>()
type(of: newStackOfStrings)


// Ограничение типа
// используется для наложения требований и ограничений на тип данных при помощи протоколов. При вызове этих конструкций сперва происходит проверка на соответствие типа значения данному протоколу
// к примеру для обеспечения сравнения двух значений воспользуемся протоколом Equtable
func findIndex<T: Equatable>(array: [T], valueToFind: T) -> Int? {
    for (index, value) in array.enumerated() {
        if value == valueToFind {
            return index
        }
    }
    return nil
}
var myArray = [3.14, 0.1, 0.25]
let firstIndex = findIndex(array: myArray, valueToFind: 0.1)
let secondIndex = findIndex(array: myArray, valueToFind: 228)


// Расширение универсального типа
// расширим универсальный тип NewStack, добавив в него вычисляемое свойство
extension NewStack {
    var topItem: T? {
        return items.isEmpty ? nil : items[items.count - 1]
    }
}
stackOfInt.topItem
stackOfInt.push(7)
stackOfInt.topItem


// Связанные типы
// при объявлении протокола могут быть использованы связанные типы, указывающие на некоторый, пока неизвестный тип данных. Связанный тип может задать заполнитель типа данных, который будет использован при заполнении протокола
// связанные типы указываются через ключевое слово associatedType
protocol Container {
    associatedtype ItemType
    mutating func append(item: ItemType)
    var count: Int {get}
    subscript(i: Int) -> ItemType {get}
}
// таким образом протокол Container может быть задействован в различных коллекциях. В этом случае тип данных, используемый в свойствах и методах, заранее не будет известен
struct AnotherStack<T>: Container {
    // typealias указывает, какой тип данных является связанным в данном объектном типе
    typealias ItemType = T
    var items = [T]()
    var count: Int {
        return items.count
    }
    init(){}
    init(_ elements: T...) {
        self.items = elements
    }
    subscript(i: Int) -> T {
        return items[i]
    }
    mutating func push(item: T) {
        items.append(item)
    }
    mutating func pop() -> T {
        items.removeLast()
    }
    mutating func append(item: T) {
        items.append(item)
    }
}


// Глава 36. Обработка ошибок

// Выбрасывание ошибок

// объявим перечень возможных ошибок автомата по продаже еды с помощью перечисления, которое должно поддерживать протокол Error
enum VendingMachineError: Error {
    // неправильный выбор
    case InvalidSelection
    // нехватка средств
    case InsufficientFunds(coinsNeeded: Int)
    // отсутствие выбранного товара
    case OutOfStock
}
// проброс ошибки с помощью оператора throw позволяет показать, что произошла нестандартная ситуация
// throw VendingMachineError.InsufficientFunds(coinsNeeded: 5)


// Обработка ошибок

// в Swift существуют 4 способа обработки ошибок:
// - передача ошибки;
// - обработка ошибки оператором do-catch;
// - преобразование ошибки в опционал;
// - запрет на выброс ошибки.

// необходимо указывать ключевое слово try перед вызовом функции, если вы знаете, что она может выбросить ошибку

// передача ошибки
// для того, чтобы указать блоку кода, что он должен передать дальше выброшенную ошибку, указывается ключевое слово throws
func anotherFunc() throws {
    // тело функции
    var _ = try someFunc()
}
func someFunc() throws -> String {
    // тело функции
    try anotherFunc()
    return ""
}
// для перехвата ошибки используется слово try перед вызовом функции
// try someFunc()

struct Item {
    var price: Int
    var count: Int
}
class VendingMachine {
    var inventory = [
        "Hambuga": Item(price: 12, count: 7),
        "Chips": Item(price: 10, count: 4),
        "Boohwooh": Item(price: 7, count: 11)
    ]
    var coinsDeposited = 0
    func dispenseSnack(snack: String) {
        print("Dispensing \(snack)")
    }
    func vend(itemNamed name: String) throws {
        guard var item = inventory[name] else {
            throw VendingMachineError.InvalidSelection
        }
        guard item.count > 0 else {
            throw VendingMachineError.OutOfStock
        }
        guard item.price <= coinsDeposited else {
            throw VendingMachineError.InsufficientFunds(coinsNeeded: item.price - coinsDeposited)
        }
        coinsDeposited -= item.price
        item.count -= 1
        inventory[name] = item
        dispenseSnack(snack: name)
    }
}

let favoriteSnacks = [
    "Alice": "Chips",
    "Chewkz": "Bottled water",
    "Lebron": "Fries"
]
// функция, которая автоматически пытается приобрести какой-либо товар
func buyFavoriteSnack(person: String, vendingMachine: VendingMachine) throws {
    let snackName = favoriteSnacks[person] ?? "Hambuga"
    try vendingMachine.vend(itemNamed: snackName)
}


// оператор do-catch
// в do будет содержится вызов функций или методов с помощью try, которые могут выбросить ошибку, а в блоках catch обрабатываются ошибки в соответствии с указанным шаблоном, или если шаблона нет, то вообще любая ошибка
var vendingMachine = VendingMachine()
vendingMachine.coinsDeposited = 8
do {
    try buyFavoriteSnack(person: "Alice", vendingMachine: vendingMachine)
} catch VendingMachineError.InvalidSelection {
    print("Invalid selection.")
} catch VendingMachineError.OutOfStock {
    print("Out of stock.")
} catch VendingMachineError.InsufficientFunds(let coinsNeeded) {
        print("Недостаточно средств, внесите ещё \(coinsNeeded) монет(ы).")
}


// Преобразование ошибки в опционал
// для преобразования выброшенной ошибки в опционал используется try?, т.е. если результатом метода или функции будет ошибка, то значение у переменной будет nil
func someThrowingFunction() -> Int {
    return 0
}
let x = try? someThrowingFunction()


// запрет на выброс ошибки выполняется с помощью оператора try! - это гарантирует, что данный блок кода не выбросит ошибку
// let photo = try! loadImage(...)
// но если ошибка всё же будет выброшена, то программа экстренно завершит свою работу


// отложенные действия по очистке происходят с помощью оператора defer, если их много, товыполняются снизу-вверх, т.е. сначала выполяется самый нижний и затем наверх
func processFile(fileName: String) throws {
    //if exists(fileName) {
    //    let file = open(fileName)
          // т.е. после завершения работы, файл будет закрыт
    //    defer {
    //        close(file)
    //    }
    //    while let line = try line.readline() {
            // работа с файлом
    //    }
    // }
}


// Глава 37. Нетривиальное использование операторов

// операторные функции
struct Vector2D {
    var x = 0.0, y = 0.0
}
func + (left: Vector2D, right: Vector2D) -> Vector2D {
    return Vector2D(x: left.x + right.x, y: left.y + right.y)
}
let vector = Vector2D(x: 3.0, y: 1.0)
let anotherVector = Vector2D(x: 2.0, y: 4.0)
let combinedVector = vector + anotherVector


// префиксные и постфиксные операторы
prefix func - (vector: Vector2D) -> Vector2D {
    return Vector2D(x: -vector.x, y: -vector.y)
}
let positive = Vector2D(x: 3.0, y: 4.0)
let negative = -positive


// составной оператор присваивания
func += (left: inout Vector2D, right: Vector2D) {
    left = left + right
}
var original = Vector2D(x: 1.0, y: 2.0)
let vectorToAdd = Vector2D(x: 3.0, y: 4.0)
original += vectorToAdd


// оператор эквивалентности
func == (left: Vector2D, right: Vector2D) -> Bool {
    return (left.x == right.x) && (left.y == right.y)
}
func != (left: Vector2D, right: Vector2D) -> Bool {
    return !(left == right)
}
let twoThree = Vector2D(x: 2.0, y: 3.0)
let anotherTwoThree = Vector2D(x: 2.0, y: 3.0)
if twoThree == anotherTwoThree {
    print("Equivalent")
}

// пользовательские операторы определяются с помощью слова operator и модификаторов prefix, infix, postfix
prefix operator +++
prefix func +++ (vector: inout Vector2D) -> Vector2D {
    vector += vector
    return vector
}
let afterDoubling = +++original
