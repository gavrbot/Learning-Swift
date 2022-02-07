// Часть 2

import Foundation
var str: String
var age = 21
age = 22
age
let friend1 = "John", friend2 = "Helga"
let age1 = 44, age2 = 33

// это мой возраст на данный момент
/*
 multiline comment
 */

//: markdown comment

var myAge = 21
var yourage = myAge
yourage
var `var` = "переменная с именем var"

// ; example
var number = 28
number = 44; var userName = "gavrbot"

print("Text message")

var foo = "Text for console"
print(foo)

var bar = "Swift"
print("Я изучаю \(bar)")

var hobbitsName = "Фродо"
var magicName : String = "Гендальф"

var variableOne = 23
var variableOneCopy: Int = variableOne
print(variableOneCopy)
variableOne = 25
print(variableOne)
print(variableOneCopy)

var minInt8 = Int8.min
var maxInt8 = Int8.max
var minUInt8 = UInt8.min
var maxUInt8 = UInt8.max

var numFloat: Float = 104.3
var numDouble: Double = 8.36
var someNumber = 8.36

var numberOne: Float = 3.14
var numberTwo: Float = 1.01
var result1 = numberOne.truncatingRemainder(dividingBy: numberTwo)
var result2 = -numberOne.truncatingRemainder(dividingBy: numberTwo)
var result3 = numberOne.truncatingRemainder(dividingBy: -numberTwo)

var numberInt = 19
var numberDouble = 3.13
var resD = Double(numberInt) * numberDouble
var resI = numberInt * Int(numberDouble)

var someNumInt = 19
someNumInt += 5
someNumInt *= 3
someNumInt -= 3
someNumInt %= 8

let decimalInteger = 17
let binaryInteger = 0b10001
let octalInteger = 0o21
let hexadecimalInteger = 0x11

var char: Character = "a"
print(char)

var stringOne: String = "Dragon"

var emptryString = ""
var anotherEmptyString = String()

let longString = """
multiline String literal
"""

var notEmptyString = String("Hello World!")

var numString = String(numDouble)

var name = "Dragon"
let hello = "Hello, my name is \(name)"
var meters: Double = 10
let text = "My length is \(meters * 3.28) feet"
print(hello)
print(text)

let firstText = "My weight "
var weight = 12.4
let secondText = " tonns"
var resultText = firstText + String(weight) + secondText
print(resultText)

let firstString = "Swift"
let secondString = "Objectoive-C"
let anotherString = "Swift"
firstString == secondString
firstString == anotherString

var isDragon = true
let isKnight: Bool = false
if isDragon {
    print("Hello Dragon!")
} else {
    print("Hello, Maybe Knight!")
}

typealias ageType = UInt8
var someAge: ageType = 29

typealias textType = String
typealias wordType = String
typealias charType = String
var someText: textType = "This is text"
var someWord: wordType = "Word"
var someChar: charType = "B"
var someString: String = "String of type String"

var myVar = 3.54
print(type(of: myVar))

var stringForHash = "Text string"
var intForHash = 23
var boolForHash = false

stringForHash.hashValue
intForHash.hashValue
boolForHash.hashValue
