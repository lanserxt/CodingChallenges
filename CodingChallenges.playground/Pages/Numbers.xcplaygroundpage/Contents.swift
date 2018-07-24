//: [Strings](@previous)

import Foundation
import UIKit

/*:
 Help function to check that something is actually executing
 */
func algorithm(_ operations: () -> Void) {
    print("Start testing...")
    operations()
    print("End...")
}

/*:
 ## Challenge 16
 ###  Write a function that counts from 1 through 100, and prints “Fizz” if the counter is evenly divisible by 3, “Buzz” if it’s evenly divisible by 5, “Fizz Buzz” if it’s even divisible by three and five, or the counter number for all other cases.
 */
func challenge16() {
    
    func fizzBuzz(number: Int) -> String {
        switch (number % 3 == 0, number % 5 == 0) {
        case (true, true):
            return "Fizz Buzz"
        case (true, false):
            return "Fizz"
        case (false, true):
            return "Buzz"
        default:
            return String(number)
        }
    }
    
    func challenge16(){
        for number in 1...100 {
            print("\(number): \(fizzBuzz(number: number))")
        }
    }
    
    algorithm {
        challenge16()
        assert(fizzBuzz(number: 1) == "1", "Challenge 16 failed")
        assert(fizzBuzz(number: 2) == "2", "Challenge 16 failed")
        assert(fizzBuzz(number: 3) == "Fizz", "Challenge 16 failed")
        assert(fizzBuzz(number: 4) == "4", "Challenge 16 failed")
        assert(fizzBuzz(number: 5) == "Buzz", "Challenge 16 failed")
        assert(fizzBuzz(number: 15) == "Fizz Buzz", "Challenge 16 failed")
    }
}

/*:
 ## Challenge 17
 ### Write a function that accepts positive minimum and maximum integers, and returns a random number between those two bounds, inclusive
 */
func challenge17() {
    
    func challenge17(min: Int, max: Int) -> Int {
        return Int(arc4random_uniform(UInt32(max - min + 1))) + min
    }
    
    algorithm {
        assert(10...15 ~= challenge17(min: 10, max: 15), "Challenge 17 failed")
        assert(20...30 ~= challenge17(min: 20, max: 30), "Challenge 17 failed")
        assert(40...50 ~= challenge17(min: 40, max: 50), "Challenge 17 failed")
    }
}


/*:
 ## Challenge 18
 ### Create a function that accepts positive two integers, and raises the first to the power of the second
 */
func challenge18() {
    
    func challenge18a(number: Int, power: Int) -> Int {
        func myPow(_ number: Int, _ power: Int) -> Int {
            if power == 1 {
                return number
            }
            return number * myPow(number, power - 1)
        }
        return myPow(number, power)
    }
    
    algorithm {
        assert(challenge18a(number: 4, power: 3) == 64, "Challenge 18 failed")
        assert(challenge18a(number: 2, power: 8) == 256, "Challenge 18 failed")
    }
}


/*:
 ## Challenge 19
 ### Swap two positive variable integers, a and b, without using a temporary variable
 */
func challenge19() {    
    
    algorithm {
        var a: Int = 5
        var b: Int = 7
        (b,a) = (a,b)
        
        assert(a == 7, "Challenge 19 failed")
        assert(b == 5, "Challenge 19 failed")
    }
}

/*:
 ## Challenge 20
 ### Write a function that accepts an integer as its parameter and returns true if the number is prime
 */
func challenge20() {
    
    func challenge20(number: Int) -> Bool {
        guard number >= 2 else {
            return false
        }
        guard number != 2 else {
            return true
        }
        let max = Int(ceil(sqrt(Double(number))))
        
        for i in 2 ... max {
            if number % i == 0 {
                return false
            }
        }
        return true
    }
    
    algorithm {
        assert(challenge20(number: 11) == true, "Challenge 20 failed")
        assert(challenge20(number: 13) == true, "Challenge 20 failed")
        assert(challenge20(number: 4) == false, "Challenge 20 failed")
        assert(challenge20(number: 9) == false, "Challenge 20 failed")
        assert(challenge20(number: 16777259) == true, "Challenge 20 failed")
    }
    
}

/*:
 ## Challenge 21
 ### Create a function that accepts any positive integer and returns the next highest and next lowest number that has the same number of ones in its binary representation. If either number is not possible, return nil for it.
 */
