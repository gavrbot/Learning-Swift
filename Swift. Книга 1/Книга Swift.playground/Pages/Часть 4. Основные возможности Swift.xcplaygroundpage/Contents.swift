// Часть 4. Основные возможности Swift

// Глава 13. Операторы управления

import Foundation

let strName = "Dragon"
let strYoung = "young"
let strOld = "old"
let strEmpty = " "
var dragonAge = 230
assert(dragonAge <= 235, strName + strEmpty + strOld)
assert(dragonAge >= 225, strName + strEmpty + strYoung)
print("Program succeded")

var logicVar = true
if logicVar == true {
    print("Variable logicVar has true value.")
}

if logicVar {
    print("Variable logicVar has true value.")
}
 
logicVar = false
if logicVar {
    print("Variable logicVar has true value.")
} else {
    print("Variable logicVar has false value")
}

var tenantCount = 6
var rentPrice = 0
if tenantCount < 5 {
    rentPrice = 1000
} else if tenantCount >= 5 && tenantCount <= 7 {
    rentPrice = 800
} else {
    rentPrice = 500
}
var allPrice = rentPrice * tenantCount

let a = 1
let b = 2
a <= b ? print("A less or equals to B") : print("A greater than B")

var height = 180
var isHeader = true
let rowHeight = height + (isHeader ? 20 : 10)

var userMark = 4
var message = ""

switch userMark {
case 1:
    message = "terrible"
case 2:
    message = "bullshit"
case 3:
    message = "weird but ok"
case 4:
    message = "not bad"
case 5:
    message = "excellent"
default:
    message = "incorrect mark"
}
print(message)

switch userMark {
case 1..<3:
    print("exam failed")
case 3:
    print("additional task required")
case 4...5:
    print("exam passed")
default:
    assert(false, "incorrect mark")
}

var answer: (code: Int, message: String) = (code: 200, message: "Ok")
switch answer {
case (100..<400, _):
    print(answer.message)
case(400..<500, _):
    assert(false, answer.message)
default:
    print("Incorrect response")
}

var dragonCharacteristics: (color: String, weight: Float) = ("red", 1.4)
switch dragonCharacteristics {
case ("green", 0..<2):
    print("1 group")
case ("red", 0..<2):
    print("2 group")
case ("green", 2...), ("red", 2...):
    print("3 group")
default:
    print("incorrect dragon")
}

var dragonsCount = 3
switch dragonCharacteristics {
case ("green", 0..<2):
    print("1 group")
case ("red", 0..<2):
    print("2 group")
case ("green", 2...) where dragonsCount < 5,
     ("red", 2...) where dragonsCount < 5:
    print("3 group")
default:
    print("incorrect dragon")
}

switch dragonCharacteristics {
case ("green", 0..<2):
    print("1 group")
case ("red", 0..<2):
    print("2 group")
case ("green", 2...) where dragonCharacteristics.weight.truncatingRemainder(dividingBy: 1) == 0,
     ("red", 2...) where dragonCharacteristics.weight.truncatingRemainder(dividingBy: 1) == 0:
    print("3 group")
default:
    print("incorrect dragon")
}

switch dragonCharacteristics {
case ("green", 0..<2):
    print("1 group")
case ("red", 0..<2):
    print("2 group")
    case let (color, weight) where (color == "green" || color == "red")
    && weight.truncatingRemainder(dividingBy: 1) == 0
    && dragonsCount < 5:
        print("Group 3. Dragon's weight: \(weight) tonns")
default:
    print("incorrect dragon")
}

var someInt = 12
switch someInt {
case 1...:
    print("greater than 0")
case ..<0:
    print("less than 0")
default:
    break
}

var level: Character = "B"
switch level {
case "A":
    print("turn off all electric things")
    fallthrough
case "B":
    print("close all doors and windows")
    fallthrough
case "C":
    print("keep calm")
default:
    break
}

var i = 1
var resultSum = 0
while i <= 10 {
    resultSum += i
    i += 1
}
resultSum

var y = 1
var result = 0
repeat {
    result += y
    y += 1
} while y <= 10
result

var x = 0
var sum = 0
while x <= 10 {
    x += 1
    if x % 2 == 1 {
        continue
    }
    sum += x
}
sum

var lastNum = 54
var currentNum = 1
var sumOfInts = 0
while currentNum <= lastNum {
    sumOfInts += currentNum
    if sumOfInts > 450 {
        print("Storage is fulled. Last proceeded number is \(currentNum)")
        break
    }
    currentNum += 1
}

