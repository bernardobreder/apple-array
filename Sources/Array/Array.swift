//
//  Array.swift
//  Array
//
//  Created by Bernardo Breder on 15/01/17.
//
//

import Foundation

extension Array {
    
    public func prefix(withoutLastCount: Int) -> [Element] {
        var array = self
        for _ in 0 ..< withoutLastCount {
            array.removeLast()
        }
        return array
    }
    
    public func componentsParentName() -> (parent: [Element], name: Element)? {
        var array = self
        guard !array.isEmpty else { return nil }
        let name = array.removeLast()
        return (array, name)
    }
    
    public func appendAndReturn(_ elements: Element...) -> [Element] {
        var array = self
        for element in elements {
            array.append(element)
        }
        return array
    }
    
    public func dic<K: Hashable, V>(_ callback: (Element) throws -> (K,V)) rethrows -> [K: V] {
        var dic = [K: V](minimumCapacity: count)
        for element in self {
            let (k,v) = try callback(element)
            dic[k] = v
        }
        return dic
    }
    
    @discardableResult
    public mutating func remove(condition: ((Int, Element) throws -> Bool), breakFirst: Bool = false) rethrows -> Array<Element> {
        for (idx, elem) in self.enumerated().reversed() {
            if try condition(idx, elem) {
                self.remove(at: idx)
                if breakFirst { break }
            }
        }
        return self
    }
    
    @discardableResult
    public mutating func update(condition: ((Int, Element) throws -> Bool), update: ((Int, Element) throws -> Element), breakFirst: Bool = false) rethrows -> Array<Element> {
        for (idx, elem) in self.enumerated() {
            if try condition(idx, elem) {
                self[idx] = try update(idx, elem)
                if breakFirst { break }
            }
        }
        return self
    }
    
    @available(*, unavailable, renamed: "map(_:)")
    public func mapThrow<T>(_ function: (Element) throws -> T) throws -> [T] {
        var array: [T] = []
        for item in self {
            array.append(try function(item))
        }
        return array
    }
    
}

extension Array where Element: Hashable {

    public func flatten(_ callback: (Element) throws -> [Element]) rethrows -> [Element] {
        let value = self
        var set: Set<Element> = Set<Element>(value)
        var list: [Element] = value
        var i = 0
        while i < list.count {
            let elem = list[i]
            let flat = try callback(elem)
            for item in flat {
                if !set.contains(item) {
                    set.insert(item)
                    list.append(item)
                }
            }
            i += 1
        }
        return set.map({$0})
    }
    
}

extension Array where Element: CustomStringConvertible {
    
    public func reducePath(separator: String = "/") -> String {
        return reduce("/", { $0 + ($0 == "/" ? "" : "/") + $1.description })
    }
    
}

extension String {
    
    public func components(separatedBy: String = "/", filterEmpty: Bool = true) -> [String] {
        return filterEmpty ?
            components(separatedBy: "/").filter{!$0.isEmpty} :
            components(separatedBy: "/")
    }

}
