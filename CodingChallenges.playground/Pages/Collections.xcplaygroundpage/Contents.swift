//: [Numbers](@previous)
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
 ## Challenge 37
 */
extension Collection where Iterator.Element == Int {
    
    func challenge37(count: Character) -> Int {
        var result = 0
        for item in self {
            let str = String(item)
            result += str.filter({$0 == count}).count
        }
        return result
    }
}
func challenge37() {
    
    algorithm {
        assert([5, 15, 55, 515].challenge37(count: "5") == 6, "Challenge 37 failed")
        assert([5, 15, 55, 515].challenge37(count: "1") == 2, "Challenge 37 failed")
        assert([55555].challenge37(count: "5") == 5, "Challenge 37 failed")
        assert([55555].challenge37(count: "1") == 0, "Challenge 37 failed")
    }
}

/*:
 ## Challenge 38
 */
extension Collection where Iterator.Element : Comparable{
    
    func challenge38(count: Int) -> [Iterator.Element] {
        let sorted = self.sorted()
        return Array(sorted.prefix(count))
    }
}
func challenge38() {
    
    algorithm {
        assert([1,2,3,4].challenge38(count: 3) == [1,2,3], "Challenge 38 failed")
        assert(["q", "f", "k"].challenge38(count: 10) == ["f", "k", "q"], "Challenge 38 failed")
        assert([256,16].challenge38(count: 3) == [16, 256], "Challenge 38 failed")
        assert([String]().challenge38(count: 3) == [], "Challenge 38 failed")
    }
}

/*:
 ## Challenge 39
 */
extension Collection where Iterator.Element == String{
    
    func challenge39() -> [Iterator.Element] {
        return self.sorted(by: {$0.count > $1.count})
    }
}
func challenge39() {
    
    algorithm {
        assert(["a", "abc", "ab"].challenge39() == ["abc", "ab", "a"], "Challenge 39 failed")
        assert(["paul", "taylor", "adele"].challenge39() == ["taylor", "adele", "paul"], "Challenge 39 failed")
        assert([String]().challenge39() == [], "Challenge 39 failed")
    }
}


/*:
 ## Challenge 40
 */
func challenge40() {
    
    func challenge40(input: [Int]) -> [Int] {
        let fullSet = Set(Array(1...100))
        let partSet = Set(input)
        return Array(fullSet.subtracting(partSet)).sorted()
    }
    
    algorithm {
        var testArray = Array(1...100)
        testArray.remove(at: 25)
        testArray.remove(at: 20)
        testArray.remove(at: 6)
        
        assert(challenge40(input: testArray) == [7, 21, 26], "Challenge 40 failed")
    }
}


/*:
 ## Challenge 41
 */
extension Collection where Iterator.Element == Int {
    
    func challenge41() -> Double? {
        guard self.count > 0 else {
            return nil
        }
        let sorted = self.sorted()
        if self.count % 2 == 0 {
            return (Double(sorted[Int(self.count / 2)]) + Double(sorted[Int(self.count / 2) - 1])) / 2.0
        } else {
            return Double(sorted[Int(self.count / 2)])
        }
        
    }
}

func challenge41() {
    
    algorithm {
        assert([1,2,3].challenge41() == 2.0, "Challenge 41 failed")
        assert([1,2,9].challenge41() == 2.0, "Challenge 41 failed")
        assert([1,3,5,7,9].challenge41() == 5.0, "Challenge 41 failed")
        assert([1,2,3,4].challenge41() == 2.5, "Challenge 41 failed")
        assert([Int]().challenge41() == nil, "Challenge 41 failed")
    }
}

/*:
 ## Challenge 42
 */
extension Collection where Iterator.Element : Equatable {
    
    func challenge42(indexOf: Iterator.Element) -> Int? {
        
        for (ind, val) in self.enumerated() {
            if val == indexOf {
                return ind
            }
        }
        return nil
        
    }
}

func challenge42() {
    
    algorithm {
        assert([1,2,3].challenge42(indexOf: 1) == 0, "Challenge 42 failed")
        assert([1,2,3].challenge42(indexOf: 3) == 2, "Challenge 42 failed")
        assert([1,2,3].challenge42(indexOf: 5) == nil, "Challenge 42 failed")
    }
}


/*:
 ## Challenge 43
 */
class Node<T> {
    var next: Node?
    var value: T
    
    init(value: T) {
        self.value = value
    }
}

class LinkedList<T> {
    var startNode: Node<T>?
    
    func printNodes() {
        var curNode = self.startNode
        while let node = curNode {
            print(node.value, terminator: " ")
            curNode = node.next
        }
        print()
    }
}


