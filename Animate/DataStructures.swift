//
//  DataStructures.swift
//  Animate
//
//  Created by Reid Chatham on 10/18/16.
//  Copyright © 2016 Reid Chatham. All rights reserved.
//


/// :nodoc:
internal class Node<T> {
    var data: T
    var next: Node<T>?
    init(data: T) {
        self.data = data
    }
}

/// :nodoc:
internal struct Queue<T> {
    var first, last: Node<T>?
    mutating func dequeue() -> T? {
        let pop = first?.data
        first = first?.next
        if first == nil {
            last = nil
        }
        return pop
    }
    mutating func enqueue(data: T) {
        if last == nil {
            first = Node(data: data)
            last = first
        } else {
            last?.next = Node(data: data)
            last = last?.next
        }
    }
}
