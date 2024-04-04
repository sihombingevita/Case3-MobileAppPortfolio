//
//  ChartData.swift
//  MobileAppPortfolio
//
//  Created by Evita Sihombing on 02/04/24.
//

import Foundation

struct ChartData: Codable {
    let type: String
    let data: DataUnion
}

enum DataUnion: Codable {
    case dataClass(DataClass)
    case datumArray([Datum])

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let x = try? container.decode([Datum].self) {
            self = .datumArray(x)
            return
        }
        if let x = try? container.decode(DataClass.self) {
            self = .dataClass(x)
            return
        }
        throw DecodingError.typeMismatch(DataUnion.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for DataUnion"))
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .dataClass(let x):
            try container.encode(x)
        case .datumArray(let x):
            try container.encode(x)
        }
    }
}

// MARK: - Datum
struct Datum: Codable {
    let label, percentage: String
    let details: [Detail]
}

// MARK: - Detail
struct Detail: Codable {
    let trxDate: TrxDate
    let nominal: Int

    enum CodingKeys: String, CodingKey {
        case trxDate = "trx_date"
        case nominal
    }
}

enum TrxDate: String, Codable {
    case the19012023 = "19/01/2023"
    case the20012023 = "20/01/2023"
    case the21012023 = "21/01/2023"
}

// MARK: - DataClass
struct DataClass: Codable {
    let month: [Int]
}