func challenge43() {
    algorithm {
        let linkedList: LinkedList<Character> = LinkedList<Character>()
        var prevNode: Node<Character>?
        let abc = "abcdefghijklmnopqrstuvwxyz"
        for char in abc {
            let newNode = Node<Character>.init(value: char)
            
            if prevNode == nil {
                linkedList.startNode = newNode
                
            } else {
                prevNode?.next = newNode
            }
            prevNode = newNode
        }
        linkedList.printNodes()
    }
}

/*:
 ## Challenge 44
 */
extension LinkedList {
    func centerNode() -> Node<T>? {
        var slow = self.startNode
        var fast = self.startNode
        
        while fast != nil && fast?.next != nil {
            slow = slow?.next
            fast = fast?.next?.next
        }
        return slow
    }
}

func challenge44() {
    algorithm {
        let linkedList: LinkedList<Character> = LinkedList<Character>()
        var prevNode: Node<Character>?
        let abc = "abcdefghijklmnopqrstuvwxyz"
        for char in abc {
            let newNode = Node<Character>.init(value: char)
            
            if prevNode == nil {
                linkedList.startNode = newNode
                
            } else {
                prevNode?.next = newNode
            }
            prevNode = newNode
        }
        print(linkedList.centerNode()?.value)
    }
}

/*:
 ## Challenge 46
 */
extension Collection {
    
    func challenge46<T>(_ closure: (_ val: Iterator.Element) throws -> T) rethrows -> [T] {
        var result: [T] = []
        for val in self {
            result.append(try closure(val))
        }
        return result
        
    }
}

func challenge46() {
    algorithm {
        print([1, 2, 3].challenge46{String($0)})
        print(["1", "2", "3"].challenge46{Int($0)!})
    }
}


/*:
 ## Challenge 47
 */
extension Collection where Iterator.Element: Comparable {
    
    func challenge47() -> Iterator.Element? {
        guard var result = self.first else {
            return nil
        }
        for val in self {
            if result > val {
                result = val
            }
        }
        return result
    }
}

func challenge47() {
    algorithm {
        assert([1, 2, 3].challenge47() == 1, "Challenge 47 failed")
        assert(["q", "f", "k"].challenge47() == "f", "Challenge 47 failed")
        assert([4096,256,16].challenge47() == 16, "Challenge 47 failed")
        assert([String]().challenge47() == nil, "Challenge 47 failed")
    }
}


/*:
 ## Challenge 48
 */
struct deque<T> {
    private var items: [T] = []
    
    var count: Int {
        return self.items.count
    }
    
    mutating func pushBack(_ val: T) {
        self.items.append(val)
    }
    
    mutating func popFront() -> T? {
        guard self.items.count > 0 else {
            return nil
        }
        return self.items.removeFirst()
    }
    
    mutating func popBack() -> T? {
        guard self.items.count > 0 else {
            return nil
        }
        return self.items.removeLast()
    }
    
}
func challenge48() {
    algorithm {
        var numbers = deque<Int>()
        numbers.pushBack(5)
        numbers.pushBack(8)
        numbers.pushBack(3)
        assert(numbers.count == 3)
        assert(numbers.popFront()! == 5)
        assert(numbers.popBack()! == 3)
        assert(numbers.popFront()! == 8)
        assert(numbers.popBack() == nil)
    }
}

/*:
 ## Challenge 49
 */

func challenge49() {
    
    func challenge49(_ numbers: Int...) -> Int {
        let counted = NSCountedSet(array: numbers)
        var sum = 0
        for case let item as Int in counted where counted.count(for: item) % 2 == 0 {
            sum += item
        }
        return sum
    }
    
    algorithm {
        assert(challenge49(1, 2, 2, 3, 3, 4) == 5, "Challenge 49 failed")
        assert(challenge49(5, 5, 5, 12, 12) == 12, "Challenge 49 failed")
        assert(challenge49(1, 1, 2, 2, 3, 3, 4, 4) == 10, "Challenge 49 failed")
    }
}

/*:
 ## Challenge 50
 */
