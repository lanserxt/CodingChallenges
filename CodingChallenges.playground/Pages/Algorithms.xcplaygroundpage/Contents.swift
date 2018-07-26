//: [Collections](@previous)

import Foundation
import UIKit
import GameplayKit

/*:
 Help function to check that something is actually executing
 */
func algorithm(_ operations: () -> Void) {
    print("Start testing...")
    operations()
    print("End...")
}

/*:
 ## Challenge 55
 */
extension Array where Element : Comparable{
    
    func bubbleSort() -> [Element] {
        guard count > 1 else {
            return self
        }
        
        var sortedArray = self
        var wereSwapped = false
        repeat {
            wereSwapped = false
            for index in 0..<sortedArray.count - 1 {
                if sortedArray[index] > sortedArray[index + 1] {
                    sortedArray.swapAt(index, index + 1)
                    wereSwapped = true
                }
            }
        } while wereSwapped
        
        return sortedArray
    }
}

func challenge55() {
    algorithm {
        assert([12, 5, 4, 9, 3, 2, 1].bubbleSort() == [12, 5, 4, 9, 3, 2, 1].sorted(), "Challenge 55 failed")
        assert(["f", "a", "b"].bubbleSort() == ["f", "a", "b"].sorted(), "Challenge 55 failed")
        assert([String]().bubbleSort() == [], "Challenge 55 failed")
    }
}

/*:
 ## Challenge 55
 */
extension Array where Element : Comparable{
    
    func insertionSort() -> [Element] {
        guard count > 1 else {
            return self
        }
        
        var sortedArray = self
        
        for k in 1..<self.count{
            var currentIndex = k
            let currentItem = sortedArray[currentIndex]
            while currentIndex > 0 && currentItem < sortedArray[currentIndex - 1] {
                sortedArray[currentIndex] = sortedArray[currentIndex - 1]
                currentIndex -= 1
            }
            sortedArray[currentIndex] = currentItem
        }
        return sortedArray
    }
}

func challenge56() {
    algorithm {
        assert([12, 5, 4, 9, 3, 2, 1].insertionSort() == [12, 5, 4, 9, 3, 2, 1].sorted(), "Challenge 55 failed")
        assert(["f", "a", "b"].insertionSort() == ["f", "a", "b"].sorted(), "Challenge 55 failed")
        assert([String]().insertionSort() == [], "Challenge 55 failed")
    }
}

/*:
 ## Challenge 57
 */
func challenge57() {
    func challenge57(_ val1: Any, _ val2: Any) -> Bool {
        let str1 = String(describing: val1)
        let str2 = String(describing: val2)
        
        guard str1.count == str2.count else {
            return false
        }
        let set1 = NSCountedSet(array: Array(str1))
        let set2 = NSCountedSet(array: Array(str2))
        
        var freqs1: [Int] = []
        var freqs2: [Int] = []
        
        for val in set1 {
            freqs1.append(set1.count(for: val))
        }
        for val in set2 {
            freqs2.append(set2.count(for: val))
        }
        return freqs1.sorted() == freqs2.sorted()
    }
    algorithm {
        assert(challenge57("clap", "slap") == true, "Challenge 57 failed")
        assert(challenge57("rum", "mud") == true, "Challenge 57 failed")
        assert(challenge57("pip", "did") == true, "Challenge 57 failed")
        assert(challenge57("123123", "456456") == true, "Challenge 57 failed")
        assert(challenge57("3.14159", "2.03048") == true, "Challenge 57 failed")
        assert(challenge57([1, 2, 1, 2, 3], [4, 5, 4, 5, 6]) == true, "Challenge 57 failed")
        
        assert(challenge57("carry", "daddy") == false, "Challenge 57 failed")
        assert(challenge57("did", "cad") == false, "Challenge 57 failed")
        assert(challenge57("maim", "saim") == false, "Challenge 57 failed")
        assert(challenge57("curry", "flurry") == false, "Challenge 57 failed")
        assert(challenge57("112233", "112211") == false, "Challenge 57 failed")
    }
}

/*:
 ## Challenge 58
 */