let numArray: Array<Int> = [1, 2, 3, 4, 5]
result = 0
for number in numArray {
    result += number
}
result

for number in 1...5 {
    print(number, number)
}

for word in "Swift" {
    print(word)
}

var myChar = "a"
let myString = "Swift"
for myChar in myString {
    let myString = "Char is"
    print("\(myString) \(myChar)")
}
myChar
myString

for _ in 1...3 {
    print("repeat")
}

var countriesAndBlocks = ["Russia": "CIS", "France": "EU"]
for (countryName, orgName) in countriesAndBlocks {
    print("\(countryName) joined \(orgName)")
}

for (countryName, _) in countriesAndBlocks {
    print("Country - \(countryName)")
}

for (_, orgName) in countriesAndBlocks {
    print("Organization - \(orgName)")
}

for countryName in countriesAndBlocks.keys {
    print("Country - \(countryName)")
}

for orgName in countriesAndBlocks.values {
    print("Organization - \(orgName)")
}

print("Some facts about me")
var myMusicStyles = ["Rock", "Jazz", "Pop"]
for (index, musicName) in myMusicStyles.enumerated() {
    print("\(index + 1). I love \(musicName)")
}

for i in stride(from: 1, through: 10, by: 3) {
    print(i)
}

for i in stride(from: 1, to: 10, by: 3) {
    print(i)
}

result = 0
for i in 1...10 where i % 2 == 0 {
    result += i
}
result

var resultsOfGames = ["Red Wings": ["2:1", "2:3"], "Capitals": ["3:6", "5:5"], "Penguins": ["3:3", "1:2"]]
for (teamName, results) in resultsOfGames {
    for oneResult in results {
        print("Games with \(teamName) - \(oneResult)")
    }
}

for i in 1...10 {
    if i % 2 == 0 {
        continue
    } else {
        print(i)
    }
}

for i in 1... {
    let randNum = Int(arc4random_uniform(100))
    if randNum == 5 {
        print("Iteration number \(i)")
        break
    }
}

mainLoop: for i in 1...5 {
    for y in i...5 {
        if y == 4 && i == 2 {
            break mainLoop
        }
        print("\(i) - \(y)")
    }
}

// Глава 14. Опционалы (Optionals)

let possibleString = "1032"
let convertPossibleString = Int(possibleString)
type(of: convertPossibleString)
let unpossibleString = "number"
let convertImpossibleString = Int(unpossibleString)
type(of: convertImpossibleString)

var optionalChar: Optional<Character> = "a"

var xCoordinate: Int? = 12
xCoordinate = nil

var someOptional: Bool? // variable has nil value by default

var optionalVar = Optional("stringValue")
optionalVar
optionalVar = nil
type(of: optionalVar)

var tuple: (code: Int, message: String)? = nil
tuple = (404, "Page not found")
type(of: tuple)

var tupleWithOptElements: (Int?, Int) = (nil, 100)
tupleWithOptElements.0
type(of: tupleWithOptElements.0)
tupleWithOptElements.1
type(of: tupleWithOptElements.1)

var aVar: Int = 4
var bVar: Int? = 5
// a + b will be failed because of different types

// unwrapping of optional value

var optVar: Int? = 12
var intVar = 34
result = optVar! + 34

var optString: String? = "Alex Gavrbot"
var unwrappedString = optString! // shouldn't be nil !!!!!!
print("My name is \(unwrappedString)")

var nilVar: String? = nil
// var unwrapNil = nilVar! // error!!!!

// косвенное извлечение работает таким образом, что при выполнении операций с опциональным типом извлечение будет происходить автоматически
var wrapInt: Double! = 3.14
wrapInt + 0.12

var optOne: UInt? = nil
var optTwo: UInt? = 32
optOne != nil
optTwo != nil

var fiveMarkCount: Int? = 8
var allCakesCount = 0
if fiveMarkCount != nil {
    let cakeForEachFiveMark = 2
    allCakesCount = cakeForEachFiveMark * fiveMarkCount!
}
allCakesCount

// опциональное связывание - одновременное извлечение параметра и инициализация его во временный параметр

var markCount: Int? = 8
if let marks = markCount {
    print("number of marks - \(marks)")
    type(of: marks)
}

var pointX: Int? = 10
var pointY: Int? = 3
if let _ = pointX, let _ = pointY {
    print("Point is on surface.")
}

if let x = pointX, x > 5 {
    print("Point is far from you")
}