func challenge50() {
    
    func challenge50(_ numbers: [Int]) -> CountableClosedRange<Int>? {
        guard numbers.count > 0 else {
            return nil
        }
        
        var bestRange: CountableClosedRange<Int>?
        var bestSum = 0
        
        var currentStart: Int? = nil
        var currentSum = 0
        
        for (index, val) in numbers.enumerated() {
            if val > 0 {
                currentStart = currentStart ?? index
                currentSum += val
                
                if currentSum > bestSum {
                    bestRange = currentStart! ... index
                    bestSum = currentSum
                }
            } else {
                currentStart = nil
                currentSum = 0
            }
        }
        
        return bestRange
    }
    
    algorithm {
        assert(challenge50([0, 1, 1, -1, 2, 3, 1]) == 4...6, "Challenge 50 failed")
        assert(challenge50([10, 20, 30, -10, -20, 10, 20]) == 0...2, "Challenge 50 failed")
        assert(challenge50([1, -1, 2, -1]) == 2...2, "Challenge 50 failed")
        assert(challenge50([2, 0, 2, 0, 2]) == 0...0, "Challenge 50 failed")
        assert(challenge50([Int]()) == nil, "Challenge 50 failed")
    }
}

/*:
 ## Challenge 51
 */
extension LinkedList {
    func reversed() -> LinkedList<T> {
        let copyLinkedList = LinkedList<T>()
        var newFirstNode: Node<T>?
        
        var curNode = self.startNode
        while let node = curNode {
            let newNode = Node<T>.init(value: node.value)
            if newFirstNode != nil {
                newNode.next = newFirstNode
            }
            newFirstNode = newNode
            curNode = node.next
        }
        copyLinkedList.startNode = newFirstNode
        return copyLinkedList
    }
}

func challenge51() {
    
    algorithm {
        let linkedList: LinkedList<Character> = LinkedList<Character>()
        var prevNode: Node<Character>?
        let abc = "abcdefghijklmnopqrstuvwxyz"
        for char in abc {
            let newNode = Node<Character>.init(value: char)
            
            if prevNode == nil {
                linkedList.startNode = newNode
                
            } else {
                prevNode?.next = newNode
            }
            prevNode = newNode
        }
        linkedList.printNodes()
        let listReversed = linkedList.reversed()
        listReversed.printNodes()
    }
}

/*:
 ## Challenge 52
 */
func challenge52() {
    
    func challenge52<T: Numeric>(numbers: [T]) -> T {
        return numbers.reduce(0, +)
    }
    
    algorithm {
        assert(challenge52(numbers: [1, 2, 3]) == 6, "Challenge 52 failed")
        assert(challenge52(numbers: [1.0, 2.0, 3.0]) == 6.0, "Challenge 52 failed")
        assert(challenge52(numbers: Array<Float>([1.0, 2.0, 3.0])) == 6.0, "Challenge 52 failed")
    }
}

/*:
 ## Challenge 53
 */
extension LinkedList {
    func findLoopStart() -> Node<T>? {
        var slow = self.startNode
        var fast = self.startNode
        
        // go through the list until we find the end
        while fast != nil && fast?.next != nil {
            // slow moves one space, fast moves two
            slow = slow?.next
            fast = fast?.next?.next
            
            // if the two met it means we found a loop, so exit the loop
            if slow === fast {
                break
            }
        }
        
        // if fast or its successor is nil it means we made it to the end of the list, so there's no loop
        guard fast != nil || fast?.next != nil else {
            return nil
        }
        
        // if we're still here, we know for sure there's a loop
        slow = self.startNode
        
        // loop through until we find another match
        while slow! !== fast! {
            // move slow and fast the same speed now
            slow = slow?.next
            fast = fast?.next
        }
        
        // slow and fast now point to the same now, so return either one of them
        return slow
    }
}
func challenge53() {
    
    algorithm {
        let list = LinkedList<UInt32>()
        var previousNode: Node<UInt32>? = nil
        var linkBackNode: Node<UInt32>? = nil
        let linkBackPoint = Int(arc4random_uniform(1000))
        
        for i in 1...1000 {
            let node = Node(value: arc4random())
            
            if i == linkBackPoint { linkBackNode = node }
            
            if let predecessor = previousNode {
                predecessor.next = node
            } else {
                list.startNode = node
            }
            
            previousNode = node
        }
        
        previousNode?.next = linkBackNode
        
        assert(list.findLoopStart()?.value == linkBackNode?.value, "Challenge 53 failed")
    }
}

/*:
 ## Challenge 54
 */
class Leaf<T> {
    var value: T
    var left: Leaf<T>?
    var right: Leaf<T>?
    
    init(_ value: T) {
        self.value = value
    }
}

class BinaryTree<T: Comparable> : CustomStringConvertible{
    private var root: Leaf<T>?
    
    init(_ items: [T]) {
        for item in items {
            
            var placed = false
            
            if  let root = self.root {
                var tracker: Leaf<T> = root
                
                while !placed {
                    if item <= tracker.value {
                        if tracker.left == nil {
                            tracker.left = Leaf<T>.init(item)
                            placed = true
                        }
                        tracker = tracker.left!
                    } else {
                        if tracker.right == nil {
                            tracker.right = Leaf<T>.init(item)
                            placed = true
                        }
                        tracker = tracker.right!
                    }
                }
            } else {
                self.root = Leaf<T>.init(item)
            }
        }
    }
    
