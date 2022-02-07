// Big O нотация - показатель вычислительной сложности функции или алгоритма

// пример функции со сложностью O(1) - постоянное время, т.е. не зависит ни от каких переменных и сложность постоянна
func constantTime(_ n: Int) -> Int {
    let result = n * n
    return result
}

// пример функции со сложность O(n) - линейное время, т.е. зависимость от одной переменной и сложность пропорциональна размеру ввода
func linearTime(_ A:[Int]) -> Int {
    for i in 0..<A.count {
        if(A[i] == 0){
            return 0
        }
    }
    return 1
}

// пример функции со сложностью O(log(n)) - логарифмическое время, т.е. здесь каждую итерацию идёт сокращение исходной длины коллекции(иного) на 2, таким образом, образуя логарифмическую сложность
func logarithmicTime(_ N: Int) -> Int {
    var n = N
    var result = 0
    while n > 1 {
        n /= 2
        result += 1
    }
    return result
}

// пример функции со сложностью O(n^2) - квадратичное время, т.е. сложность алгоритма пропорциональна квадрату размера ввода
func quadratic(_ n: Int) -> Int {
    var result = 0
    for i in 0..<n {
        for j in i..<n {
            result += 1
            print("\(i), \(j)")
        }
    }
    return result
}


// имеется следующая задача:
// Имея два массива, создайте функцию, которая позволит пользователю узнать, содержат ли эти два массива какие-либо общие элементы.

// грубое решение с маленькой затратой памяти, но сложностью O(n^2)
func commonItemsBrute(_ A: [Int], _ B: [Int]) -> Bool {
    for i in 0..<A.count {
        for j in 0..<B.count {
            if A[i] == B[j] {
                return true
            }
        }
    }
    return false
}

// решение с чуть большей затратой памяти на хэш мапу, но сложность в данном случае будет O(n)
func commonItemsHash(_ A: [Int], _ B: [Int]) -> Bool {
    var hashA = [Int: Bool]()
    for a in A { // O(n)
        hashA[a] = true
    }
    
    for b in B {
        if hashA[b] == true {
            return true
        }
    }
    return false
}

commonItemsBrute([1, 2, 3], [4, 5, 6])
commonItemsHash([1, 2, 3], [4, 5, 6])

