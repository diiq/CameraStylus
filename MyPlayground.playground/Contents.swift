//: Playground - noun: a place where people can play


import Darwin

/**
 A single point in a stroke. Doesn't *necessarily* correspond to a specific
 UITouch.
 */

struct Point {
  let x: Double
  let y: Double
  let weight: Double
  let altitude: Double
  
  init(x: Double, y: Double, weight: Double = -1, altitude: Double=90) {
    if x.isNaN || y.isNaN {
      // TODO For development env only. Remove before deploy.
      fatalError("NaNish point created.")
    }
    self.x = x
    self.y = y
    self.weight = weight
    self.altitude = altitude
  }
  
  func withWeight(weight: Double) -> Point {
    return Point(x: x, y: y, weight: weight)
  }
}

// Maths

extension Point {
  func length() -> Double {
    return sqrt(x*x + y*y)
  }
  
  func unit() -> Point {
    let len = length()
    // Not sure this is the right solution to unitizing 0 length vector.
    guard len > 0 else { return Point(x: 0, y: 0, weight: weight) }
    return Point(x: x/len, y: y/len, weight: weight)
  }
  
  func perpendicular() -> Point {
    return Point(x: -y, y: x, weight: -1).unit()
  }
  
  func radians() -> Double {
    return atan2(y, x)
  }
  
  func dot(point: Point) -> Double {
    return x * point.x + y * point.y
  }
  
  func downward() -> Point {
    return Point(x: x * y/abs(y), y: abs(y))
  }
}

// Operators

func *(left: Point, right: Double) -> Point {
  return Point(x: left.x * right, y: left.y * right, weight: -1)
}

func *(left: Double, right: Point) -> Point {
  return right * left
}

func /(left: Point, right: Double) -> Point {
  return Point(x: left.x / right, y: left.y / right, weight: -1)
}

func +(left: Point, right: Point) -> Point {
  return Point(x: left.x + right.x, y: left.y + right.y, weight: -1)
}

func -(left: Point, right: Point) -> Point {
  return Point(x: left.x - right.x, y: left.y - right.y, weight: -1)
}


extension Point : Equatable {}

func ==(left: Point, right: Point) -> Bool {
  return left.x == right.x && left.y == right.y && left.weight == right.weight
}

extension Point : CustomStringConvertible {
  var description: String {
    return "<\(x), \(y)>"
  }
}









let p1 = Point(x: 0, y: 0)
let p2 = Point(x: 0, y: 1)
let p3 = Point(x: 1, y: 1)
let p4 = Point(x: 1, y: 0)

let d1 = Point(x: 0, y: 1)
let d2 = Point(x: 0, y: 0)
let d3 = Point(x: 1, y: 0)
let d4 = Point(x: 1, y: 1)

let it = general2DProjectionMatrix(
  p1, p1_destination: d1,
  p2_start: p2, p2_destination: d2,
  p3_start: p3, p3_destination: d3,
  p4_start: p4, p4_destination: d4)

it.project(p1) == d1
it.project(p2) == d2
it.project(p3) == d3
it.project(p4) == d4

it.project(Point(x: 0.25, y:0.25))