    func sortedPrint() {
        func visitLeaf(_ leaf: Leaf<T>?) {
            guard let leaf = leaf else {
                return
            }
            
            visitLeaf(leaf.left)
            print(leaf.value)
            visitLeaf(leaf.right)
        }
        visitLeaf(self.root)
    }
    
    //Challenge 45
    func traverse(_ closure: @escaping (_ val: T) -> Void) {
        func visitLeaf(_ leaf: Leaf<T>?) {
            guard let leaf = leaf else {
                return
            }
            
            visitLeaf(leaf.left)
            closure(leaf.value)
            visitLeaf(leaf.right)
        }
        visitLeaf(self.root)
    }
    
    var description: String {
        guard let first = root else { return "(Empty)" }
        var queue = [Leaf<T>]()
        queue.append(first)
        
        var output = ""
        
        while queue.count > 0 {
            var nodesAtCurrentLevel = queue.count
            
            while nodesAtCurrentLevel > 0 {
                let node = queue.removeFirst()
                output += "\(node.value) "
                
                if node.left != nil { queue.append(node.left!) }
                if node.right != nil { queue.append(node.right!) }
                
                nodesAtCurrentLevel -= 1
            }
            
            output += "\n"
        }
        return output
    }
    
    var isBalanced: Bool {
        guard let root = self.root else {
            return true
        }
        
        func minDepth(_ leaf: Leaf<T>?) -> Int{
            guard let leaf = leaf else {
                return 0
            }
            return 1 + min(minDepth(leaf.left), minDepth(leaf.right))
        }
        func maxDepth(_ leaf: Leaf<T>?) -> Int{
            guard let leaf = leaf else {
                return 0
            }
            return 1 + max(maxDepth(leaf.left), maxDepth(leaf.right))
        }
        let diff = maxDepth(root) - minDepth(root)
        return diff <= 1
    }
}

func challenge45() {
    algorithm {
        let binaryTree = BinaryTree<Int>([3, 1, 2])
        
        var sum = 0
        binaryTree.traverse({
            sum += $0
        })
        assert(sum == 6, "Challenge 45 failed")
        
        var values = [Int]()
        binaryTree.traverse({
            values.append($0)
        })
        assert(values.count == 3, "Challenge 45 failed")
    }
}

func challenge55() {
    algorithm {
        let binaryTree1 = BinaryTree<Int>([2, 1, 3])
        assert(binaryTree1.isBalanced == true, "Challenge 55 failed")
        
        let binaryTree2 = BinaryTree<Int>([5, 1, 7, 6, 2, 1, 9, 1])
        assert(binaryTree2.isBalanced == true, "Challenge 55 failed")
        
        let binaryTree3 = BinaryTree<Int>([5, 1, 7, 6, 2, 1, 9, 1])
        assert(binaryTree3.isBalanced == true, "Challenge 55 failed")
        
        let binaryTree4 = BinaryTree<Int>([5, 1, 7, 6, 2, 1, 9, 1, 3])
        assert(binaryTree4.isBalanced == true, "Challenge 55 failed")
        
        let binaryTree5 = BinaryTree<Int>([50, 25, 100, 26, 101, 24, 99])
        assert(binaryTree5.isBalanced == true, "Challenge 55 failed")
        
        let binaryTree6 = BinaryTree<Character>(["k", "t", "d", "a", "z", "m", "f"])
        assert(binaryTree6.isBalanced == true, "Challenge 55 failed")
        
        let binaryTree7 = BinaryTree<Int>([1])
        assert(binaryTree7.isBalanced == true, "Challenge 55 failed")
        
        let binaryTree8 = BinaryTree<Character>([Character]())
        assert(binaryTree8.isBalanced == true, "Challenge 55 failed")
        
        
        let unbalancedTree1 = BinaryTree<Int>([1,2,3,4,5])
        assert(unbalancedTree1.isBalanced == false, "Challenge 55 failed")
        
        let unbalancedTree2 = BinaryTree<Int>([10, 5, 4, 3, 2, 1, 11, 12, 13, 14, 15])
        assert(unbalancedTree2.isBalanced == false, "Challenge 55 failed")
        
        let unbalancedTree3 = BinaryTree<Character>(["f", "d", "c", "e", "a", "b"])
        assert(unbalancedTree3.isBalanced == false, "Challenge 55 failed")
    }
}

//: [Algorithms](@previous)