extension String {
    func numberOfChar(_ char: Character) -> Int {
        guard self.count > 0 else {
            return 0
        }
        return self.filter({$0 == char}).count
    }
}

extension BinaryInteger {
    var binaryString: String {
        return String.init(Int(self), radix: 2, uppercase: false)
    }
}

func challenge21() {
    
    func challenge21(number: Int) -> (nextHighest: Int?, nextLowest: Int?) {
        let numberOfOnes = number.binaryString.numberOfChar("1")
        
        var result: (nextHighest: Int?, nextLowest: Int?) = (nil, nil)
        for val in number + 1...Int.max {
            if val.binaryString.numberOfChar("1") == numberOfOnes {
                result.nextHighest = val
                break
            }
        }
        for val in (0..<number).reversed() {
            if val.binaryString.numberOfChar("1") == numberOfOnes {
                result.nextLowest = val
                break
            }
        }
        return result
    }
    
    algorithm {
        assert(challenge21(number: 12) == (17, 10), "Challenge 21 failed")
    }
    
}

/*:
 ## Challenge 22
 ### Create a function that accepts an unsigned 8-bit integer and returns its binary reverse, padded so that it holds precisely eight binary digits.
 */
func challenge22() {
    
    func challenge22(number: UInt) -> UInt {
        var binaryString = number.binaryString
        if binaryString.count < 8 {
            binaryString = String.init(repeating: "0", count: 8 - binaryString.count) + binaryString
        }
        
        return UInt(String(binaryString.reversed()), radix: 2)!
    }
    
    algorithm {
        assert(challenge22(number: 32) == 4, "Challenge 22 failed")
        assert(challenge22(number: 41) == 148, "Challenge 22 failed")
    }
    
}

/*:
 ## Challenge 23
 ### Write a function that accepts a string and returns true if it contains only numbers, i.e. the digits 0 through 9
 */
func challenge23() {
    
    func challenge23(input: String) -> Bool {
        let numbers = (0...9).compactMap({String($0)}).joined()
        
        return input.filter({numbers.contains($0)}).count == input.count
    }
    
    algorithm {
        assert(challenge23(input: "01010101") == true, "Challenge 23 failed")
        assert(challenge23(input: "123456789") == true, "Challenge 23 failed")
        assert(challenge23(input: "1.01") == false, "Challenge 23 failed")
    }
}

/*:
 ## Challenge 24
 ### Given a string that contains both letters and numbers, write a function that pulls out all the numbers then returns their sum
 */
func challenge24() {
    
    func challenge24(input: String) -> Int {
        let abc = "abcdefghijklmnopqrstuvwxyz"
        var strippedStr = input.lowercased()
        for char in abc {
            strippedStr = strippedStr.replacingOccurrences(of: String(char), with: " ")
        }
        return strippedStr.split(separator: " ").compactMap({Int($0)}).reduce(0, +)
    }
    
    algorithm {
        assert(challenge24(input: "a1b2c3") == 6, "Challenge 24 failed")
        assert(challenge24(input: "a10b20c30") == 60, "Challenge 24 failed")
        assert(challenge24(input: "h8ers") == 8, "Challenge 24 failed")
    }
}

/*:
 ## Challenge 25
 ### Write a function that returns the square root of a positive integer, rounded down to the nearest integer, without using sqrt()
 */
func challenge25() {
    
    func challenge25(input: Int) -> Int {
        return Int(floor(pow(Double(input), 0.5)))
    }
    
    algorithm {
        assert(challenge25(input: 9) == 3, "Challenge 25 failed")
        assert(challenge25(input: 16777216) == 4096, "Challenge 25 failed")
        assert(challenge25(input: 16) == 4, "Challenge 25 failed")
        assert(challenge25(input: 15) == 3, "Challenge 25 failed")
    }
}

/*:
 ## Challenge 26
 ### Create a function that subtracts one positive integer from another, without using -
 */
func challenge26() {
    
    func challenge26(subtract: Int, from: Int) -> Int {
        return from + (~subtract + 1)
    }
    
    algorithm {
        assert(challenge26(subtract: 5, from: 9) == 4, "Challenge 26 failed")
        assert(challenge26(subtract: 10, from: 30) == 20, "Challenge 26 failed")
    }
}

//: [Collections](@next)
