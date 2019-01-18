//
//  Structs.swift
//  Chess
//
//  Created by Jordan Doczy on 1/6/19.
//  Copyright © 2019 Jordan Doczy. All rights reserved.
//

import Foundation

struct Constants {
    static let squares = Squares()
    static let ranks = Ranks()
    static var possibleSpaces = [String:Set<Space>]()
    static var pathways = [String:Set<Space>]()
}

struct MoveStruct: Hashable, Equatable {
    var from: Space
    var to: Space
    let hashValue: Int
    
    init(from: Space, to: Space) {
        self.from = from
        self.to = to
        hashValue = Int("\(Constants.squares[from].index)\(Constants.squares[to].index)")!
    }
    
    public static func == (lhs: MoveStruct, rhs: MoveStruct) -> Bool {
        return lhs.hashValue == rhs.hashValue
    }
}

struct EnumMap<Enum: CaseIterable & Hashable, Value> {
    private let values: [Enum : Value]
    
    init(resolver: (Enum) -> Value) {
        var values = [Enum : Value]()
        
        for key in Enum.allCases {
            values[key] = resolver(key)
        }
        
        self.values = values
    }
    
    subscript(key: Enum) -> Value {
        return values[key]!
    }
}

struct Ranks {

    let model = EnumMap<Rank, Set<Space>> { type in
        switch type {
        case ._1: return [.a1,.b1,.c1,.d1,.e1,.f1,.g1,.h1]
        case ._2: return [.a2,.b2,.c2,.d2,.e2,.f2,.g2,.h2]
        case ._3: return [.a3,.b3,.c3,.d3,.e3,.f3,.g3,.h3]
        case ._4: return [.a4,.b4,.c4,.d4,.e4,.f4,.g4,.h4]
        case ._5: return [.a5,.b5,.c5,.d5,.e5,.f5,.g5,.h5]
        case ._6: return [.a6,.b6,.c6,.d6,.e6,.f6,.g6,.h6]
        case ._7: return [.a7,.b7,.c7,.d7,.e7,.f7,.g7,.h7]
        case ._8: return [.a8,.b8,.c8,.d8,.e8,.f8,.g8,.h8]
        }
    }
    
    subscript(rank: Rank) -> Set<Space> {
        get {
            return model[rank]
        }
    }
}

struct Diagonals {
    
    static let model = EnumMap<Diagonal, Set<Space>> { type in
        switch type {
        case .a1h8: return [.a1,.b2,.c3,.d4,.e5,.f6,.g7,.h8]
        case .b1h7: return [.b1,.c2,.d3,.e4,.f5,.g6,.h7]
        case .b1a2: return [.b1,.a2]
        case .b8a7: return [.b8,.a7]
        case .b8h2: return [.b8,.c7,.d6,.e5,.f4,.g3,.h2]
        case .c1h6: return [.c1,.d2,.e3,.f4,.g5,.h6]
        case .c1a3: return [.c1,.b2,.a3]
        case .c8a6: return [.c8,.b7,.a6]
        case .c8h3: return [.c8,.d7,.e6,.f5,.g4,.h3]
        case .d1h5: return [.d1,.e2,.f3,.g4,.h5]
        case .d1a4: return [.d1,.c2,.b3,.a4]
        case .d8a5: return [.d8,.c7,.b6,.a5]
        case .d8h4: return [.d8,.e7,.f6,.g5,.h4]
        case .e1h4: return [.e1,.f2,.g3,.h4]
        case .e1a5: return [.e1,.d2,.c3,.b4,.a5]
        case .e8a4: return [.e8,.d7,.c6,.b5,.a4]
        case .e8h5: return [.e8,.f7,.g6,.h5]
        case .f1h3: return [.f1,.g2,.h3]
        case .f1a6: return [.f1,.e2,.d3,.c4,.b5,.a6]
        case .f8a3: return [.f8,.e7,.d6,.c5,.b4,.a3]
        case .f8h6: return [.f8,.g7,.h6]
        case .g1h2: return [.g1,.h2]
        case .g1a7: return [.g1,.f2,.e3,.d4,.c5,.b6,.a7]
        case .g8a2: return [.g8,.f7,.e6,.d5,.c4,.b3,.a2]
        case .g8h7: return [.g8,.h7]
        case .h1a8: return [.h1,.g2,.f3,.e4,.d5,.c6,.b7,.a8]
        }
    }
    
    static func getSpaces(diagonal: Diagonal) -> Set<Space> {
        return model[diagonal]
    }
}

typealias Square = (
    index: Int,
    adjacentSpaces: Set<Space>,
    file: File,
    fileSpaces: Set<Space>,
    rank: Rank,
    rankSpaces: Set<Space>,
    diagonals: Set<Diagonal>,
    diagonalSpaces: Set<Space>,
    knightMoves: Set<Space>)

struct Squares {

    subscript(space: Space) -> Square {
        get {
            return model[space]
        }
    }
    
