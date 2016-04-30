import Foundation

struct Matrix {
  let m: [Double]
  init(_ a: Double, _ b: Double, _ c: Double,
         _ d: Double, _ e: Double, _ f: Double,
           _ g: Double, _ h: Double, _ i: Double) {
    m = [a, b, c, d, e, f, g, h, i]
  }
  
  init(arr: [Double]) {
    m = arr
  }
  
  func adj() -> Matrix { // Compute the adjugate of m
    return Matrix(
      m[4]*m[8]-m[5]*m[7], m[2]*m[7]-m[1]*m[8], m[1]*m[5]-m[2]*m[4],
      m[5]*m[6]-m[3]*m[8], m[0]*m[8]-m[2]*m[6], m[2]*m[3]-m[0]*m[5],
      m[3]*m[7]-m[4]*m[6], m[1]*m[6]-m[0]*m[7], m[0]*m[4]-m[1]*m[3]
    )
  }
  
  func project(p: Point) -> Point {
    let v = self * [p.x, p.y, 1]
    return Point(x: v[0]/v[2], y: v[1]/v[2])
  }
}

extension Matrix : CustomStringConvertible {
  var description: String {
    return "\(m[0]) \(m[3]) \(m[6]) | \(m[1]) \(m[4]) \(m[7]) | \(m[2]) \(m[5]) \(m[8])\n"
  }
}

func *(left: Matrix, right: Matrix) -> Matrix { // multiply two matrices
  var c: [Double] = [0, 0, 0, 0, 0, 0, 0, 0, 0]
  for i in 0 ..< 3 {
    for j in 0 ..< 3 {
      var cij: Double = 0;
      for k in 0 ..< 3 {
        cij += left.m[3*i + k] * right.m[3*k + j];
      }
      c[3*i + j] = cij;
    }
  }
  return Matrix(arr: c);
}

func *(left: Matrix, right: [Double]) -> [Double] { // multiply matrix and vector
  let m = left.m
  let v = right
  return [
    m[0]*v[0] + m[1]*v[1] + m[2]*v[2],
    m[3]*v[0] + m[4]*v[1] + m[5]*v[2],
    m[6]*v[0] + m[7]*v[1] + m[8]*v[2]
  ];
}

func basisToPoints(p1: Point, p2: Point, p3: Point, p4: Point) -> Matrix {
  let m = Matrix(
    p1.x, p2.x, p3.x,
    p1.y, p2.y, p3.y,
    1,  1,  1
  );
  var v = m.adj() * [p4.x, p4.y, 1];
  return m * Matrix(
    v[0], 0, 0,
    0, v[1], 0,
    0, 0, v[2]
  );
}

func general2DProjectionMatrix(
  p1_start: Point, p1_destination: Point,
  p2_start: Point, p2_destination: Point,
  p3_start: Point, p3_destination: Point,
  p4_start: Point, p4_destination: Point
  ) -> Matrix {
  let start = basisToPoints(p1_start, p2: p2_start, p3: p3_start, p4: p4_start);
  let destination = basisToPoints(p1_destination, p2: p2_destination, p3: p3_destination, p4: p4_destination);
  return destination * start.adj()
}
