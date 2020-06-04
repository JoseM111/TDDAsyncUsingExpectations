import XCTest
@testable import TDDAsyncUsingExpectations

class TDDAsyncUsingExpectationsTests: XCTestCase {

// MARK: _©Test XCTestCase
    /**©-----------------------©*/
    override func setUp() {
        printf("Created ()--> running func test")
        super.setUp()
        // Initializing our object
//        self.acc = Account()
    }

    override func tearDown() {
        // Will run depending on how many test functions there are. 🤔
        printf("Destroyed ()--> running func test")
//        acc = nil
        super.tearDown()
        print("")
    }
    /**©-----------------------©*/

    // MARK: _©Test for funcs that are fetching data
    /**©-------------------------------------------©*/
    // "https://jsonplaceholder.typicode.com/posts"
    func test_GetAllPosts() {
        // MARK: #©XCTestExpectation
        let expectation = XCTestExpectation(description: "Post has been downloaded...")

        // MARK: #©listOfPost
        var listOfPost: [Post] = []

        // 1) - URL
        let url = URL(string: "https://jsonplaceholder.typicode.com/posts")
        guard let fullURL = url else { return }

        // 2) - Data-Task
        URLSession.shared.dataTask(with: fullURL) { (data, _, error) in
            // 3) - Error-Handling
            if let error = error {
                printf("Some Error.. \(error.localizedDescription)")
                /*-------------------------------------------------------
                  XCTFail():
                  Generates a failure immediately and unconditionally.
                  -------------------------------------------------------*/
                return XCTFail()
            }

            // 4) - Check for Data
            guard let data = data else { return XCTFail() }

            // 5) - Decode-Data
            let jsonDecoder = JSONDecoder()

            do {
                listOfPost = try jsonDecoder.decode([Post].self, from: data)
                expectation.fulfill()
            } catch {
                printf("No data..-->> \(error.localizedDescription)")
            }
        }.resume()

        wait(for: [expectation], timeout: 2.0)
        XCTAssertTrue(listOfPost.count > 0)
    }
    /**©-------------------------------------------©*/
}
