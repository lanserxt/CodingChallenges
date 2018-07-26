//: [Home](@previous)

import Foundation

/*:
 Help function to check that something is actually executing
 */
func algorithm(_ operations: () -> Void) {
    print("Start testing...")
    operations()
    print("End...")
}

/*:
 ## Challenge 1
 */
func challenge1() {
    
    func challenge1(input: String) -> Bool {
        return Set(Array(input)).count == input.count
    }
    
    algorithm {
        assert(challenge1(input: "No duplicates") == true, "Challenge 1 failed")
        assert(challenge1(input: "abcdefghijklmnopqrstuvwxyz") == true, "Challenge 1 failed")
        assert(challenge1(input: "AaBbCc") == true, "Challenge 1 failed")
        assert(challenge1(input: "Hello, world") == false, "Challenge 1 failed")
    }
    
}



/*:
 ## Challenge 2
 */
func challenge2() {
    
    func challenge2(input: String) -> Bool {
        return String(input.reversed()).lowercased() == input.lowercased()
    }
    
    algorithm {
        assert(challenge2(input: "rotator") == true, "Challenge 2 failed")
        assert(challenge2(input: "Rats live on no evil star") == true, "Challenge 2 failed")
        assert(challenge2(input: "Never odd or even") == false, "Challenge 2 failed")
        assert(challenge2(input: "Hello, world") == false, "Challenge 2 failed")
    }
    
}

/*:
 ## Challenge 3
 */
func challenge3() {
    
    func challenge3(string1: String, string2: String) -> Bool {
        let arr1 = Array(string1)
        let arr2 = Array(string2)
        return arr1.sorted() == arr2.sorted()
    }
    
    algorithm {
        assert(challenge3(string1: "abca", string2: "abca") == true, "Challenge 3 failed")
        assert(challenge3(string1: "abc", string2: "cba") == true, "Challenge 3 failed")
        assert(challenge3(string1: "a1 b1", string2: "b1 a1") == true, "Challenge 3 failed")
        assert(challenge3(string1: "abc", string2: "abca") == false, "Challenge 3 failed")
        assert(challenge3(string1: "abc", string2: "Abc") == false, "Challenge 3 failed")
        assert(challenge3(string1: "abc", string2: "cbAa") == false, "Challenge 3 failed")
    }
    
}

/*:
 ## Challenge 4
 */
extension String {
    func fuzzyContains(_ searchStr: String) -> Bool {
        let maxIndex = self.count - searchStr.count
        for index in 0...maxIndex {
            let rangeSubstring = self.index(self.startIndex, offsetBy: index)..<self.index(self.startIndex, offsetBy: index + searchStr.count)
            if self.lowercased()[rangeSubstring] == searchStr.lowercased() {
                return true
            }
        }
        return false
    }
}

func challenge4() {
    
    algorithm {
        assert("Hello, world".fuzzyContains("Hello") == true, "Challenge 4 failed")
        assert("Hello, world".fuzzyContains("WORLD") == true, "Challenge 4 failed")
        assert("Hello, world".fuzzyContains("Goodbye") == false, "Challenge 4 failed")
    }
    
}

/*:
 ## Challenge 5
 */
func challenge5() {
    
    func challenge5a(input: String, count: Character) -> Int {
        return NSCountedSet.init(array: Array(input)).count(for: count)
    }
    
    algorithm {
        assert(challenge5a(input: "The rain in Spain", count: "a") == 2, "Challenge 5 failed")
        assert(challenge5a(input: "Mississippi", count: "i") == 4, "Challenge 5 failed")
        assert(challenge5a(input: "Hacking with Swift", count: "i") == 3, "Challenge 5 failed")
    }
    
}

/*:
 ## Challenge 6
 */
func challenge6() {
    
    func challenge6(string: String) -> String {
        var used = [Character]()
        
        for letter in string {
            if !used.contains(letter) {
                used.append(letter)
            }
        }
        
        return String(used)
    }
    
    algorithm {
        assert(challenge6(string: "wombat") == "wombat", "Challenge 6 failed")
        assert(challenge6(string: "hello") == "helo", "Challenge 6 failed")
        assert(challenge6(string: "Mississippi") == "Misp", "Challenge 6 failed")
    }
    
}

/*:
 ## Challenge 7
 */
func challenge7() {
    
    func challenge7(input: String) -> String {
        var sawSpace = false
        var result = ""
        
        for char in input {
            if char == " " {
                if sawSpace {
                    continue
                }
                sawSpace = true
            } else {
                sawSpace = false
            }
            result.append(char)
        }
        
        return result
    }
    algorithm {
        assert(challenge7(input: "a   b   c") == "a b c", "Challenge 7 failed")
        assert(challenge7(input: "    a") == " a", "Challenge 7 failed")
        assert(challenge7(input: "abc") == "abc", "Challenge 7 failed")
    }
    
}


/*:
 ## Challenge 8
 */
func challenge8() {
    
    func challenge8(input: String, rotated: String) -> Bool {
        guard input.count == rotated.count else {
            return false
            
        }
        let combined = input + input
        return combined.contains(rotated)
    }
    
    algorithm {
        assert(challenge8(input: "abcde", rotated: "eabcd") == true, "Challenge 8 failed")
        assert(challenge8(input: "abcde", rotated: "cdeab") == true, "Challenge 8 failed")
        assert(challenge8(input: "abcde", rotated: "abced") == false, "Challenge 8 failed")
        assert(challenge8(input: "abc", rotated: "a") == false, "Challenge 8 failed")
    }
    
}