var coinsInNewChest = "140"
var allCoinsCount = 1301
if Int(coinsInNewChest) != nil {
    allCoinsCount += Int(coinsInNewChest)!
} else {
    print("There is no gold from new Dragon")
}

// optimized by deleting 2 calls if Int(_:) function
var coins = Int(coinsInNewChest)
if coins != nil {
    allCoinsCount += coins!
} else {
    print("There is no gold from new Dragon")
}

// optimized by removind coins variable from memory
if let coins = Int(coinsInNewChest) {
    allCoinsCount += coins
} else {
    print("There is no gold from new Dragon")
}

// оператор объединения с nil. Если опционал равен nil, то берётся значение по умолчанию
var optionalInt: Int? = 20
var mustHaveResult = optionalInt ?? 0
type(of: mustHaveResult)

// Глава 15. Функции

func printMessage() {
    print("Mail!!!")
}
printMessage()

func sumTwoInt(a: Int, b: Int) {
    print("Result - \(a + b)")
}
sumTwoInt(a: 10, b: 12)

// создано для сохранения качества кода внутри функции и для понятных названий переменных снаружи
func sumTwoInt(num1 a:Int, num2 b: Int) {
    print("Result - \(a + b)")
}
sumTwoInt(num1: 12, num2: 12)

func sumTwoInt(_ a: Int, _ b: Int) -> Int {
    let result = a + b
    print("Result - \(result)")
    return result
}

result = sumTwoInt(50, 13)

// значения параметров функции являются неизменяемыми. Если нужно изменить их значение, то необходимо создавать новую переменную и изменять уже её
func returnMessage(code: Int, message: String) -> String {
    var mutableMessage = message
    mutableMessage += String(code)
    return mutableMessage
}

var myMessage = returnMessage(code: 228, message: "оп смотри как могу - ")

// чтобы было возможно изменять значение переменных необходимо указывать оператор inout перед типом переменной в описании функции и передавать параметры через &
func changeValues(_ a: inout Int, _ b: inout Int) -> () {
    let tmp = a
    a = b
    b = tmp
}
var xVar = 150, yVar = 345
changeValues(&xVar, &yVar)
xVar
yVar

print(returnMessage(code: 200, message: "Success "))

// функции с переменным числом параметров. Переменные содержатся в последовательности(Sequence)
func printRequestString(codes: Int...) -> Void {
    var codesString = ""
    for oneCode in codes {
        codesString += String(oneCode) + " "
    }
    print("Received codes: \(codesString)")
}
printRequestString(codes: 200, 120, 404, 501)

// функции, возвращающие набор значений в виде кортежа
func getCodeDescriptor(code: Int) -> (Int, String) {
    let description: String
    switch code{
    case 1...100:
        description = "Error"
    case 101...200:
        description = "Correct"
    default:
        description = "Unknown"
    }
    return (code, description)
}
getCodeDescriptor(code: 200)

// refactored by adding name of returning variables
func getCodeDescription(code: Int) -> (code: Int, description: String) {
    let description: String
    switch code {
    case 1...100:
        description = "Error"
    case 101...200:
        description = "Correct"
    default:
        description = "Unknown"
    }
    return (code, description)
}
let request = getCodeDescription(code: 45)
request.description
request.code

func refReturnMessage(code: Int, message: String = "Code - ") -> String {
    var mutableMessage = message
    mutableMessage += String(code)
    return mutableMessage
}
refReturnMessage(code: 200)


// возвращаемое значение функционального типа(возвращаемое значение вернёт функцию вида () -> () )
func printText() {
    print("Function is called")
}
func returnPrintTextFunction() -> () -> () {
    return printText
}

print("Step 1")
let newFunctionInLet = returnPrintTextFunction()
print("Step 2")
newFunctionInLet()
print("Step 3")


func generateWallet(walletLength: Int) -> [Int] {
    let typesOfBanknotes = [50, 100, 500, 1000, 5000]
    var wallet: [Int] = []
    for _ in 1...walletLength {
        let randomIndex = Int(arc4random_uniform(UInt32(typesOfBanknotes.count - 1)))
        wallet.append(typesOfBanknotes[randomIndex])
    }
    return wallet
}
func sumWallet(banknotsFunction wallet: (Int) -> [Int], walletLenght: Int) -> Int? {
    let myWalletArray = wallet(walletLenght)
    var sum: Int = 0
    for oneBanknote in myWalletArray {
        sum += oneBanknote
    }
    return sum
}
sumWallet(banknotsFunction: generateWallet, walletLenght: 20)