    let model = EnumMap<Space, Square> { type in
        switch type {
        case .a1: return (index: 0,
                          adjacentSpaces: [.a2,.b1,.b2],
                          file: .a,
                          fileSpaces: [.a1,.a2,.a3,.a4,.a5,.a6,.a7,.a8],
                          rank: ._1,
                          rankSpaces: [.a1,.b1,.c1,.d1,.e1,.f1,.g1,.h1],
                          diagonals: [.a1h8],
                          diagonalSpaces: [.a1,.b2,.c3,.d4,.e5,.f6,.g7,.h8],
                          knightMoves: [.b3,.c2])
        case .a2: return (index: 1,
                         adjacentSpaces: [.a1,.a3,.b1,.b2,.b3],
                         file: .a,
                         fileSpaces: [.a1,.a2,.a3,.a4,.a5,.a6,.a7,.a8],
                         rank: ._2,
                         rankSpaces: [.a2,.b2,.c2,.d2,.e2,.f2,.g2,.h2],
                         diagonals: [.g8a2, .b1a2],
                         diagonalSpaces: [.g8,.f7,.e6,.d5,.c4,.b3,.a2,.b1],
                         knightMoves: [.b4,.c1,.c3])
        case .a3: return (index: 2,
                          adjacentSpaces: [.a2,.a4,.b2,.b3,.b4],
                         file: .a,
                         fileSpaces: [.a1,.a2,.a3,.a4,.a5,.a6,.a7,.a8],
                         rank: ._3,
                         rankSpaces: [.a3,.b3,.c3,.d3,.e3,.f3,.g3,.h3],
                         diagonals: [.f8a3, .c1a3],
                         diagonalSpaces: [.f8,.e7,.d6,.c5,.b4,.a3,.c1,.b2],
                         knightMoves: [.b5,.b1,.c4,.c2])
        case .a4: return (index: 3,
                          adjacentSpaces: [.a3,.a5,.b3,.b4,.b5],
                         file: .a,
                         fileSpaces: [.a1,.a2,.a3,.a4,.a5,.a6,.a7,.a8],
                         rank: ._4,
                         rankSpaces: [.a4,.b4,.c4,.d4,.e4,.f4,.g4,.h4],
                         diagonals: [.e8a4, .d1a4],
                         diagonalSpaces: [.d1,.c2,.b3,.a4,.e8,.d7,.c6,.b5],
                         knightMoves: [.b6,.b2,.c5,.c3])
        case .a5: return (index: 4,
                          adjacentSpaces: [.a4,.a6,.b4,.b5,.b6],
                         file: .a,
                         fileSpaces: [.a1,.a2,.a3,.a4,.a5,.a6,.a7,.a8],
                         rank: ._5,
                         rankSpaces: [.a5,.b5,.c5,.d5,.e5,.f5,.g5,.h5],
                         diagonals: [.d8a5, .e1a5],
                         diagonalSpaces: [.e1,.d2,.c3,.b4,.a5,.d8,.c7,.b6],
                         knightMoves: [.b7,.b3,.c6,.c4])
        case .a6: return (index: 5,
                          adjacentSpaces: [.a5,.a7,.b5,.b6,.b7],
                         file: .a,
                         fileSpaces: [.a1,.a2,.a3,.a4,.a5,.a6,.a7,.a8],
                         rank: ._6,
                         rankSpaces: [.a6,.b6,.c6,.d6,.e6,.f6,.g6,.h6],
                         diagonals: [.c8a6, .f1a6],
                         diagonalSpaces: [.c8,.b7,.a6,.f1,.e2,.d3,.c4,.b5],
                         knightMoves: [.b8,.b4,.c7,.c5])
        case .a7: return (index: 6,
                          adjacentSpaces: [.a6,.a8,.b6,.b7,.b8],
                         file: .a,
                         fileSpaces: [.a1,.a2,.a3,.a4,.a5,.a6,.a7,.a8],
                         rank: ._7,
                         rankSpaces: [.a7,.b7,.c7,.d7,.e7,.f7,.g7,.h7],
                         diagonals: [.b8a7, .g1a7],
                         diagonalSpaces: [.g1,.f2,.e3,.d4,.c5,.b6,.a7,.b8],
                         knightMoves: [.b5,.c8,.c6])
        case .a8: return (index: 7,
                          adjacentSpaces: [.a7,.b7,.b8],
                         file: .a,
                         fileSpaces: [.a1,.a2,.a3,.a4,.a5,.a6,.a7,.a8],
                         rank: ._8,
                         rankSpaces: [.a8,.b8,.c8,.d8,.e8,.f8,.g8,.h8],
                         diagonals: [.h1a8],
                         diagonalSpaces: [.h1,.g2,.f3,.e4,.d5,.c6,.b7,.a8],
                         knightMoves: [.b6,.c7])
        case .b1: return (index: 8,
                          adjacentSpaces: [.a1,.a2,.b2,.c1,.c2],
                         file: .b,
                         fileSpaces: [.b1,.b2,.b3,.b4,.b5,.b6,.b7,.b8],
                         rank: ._1,
                         rankSpaces: [.a1,.b1,.c1,.d1,.e1,.f1,.g1,.h1],
                         diagonals: [.b1a2, .b1h7],
                         diagonalSpaces: [.b1,.c2,.d3,.e4,.f5,.g6,.h7,.a2],
                         knightMoves: [.a3,.c3,.d2])
        case .b2: return (index: 9,
                          adjacentSpaces: [.a1,.a2,.a3,.b1,.b3,.c1,.c2,.c3],
                         file: .b,
                         fileSpaces: [.b1,.b2,.b3,.b4,.b5,.b6,.b7,.b8],
                         rank: ._2,
                         rankSpaces: [.a2,.b2,.c2,.d2,.e2,.f2,.g2,.h2],
                         diagonals: [.a1h8, .c1a3],
                         diagonalSpaces: [.a1,.b2,.c3,.d4,.e5,.f6,.g7,.h8,.c1,.a3],
                         knightMoves: [.a4,.c4,.d1,.d3])
        case .b3: return (index: 10,
                          adjacentSpaces: [.a2,.a3,.a4,.b2,.b4,.c2,.c3,.c4],
                         file: .b,
                         fileSpaces: [.b1,.b2,.b3,.b4,.b5,.b6,.b7,.b8],
                         rank: ._3,
                         rankSpaces: [.a3,.b3,.c3,.d3,.e3,.f3,.g3,.h3],
                         diagonals: [.g8a2, .d1a4],
                         diagonalSpaces: [.g8,.f7,.e6,.d5,.c4,.b3,.a2,.d1,.c2,.a4],
                         knightMoves: [.a1,.a5,.c1,.c5,.d2,.d4])
        case .b4: return (index: 11,
                          adjacentSpaces: [.a3,.a4,.a5,.b3,.b5,.c3,.c4,.c5],
                         file: .b,
                         fileSpaces: [.b1,.b2,.b3,.b4,.b5,.b6,.b7,.b8],
                         rank: ._4,
                         rankSpaces: [.a4,.b4,.c4,.d4,.e4,.f4,.g4,.h4],
                         diagonals: [.f8a3, .e1a5],
                         diagonalSpaces: [.f8,.e7,.d6,.c5,.b4,.a3,.e1,.d2,.c3,.a5],
                         knightMoves: [.a2,.a6,.c2,.c6,.d3,.d5])
        case .b5: return (index: 12,
                          adjacentSpaces: [.a4,.a5,.a6,.b4,.b6,.c4,.c5,.c6],
                         file: .b,
                         fileSpaces: [.b1,.b2,.b3,.b4,.b5,.b6,.b7,.b8],
                         rank: ._5,
                         rankSpaces: [.a5,.b5,.c5,.d5,.e5,.f5,.g5,.h5],
                         diagonals: [.e8a4, .f1a6],
                         diagonalSpaces: [.e8,.d7,.c6,.b5,.a4,.f1,.e2,.d3,.c4,.a6],
                         knightMoves: [.a3,.a7,.c3,.c7,.d4,.d6])
        case .b6: return (index: 13,
                          adjacentSpaces: [.a5,.a6,.a7,.b5,.b7,.c5,.c6,.c7],
                         file: .b,
                         fileSpaces: [.b1,.b2,.b3,.b4,.b5,.b6,.b7,.b8],
                         rank: ._6,
                         rankSpaces: [.a6,.b6,.c6,.d6,.e6,.f6,.g6,.h6],
                         diagonals: [.d8a5, .g1a7],
                         diagonalSpaces: [.d8,.c7,.b6,.a5,.g1,.f2,.e3,.d4,.c5,.a7],
                         knightMoves: [.a4,.a8,.c4,.c8,.d5,.d7])
        case .b7: return (index: 14,
                          adjacentSpaces: [.a6,.a7,.a8,.b6,.b8,.c6,.c7,.c8],
                         file: .b,
                         fileSpaces: [.b1,.b2,.b3,.b4,.b5,.b6,.b7,.b8],
                         rank: ._7,
                         rankSpaces: [.a7,.b7,.c7,.d7,.e7,.f7,.g7,.h7],
                         diagonals: [.c8a6, .h1a8],
                         diagonalSpaces: [.c8,.b7,.a6,.h1,.g2,.f3,.e4,.d5,.c6,.a8],
                         knightMoves: [.a5,.c5,.d6,.d8])
        case .b8: return (index: 15,
                          adjacentSpaces: [.a7,.a8,.b7,.c7,.c8],
                         file: .b,
                         fileSpaces: [.b1,.b2,.b3,.b4,.b5,.b6,.b7,.b8],
                         rank: ._8,
                         rankSpaces: [.a8,.b8,.c8,.d8,.e8,.f8,.g8,.h8],
                         diagonals: [.b8a7, .b8h2],
                         diagonalSpaces: [.b8,.a7,.c7,.d6,.e5,.f4,.g3,.h2],
                         knightMoves: [.a6,.c6,.d7])
        case .c1: return (index: 16,
                          adjacentSpaces: [.b1,.b2,.c2,.d1,.d2],
                         file: .c,
                         fileSpaces: [.c1,.c2,.c3,.c4,.c5,.c6,.c7,.c8],
                         rank: ._1,
                         rankSpaces: [.a1,.b1,.c1,.d1,.e1,.f1,.g1,.h1],
                         diagonals: [.c1a3, .c1h6],
                         diagonalSpaces: [.c1,.d2,.e3,.f4,.g5,.h6,.b2,.a3],
                         knightMoves: [.a2,.b3,.d3,.e2])
        case .c2: return (index: 17,
                          adjacentSpaces: [.b1,.b2,.b3,.c1,.c3,.d1,.d2,.d3],
                         file: .c,
                         fileSpaces: [.c1,.c2,.c3,.c4,.c5,.c6,.c7,.c8],
                         rank: ._2,
                         rankSpaces: [.a2,.b2,.c2,.d2,.e2,.f2,.g2,.h2],
                         diagonals: [.d1a4, .b1h7],
                         diagonalSpaces: [.b1,.c2,.d3,.e4,.f5,.g6,.h7,.d1,.b3,.a4],
                         knightMoves: [.a1,.a3,.b4,.d4,.e1,.e3])
        case .c3: return (index: 18,
                          adjacentSpaces: [.b2,.b3,.b4,.c2,.c4,.d2,.d3,.d4],
                         file: .c,
                         fileSpaces: [.c1,.c2,.c3,.c4,.c5,.c6,.c7,.c8],
                         rank: ._3,
                         rankSpaces: [.a3,.b3,.c3,.d3,.e3,.f3,.g3,.h3],
                         diagonals: [.e1a5, .a1h8],
                         diagonalSpaces: [.a1,.b2,.c3,.d4,.e5,.f6,.g7,.h8,.e1,.d2,.b4,.a5],
                         knightMoves: [.a2,.a4,.b1,.b5,.d1,.d5,.e2,.e4])
        case .c4: return (index: 19,
                          adjacentSpaces: [.b3,.b4,.b5,.c3,.c5,.d3,.d4,.d5],
                         file: .c,
                         fileSpaces: [.c1,.c2,.c3,.c4,.c5,.c6,.c7,.c8],
                         rank: ._4,
                         rankSpaces: [.a4,.b4,.c4,.d4,.e4,.f4,.g4,.h4],
                         diagonals: [.g8a2, .f1a6],
                         diagonalSpaces: [.f1,.e2,.d3,.c4,.b5,.a6,.g8,.f7,.e6,.d5,.b3,.a2],
                         knightMoves: [.a3,.a5,.b2,.b6,.d2,.d6,.e3,.e5])
        case .c5: return (index: 20,
                          adjacentSpaces: [.b4,.b5,.b6,.c4,.c6,.d4,.d5,.d6],
                         file: .c,
                         fileSpaces: [.c1,.c2,.c3,.c4,.c5,.c6,.c7,.c8],
                         rank: ._5,
                         rankSpaces: [.a5,.b5,.c5,.d5,.e5,.f5,.g5,.h5],
                         diagonals: [.f8a3, .g1a7],
                         diagonalSpaces: [.f8,.e7,.d6,.c5,.b4,.a3,.g1,.f2,.e3,.d4,.b6,.a7],
                         knightMoves: [.a4,.a6,.b3,.b7,.d3,.d7,.e4,.e6])
        case .c6: return (index: 21,
                          adjacentSpaces: [.b5,.b6,.b7,.c5,.c7,.d5,.d6,.d7],
                         file: .c,
                         fileSpaces: [.c1,.c2,.c3,.c4,.c5,.c6,.c7,.c8],
                         rank: ._6,
                         rankSpaces: [.a6,.b6,.c6,.d6,.e6,.f6,.g6,.h6],
                         diagonals: [.e8a4, .h1a8],
                         diagonalSpaces: [.e8,.d7,.c6,.b5,.a4,.h1,.g2,.f3,.e4,.d5,.b7,.a8],
                         knightMoves: [.a5,.a7,.b4,.b8,.d4,.d8,.e6,.e7])
        case .c7: return (index: 22,
                          adjacentSpaces: [.b6,.b7,.b8,.c6,.c8,.d6,.d7,.d8],
                         file: .c,
                         fileSpaces: [.c1,.c2,.c3,.c4,.c5,.c6,.c7,.c8],
                         rank: ._7,
                         rankSpaces: [.a7,.b7,.c7,.d7,.e7,.f7,.g7,.h7],
                         diagonals: [.d8a5, .b8h2],
                         diagonalSpaces: [.b8,.c7,.d6,.e5,.f4,.g3,.h2,.d8,.b6,.a5],
                         knightMoves: [.a6,.a8,.b5,.d5,.e6,.e8])
        case .c8: return (index: 23,
                          adjacentSpaces: [.b7,.b8,.c7,.d7,.d8],
                         file: .c,
                         fileSpaces: [.c1,.c2,.c3,.c4,.c5,.c6,.c7,.c8],
                         rank: ._8,
                         rankSpaces: [.a8,.b8,.c8,.d8,.e8,.f8,.g8,.h8],
                         diagonals: [.c8a6, .c8h3],
                         diagonalSpaces: [.c8,.b7,.a6,.d7,.e6,.f5,.g4,.h3],
                         knightMoves: [.a7,.b6,.d6,.e7])
        case .d1: return (index: 24,
                          adjacentSpaces: [.c1,.c2,.d2,.e1,.e2],
                         file: .d,
                         fileSpaces: [.d1,.d2,.d3,.d4,.d5,.d6,.d7,.d8],
                         rank: ._1,
                         rankSpaces: [.a1,.b1,.c1,.d1,.e1,.f1,.g1,.h1],
                         diagonals: [.d1a4, .d1h5],
                         diagonalSpaces: [.d1,.e2,.f3,.g4,.h5,.c2,.b3,.a4],
                         knightMoves: [.b2,.c3,.e3,.f2])
        case .d2: return (index: 25,
                          adjacentSpaces: [.c1,.c2,.c3,.d1,.d3,.e1,.e2,.e3],
                         file: .d,
                         fileSpaces: [.d1,.d2,.d3,.d4,.d5,.d6,.d7,.d8],
                         rank: ._2,
                         rankSpaces: [.a2,.b2,.c2,.d2,.e2,.f2,.g2,.h2],
                         diagonals: [.c1h6, .e1a5],
                         diagonalSpaces: [.c1,.d2,.e3,.f4,.g5,.h6,.e1,.c3,.b4,.a5],
                         knightMoves: [.b1,.b3,.c4,.e4,.f1,.f3])
        case .d3: return (index: 26,
                          adjacentSpaces: [.c2,.c3,.c4,.d2,.d4,.e2,.e3,.e4],
                         file: .d,
                         fileSpaces: [.d1,.d2,.d3,.d4,.d5,.d6,.d7,.d8],
                         rank: ._3,
                         rankSpaces: [.a3,.b3,.c3,.d3,.e3,.f3,.g3,.h3],
                         diagonals: [.b1h7, .f1a6],
                         diagonalSpaces: [.f1,.e2,.d3,.c4,.b5,.a6,.b1,.c2,.e4,.f5,.g6,.h7],
                         knightMoves: [.b2,.b4,.c1,.c5,.e1,.e5,.f2,.f4])
        case .d4: return (index: 27,
                          adjacentSpaces: [.c3,.c4,.c5,.d3,.d5,.e3,.e4,.e5],
                         file: .d,
                         fileSpaces: [.d1,.d2,.d3,.d4,.d5,.d6,.d7,.d8],
                         rank: ._4,
                         rankSpaces: [.a4,.b4,.c4,.d4,.e4,.f4,.g4,.h4],
                         diagonals: [.a1h8, .g1a7],
                         diagonalSpaces: [.g1,.f2,.e3,.d4,.c5,.b6,.a7,.a1,.b2,.c3,.e5,.f6,.g7,.h8],
                         knightMoves: [.b3,.b5,.c2,.c6,.e2,.e6,.f3,.f5])
        case .d5: return (index: 28,
                          adjacentSpaces: [.c4,.c5,.c6,.d4,.d6,.e4,.e5,.e6],
                         file: .d,
                         fileSpaces: [.d1,.d2,.d3,.d4,.d5,.d6,.d7,.d8],
                         rank: ._5,
                         rankSpaces: [.a5,.b5,.c5,.d5,.e5,.f5,.g5,.h5],
                         diagonals: [.g8a2, .h1a8],
                         diagonalSpaces: [.g8,.f7,.e6,.d5,.c4,.b3,.a2,.h1,.g2,.f3,.e4,.c6,.b7,.a8],
                         knightMoves: [.b4,.b6,.c3,.c7,.e3,.e7,.f4,.f6])
        case .d6: return (index: 29,
                          adjacentSpaces: [.c5,.c6,.c7,.d5,.d7,.e5,.e6,.e7],
                         file: .d,
                         fileSpaces: [.d1,.d2,.d3,.d4,.d5,.d6,.d7,.d8],
                         rank: ._6,
                         rankSpaces: [.a6,.b6,.c6,.d6,.e6,.f6,.g6,.h6],
                         diagonals: [.f8a3, .b8h2],
                         diagonalSpaces: [.b8,.c7,.d6,.e5,.f4,.g3,.h2,.f8,.e7,.c5,.b4,.a3],
                         knightMoves: [.b5,.b7,.c4,.c8,.e4,.e8,.f6,.f7])
        case .d7: return (index: 30,
                          adjacentSpaces: [.c6,.c7,.c8,.d6,.d8,.e6,.e7,.e8],
                         file: .d,
                         fileSpaces: [.d1,.d2,.d3,.d4,.d5,.d6,.d7,.d8],
                         rank: ._7,
                         rankSpaces: [.a7,.b7,.c7,.d7,.e7,.f7,.g7,.h7],
                         diagonals: [.e8a4, .c8h3],
                         diagonalSpaces: [.c8,.d7,.e6,.f5,.g4,.h3,.e8,.c6,.b5,.a4],
                         knightMoves: [.b6,.b8,.c5,.e5,.f6,.f8])
        case .d8: return (index: 31,
                          adjacentSpaces: [.c7,.c8,.d7,.e7,.e8],
                         file: .d,
                         fileSpaces: [.d1,.d2,.d3,.d4,.d5,.d6,.d7,.d8],
                         rank: ._8,
                         rankSpaces: [.a8,.b8,.c8,.d8,.e8,.f8,.g8,.h8],
                         diagonals: [.d8a5, .d8h4],
                         diagonalSpaces: [.d8,.c7,.b6,.a5,.e7,.f6,.g5,.h4],
                         knightMoves: [.b7,.c6,.e6,.f7])
        case .e1: return (index: 32,
                          adjacentSpaces: [.d1,.d2,.e2,.f1,.f2],
                         file: .e,
                         fileSpaces: [.e1,.e2,.e3,.e4,.e5,.e6,.e7,.e8],
                         rank: ._1,
                         rankSpaces: [.a1,.b1,.c1,.d1,.e1,.f1,.g1,.h1],
                         diagonals: [.e1a5, .e1h4],
                         diagonalSpaces: [.e1,.f2,.g3,.h4,.d2,.c3,.b4,.a5],
                         knightMoves: [.c2,.d3,.f3,.g2])
        case .e2: return (index: 33,
                          adjacentSpaces: [.d1,.d2,.d3,.e1,.e3,.f1,.f2,.f3],
                         file: .e,
                         fileSpaces: [.e1,.e2,.e3,.e4,.e5,.e6,.e7,.e8],
                         rank: ._2,
                         rankSpaces: [.a2,.b2,.c2,.d2,.e2,.f2,.g2,.h2],
                         diagonals: [.d1h5, .f1a6],
                         diagonalSpaces: [.d1,.e2,.f3,.g4,.h5,.f1,.d3,.c4,.b5,.a6],
                         knightMoves: [.c1,.c3,.d4,.f4,.g1,.g3])
        case .e3: return (index: 34,
                          adjacentSpaces: [.d2,.d3,.d4,.e2,.e4,.f2,.f3,.f4],
                         file: .e,
                         fileSpaces: [.e1,.e2,.e3,.e4,.e5,.e6,.e7,.e8],
                         rank: ._3,
                         rankSpaces: [.a3,.b3,.c3,.d3,.e3,.f3,.g3,.h3],
                         diagonals: [.c1h6, .g1a7],
                         diagonalSpaces: [.c1,.d2,.e3,.f4,.g5,.h6,.g1,.f2,.d4,.c5,.b6,.a7],
                         knightMoves: [.c2,.c4,.d1,.d5,.f1,.f5,.g2,.g4])
        case .e4: return (index: 35,
                          adjacentSpaces: [.d3,.d4,.d5,.e3,.e5,.f3,.f4,.f5],
                         file: .e,
                         fileSpaces: [.e1,.e2,.e3,.e4,.e5,.e6,.e7,.e8],
                         rank: ._4,
                         rankSpaces: [.a4,.b4,.c4,.d4,.e4,.f4,.g4,.h4],
                         diagonals: [.b1h7, .h1a8],
                         diagonalSpaces: [.b1,.c2,.d3,.e4,.f5,.g6,.h7,.h1,.g2,.f3,.d5,.c6,.b7,.a8],
                         knightMoves: [.c3,.c5,.d2,.d6,.f2,.f6,.g3,.g5])
        case .e5: return (index: 36,
                          adjacentSpaces: [.d4,.d5,.d6,.e4,.e6,.f4,.f5,.f6],
                         file: .e,
                         fileSpaces: [.e1,.e2,.e3,.e4,.e5,.e6,.e7,.e8],
                         rank: ._5,
                         rankSpaces: [.a5,.b5,.c5,.d5,.e5,.f5,.g5,.h5],
                         diagonals: [.a1h8, .b8h2],
                         diagonalSpaces: [.a1,.b2,.c3,.d4,.e5,.f6,.g7,.h8,.b8,.c7,.d6,.f4,.g3,.h2],
                         knightMoves: [.c4,.c6,.d3,.d7,.f3,.f7,.g4,.g6])
        case .e6: return (index: 37,
                          adjacentSpaces: [.d5,.d6,.d7,.e5,.e7,.f5,.f6,.f7],
                         file: .e,
                         fileSpaces: [.e1,.e2,.e3,.e4,.e5,.e6,.e7,.e8],
                         rank: ._6,
                         rankSpaces: [.a6,.b6,.c6,.d6,.e6,.f6,.g6,.h6],
                         diagonals: [.g8a2, .c8h3],
                         diagonalSpaces: [.c8,.d7,.e6,.f5,.g4,.h3,.g8,.f7,.d5,.c4,.b3,.a2],
                         knightMoves: [.c5,.c7,.d4,.d8,.f4,.f8,.g6,.g7])
        case .e7: return (index: 38,
                          adjacentSpaces: [.d6,.d7,.d8,.e6,.e8,.f6,.f7,.f8],
                         file: .e,
                         fileSpaces: [.e1,.e2,.e3,.e4,.e5,.e6,.e7,.e8],
                         rank: ._7,
                         rankSpaces: [.a7,.b7,.c7,.d7,.e7,.f7,.g7,.h7],
                         diagonals: [.f8a3, .d8h4],
                         diagonalSpaces: [.d8,.e7,.f6,.g5,.h4,.f8,.d6,.c5,.b4,.a3],
                         knightMoves: [.c6,.c8,.d5,.f5,.g6,.g8])
        case .e8: return (index: 39,
                          adjacentSpaces: [.d7,.d8,.e7,.f7,.f8],
                         file: .e,
                         fileSpaces: [.e1,.e2,.e3,.e4,.e5,.e6,.e7,.e8],
                         rank: ._8,
                         rankSpaces: [.a8,.b8,.c8,.d8,.e8,.f8,.g8,.h8],
                         diagonals: [.e8a4, .e8h5],
                         diagonalSpaces: [.e8,.d7,.c6,.b5,.a4,.f7,.g6,.h5],
                         knightMoves: [.c7,.d6,.f6,.g7])
        case .f1: return (index: 40,
                          adjacentSpaces: [.e1,.e2,.f2,.g1,.g2],
                         file: .f,
                         fileSpaces: [.f1,.f2,.f3,.f4,.f5,.f6,.f7,.f8],
                         rank: ._1,
                         rankSpaces: [.a1,.b1,.c1,.d1,.e1,.f1,.g1,.h1],
                         diagonals: [.f1a6, .f1h3],
                         diagonalSpaces: [.f1,.g2,.h3,.e2,.d3,.c4,.b5,.a6],
                         knightMoves: [.d2,.e3,.g3,.h2])
        case .f2: return (index: 41,
                          adjacentSpaces: [.e1,.e2,.e3,.f1,.f3,.g1,.g2,.g3],
                         file: .f,
                         fileSpaces: [.f1,.f2,.f3,.f4,.f5,.f6,.f7,.f8],
                         rank: ._2,
                         rankSpaces: [.a2,.b2,.c2,.d2,.e2,.f2,.g2,.h2],
                         diagonals: [.e1h4, .g1a7],
                         diagonalSpaces: [.e1,.f2,.g3,.h4,.g1,.e3,.d4,.c5,.b6,.a7],
                         knightMoves: [.d1,.d3,.e4,.g4,.g1,.h3])
        case .f3: return (index: 42,
                          adjacentSpaces: [.e2,.e3,.e4,.f2,.f4,.g2,.g3,.g4],
                         file: .f,
                         fileSpaces: [.f1,.f2,.f3,.f4,.f5,.f6,.f7,.f8],
                         rank: ._3,
                         rankSpaces: [.a3,.b3,.c3,.d3,.e3,.f3,.g3,.h3],
                         diagonals: [.d1h5, .h1a8],
                         diagonalSpaces: [.d1,.e2,.f3,.g4,.h5,.h1,.g2,.e4,.d5,.c6,.b7,.a8],
                         knightMoves: [.d2,.d4,.e1,.e5,.g1,.g5,.h2,.h4])
        case .f4: return (index: 43,
                          adjacentSpaces: [.e3,.e4,.e5,.f3,.f5,.g3,.g4,.g5],
                         file: .f,
                         fileSpaces: [.f1,.f2,.f3,.f4,.f5,.f6,.f7,.f8],
                         rank: ._4,
                         rankSpaces: [.a4,.b4,.c4,.d4,.e4,.f4,.g4,.h4],
                         diagonals: [.c1h6, .b8h2],
                         diagonalSpaces: [.b8,.c7,.d6,.e5,.f4,.g3,.h2,.c1,.d2,.e3,.g5,.h6],
                         knightMoves: [.d3,.d5,.e2,.e6,.g2,.g6,.h3,.h5])
        case .f5: return (index: 44,
                          adjacentSpaces: [.e4,.e5,.e6,.f4,.f6,.g4,.g5,.g6],
                         file: .f,
                         fileSpaces: [.f1,.f2,.f3,.f4,.f5,.f6,.f7,.f8],
                         rank: ._5,
                         rankSpaces: [.a5,.b5,.c5,.d5,.e5,.f5,.g5,.h5],
                         diagonals: [.b1h7, .c8h3],
                         diagonalSpaces: [.b1,.c2,.d3,.e4,.f5,.g6,.h7,.c8,.d7,.e6,.g4,.h3],
                         knightMoves: [.d4,.d6,.e3,.e7,.g3,.g7,.h4,.h6])
        case .f6: return (index: 45,
                          adjacentSpaces: [.e5,.e6,.e7,.f5,.f7,.g5,.g6,.g7],
                         file: .f,
                         fileSpaces: [.f1,.f2,.f3,.f4,.f5,.f6,.f7,.f8],
                         rank: ._6,
                         rankSpaces: [.a6,.b6,.c6,.d6,.e6,.f6,.g6,.h6],
                         diagonals: [.a1h8, .d8h4],
                         diagonalSpaces: [.a1,.b2,.c3,.d4,.e5,.f6,.g7,.h8,.d8,.e7,.g5,.h4],
                         knightMoves: [.d5,.d7,.e4,.e8,.g4,.g8,.h6,.h7])
        case .f7: return (index: 46,
                          adjacentSpaces: [.e6,.e7,.e8,.f6,.f8,.g6,.g7,.g8],
                         file: .f,
                         fileSpaces: [.f1,.f2,.f3,.f4,.f5,.f6,.f7,.f8],
                         rank: ._7,
                         rankSpaces: [.a7,.b7,.c7,.d7,.e7,.f7,.g7,.h7],
                         diagonals: [.g8a2, .e8h5],
                         diagonalSpaces: [.e8,.f7,.g6,.h5,.g8,.e6,.d5,.c4,.b3,.a2],
                         knightMoves: [.d6,.d8,.e5,.g5,.h6,.h8])
        case .f8: return (index: 47,
                          adjacentSpaces: [.e7,.e8,.f7,.g7,.g8],
                         file: .f,
                         fileSpaces: [.f1,.f2,.f3,.f4,.f5,.f6,.f7,.f8],
                         rank: ._8,
                         rankSpaces: [.a8,.b8,.c8,.d8,.e8,.f8,.g8,.h8],
                         diagonals: [.f8a3, .f8h6],
                         diagonalSpaces: [.f8,.e7,.d6,.c5,.b4,.a3,.g7,.h6],
                         knightMoves: [.d7,.e6,.g6,.h7])
        case .g1: return (index: 48,
                          adjacentSpaces: [.f1,.f2,.g2,.h1,.h2],
                         file: .g,
                         fileSpaces: [.g1,.g2,.g3,.g4,.g5,.g6,.g7,.g8],
                         rank: ._1,
                         rankSpaces: [.a1,.b1,.c1,.d1,.e1,.f1,.g1,.h1],
                         diagonals: [.g1a7, .g1h2],
                         diagonalSpaces: [.g1,.h2,.f2,.e3,.d4,.c5,.b6,.a7],
                         knightMoves: [.h3,.f3,.e2])
        case .g2: return (index: 49,
                          adjacentSpaces: [.f1,.f2,.f3,.g1,.g3,.h1,.h2,.h3],
                         file: .g,
                         fileSpaces: [.g1,.g2,.g3,.g4,.g5,.g6,.g7,.g8],
                         rank: ._2,
                         rankSpaces: [.a2,.b2,.c2,.d2,.e2,.f2,.g2,.h2],
                         diagonals: [.f1h3, .h1a8],
                         diagonalSpaces: [.f1,.g2,.h3,.h1,.f3,.e4,.d5,.c6,.b7,.a8],
                         knightMoves: [.h4,.f4,.e1,.e3])
        case .g3: return (index: 50,
                          adjacentSpaces: [.f2,.f3,.f4,.g2,.g4,.h2,.h3,.h4],
                         file: .g,
                         fileSpaces: [.g1,.g2,.g3,.g4,.g5,.g6,.g7,.g8],
                         rank: ._3,
                         rankSpaces: [.a3,.b3,.c3,.d3,.e3,.f3,.g3,.h3],
                         diagonals: [.e1h4, .b8h2],
                         diagonalSpaces: [.b8,.c7,.d6,.e5,.f4,.g3,.h2,.e1,.f2,.h4],
                         knightMoves: [.h1,.h5,.f1,.f5,.e2,.e4])
        case .g4: return (index: 51,
                          adjacentSpaces: [.f3,.f4,.f5,.g3,.g5,.h3,.h4,.h5],
                         file: .g,
                         fileSpaces: [.g1,.g2,.g3,.g4,.g5,.g6,.g7,.g8],
                         rank: ._4,
                         rankSpaces: [.a4,.b4,.c4,.d4,.e4,.f4,.g4,.h4],
                         diagonals: [.d1h5, .c8h3],
                         diagonalSpaces: [.c8,.d7,.e6,.f5,.g4,.h3,.d1,.e2,.f3,.h5],
                         knightMoves: [.h2,.h6,.f2,.f6,.e3,.e5])
        case .g5: return (index: 52,
                          adjacentSpaces: [.f4,.f5,.f6,.g4,.g6,.h4,.h5,.h6],
                         file: .g,
                         fileSpaces: [.g1,.g2,.g3,.g4,.g5,.g6,.g7,.g8],
                         rank: ._5,
                         rankSpaces: [.a5,.b5,.c5,.d5,.e5,.f5,.g5,.h5],
                         diagonals: [.c1h6, .d8h4],
                         diagonalSpaces: [.c1,.d2,.e3,.f4,.g5,.h6,.d8,.e7,.f6,.h4],
                         knightMoves: [.h3,.h7,.f3,.f7,.e4,.e6])
        case .g6: return (index: 53,
                          adjacentSpaces: [.f5,.f6,.f7,.g5,.g7,.h5,.h6,.h7],
                         file: .g,
                         fileSpaces: [.g1,.g2,.g3,.g4,.g5,.g6,.g7,.g8],
                         rank: ._6,
                         rankSpaces: [.a6,.b6,.c6,.d6,.e6,.f6,.g6,.h6],
                         diagonals: [.b1h7, .e8h5],
                         diagonalSpaces: [.b1,.c2,.d3,.e4,.f5,.g6,.h7,.e8,.f7,.h5],
                         knightMoves: [.h4,.h8,.f4,.f8,.e5,.e7])
        case .g7: return (index: 54,
                          adjacentSpaces: [.f6,.f7,.f8,.g6,.g8,.h6,.h7,.h8],
                         file: .g,
                         fileSpaces: [.g1,.g2,.g3,.g4,.g5,.g6,.g7,.g8],
                         rank: ._7,
                         rankSpaces: [.a7,.b7,.c7,.d7,.e7,.f7,.g7,.h7],
                         diagonals: [.a1h8, .f8h6],
                         diagonalSpaces: [.a1,.b2,.c3,.d4,.e5,.f6,.g7,.h8,.f8,.h6],
                         knightMoves: [.h5,.f5,.e6,.e8])
        case .g8: return (index: 55,
                          adjacentSpaces: [.f7,.f8,.g7,.h7,.h8],
                         file: .g,
                         fileSpaces: [.g1,.g2,.g3,.g4,.g5,.g6,.g7,.g8],
                         rank: ._8,
                         rankSpaces: [.a8,.b8,.c8,.d8,.e8,.f8,.g8,.h8],
                         diagonals: [.g8a2, .g8h7],
                         diagonalSpaces: [.g8,.f7,.e6,.d5,.c4,.b3,.a2,.h7],
                         knightMoves: [.h6,.f6,.e7])
        case .h1: return (index: 56,
                          adjacentSpaces: [.h2,.g1,.g2],
                         file: .h,
                         fileSpaces: [.h1,.h2,.h3,.h4,.h5,.h6,.h7,.h8],
                         rank: ._1,
                         rankSpaces: [.a1,.b1,.c1,.d1,.e1,.f1,.g1,.h1],
                         diagonals: [.h1a8],
                         diagonalSpaces: [.h1,.g2,.f3,.e4,.d5,.c6,.b7,.a8],
                         knightMoves: [.g3,.f2])
        case .h2: return (index: 57,
                          adjacentSpaces: [.h1,.h3,.g1,.g2,.g3],
                         file: .h,
                         fileSpaces: [.h1,.h2,.h3,.h4,.h5,.h6,.h7,.h8],
                         rank: ._2,
                         rankSpaces: [.a2,.b2,.c2,.d2,.e2,.f2,.g2,.h2],
                         diagonals: [.b8h2, .g1h2],
                         diagonalSpaces: [.b8,.c7,.d6,.e5,.f4,.g3,.h2,.g1],
                         knightMoves: [.g4,.f1,.f3])
        case .h3: return (index: 58,
                          adjacentSpaces: [.h2,.h4,.g2,.g3,.g4],
                         file: .h,
                         fileSpaces: [.h1,.h2,.h3,.h4,.h5,.h6,.h7,.h8],
                         rank: ._3,
                         rankSpaces: [.a3,.b3,.c3,.d3,.e3,.f3,.g3,.h3],
                         diagonals: [.c8h3, .f1h3],
                         diagonalSpaces: [.c8,.d7,.e6,.f5,.g4,.h3,.f1,.g2],
                         knightMoves: [.g5,.g1,.f4,.f2])
        case .h4: return (index: 59,
                          adjacentSpaces: [.h3,.h5,.g3,.g4,.g5],
                         file: .h,
                         fileSpaces: [.h1,.h2,.h3,.h4,.h5,.h6,.h7,.h8],
                         rank: ._4,
                         rankSpaces: [.a4,.b4,.c4,.d4,.e4,.f4,.g4,.h4],
                         diagonals: [.d8h4, .e1h4],
                         diagonalSpaces: [.d8,.e7,.f6,.g5,.h4,.e1,.f2,.g3],
                         knightMoves: [.g6,.g2,.f5,.f3])
        case .h5: return (index: 60,
                          adjacentSpaces: [.h4,.h6,.g4,.g5,.g6],
                         file: .h,
                         fileSpaces: [.h1,.h2,.h3,.h4,.h5,.h6,.h7,.h8],
                         rank: ._5,
                         rankSpaces: [.a5,.b5,.c5,.d5,.e5,.f5,.g5,.h5],
                         diagonals: [.e8h5, .d1h5],
                         diagonalSpaces: [.d1,.e2,.f3,.g4,.h5,.e8,.f7,.g6],
                         knightMoves: [.g7,.g3,.f6,.f4])
        case .h6: return (index: 61,
                          adjacentSpaces: [.h5,.h7,.g5,.g6,.g7],
                         file: .h,
                         fileSpaces: [.h1,.h2,.h3,.h4,.h5,.h6,.h7,.h8],
                         rank: ._6,
                         rankSpaces: [.a6,.b6,.c6,.d6,.e6,.f6,.g6,.h6],
                         diagonals: [.f8h6, .c1h6],
                         diagonalSpaces: [.c1,.d2,.e3,.f4,.g5,.h6,.f8,.g7],
                         knightMoves: [.g8,.g4,.f7,.f5])
        case .h7: return (index: 62,
                          adjacentSpaces: [.h6,.h8,.g6,.g7,.g8],
                         file: .h,
                         fileSpaces: [.h1,.h2,.h3,.h4,.h5,.h6,.h7,.h8],
                         rank: ._7,
                         rankSpaces: [.a7,.b7,.c7,.d7,.e7,.f7,.g7,.h7],
                         diagonals: [.g8h7, .b1h7],
                         diagonalSpaces: [.b1,.c2,.d3,.e4,.f5,.g6,.h7,.g8],
                         knightMoves: [.g5,.f8,.f6])
        case .h8: return (index: 63,
                          adjacentSpaces: [.h7,.g7,.g8],
                         file: .h,
                         fileSpaces: [.h1,.h2,.h3,.h4,.h5,.h6,.h7,.h8],
                         rank: ._8,
                         rankSpaces: [.a8,.b8,.c8,.d8,.e8,.f8,.g8,.h8],
                         diagonals: [.a1h8],
                         diagonalSpaces: [.a1,.b2,.c3,.d4,.e5,.f6,.g7,.h8],
                         knightMoves: [.g6,.f7])
        }
    }
    
}
