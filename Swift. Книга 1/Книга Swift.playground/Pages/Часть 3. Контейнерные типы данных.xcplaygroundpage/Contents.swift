// Часть 3. Контейнерные типы данных

// Глава 6. Кортежи(Tuples)

import Foundation

let myProgramStatus = (200, "In work", true)

var tuple1 = (200, "In work", true)

var tuple2 = (true, "On work", 200)
// из-за разного порядка типов внутри кортежей
print(type(of: tuple1) == type(of: tuple2))

let floatStatus: (Float, String, Bool) = (200.2, "In work", true)

typealias numberType = Int
let numbersTuple: (Int, Int, numberType, numberType) = (0, 1, 2, 3)

var (statusCode, statusText, statusConnect) = myProgramStatus
print("Код ответа - \(statusCode)")
print("Текст ответа - \(statusText)")
print("Связь с сервером - \(statusConnect)")

var (myName, myAge) = ("Тролль", 140)
print("Мое имя \(myName), и мне \(myAge) лет")

print("Код ответа - \(myProgramStatus.0)")
print("Текст ответа - \(myProgramStatus.1)")
print("Связь с сервером - \(myProgramStatus.2)")

let statusTuple = (statusCode: 200, statusText: "In Work", statusConnect: true)
print("Код ответа - \(statusTuple.statusCode)")
print("Текст ответа - \(statusTuple.statusText)")
print("Связь с сервером - \(statusTuple.statusConnect)")

let anotherStatusTuple: (statusCode: Int, statusText: String, statusConnect: Bool) = (200, "In Work", true)
anotherStatusTuple.statusCode

var myFirstTuple: (Int, String) = (0, "0")
var mySecondTuple = (100, "Код")
myFirstTuple = mySecondTuple
myFirstTuple

var someTuple = (200, true)
someTuple.0 = 404
someTuple.1 = false
someTuple

(1, "alpha") < (2, "betta")
(4, "beta") < (4, "gamma")
(3.14, "pi") == (3.14, "pi")

// Глава 7. Последовательности и коллекции

/*
 Были изучены последовательности и коллекции, а также описаны протоколы
 */

var intVar = 12 // с помощью Option можно навести на тип и открыть документацию

// Глава 8. Диапазоны(Range)

var myRange = 1..<500

let rangeInt = 1..<5

var someRangeInt: Range<Int> = 1..<10
type(of: someRangeInt)
var anotherRangeInt = 51..<59
type(of: anotherRangeInt)
var angeInt: Range<Int> = 1..<10

var rangeString = "a"..<"z"
type(of: rangeString)
var rangeChar: Range<Character> = "a"..<"z"
type(of: rangeChar)
var rangeDouble = 1.0..<5.0
type(of: rangeDouble)

var firstElement = 10
var lastElement = 18
var myBestRange = firstElement..<lastElement

var oneSideRange = ..<500
type(of: oneSideRange)

var fullrange = 1...10
type(of: fullrange)

var infRange = 1...
type(of: infRange)

var closedRange = ...5

var intR = 1...10
intR.count

var floatR: ClosedRange<Float> = 1.0...2.0
floatR.contains(1.4)

var emptyR = 0..<0
emptyR.count
emptyR.isEmpty

var notEmptyR = 0...0
notEmptyR.count
notEmptyR.isEmpty

var anotherIntR = 20..<34
anotherIntR.lowerBound
anotherIntR.upperBound
anotherIntR.min()
anotherIntR.max()

// Глава 9. Массивы(Array)

let alphabetArray = ["a", "b", "c"]
var mutableArray = [2, 4, 8]

let newAlhabetArray = Array(arrayLiteral: "a", "b", "c")

let lineArray = Array(0...9)

let repeatArray = Array(repeating: "Swift", count: 5)

alphabetArray[1]
mutableArray[2]

var stringsArray = ["one", "two", "three", "four"]
stringsArray[1...2] = ["five"]
stringsArray

var firstAr = Array(arrayLiteral: "a", "b", "c")
type(of: firstAr)
var secondAr = Array(1..<5)
type(of: secondAr)

var arrayOne: Array<Character> = ["a", "b", "c"]
var arrayTwo: [Int] = [1, 2, 3, 4, 5]

var parentArray = ["one", "two", "three"]
var copyParentArray = parentArray
copyParentArray[1] = "four"
parentArray
copyParentArray

var emptyArray: [String] = []
var anotherEmptyArray = [String]()

let a1 = 1
let a2 = 2
let a3 = 3
var someArray = [1, 2, 3]
someArray == [a1, a2, a3]

let charsOne = ["a", "b", "c"]
let charsTwo = ["d", "e", "f"]
let charsThree = ["g", "h", "i"]
var alphabet = charsOne + charsTwo
alphabet += charsThree

var arrayOfArrays = [[1, 2, 3], [4, 5, 6], [7, 8, 9]]
arrayOfArrays[1]
arrayOfArrays[2][2]

var someAnotherArray = [1, 2, 3, 4, 5]
someArray.count

emptyArray.count
emptyArray.isEmpty

var numArray = [1, 2, 3, 4, 5]
var sliceOfArray = numArray[numArray.count-3...numArray.count-1]
let subArray = numArray.suffix(3)

numArray.first
numArray.last

numArray.append(6)

numArray.insert(100, at: 2)

numArray.remove(at: 2)
numArray.removeFirst()
numArray.removeLast()
numArray