func oneStep(coordinates: inout (Int, Int), stepType: String) {
    func up(coords: inout (Int, Int)) {
        coords = (coords.0 + 1, coords.1)
    }
    func right(coords: inout (Int, Int)) {
        coords = (coords.0, coords.1 + 1)
    }
    func down(coords: inout (Int, Int)) {
        coords = (coords.0 - 1, coords.1)
    }
    func left(coords: inout (Int, Int)) {
        coords = (coords.0, coords.1 - 1)
    }
    
    switch stepType {
    case "up":
        up(coords: &coordinates)
    case "down":
        down(coords: &coordinates)
    case "left":
        left(coords: &coordinates)
    case "right":
        right(coords: &coordinates)
    default:
        break
    }
}
var coordinates = (10, -5)
oneStep(coordinates: &coordinates, stepType: "up")
oneStep(coordinates: &coordinates, stepType: "right")
coordinates


func say(what: String){}
func say(what: Int){}

func cry() -> String {
    return "one"
}
func cry() -> Int {
    return 1
}

// let resultOfFunc = say() - ERROR
let resultString: String = cry()
var resultInt = cry() + 101


func countDown(firstNum num: Int) {
    print(num)
    if num > 0 {
        countDown(firstNum: num - 1)
    }
}
countDown(firstNum: 10)

// Глава 16. Замыкания(Closure)
//  Функции - общий вид замыканий, так как замыкания есть блоки кода, которые можно вызывать и передавать по ссылке, но для наглядности функции есть функции в привычном понимании, а замыкания - безымянные функции
var wallet = [10, 50, 100, 100, 5000, 100, 50, 50, 500, 100]
func handle100(wallet: [Int]) -> [Int] {
    var returnWallet = [Int]()
    for banknot in wallet {
        if banknot == 100 {
            returnWallet.append(banknot)
        }
    }
    return returnWallet
}
handle100(wallet: wallet)

func handle1000(wallet: [Int]) -> [Int] {
    var returnWallet = [Int]()
    for banknot in wallet {
        if banknot >= 1000 {
            returnWallet.append(banknot)
        }
    }
    return returnWallet
}
handle1000(wallet: wallet)

// неудобно плодить такие функции, отличающиеся только лишь проверяемым условием
// решение - замыкания

func handle(wallet: [Int], closure: (Int) -> Bool) -> [Int] {
    var returnWallet = [Int]()
    for banknot in wallet {
        if closure(banknot) {
            returnWallet.append(banknot)
        }
    }
    return returnWallet
}

func compare100(banknot: Int) -> Bool {
    return banknot == 100
}

func compareMore1000(banknot: Int) -> Bool {
    return banknot >= 1000
}

let resultWalletOne = handle(wallet: wallet, closure: compare100)
let resultWalletTwo = handle(wallet: wallet, closure: compareMore1000)
// аналог с описанием замыкания внутри вызова функции
handle(wallet: wallet, closure: {(banknot: Int) -> Bool in
    return banknot >= 1000
})
handle(wallet: wallet, closure: {(banknot: Int) -> Bool in
    return banknot == 100
})


handle(wallet: wallet, closure: {banknot in
    return banknot >= 1000
})

handle(wallet: wallet, closure: {banknot in banknot >= 1000})

// сокращённые имена параметров описываются через $ : $0 - нулевой по счёту параметр, передаваемый в функции и тд. То есть если у фунеции параметры (first: Int, second: Bool), то через $0 будет доступ к first
handle(wallet: wallet, closure: {$0 >= 1000})

// если входной параметр-функция является последним в списке передаваемых параметров, то его можно вынести за скобки. Полезно в тех случаях, когда замыкание будет многострочным
handle(wallet: wallet){$0 >= 1000}

handle(wallet: wallet){
    banknot in
    for number in Array(arrayLiteral: 100, 500) {
        if number == banknot {
            return true
        }
    }
    return false
}
// или
var successBanknots = handle(wallet: wallet){
    Array(arrayLiteral: 100, 500).contains($0)
}

var closure: () -> () = {
    print("closure")
}
closure()

// для безымянных функций, которые определены в параметр, входные параметры замыкания не должны иметь внешних имён, поэтому они либо не указываются, либо обозначаются с помощью "_"
var closurePrint: (String) -> () = { text in
    print(text)
}
closurePrint("Chlen")

