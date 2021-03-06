
import FileBuilder
import XCTest

final class ContentModifierTests: XCTestCase {

    func testContentModifier() throws {

        struct Append<C: Content, Line: Content>: ContentModifier {
            let line: Line
            func body(content: C) -> some Content {
                content
                line
            }
        }

        try AssertContent {
            "Hello".modifier(Append(line: "World!"))
        } is: {
            """
            Hello
            World!
            """
        }
    }
}