numArray.dropLast()
var anotherNumArray = numArray.dropFirst(3)
numArray
anotherNumArray

let resultTrue = numArray.contains(4)
let resultFalse = numArray.contains(100)

let randomArray = [3, 2, 1, 4, 8, 7, 5]
randomArray.min()
randomArray.max()

var myAlphaArray = ["a", "bb", "ccc"]
myAlphaArray.reverse()
myAlphaArray

var unsortedArray = [3, 2, 44, 4, 8, 765, 33]
var sortedArray = unsortedArray.sorted()
unsortedArray
sortedArray

unsortedArray.sort()

var arrayOfNumbers = Array(1...10)
type(of: arrayOfNumbers)
var slice = arrayOfNumbers[4...6]
type(of: slice)

var arrayFromSlice = Array(slice)
type(of: arrayFromSlice)

arrayOfNumbers[5]
slice[5]

// Глава 10. Наборы(Set)

var dishes: Set<String> = ["bread", "vebetables", "water"]
var dishesTwo: Set = ["bread", "vegetables", "water"]
var members = Set<String>(arrayLiteral: "Anakin", "Obi Wan", "Yoda")
var membersTwo = Set(arrayLiteral: "Anakin", "Yoda", "Obi Wan")

var emptySet = Set<String>()
var setWithValues: Set<String> = ["one", "two"]
setWithValues = []

var musicStyleSet: Set<String> = []
musicStyleSet.insert("Jazz")
musicStyleSet

musicStyleSet = ["Jazz", "Hip-Hop", "Rock"]
musicStyleSet.remove("Hip-Hop")
musicStyleSet
musicStyleSet.remove("Classic")
musicStyleSet.removeAll()

musicStyleSet = ["Jazz", "Hip-Hop", "Rock", "Funk"]
musicStyleSet.contains("Funk")
musicStyleSet.contains("Pop")

musicStyleSet.count

let eventDigits: Set = [0, 2, 4, 6, 8]
let oddDigits: Set = [1, 3, 5, 7, 9]
let differentDigits: Set = [3, 4, 7, 8]

var inter = differentDigits.intersection(oddDigits)
var exclusive = differentDigits.symmetricDifference(oddDigits)
var union = eventDigits.union(oddDigits)
var subtract = differentDigits.subtracting(eventDigits)

var aSet: Set = [1, 2, 3, 4, 5]
var bSet: Set = [1, 3]
var cSet: Set = [6, 7, 8, 9]
bSet.isSubset(of: aSet)
aSet.isSuperset(of: bSet)
bSet.isDisjoint(with: cSet)
bSet.isStrictSubset(of: aSet)
aSet.isStrictSuperset(of: bSet)

var setOfNums: Set = [1, 10, 2, 5, 12, 23]
var anotherSortedArray = setOfNums.sorted()
type(of: sortedArray)

// Глава 11. Словари(Dictionary)

var dictionary = ["one":"один", "two":"два", "three":"три"]
var anotherDictionary = Dictionary(dictionaryLiteral: (100, "hundred"), (200, "two hundred"))

let baseCollection = [(2, 5), (3, 6), (1, 4)]
let newDictionary = Dictionary(uniqueKeysWithValues: baseCollection)

let nearestStarNames = ["Proxima Centauri", "Alplha Centauri A", "Alpha Centauri B"]
let nearestStarDistances = [4.24, 4.37, 4.37]
let starDistanceDict = Dictionary(uniqueKeysWithValues: zip(nearestStarNames, nearestStarDistances))

var codeDesc = [200: "success", 300: "warning", 400: "error"]
type(of: codeDesc)

var dictOne: Dictionary<Int, Bool> = [100: false, 200: true, 400: true]
var dictTwo: [String: String] = ["John": "Dave", "Eleonor": "Green"]

var countryDict = ["RUS": "Russia", "BEL": "Belarus", "UKR": "Ukraine"]
var countryName = countryDict["BEL"]
countryDict["RUS"] = "Russian Federation"

var oldValueOne = countryDict.updateValue("Republic Belarus", forKey: "BEL")
var oldValueTwo = countryDict.updateValue("Estonia", forKey: "EST")

countryDict["TUR"] = "Turkey"
countryDict

countryDict["TUR"] = nil
countryDict.removeValue(forKey: "BEL")
countryDict

var emptyDictionary: [String: Int] = [:]
var anotherEmptyDictionary = Dictionary<String, Int>()

dictionary.count
dictionary.isEmpty
var keys = dictionary.keys
type(of: keys)
var values = dictionary.values
type(of: values)

var keysSet = Set(keys)
var valuesArray = Array(values)

// Глава 12. Строка - коллекция символов(String)

var str = "Hello!"
str.count

let name = "e\u{301}lastic"
var index = name.startIndex
let firstChar = name[index]
type(of: index)
type(of: firstChar)
var indexLastChar = name.endIndex // указатель на следующий элемент после последнего
var lastChar = name.index(before: indexLastChar)
name[lastChar]

var fourCharIndex = name.index(name.startIndex, offsetBy: 3)
name[fourCharIndex]

name.count
name.unicodeScalars.count

var abc = "qwertyuiopasdfghjklzxcvbnm"
var firstIndexChar = abc.startIndex
var fourthIndexChar = abc.index(firstIndexChar, offsetBy: 3)
var subAbc = abc[firstIndexChar...fourCharIndex]
type(of: subAbc)