var sumVar: (_ numOne: Int, _ numTwo: Int) -> Int = {
    return $0 + $1
}
sumVar(10, 14)


var array = [1, 44, 81, 4, 277, 50, 101, 51, 8]
var sortedArray = array.sorted(by: { (first: Int, second: Int) -> Bool in
    return first < second
})
//optimized
sortedArray = array.sorted(by: {$0 < $1})
sortedArray
// and once more optimized
sortedArray = array.sorted(by: <)

var alpha = 1
var betta = 2
let closureSum: () -> Int = {
    return alpha + betta
}
closureSum()
alpha = 3
betta = 4
closureSum()
// перепишем с захватом значений переменных alpha и betta
alpha = 1
betta = 2
let closureSumCatch: () -> Int = {
    [alpha, betta] in
    return alpha + betta
}
closureSumCatch()
alpha = 3
betta = 4
closureSumCatch()

// захват вложенной функции
func makeIncrement(forIncrement amount: Int) -> () -> Int {
    var runningTotal = 0
    func increment() -> Int {
        runningTotal += amount
        return runningTotal
    }
    return increment
}
var incrementByTen = makeIncrement(forIncrement: 10)
var incrementbySeven = makeIncrement(forIncrement: 7)
incrementByTen()
incrementByTen()
incrementByTen()
incrementbySeven()
incrementbySeven()
incrementbySeven()

// так как в элементах incrementbyTen и incrementBySeven хранятся замыкания, то при доступе к ним после их имени нужно указывать () (по аналогии с вызовом функции)

// замыкания передаются по ссылке!!!! функциональный тип данных - это ссылочный тип, т.е.
var incrementbyFive = makeIncrement(forIncrement: 5)
var copyIncrementByFive = incrementbyFive
incrementbyFive()
copyIncrementByFive()
incrementbyFive()


var arrayOfNames = ["Helga", "Bazil", "Alex"]
func printName(nextName: String) {
    print(nextName)
}
printName(nextName: arrayOfNames.remove(at: 0))

// в этой функции независимо от того, в какой части фунцкии будет использоваться параметр, возвращаемое значение будет вычислено в момент вызова функции printName. Чтобы высчитывать значение именно тогда, когда оно понадобится, можно воспользоваться ленивым вычислением с помощью замыкания
func printNameClosure(nextName: () -> String) {
    // some code
    print(nextName())
}
printNameClosure(nextName: {arrayOfNames.remove(at:  0)})
// таким образом значение выражения remove(at:) будет вычислено именно тогда, когда оно пригодится, а не при вызове функции printName
// недостаток - передача параметров в {} и как следствие - усложнение кода
// выход - автозамыкания
// для него есть несколько условий:
// 1. входной аргумент имеет функциональный тип
// 2. функциональный тип не должен определять типы входных параметров
// 3. функциональный тип должен определять тип возвращаемого значения
// 4. переданное выражение должно возвращать значение того же типа, которое определено в функциональном типе замыкания
// 5. перед функциональным типом необходимо использовать атрибут @autoclosure
func printNameAutoClosure(nextName: @autoclosure () -> String) {
    print(nextName())
}
printName(nextName: arrayOfNames.remove(at: 0))


// замыкания имеют ограниченную область видимости в пределах функции, в которую мы их передаём. следующий код вызовет ошибку
var arrayOfClosures: [() -> Int] = []
//func addNewClosureInArray(_ newClosure: () -> Int) {
//    arrayOfClosures.append(newClosure)
//}
// чтобы позволить замыканию выходить за область видимости функции, необходимо указать атрибут @escaping
func addNewClosureInArray(_ newClosure: @escaping () -> Int) {
    arrayOfClosures.append(newClosure)
}
addNewClosureInArray({return 100})
addNewClosureInArray{return 1000}

// рассмотрим каррирование функций, т.е. если у нас была функция с 3-мя входными параметрами, то сделаем из неё функцию с 1 входным параметром
func sum(x: Int, y: Int) -> Int{
    return x + y
}
sum(x: 1, y: 2)

func sumTwo(_ x: Int) -> (Int) -> Int{
    return { return $0 + x}
}
var anotherClosure = sumTwo(1)
anotherClosure(12)
sumTwo(5)(12)

var sumClosure = sumTwo(1)
sumClosure(12)
sumClosure(19)

// Глава 17. Дополнительные возможности

// map(_:) применяет переданное в него замыкание на каждый элемент коллекции

var myArray = [2, 4, 5, 7]
var newArray = myArray.map{$0*$0}
newArray

