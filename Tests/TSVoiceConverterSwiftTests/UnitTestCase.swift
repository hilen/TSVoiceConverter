//
//  UnitTestCase.swift
//  
//
//  Created by william on 2023/12/12.
//

import XCTest
import TSVoiceConverterSwift

final class UnitTestCase: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        // Any test you write for XCTest can be annotated as throws and async.
        // Mark your test throws to produce an unexpected failure when your test encounters an uncaught error.
        // Mark your test async to allow awaiting for asynchronous code to complete. Check the results with assertions afterwards.
    }

    func testVoiceConverter() throws {
        let amrPath = Bundle.module.path(forResource: "hello", ofType: "amr")
        let wavPath = Bundle.module.path(forResource: "count", ofType: "wav")

        let wavTargetPath = AudioFolderManager.wavPathWithName("hello_wav").path
        let amrTargetPath = AudioFolderManager.amrPathWithName("count_amr").path

        if TSVoiceConverter.convertAmrToWav(amrPath!, wavSavePath: wavTargetPath) {
            print("wav path: \(wavTargetPath)")
        } else {
            print("convertAmrToWav error")
        }

        if TSVoiceConverter.convertWavToAmr(wavPath!, amrSavePath: amrTargetPath) {
            print("amr path: \(amrTargetPath)")
        } else {
            print("convertWavToAmr error")
        }
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