func challenge58() {
    struct BracketsQueue<T> {
        private var items: [T] = []
        
        var count: Int {
            return self.items.count
        }
        
        mutating func push(_ val: T) {
            self.items.append(val)
        }
        
        mutating func pop() -> T {
            return self.items.removeLast()
        }
        
        func peek() -> T? {
            return self.items.last
        }
        
        func printQueue() {
            print(self.items)
        }
    }
    
    func challenge58(input: String) -> Bool {
        
        let matchingBrackets: [Character: Character] = [")": "(", "]": "[", "}": "{", ">": "<"]
        
        var queue: BracketsQueue<Character> = BracketsQueue<Character>()
        
        for val in input {
            if queue.count == 0 {
                queue.push(val)
            } else {
                if let last = queue.peek() {
                    if last == matchingBrackets[val] {
                        queue.pop()
                    } else {
                        queue.push(val)
                    }
                }
            }
        }
        return queue.count > 0 ? false : true
    }
    algorithm {
        assert(challenge58(input: "()") == true, "Challenge 58 failed")
        assert(challenge58(input: "([])") == true, "Challenge 58 failed")
        assert(challenge58(input: "([])(<{}>)") == true, "Challenge 58 failed")
        assert(challenge58(input: "([]{}<[{}]>)") == true, "Challenge 58 failed")
        assert(challenge58(input: "") == true, "Challenge 58 failed")
        
        assert(challenge58(input: "}{") == false, "Challenge 58 failed")
        assert(challenge58(input: "([)]") == false, "Challenge 58 failed")
        assert(challenge58(input: "([)") == false, "Challenge 58 failed")
        assert(challenge58(input: "([") == false, "Challenge 58 failed")
        assert(challenge58(input: "[<<<{}>>]") == false, "Challenge 58 failed")
        assert(challenge58(input: "hello") == false, "Challenge 58 failed")
    }
}

/*:
 ## Challenge 59
 */
extension Array where Element : Comparable{
    
    mutating func _quickSort(left: Int, right: Int) {
        guard left < right else {
            return
        }
        let pivot = self[right]
        var replaceIndex = left
        for index in left..<right {
            if pivot > self[index] {
                self.swapAt(index, replaceIndex)
                replaceIndex += 1
            }
        }
        self.swapAt(replaceIndex, right)
        _quickSort(left: left, right: replaceIndex - 1)
        _quickSort(left: replaceIndex + 1, right: right)
    }
    
    mutating func quickSort() -> [Element] {
        guard count > 1 else {
            return self
        }
        self._quickSort(left: 0, right: self.count - 1)
        return self
    }
}

func challenge59() {
    algorithm {
        var arr1 = [12, 5, 4, 9, 3, 2, 1]
        var arr2 = ["f", "a", "b"]
        var arr3 = [String]()
        assert(arr1.quickSort() == [12, 5, 4, 9, 3, 2, 1].sorted(), "Challenge 59 failed")
        assert(arr2.quickSort() == ["f", "a", "b"].sorted(), "Challenge 59 failed")
        assert(arr3.quickSort() == [], "Challenge 59 failed")
    }
}

/*:
 ## Challenge 60
 */
func challenge60(_ board: [[String]]) -> Bool {
    func isWin(_ first: String, _ second: String, _ third: String) -> Bool {
        guard first != "" && second != "" && third != "" else {
            return false
        }
        return first == second && second == third
    }
    
    for index in 0..<board.count {
        if isWin(board[index][0], board[index][1], board[index][2]) || isWin(board[0][index], board[1][index], board[2][index]) {
            return true
        }
    }
    if isWin(board[0][0], board[1][1], board[2][2]) || isWin(board[0][2], board[1][1], board[2][0]) {
        return true
    }
    return false
}

func challenge60() {
    algorithm {
        assert(challenge60([["X", "", "O"],["", "X", "O"],["", "", "X"]]) == true, "Challenge 60 failed")
        assert(challenge60([["X", "", "O"],["X", "", "O"],["X", "", ""]]) == true, "Challenge 60 failed")
        assert(challenge60([["", "X", ""],["O", "X", ""],["O", "X", ""]]) == true, "Challenge 60 failed")
        assert(challenge60([["", "X", ""],["O", "X", ""],["O", "", "X"]]) == false, "Challenge 60 failed")
    }
}

/*:
 ## Challenge 61
 */
func challenge61(upTo: Int) -> [Int] {
    guard upTo > 1 else {
        return []
    }
    
    var sieve: [Bool] = [Bool](repeating: true, count: upTo)
    sieve[0] = false
    sieve[1] = false
    
    for number in 2..<upTo {
        if sieve[number] {
            for multiply in stride(from: number * number, to: upTo, by: number) {
                sieve[multiply] = false
            }
        }
    }
    return sieve.enumerated().compactMap { $1 == true ? $0 : nil }
}

func challenge61() {
    algorithm {
        assert(challenge61(upTo: 10) == [2, 3, 5, 7], "Challenge 61 failed")
        assert(challenge61(upTo: 11)  == [2, 3, 5, 7], "Challenge 61 failed")
        assert(challenge61(upTo: 12) == [2, 3, 5, 7, 11], "Challenge 61 failed")
    }
}

/*:
 ## Challenge 62
 */
func challenge62(points: [(first: CGPoint, second: CGPoint)]) -> [CGFloat] {
    
    func radToDegree(_ rad: CGFloat) -> CGFloat {
        var degree = rad * 180.0 / CGFloat.pi - 90.0
        if  degree < 0 {
            degree += 360.0
        }
        if  degree == 360.0 {
            degree = 0
        }
        return degree
    }
    
    guard points.count > 0 else {
        return []
    }
    return points.map({radToDegree(atan2($0.first.y - $0.second.y, $0.first.x - $0.second.x))})
}