var intArray = [1, 2, 3, 4]
var boolArray = intArray.map{$0 > 2}
boolArray

let numbers = [1, 2, 3, 4]
let mapped = numbers.map{ Array(repeating: $0, count: $0)}
mapped

// mapValues(_:) позволит обработать значения для каждого элемента словаря, не меняя при этом ключей

var mappedCloseStars = ["Proxima Centauri": 4.24, "Alpha Centauri A": 4.37]
var newCollection = mappedCloseStars.mapValues{$0 + 1}
newCollection

// filter(_:) используется для фильтрации коллекций по правилу

let numArrayFilter = [1, 4, 10, 15]
let even = numArrayFilter.filter{ $0 % 2 == 0 }
even

var starDistanceDict = ["Wolf 359": 7.78, "Alpha Centauri B": 4.37, "Barnard's Star": 5.96]
let closeStars = starDistanceDict.filter{ $0.value < 5.0}
closeStars

// allSatisfy(_:) - метод такой же как filter, только выводится Bool значение, удовлетворяют ли все элементы коллекции заданному условию или нет

let ages = [20, 28, 30, 45]
let allAdults = ages.allSatisfy { $0 >= 18 }
allAdults

// reduce(_:_:) позволяет объединить все элементы коллекции в одно значение в соответствии с переданным замыканием, принимая на вход первым аргументом первоначальное значение, а вторым - замыкание

let cash = [10, 50, 100, 500]
let total = cash.reduce(210, +)
total

let multiTotal = cash.reduce(210, { $0 * $1 })
multiTotal

let totalThree = cash.reduce(210, { a, b in a - b })
totalThree

// flatMap(_:) - тот же метод, что и map(_:) , но всегда возвращает плоский одномерный массив

let numbersArray = [1, 2, 3, 4]
let flatMapped = numbersArray.flatMap({ Array(repeating: $0, count: $0) })
flatMapped

let someArray = [[1, 2, 3, 4, 5], [11, 44, 1, 6],[16, 403, 321, 10]]
let filterSomeArray = someArray.flatMap{ $0.filter{ $0 % 2 == 0 } }
filterSomeArray

// zip(_:_:) формирует последовательности пар значений, каждая из которых составлена их элементов двух базовых значений

let collectionOne = [1, 2, 3]
let collectionTwo = [4, 5, 6]
var zipSequence = zip(collectionOne, collectionTwo)
type(of: zipSequence)
Array(zipSequence)
let newDictionary = Dictionary(uniqueKeysWithValues: zipSequence)

// оператор guard для опционалов позволяет сокращать код проверки в случае, если функционал имеент значение nil

func countSidesOfShape(shape: String) -> Int? {
    switch shape{
    case "треугольник":
        return 3
    case "квадрат":
        return 4
    default:
        return nil
    }
}

func maybePrintCountSides(shape: String) {
    if let sides = countSidesOfShape(shape: shape) {
        print("Фигура \(shape) имеет \(sides) стороны")
    } else {
        print("Неизвестно количество сторон")
    }
}

func guardMaybePrintCountSides(shape: String) {
    guard let sides = countSidesOfShape(shape: shape) else {
        print("Неизвестно количество сторон")
        return
    }
    print("Фигура \(shape) имеет \(sides) стороны")
}

// Глава 18. Ленивые вычисления.

// lazy-by-name - значение элемента вычисляется при каждом доступе к нему
// lazy-by-need - элемент вычисляется один раз при первом обращении, после чего фиксируется и больше не меняется

// lazy-by-name создаются с помощью замыканий

arrayOfNames = ["Helga", "Bazil", "Alex"]
arrayOfNames.count
let nextName = { arrayOfNames.remove(at: 0) }
arrayOfNames.count
nextName()
arrayOfNames.count

// свойство lazy у массивов и словарей

// в данном примере возвращается ленивая коллекция, память под отдельный массив целочисленных значений не выделяется, а вычисления метода map не производятся до тех пор, пока не произойдёт обращение к переменной collection

var baseCollection = [1, 2, 3, 4, 5, 6]
var myLazyCollection = baseCollection.lazy
type(of: myLazyCollection)
var collection = myLazyCollection.map{ $0 + 1 }
type(of: collection)

// можно увеличивать цепочки вызовов, при этом не расходуя ресурсы

var resultCollection = [1, 2, 3, 4, 5, 6].lazy.map{$0 + 1}.filter{$0 % 2 == 0}