/*:
 ## Challenge 9
 */
func challenge9() {
    
    func challenge9(input: String) -> Bool {
        let set = Set(Array(input))
        let filteredSet = set.filter({"a" <= $0 && $0 <= "z"})
        return filteredSet.count == 26
    }
    
    algorithm {
        assert(challenge9(input: "The quick brown fox jumps over the lazy dog") == true, "Challenge 9 failed")
        assert(challenge9(input: "The quick brown fox jumped the lazy dog") == false, "Challenge 9 failed")
    }
    
}

/*:
 ## Challenge 10
 */
func challenge10() {
    
    func challenge10(input: String) -> (vowels: Int, consonants: Int) {
        let vowels = "aeiou"
        let consonants = "bcdfghjklmnpqrstvwxyz"
        
        var vowelsCount = 0
        var consonantsCount = 0
        input.lowercased().forEach({
            if vowels.contains($0) {
                vowelsCount += 1
            } else
                if consonants.contains($0) {
                    consonantsCount += 1
            }
            
        })
        return (vowelsCount, consonantsCount)
    }
    
    algorithm {
        assert(challenge10(input: "Swift Coding Challenges") == (6, 15), "Challenge 10 failed")
        assert(challenge10(input: "Mississippi") == (4, 7), "Challenge 10 failed")
    }
    
}

/*:
 ## Challenge 11
 */
func challenge11() {
    
    func challenge11(first: String, second: String) -> Bool {
        guard first.count == second.count else {
            return false
        }
        let maxDiff = 3
        let arr1 = Array(first)
        let arr2 = Array(second)
        
        var diffCount = 0
        for (index, val) in arr1.enumerated() {
            if val != arr2[index] {
                diffCount += 1
            }
            if diffCount > maxDiff {
                return false
            }
        }
        return true
    }
    
    algorithm {
        assert(challenge11(first: "Clamp", second: "Cramp") == true, "Challenge 11 failed")
        assert(challenge11(first: "Clamp", second: "Crams") == true, "Challenge 11 failed")
        assert(challenge11(first: "Clamp", second: "Grams") == true, "Challenge 11 failed")
        assert(challenge11(first: "Clamp", second: "Grans") == false, "Challenge 11 failed")
        assert(challenge11(first: "Clamp", second: "Clan") == false, "Challenge 11 failed")
        assert(challenge11(first: "clamp", second: "maple") == false, "Challenge 11 failed")
    }
    
}

/*:
 ## Challenge 12
 */
func challenge12() {
    
    func challenge12(input: String) -> String {
        let words = input.split(separator: " ")
        
        let minWord = words.min(by: {$0.count < $1.count}) ?? ""
        for (index, _) in minWord.enumerated() {
            let prefix = minWord[minWord.startIndex...minWord.index(minWord.startIndex, offsetBy: index)]
            let filtered = words.filter({$0 != minWord && $0.hasPrefix(String(prefix))})
            if filtered.count == 0 && index > 0 {
                return String(prefix.dropLast())
            }
        }
        
        return ""
    }
    
    algorithm {
        assert(challenge12(input: "swift switch swill swim") == "swi", "Challenge 12 failed")
        assert(challenge12(input: "flip flap flop") == "fl", "Challenge 12 failed")
    }
}

/*:
 ## Challenge 13
 */
func challenge13() {
    
    func challenge13(input: String) -> String {
        guard input.count > 0 else {
            return ""
        }
        
        var result: String = ""
        var currentCounter = 0
        for val in input {
            if result.isEmpty {
                result.append(val)
                currentCounter += 1
            } else {
                if result.last ?? Character.init("") == val {
                    currentCounter += 1
                } else {
                    result.append(String(currentCounter))
                    result.append(val)
                    currentCounter = 1
                }
            }
        }
        if currentCounter > 1 {
            result.append(String(currentCounter))
        }
        return result
    }
    
    algorithm {
        assert(challenge13(input: "aabbcc") == "a2b2c2", "Challenge 13 failed")
        assert(challenge13(input: "aaabaaabaaa") == "a3b1a3b1a3", "Challenge 13 failed")
        assert(challenge13(input: "aaAAaa") == "a2A2a2", "Challenge 13 failed")
    }
}

/*:
 ## Challenge 14
 */
func challenge14() {
    
    func challenge14(string: String, current: String = "") {
        let arr = Array(string)
        if string.count == 0 {
            print(current)
            print(String.init(repeating: "*", count: current.count))
        } else {
            for ind in 0..<string.count {
                let left = String(arr[0..<ind])
                let right = String(arr[ind + 1..<string.count])
                challenge14(string: left + right, current: current + String(arr[ind]))
            }
        }
        
    }
    
    algorithm {
        challenge14(string: "a")
        challenge14(string: "ab")
        challenge14(string: "abc")
        
    }
}

/*:
 ## Challenge 15
 */
func challenge15() {
    
    func challenge15(input: String) -> String {
        let words = input.components(separatedBy: " ")
        let reversedWords = words.map({$0.reversed()})
        return String(reversedWords.joined(separator: " "))
    }
    
    algorithm {
        assert(challenge15(input: "Swift Coding Challenges") == "tfiwS gnidoC segnellahC", "Challenge 12 failed")
        assert(challenge15(input: "The quick brown fox") == "ehT kciuq nworb xof", "Challenge 12 failed")
    }
}
//: [Numbers](@next)