func challenge62() {
    algorithm {
        var points = [(first: CGPoint, second: CGPoint)]()
        points.append((first: CGPoint.zero, second: CGPoint(x: 0, y: -100)))
        points.append((first: CGPoint.zero, second: CGPoint(x: 100, y: -100)))
        points.append((first: CGPoint.zero, second: CGPoint(x: 100, y: 0)))
        points.append((first: CGPoint.zero, second: CGPoint(x: 100, y: 100)))
        points.append((first: CGPoint.zero, second: CGPoint(x: 0, y: 100)))
        points.append((first: CGPoint.zero, second: CGPoint(x: -100, y: 100)))
        points.append((first: CGPoint.zero, second: CGPoint(x: -100, y: 0)))
        points.append((first: CGPoint.zero, second: CGPoint(x: -100, y: -100)))
        assert(challenge62(points: points) == [0.0, 45.0, 90.0, 135.0, 180.0, 225.0, 270.0, 315.0], "Challenge 62 failed")
    }
}

/*:
 ## Challenge 63
 ### Solution provided by Paul Hudson
 */
func challenge63() {
    
    func printGrid(_ grid: [[Int]]) {
        for x in 0..<grid.count {
            print(grid[x])
        }
    }
    
    func challenge63(fill: Int, in grid: [[Int]], at point: (x: Int, y: Int)) -> [[Int]] {
        var returnValue = grid
        var squaresToFill = [point] //queue of cels to fill
        let startNumber = grid[point.y][point.x] // 1 or 0
        
        func tryAddMove(_ move: (x: Int, y: Int)) {
            guard move.x >= 0 else { return }
            guard move.x < grid.count else { return }
            guard move.y >= 0 else { return  }
            guard move.y < grid.count else  { return }
            guard returnValue[move.y][move.x] == startNumber else { return }
            print("\(move) is currently \(returnValue[move.y][move.x])")
            
            squaresToFill.append(move)
        }
        
        print("BEFORE")
        returnValue.forEach { print($0) }
        print("")
        
        while let square = squaresToFill.popLast() {
            guard returnValue[square.y][square.x] != fill else {
                continue
            }
            print("Filling \(square) with \(fill)")
            returnValue[square.y][square.x] = fill
            
            print("****")
            returnValue.forEach { print($0) }
            
            tryAddMove((x: square.x, y: square.y - 1))
            tryAddMove((x: square.x, y: square.y + 1))
            tryAddMove((x: square.x - 1, y: square.y))
            tryAddMove((x: square.x + 1, y: square.y))
        }
        
        print("AFTER")
        returnValue.forEach { print($0) }
        
        return returnValue
    }
    
    algorithm {
        let random = GKMersenneTwisterRandomSource(seed: 1)
        let grid = (1...10).map {
            _ in (1...10).map {
                _ in Int(random.nextInt(upperBound: 2))
            }
        }
        printGrid(grid)
        challenge63(fill: 5, in: grid, at: (x: 2, y: 0))
    }
}

/*:
 ## Challenge 64
 ###  During implementation I've searched web for the most easy explaination and solution by Jacob Schwartz (@isoiphone) were really cool.
 You can check it out here: https://gist.github.com/isoiphone/a2b88b9b8ccaeab8fcb8
 */

func challenge64() {
    
    var N = 8
    
    //current solution index
    var numSolutions = 0
    
    var solution = [Int](repeating: 0, count: N)
    //current queens in a row
    var inRow = [Bool](repeating: false, count: N)
    //current queens in a forward diagonal
    var inForwardDiag = [Bool](repeating: false, count: 2*N)
    //current queens in a back diagonal
    var inBackDiag = [Bool](repeating: false, count: 2*N)
    
    func placeQueen(col: Int) {
        //if we placed all queens in solution row
        if col == N {
            //printing solution
            let line = solution.map{"\($0)"}.joined(separator: ",")
            numSolutions += 1
            print("\(numSolutions): \(line)")
            return
        }
        
        //Iterating columns
        for row in 0..<N {
            //if not in any other rows
            if !inRow[row] && !inForwardDiag[row+col] && !inBackDiag[row-col+N] {
                //placing queen
                solution[col] = row
                
                //adding to rows
                inRow[row] = true
                inForwardDiag[row+col] = true
                inBackDiag[row-col+N] = true
                
                //Going into next columns
                placeQueen(col: col+1)
                
                //Removing from rows
                inRow[row] = false
                inForwardDiag[row+col] = false
                inBackDiag[row-col+N] = false
            }
            //placing queen
            solution[col] = row
        }
    }
    
    algorithm {
        placeQueen(col: 0)
    }
}
