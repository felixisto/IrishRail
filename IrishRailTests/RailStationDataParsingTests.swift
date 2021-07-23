//
//  RailStationDataParsingTests.swift
//  IrishRailTests
//
//  Created by Kristiyan Butev on 23.07.21.
//

import XCTest
@testable import IrishRail

class RailStationDataParsingTests: XCTestCase {
    let data = IrishRailSampleData()
    
    var allStationsParser: AllStationsParser!
    var stationTrainCodesParser: StationDataTrainInfosParser!
    var trainMovementsParser: TrainMovementsParser!
    
    override func setUpWithError() throws {
        allStationsParser = AllStationsParserImpl()
        stationTrainCodesParser = StationDataTrainInfosParserImpl()
        trainMovementsParser = TrainMovementsParserImpl()
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testAllStationsParsingWithValidData() throws {
        let result = try allStationsParser.parse(xmlData: data.xmlData(of: data.allStations))
        XCTAssert(result.count == 2)
    }
    
    func testAllStationsParsingWithInvalidData() throws {
        do {
            let _ = try allStationsParser.parse(xmlData: data.xmlData(of: data.invalidAllStations))
            XCTAssert(false, "Parser must fail when parsing invalid data")
        } catch {
            
        }
    }
    
    func testAllStationsParsingWithBlankData() throws {
        do {
            let _ = try allStationsParser.parse(xmlData: Data())
            XCTAssert(false, "Parser must fail when parsing blank data")
        } catch {
            
        }
    }
    
    func testStationTrainCodesParsingWithValidData() throws {
        let result = try stationTrainCodesParser.parse(xmlData: data.xmlData(of: data.stationData))
        XCTAssert(result.count == 6)
    }
    
    func testStationTrainCodesParsingWithInvalidData() throws {
        do {
            let _ = try stationTrainCodesParser.parse(xmlData: data.xmlData(of: data.invalidStationData))
            XCTAssert(false, "Parser must fail when parsing invalid data")
        } catch {
            
        }
    }
    
    func testStationTrainCodesParsingWithBlankData() throws {
        do {
            let _ = try stationTrainCodesParser.parse(xmlData: Data())
            XCTAssert(false, "Parser must fail when parsing blank data")
        } catch {
            
        }
    }
    
    func testTrainMovementsParsingWithValidData() throws {
        let result = try trainMovementsParser.parse(xmlData: data.xmlData(of: data.trainMovements))
        XCTAssert(result.count == 32)
    }
    
    func testTrainMovementsParsingWithInvalidData() throws {
        do {
            let _ = try trainMovementsParser.parse(xmlData: data.xmlData(of: data.invalidTrainMovements))
            XCTAssert(false, "Parser must fail when parsing invalid data")
        } catch {
            
        }
    }
    
    func testTrainMovementsParsingWithBlankData() throws {
        do {
            let _ = try trainMovementsParser.parse(xmlData: Data())
            XCTAssert(false, "Parser must fail when parsing blank data")
        } catch {
            
        }
    }
}
