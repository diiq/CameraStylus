import XCTest
@testable import CameraStylus

class SmoothFixedPenStrokeTests: XCTestCase {
  lazy var renderer = TestRenderer()
  lazy var stroke : BaseStroke = {
    let points = (1...5).map {
      return Point(x: 10.0 * Double($0), y: 50.0, weight: 1)
    }
    let stroke = SmoothFixedPenStroke(points: points)
    return stroke
  }()

  func testDraw() {
    stroke.draw(renderer)
    XCTAssertEqual(renderer.currentImage, [
      "color",
      "move: <10.0, 50.0>",
      "bezier: <10.0, 50.0>, [<10.0, 50.0>, <16.6666666666667, 50.0>], <20.0, 50.0>",
      "bezier: <20.0, 50.0>, [<23.3333333333333, 50.0>, <26.6666666666667, 50.0>], <30.0, 50.0>",
      "bezier: <30.0, 50.0>, [<33.3333333333333, 50.0>, <36.6666666666667, 50.0>], <40.0, 50.0>",
      "bezier: <40.0, 50.0>, [<43.3333333333333, 50.0>, <50.0, 50.0>], <50.0, 50.0>",
      "stroke"],
    "draw() draws points")
  }
}
