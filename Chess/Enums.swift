////
////  Enums.swift
////  Chess
////
////  Created by Jordan Doczy on 11/24/16.
////  Copyright © 2016 Jordan Doczy. All rights reserved.
////
//
//import Foundation
//
//typealias Move = (from: Space, to: Space)
//
enum File: Int {
    case a = 1
    case b
    case c
    case d
    case e
    case f
    case g
    case h
    
    var spaces: UInt64 {
        switch self {
        case .a: return Space.a1.rawValue | Space.a2.rawValue | Space.a3.rawValue | Space.a4.rawValue | Space.a5.rawValue | Space.a6.rawValue | Space.a7.rawValue | Space.a8.rawValue
        case .b: return Space.b1.rawValue | Space.b2.rawValue | Space.b3.rawValue | Space.b4.rawValue | Space.b5.rawValue | Space.b6.rawValue | Space.b7.rawValue | Space.b8.rawValue
        case .c: return Space.c1.rawValue | Space.c2.rawValue | Space.c3.rawValue | Space.c4.rawValue | Space.c5.rawValue | Space.c6.rawValue | Space.c7.rawValue | Space.c8.rawValue
        case .d: return Space.d1.rawValue | Space.d2.rawValue | Space.d3.rawValue | Space.d4.rawValue | Space.d5.rawValue | Space.d6.rawValue | Space.d7.rawValue | Space.d8.rawValue
        case .e: return Space.e1.rawValue | Space.e2.rawValue | Space.e3.rawValue | Space.e4.rawValue | Space.e5.rawValue | Space.e6.rawValue | Space.e7.rawValue | Space.e8.rawValue
        case .f: return Space.f1.rawValue | Space.f2.rawValue | Space.f3.rawValue | Space.f4.rawValue | Space.f5.rawValue | Space.f6.rawValue | Space.f7.rawValue | Space.f8.rawValue
        case .g: return Space.g1.rawValue | Space.g2.rawValue | Space.g3.rawValue | Space.g4.rawValue | Space.g5.rawValue | Space.g6.rawValue | Space.g7.rawValue | Space.g8.rawValue
        case .h: return Space.h1.rawValue | Space.h2.rawValue | Space.h3.rawValue | Space.h4.rawValue | Space.h5.rawValue | Space.h6.rawValue | Space.h7.rawValue | Space.h8.rawValue
        }
    }
    
    var nextFile: File {
        switch self {
        case .a: return .b
        case .b: return .c
        case .c: return .d
        case .d: return .e
        case .e: return .f
        case .f: return .g
        case .g: return .h
        case .h: return .a
        }
    }
    
    var previousFile: File {
        switch self {
        case .a: return .h
        case .b: return .a
        case .c: return .b
        case .d: return .c
        case .e: return .d
        case .f: return .e
        case .g: return .f
        case .h: return .g
        }
    }

}

enum Rank: Int {
    case _1 = 1
    case _2
    case _3
    case _4
    case _5
    case _6
    case _7
    case _8
    
    var spaces: UInt64{
        switch self {
        case ._1: return Space.a1.rawValue | Space.b1.rawValue | Space.c1.rawValue | Space.d1.rawValue | Space.e1.rawValue | Space.f1.rawValue | Space.g1.rawValue | Space.h1.rawValue
        case ._2: return Space.a2.rawValue | Space.b2.rawValue | Space.c2.rawValue | Space.d2.rawValue | Space.e2.rawValue | Space.f2.rawValue | Space.g2.rawValue | Space.h2.rawValue
        case ._3: return Space.a3.rawValue | Space.b3.rawValue | Space.c3.rawValue | Space.d3.rawValue | Space.e3.rawValue | Space.f3.rawValue | Space.g3.rawValue | Space.h3.rawValue
        case ._4: return Space.a4.rawValue | Space.b4.rawValue | Space.c4.rawValue | Space.d4.rawValue | Space.e4.rawValue | Space.f4.rawValue | Space.g4.rawValue | Space.h4.rawValue
        case ._5: return Space.a5.rawValue | Space.b5.rawValue | Space.c5.rawValue | Space.d5.rawValue | Space.e5.rawValue | Space.f5.rawValue | Space.g5.rawValue | Space.h5.rawValue
        case ._6: return Space.a6.rawValue | Space.b6.rawValue | Space.c6.rawValue | Space.d6.rawValue | Space.e6.rawValue | Space.f6.rawValue | Space.g6.rawValue | Space.h6.rawValue
        case ._7: return Space.a7.rawValue | Space.b7.rawValue | Space.c7.rawValue | Space.d7.rawValue | Space.e7.rawValue | Space.f7.rawValue | Space.g7.rawValue | Space.h7.rawValue
        case ._8: return Space.a8.rawValue | Space.b8.rawValue | Space.c8.rawValue | Space.d8.rawValue | Space.e8.rawValue | Space.f8.rawValue | Space.g8.rawValue | Space.h8.rawValue
        }
    }
    
    var nextRank: Rank {
        switch self {
        case ._1: return ._2
        case ._2: return ._3
        case ._3: return ._4
        case ._4: return ._5
        case ._5: return ._6
        case ._6: return ._7
        case ._7: return ._8
        case ._8: return ._1
        }
    }
    
    var previousRank: Rank {
        switch self {
        case ._1: return ._8
        case ._2: return ._1
        case ._3: return ._2
        case ._4: return ._3
        case ._5: return ._4
        case ._6: return ._5
        case ._7: return ._6
        case ._8: return ._7
        }
    }

}

enum Diagonal {
    case a1h8
    case b1h7
    case b1a2
    case b8a7
    case b8h2
    case c1h6
    case c1a3
    case c8a6
    case c8h3
    case d1h5
    case d1a4
    case d8a5
    case d8h4
    case e1h4
    case e1a5
    case e8a4
    case e8h5
    case f1h3
    case f1a6
    case f8a3
    case f8h6
    case g1h2
    case g1a7
    case g8a2
    case g8h7
    case h1a8
    
    var spaces: UInt64 {
        switch self {
        case .a1h8: return Space.a1.rawValue | Space.b2.rawValue | Space.c3.rawValue | Space.d4.rawValue | Space.e5.rawValue | Space.f6.rawValue | Space.g7.rawValue | Space.h8.rawValue
        case .b1h7: return Space.b1.rawValue | Space.c2.rawValue | Space.d3.rawValue | Space.e4.rawValue | Space.f5.rawValue | Space.g6.rawValue | Space.h7.rawValue
        case .b1a2: return Space.b1.rawValue | Space.a2.rawValue
        case .b8a7: return Space.b8.rawValue | Space.a7.rawValue
        case .b8h2: return Space.b8.rawValue | Space.c7.rawValue | Space.d6.rawValue | Space.e5.rawValue | Space.f4.rawValue | Space.g3.rawValue | Space.h2.rawValue
        case .c1h6: return Space.c1.rawValue | Space.d2.rawValue | Space.e3.rawValue | Space.f4.rawValue | Space.g5.rawValue | Space.h6.rawValue
        case .c1a3: return Space.c1.rawValue | Space.b2.rawValue | Space.a3.rawValue
        case .c8a6: return Space.c8.rawValue | Space.b7.rawValue | Space.a6.rawValue
        case .c8h3: return Space.c8.rawValue | Space.d7.rawValue | Space.e6.rawValue | Space.f5.rawValue | Space.g4.rawValue | Space.h3.rawValue
        case .d1h5: return Space.d1.rawValue | Space.e2.rawValue | Space.f3.rawValue | Space.g4.rawValue | Space.h5.rawValue
        case .d1a4: return Space.d1.rawValue | Space.c2.rawValue | Space.b3.rawValue | Space.a4.rawValue
        case .d8a5: return Space.d8.rawValue | Space.c7.rawValue | Space.b6.rawValue | Space.a5.rawValue
        case .d8h4: return Space.d8.rawValue | Space.e7.rawValue | Space.f6.rawValue | Space.g5.rawValue | Space.h4.rawValue
        case .e1h4: return Space.e1.rawValue | Space.f2.rawValue | Space.g3.rawValue | Space.h4.rawValue
        case .e1a5: return Space.e1.rawValue | Space.d2.rawValue | Space.c3.rawValue | Space.b4.rawValue | Space.a5.rawValue
        case .e8a4: return Space.e8.rawValue | Space.d7.rawValue | Space.c6.rawValue | Space.b5.rawValue | Space.a4.rawValue
        case .e8h5: return Space.e8.rawValue | Space.f7.rawValue | Space.g6.rawValue | Space.h5.rawValue
        case .f1h3: return Space.f1.rawValue | Space.g2.rawValue | Space.h3.rawValue
        case .f1a6: return Space.f1.rawValue | Space.e2.rawValue | Space.d3.rawValue | Space.c4.rawValue | Space.b5.rawValue | Space.a6.rawValue
        case .f8a3: return Space.f8.rawValue | Space.e7.rawValue | Space.d6.rawValue | Space.c5.rawValue | Space.b4.rawValue | Space.a3.rawValue
        case .f8h6: return Space.f8.rawValue | Space.g7.rawValue | Space.h6.rawValue
        case .g1h2: return Space.g1.rawValue | Space.h2.rawValue
        case .g1a7: return Space.g1.rawValue | Space.f2.rawValue | Space.e3.rawValue | Space.d4.rawValue | Space.c5.rawValue | Space.b6.rawValue | Space.a7.rawValue
        case .g8a2: return Space.g8.rawValue | Space.f7.rawValue | Space.e6.rawValue | Space.d5.rawValue | Space.c4.rawValue | Space.b3.rawValue | Space.a2.rawValue
        case .g8h7: return Space.g8.rawValue | Space.h7.rawValue
        case .h1a8: return Space.h1.rawValue | Space.g2.rawValue | Space.f3.rawValue | Space.e4.rawValue | Space.d5.rawValue | Space.c6.rawValue | Space.b7.rawValue | Space.a8.rawValue
        }
    }
}

enum Space: UInt64 {
    case a1 = 0b1
    case a2 = 0b10
    case a3 = 0b100
    case a4 = 0b1000
    case a5 = 0b10000
    case a6 = 0b100000
    case a7 = 0b1000000
    case a8 = 0b10000000
    case b1 = 0b100000000
    case b2 = 0b1000000000
    case b3 = 0b10000000000
    case b4 = 0b100000000000
    case b5 = 0b1000000000000
    case b6 = 0b10000000000000
    case b7 = 0b100000000000000
    case b8 = 0b1000000000000000
    case c1 = 0b10000000000000000
    case c2 = 0b100000000000000000
    case c3 = 0b1000000000000000000
    case c4 = 0b10000000000000000000
    case c5 = 0b100000000000000000000
    case c6 = 0b1000000000000000000000
    case c7 = 0b10000000000000000000000
    case c8 = 0b100000000000000000000000
    case d1 = 0b1000000000000000000000000
    case d2 = 0b10000000000000000000000000
    case d3 = 0b100000000000000000000000000
    case d4 = 0b1000000000000000000000000000
    case d5 = 0b10000000000000000000000000000
    case d6 = 0b100000000000000000000000000000
    case d7 = 0b1000000000000000000000000000000
    case d8 = 0b10000000000000000000000000000000
    case e1 = 0b100000000000000000000000000000000
    case e2 = 0b1000000000000000000000000000000000
    case e3 = 0b10000000000000000000000000000000000
    case e4 = 0b100000000000000000000000000000000000
    case e5 = 0b1000000000000000000000000000000000000
    case e6 = 0b10000000000000000000000000000000000000
    case e7 = 0b100000000000000000000000000000000000000
    case e8 = 0b1000000000000000000000000000000000000000
    case f1 = 0b10000000000000000000000000000000000000000
    case f2 = 0b100000000000000000000000000000000000000000
    case f3 = 0b1000000000000000000000000000000000000000000
    case f4 = 0b10000000000000000000000000000000000000000000
    case f5 = 0b100000000000000000000000000000000000000000000
    case f6 = 0b1000000000000000000000000000000000000000000000
    case f7 = 0b10000000000000000000000000000000000000000000000
    case f8 = 0b100000000000000000000000000000000000000000000000
    case g1 = 0b1000000000000000000000000000000000000000000000000
    case g2 = 0b10000000000000000000000000000000000000000000000000
    case g3 = 0b100000000000000000000000000000000000000000000000000
    case g4 = 0b1000000000000000000000000000000000000000000000000000
    case g5 = 0b10000000000000000000000000000000000000000000000000000
    case g6 = 0b100000000000000000000000000000000000000000000000000000
    case g7 = 0b1000000000000000000000000000000000000000000000000000000
    case g8 = 0b10000000000000000000000000000000000000000000000000000000
    case h1 = 0b100000000000000000000000000000000000000000000000000000000
    case h2 = 0b1000000000000000000000000000000000000000000000000000000000
    case h3 = 0b10000000000000000000000000000000000000000000000000000000000
    case h4 = 0b100000000000000000000000000000000000000000000000000000000000
    case h5 = 0b1000000000000000000000000000000000000000000000000000000000000
    case h6 = 0b10000000000000000000000000000000000000000000000000000000000000
    case h7 = 0b100000000000000000000000000000000000000000000000000000000000000
    case h8 = 0b1000000000000000000000000000000000000000000000000000000000000000

    var diagonals: UInt64 {
        switch self {
        case .a1: return Diagonal.a1h8.spaces
        case .a2: return Diagonal.g8a2.spaces | Diagonal.b1a2.spaces
        case .a3: return Diagonal.f8a3.spaces | Diagonal.c1a3.spaces
        case .a4: return Diagonal.e8a4.spaces | Diagonal.d1a4.spaces
        case .a5: return Diagonal.d8a5.spaces | Diagonal.e1a5.spaces
        case .a6: return Diagonal.c8a6.spaces | Diagonal.f1a6.spaces
        case .a7: return Diagonal.b8a7.spaces | Diagonal.g1a7.spaces
        case .a8: return Diagonal.h1a8.spaces
            
        case .b1: return Diagonal.b1a2.spaces | Diagonal.b1h7.spaces
        case .b2: return Diagonal.a1h8.spaces | Diagonal.c1a3.spaces
        case .b3: return Diagonal.g8a2.spaces | Diagonal.d1a4.spaces
        case .b4: return Diagonal.f8a3.spaces | Diagonal.e1a5.spaces
        case .b5: return Diagonal.e8a4.spaces | Diagonal.f1a6.spaces
        case .b6: return Diagonal.d8a5.spaces | Diagonal.g1a7.spaces
        case .b7: return Diagonal.c8a6.spaces | Diagonal.h1a8.spaces
        case .b8: return Diagonal.b8a7.spaces | Diagonal.b8h2.spaces
            
        case .c1: return Diagonal.c1a3.spaces | Diagonal.c1h6.spaces
        case .c2: return Diagonal.d1a4.spaces | Diagonal.b1h7.spaces
        case .c3: return Diagonal.e1a5.spaces | Diagonal.a1h8.spaces
        case .c4: return Diagonal.g8a2.spaces | Diagonal.f1a6.spaces
        case .c5: return Diagonal.f8a3.spaces | Diagonal.g1a7.spaces
        case .c6: return Diagonal.e8a4.spaces | Diagonal.h1a8.spaces
        case .c7: return Diagonal.d8a5.spaces | Diagonal.b8h2.spaces
        case .c8: return Diagonal.c8a6.spaces | Diagonal.c8h3.spaces
            
        case .d1: return Diagonal.d1a4.spaces | Diagonal.d1h5.spaces
        case .d2: return Diagonal.c1h6.spaces | Diagonal.e1a5.spaces
        case .d3: return Diagonal.b1h7.spaces | Diagonal.f1a6.spaces
        case .d4: return Diagonal.a1h8.spaces | Diagonal.g1a7.spaces
        case .d5: return Diagonal.g8a2.spaces | Diagonal.h1a8.spaces
        case .d6: return Diagonal.f8a3.spaces | Diagonal.b8h2.spaces
        case .d7: return Diagonal.e8a4.spaces | Diagonal.c8h3.spaces
        case .d8: return Diagonal.d8a5.spaces | Diagonal.d8h4.spaces
            
        case .e1: return Diagonal.e1a5.spaces | Diagonal.e1h4.spaces
        case .e2: return Diagonal.d1h5.spaces | Diagonal.f1a6.spaces
        case .e3: return Diagonal.c1h6.spaces | Diagonal.g1a7.spaces
        case .e4: return Diagonal.b1h7.spaces | Diagonal.h1a8.spaces
        case .e5: return Diagonal.a1h8.spaces | Diagonal.b8h2.spaces
        case .e6: return Diagonal.g8a2.spaces | Diagonal.c8h3.spaces
        case .e7: return Diagonal.f8a3.spaces | Diagonal.d8h4.spaces
        case .e8: return Diagonal.e8a4.spaces | Diagonal.e8h5.spaces
            
        case .f1: return Diagonal.f1a6.spaces | Diagonal.f1h3.spaces
        case .f2: return Diagonal.e1h4.spaces | Diagonal.g1a7.spaces
        case .f3: return Diagonal.d1h5.spaces | Diagonal.h1a8.spaces
        case .f4: return Diagonal.c1h6.spaces | Diagonal.b8h2.spaces
        case .f5: return Diagonal.b1h7.spaces | Diagonal.c8h3.spaces
        case .f6: return Diagonal.a1h8.spaces | Diagonal.d8h4.spaces
        case .f7: return Diagonal.g8a2.spaces | Diagonal.e8h5.spaces
        case .f8: return Diagonal.f8a3.spaces | Diagonal.f8h6.spaces
            
        case .g1: return Diagonal.g1a7.spaces | Diagonal.g1h2.spaces
        case .g2: return Diagonal.f1h3.spaces | Diagonal.h1a8.spaces
        case .g3: return Diagonal.e1h4.spaces | Diagonal.b8h2.spaces
        case .g4: return Diagonal.d1h5.spaces | Diagonal.c8h3.spaces
        case .g5: return Diagonal.c1h6.spaces | Diagonal.d8h4.spaces
        case .g6: return Diagonal.b1h7.spaces | Diagonal.e8h5.spaces
        case .g7: return Diagonal.a1h8.spaces | Diagonal.f8h6.spaces
        case .g8: return Diagonal.g8a2.spaces | Diagonal.g8h7.spaces
            
        case .h1: return Diagonal.h1a8.spaces
        case .h2: return Diagonal.b8h2.spaces | Diagonal.g1h2.spaces
        case .h3: return Diagonal.c8h3.spaces | Diagonal.f1h3.spaces
        case .h4: return Diagonal.d8h4.spaces | Diagonal.e1h4.spaces
        case .h5: return Diagonal.e8h5.spaces | Diagonal.d1h5.spaces
        case .h6: return Diagonal.f8h6.spaces | Diagonal.c1h6.spaces
        case .h7: return Diagonal.g8h7.spaces | Diagonal.b1h7.spaces
        case .h8: return Diagonal.a1h8.spaces
        }
    }
    
    var file: File {
        switch self {
        case .a1,.a2,.a3,.a4,.a5,.a6,.a7,.a8: return .a
        case .b1,.b2,.b3,.b4,.b5,.b6,.b7,.b8: return .b
        case .c1,.c2,.c3,.c4,.c5,.c6,.c7,.c8: return .c
        case .d1,.d2,.d3,.d4,.d5,.d6,.d7,.d8: return .d
        case .e1,.e2,.e3,.e4,.e5,.e6,.e7,.e8: return .e
        case .f1,.f2,.f3,.f4,.f5,.f6,.f7,.f8: return .f
        case .g1,.g2,.g3,.g4,.g5,.g6,.g7,.g8: return .g
        case .h1,.h2,.h3,.h4,.h5,.h6,.h7,.h8: return .h
        }
    }
    
    var rank: Rank {
        switch self {
        case .a1,.b1,.c1,.d1,.e1,.f1,.g1,.h1: return ._1
        case .a2,.b2,.c2,.d2,.e2,.f2,.g2,.h2: return ._2
        case .a3,.b3,.c3,.d3,.e3,.f3,.g3,.h3: return ._3
        case .a4,.b4,.c4,.d4,.e4,.f4,.g4,.h4: return ._4
        case .a5,.b5,.c5,.d5,.e5,.f5,.g5,.h5: return ._5
        case .a6,.b6,.c6,.d6,.e6,.f6,.g6,.h6: return ._6
        case .a7,.b7,.c7,.d7,.e7,.f7,.g7,.h7: return ._7
        case .a8,.b8,.c8,.d8,.e8,.f8,.g8,.h8: return ._8
        }
    }
    
    var knightMoves: UInt64 {
        switch self {
        case .a1: return Space.b3.rawValue | Space.c2.rawValue
        case .a2: return Space.b4.rawValue | Space.c1.rawValue | Space.c3.rawValue
        case .a3: return Space.b5.rawValue | Space.b1.rawValue | Space.c4.rawValue | Space.c2.rawValue
        case .a4: return Space.b6.rawValue | Space.b2.rawValue | Space.c5.rawValue | Space.c3.rawValue
        case .a5: return Space.b7.rawValue | Space.b3.rawValue | Space.c6.rawValue | Space.c4.rawValue
        case .a6: return Space.b8.rawValue | Space.b4.rawValue | Space.c7.rawValue | Space.c5.rawValue
        case .a7: return Space.b5.rawValue | Space.c8.rawValue | Space.c6.rawValue
        case .a8: return Space.b6.rawValue | Space.c7.rawValue
            
        case .b1: return Space.a3.rawValue | Space.c3.rawValue | Space.d2.rawValue
        case .b2: return Space.a4.rawValue | Space.c4.rawValue | Space.d1.rawValue | Space.d3.rawValue
        case .b3: return Space.a1.rawValue | Space.a5.rawValue | Space.c1.rawValue | Space.c5.rawValue | Space.d2.rawValue | Space.d4.rawValue
        case .b4: return Space.a2.rawValue | Space.a6.rawValue | Space.c2.rawValue | Space.c6.rawValue | Space.d3.rawValue | Space.d5.rawValue
        case .b5: return Space.a3.rawValue | Space.a7.rawValue | Space.c3.rawValue | Space.c7.rawValue | Space.d4.rawValue | Space.d6.rawValue
        case .b6: return Space.a4.rawValue | Space.a8.rawValue | Space.c4.rawValue | Space.c8.rawValue | Space.d5.rawValue | Space.d7.rawValue
        case .b7: return Space.a5.rawValue | Space.c5.rawValue | Space.d6.rawValue | Space.d8.rawValue
        case .b8: return Space.a6.rawValue | Space.c6.rawValue | Space.d7.rawValue
            
        case .c1: return Space.a2.rawValue | Space.b3.rawValue | Space.d3.rawValue | Space.e2.rawValue
        case .c2: return Space.a1.rawValue | Space.a3.rawValue | Space.b4.rawValue | Space.d4.rawValue | Space.e1.rawValue | Space.e3.rawValue
        case .c3: return Space.a2.rawValue | Space.a4.rawValue | Space.b1.rawValue | Space.b5.rawValue | Space.d1.rawValue | Space.d5.rawValue | Space.e2.rawValue | Space.e4.rawValue
        case .c4: return Space.a3.rawValue | Space.a5.rawValue | Space.b2.rawValue | Space.b6.rawValue | Space.d2.rawValue | Space.d6.rawValue | Space.e3.rawValue | Space.e5.rawValue
        case .c5: return Space.a4.rawValue | Space.a6.rawValue | Space.b3.rawValue | Space.b7.rawValue | Space.d3.rawValue | Space.d7.rawValue | Space.e4.rawValue | Space.e6.rawValue
        case .c6: return Space.a5.rawValue | Space.a7.rawValue | Space.b4.rawValue | Space.b8.rawValue | Space.d4.rawValue | Space.d8.rawValue | Space.e6.rawValue | Space.e7.rawValue
        case .c7: return Space.a6.rawValue | Space.a8.rawValue | Space.b5.rawValue | Space.d5.rawValue | Space.e6.rawValue | Space.e8.rawValue
        case .c8: return Space.a7.rawValue | Space.b6.rawValue | Space.d6.rawValue | Space.e7.rawValue
            
        case .d1: return Space.b2.rawValue | Space.c3.rawValue | Space.e3.rawValue | Space.f2.rawValue
        case .d2: return Space.b1.rawValue | Space.b3.rawValue | Space.c4.rawValue | Space.e4.rawValue | Space.f1.rawValue | Space.f3.rawValue
        case .d3: return Space.b2.rawValue | Space.b4.rawValue | Space.c1.rawValue | Space.c5.rawValue | Space.e1.rawValue | Space.e5.rawValue | Space.f2.rawValue | Space.f4.rawValue
        case .d4: return Space.b3.rawValue | Space.b5.rawValue | Space.c2.rawValue | Space.c6.rawValue | Space.e2.rawValue | Space.e6.rawValue | Space.f3.rawValue | Space.f5.rawValue
        case .d5: return Space.b4.rawValue | Space.b6.rawValue | Space.c3.rawValue | Space.c7.rawValue | Space.e3.rawValue | Space.e7.rawValue | Space.f4.rawValue | Space.f6.rawValue
        case .d6: return Space.b5.rawValue | Space.b7.rawValue | Space.c4.rawValue | Space.c8.rawValue | Space.e4.rawValue | Space.e8.rawValue | Space.f6.rawValue | Space.f7.rawValue
        case .d7: return Space.b6.rawValue | Space.b8.rawValue | Space.c5.rawValue | Space.e5.rawValue | Space.f6.rawValue | Space.f8.rawValue
        case .d8: return Space.b7.rawValue | Space.c6.rawValue | Space.e6.rawValue | Space.f7.rawValue
            
        case .e1: return Space.c2.rawValue | Space.d3.rawValue | Space.f3.rawValue | Space.g2.rawValue
        case .e2: return Space.c1.rawValue | Space.c3.rawValue | Space.d4.rawValue | Space.f4.rawValue | Space.g1.rawValue | Space.g3.rawValue
        case .e3: return Space.c2.rawValue | Space.c4.rawValue | Space.d1.rawValue | Space.d5.rawValue | Space.f1.rawValue | Space.f5.rawValue | Space.g2.rawValue | Space.g4.rawValue
        case .e4: return Space.c3.rawValue | Space.c5.rawValue | Space.d2.rawValue | Space.d6.rawValue | Space.f2.rawValue | Space.f6.rawValue | Space.g3.rawValue | Space.g5.rawValue
        case .e5: return Space.c4.rawValue | Space.c6.rawValue | Space.d3.rawValue | Space.d7.rawValue | Space.f3.rawValue | Space.f7.rawValue | Space.g4.rawValue | Space.g6.rawValue
        case .e6: return Space.c5.rawValue | Space.c7.rawValue | Space.d4.rawValue | Space.d8.rawValue | Space.f4.rawValue | Space.f8.rawValue | Space.g6.rawValue | Space.g7.rawValue
        case .e7: return Space.c6.rawValue | Space.c8.rawValue | Space.d5.rawValue | Space.f5.rawValue | Space.g6.rawValue | Space.g8.rawValue
        case .e8: return Space.c7.rawValue | Space.d6.rawValue | Space.f6.rawValue | Space.g7.rawValue
            
        case .f1: return Space.d2.rawValue | Space.e3.rawValue | Space.g3.rawValue | Space.h2.rawValue
        case .f2: return Space.d1.rawValue | Space.d3.rawValue | Space.e4.rawValue | Space.g4.rawValue | Space.g1.rawValue | Space.h3.rawValue
        case .f3: return Space.d2.rawValue | Space.d4.rawValue | Space.e1.rawValue | Space.e5.rawValue | Space.g1.rawValue | Space.g5.rawValue | Space.h2.rawValue | Space.h4.rawValue
        case .f4: return Space.d3.rawValue | Space.d5.rawValue | Space.e2.rawValue | Space.e6.rawValue | Space.g2.rawValue | Space.g6.rawValue | Space.h3.rawValue | Space.h5.rawValue
        case .f5: return Space.d4.rawValue | Space.d6.rawValue | Space.e3.rawValue | Space.e7.rawValue | Space.g3.rawValue | Space.g7.rawValue | Space.h4.rawValue | Space.h6.rawValue
        case .f6: return Space.d5.rawValue | Space.d7.rawValue | Space.e4.rawValue | Space.e8.rawValue | Space.g4.rawValue | Space.g8.rawValue | Space.h6.rawValue | Space.h7.rawValue
        case .f7: return Space.d6.rawValue | Space.d8.rawValue | Space.e5.rawValue | Space.g5.rawValue | Space.h6.rawValue | Space.h8.rawValue
        case .f8: return Space.d7.rawValue | Space.e6.rawValue | Space.g6.rawValue | Space.h7.rawValue
            
        case .g1: return Space.h3.rawValue | Space.f3.rawValue | Space.e2.rawValue
        case .g2: return Space.h4.rawValue | Space.f4.rawValue | Space.e1.rawValue | Space.e3.rawValue
        case .g3: return Space.h1.rawValue | Space.h5.rawValue | Space.f1.rawValue | Space.f5.rawValue | Space.e2.rawValue | Space.e4.rawValue
        case .g4: return Space.h2.rawValue | Space.h6.rawValue | Space.f2.rawValue | Space.f6.rawValue | Space.e3.rawValue | Space.e5.rawValue
        case .g5: return Space.h3.rawValue | Space.h7.rawValue | Space.f3.rawValue | Space.f7.rawValue | Space.e4.rawValue | Space.e6.rawValue
        case .g6: return Space.h4.rawValue | Space.h8.rawValue | Space.f4.rawValue | Space.f8.rawValue | Space.e5.rawValue | Space.e7.rawValue
        case .g7: return Space.h5.rawValue | Space.f5.rawValue | Space.e6.rawValue | Space.e8.rawValue
        case .g8: return Space.h6.rawValue | Space.f6.rawValue | Space.e7.rawValue
            
        case .h1: return Space.g3.rawValue | Space.f2.rawValue
        case .h2: return Space.g4.rawValue | Space.f1.rawValue | Space.f3.rawValue
        case .h3: return Space.g5.rawValue | Space.g1.rawValue | Space.f4.rawValue | Space.f2.rawValue
        case .h4: return Space.g6.rawValue | Space.g2.rawValue | Space.f5.rawValue | Space.f3.rawValue
        case .h5: return Space.g7.rawValue | Space.g3.rawValue | Space.f6.rawValue | Space.f4.rawValue
        case .h6: return Space.g8.rawValue | Space.g4.rawValue | Space.f7.rawValue | Space.f5.rawValue
        case .h7: return Space.g5.rawValue | Space.f8.rawValue | Space.f6.rawValue
        case .h8: return Space.g6.rawValue | Space.f7.rawValue
        }
    }
    
    var adjacentSpaces: UInt64 {
        switch self {
        case .a1: return Space.a2.rawValue | Space.b1.rawValue | Space.b2.rawValue
        case .a2: return Space.a1.rawValue | Space.a3.rawValue | Space.b1.rawValue | Space.b2.rawValue | Space.b3.rawValue
        case .a3: return Space.a2.rawValue | Space.a4.rawValue | Space.b2.rawValue | Space.b3.rawValue | Space.b4.rawValue
        case .a4: return Space.a3.rawValue | Space.a5.rawValue | Space.b3.rawValue | Space.b4.rawValue | Space.b5.rawValue
        case .a5: return Space.a4.rawValue | Space.a6.rawValue | Space.b4.rawValue | Space.b5.rawValue | Space.b6.rawValue
        case .a6: return Space.a5.rawValue | Space.a7.rawValue | Space.b5.rawValue | Space.b6.rawValue | Space.b7.rawValue
        case .a7: return Space.a6.rawValue | Space.a8.rawValue | Space.b6.rawValue | Space.b7.rawValue | Space.b8.rawValue
        case .a8: return Space.a7.rawValue | Space.b7.rawValue | Space.b8.rawValue
            
        case .b1: return Space.a1.rawValue | Space.a2.rawValue | Space.b2.rawValue | Space.c1.rawValue | Space.c2.rawValue
        case .b2: return Space.a1.rawValue | Space.a2.rawValue | Space.a3.rawValue | Space.b1.rawValue | Space.b3.rawValue | Space.c1.rawValue | Space.c2.rawValue | Space.c3.rawValue
        case .b3: return Space.a2.rawValue | Space.a3.rawValue | Space.a4.rawValue | Space.b2.rawValue | Space.b4.rawValue | Space.c2.rawValue | Space.c3.rawValue | Space.c4.rawValue
        case .b4: return Space.a3.rawValue | Space.a4.rawValue | Space.a5.rawValue | Space.b3.rawValue | Space.b5.rawValue | Space.c3.rawValue | Space.c4.rawValue | Space.c5.rawValue
        case .b5: return Space.a4.rawValue | Space.a5.rawValue | Space.a6.rawValue | Space.b4.rawValue | Space.b6.rawValue | Space.c4.rawValue | Space.c5.rawValue | Space.c6.rawValue
        case .b6: return Space.a5.rawValue | Space.a6.rawValue | Space.a7.rawValue | Space.b5.rawValue | Space.b7.rawValue | Space.c5.rawValue | Space.c6.rawValue | Space.c7.rawValue
        case .b7: return Space.a6.rawValue | Space.a7.rawValue | Space.a8.rawValue | Space.b6.rawValue | Space.b8.rawValue | Space.c6.rawValue | Space.c7.rawValue | Space.c8.rawValue
        case .b8: return Space.a7.rawValue | Space.a8.rawValue | Space.b7.rawValue | Space.c7.rawValue | Space.c8.rawValue
            
        case .c1: return Space.b1.rawValue | Space.b2.rawValue | Space.c2.rawValue | Space.d1.rawValue | Space.d2.rawValue
        case .c2: return Space.b1.rawValue | Space.b2.rawValue | Space.b3.rawValue | Space.c1.rawValue | Space.c3.rawValue | Space.d1.rawValue | Space.d2.rawValue | Space.d3.rawValue
        case .c3: return Space.b2.rawValue | Space.b3.rawValue | Space.b4.rawValue | Space.c2.rawValue | Space.c4.rawValue | Space.d2.rawValue | Space.d3.rawValue | Space.d4.rawValue
        case .c4: return Space.b3.rawValue | Space.b4.rawValue | Space.b5.rawValue | Space.c3.rawValue | Space.c5.rawValue | Space.d3.rawValue | Space.d4.rawValue | Space.d5.rawValue
        case .c5: return Space.b4.rawValue | Space.b5.rawValue | Space.b6.rawValue | Space.c4.rawValue | Space.c6.rawValue | Space.d4.rawValue | Space.d5.rawValue | Space.d6.rawValue
        case .c6: return Space.b5.rawValue | Space.b6.rawValue | Space.b7.rawValue | Space.c5.rawValue | Space.c7.rawValue | Space.d5.rawValue | Space.d6.rawValue | Space.d7.rawValue
        case .c7: return Space.b6.rawValue | Space.b7.rawValue | Space.b8.rawValue | Space.c6.rawValue | Space.c8.rawValue | Space.d6.rawValue | Space.d7.rawValue | Space.d8.rawValue
        case .c8: return Space.b7.rawValue | Space.b8.rawValue | Space.c7.rawValue | Space.d7.rawValue | Space.d8.rawValue
            
        case .d1: return Space.c1.rawValue | Space.c2.rawValue | Space.d2.rawValue | Space.e1.rawValue | Space.e2.rawValue
        case .d2: return Space.c1.rawValue | Space.c2.rawValue | Space.c3.rawValue | Space.d1.rawValue | Space.d3.rawValue | Space.e1.rawValue | Space.e2.rawValue | Space.e3.rawValue
        case .d3: return Space.c2.rawValue | Space.c3.rawValue | Space.c4.rawValue | Space.d2.rawValue | Space.d4.rawValue | Space.e2.rawValue | Space.e3.rawValue | Space.e4.rawValue
        case .d4: return Space.c3.rawValue | Space.c4.rawValue | Space.c5.rawValue | Space.d3.rawValue | Space.d5.rawValue | Space.e3.rawValue | Space.e4.rawValue | Space.e5.rawValue
        case .d5: return Space.c4.rawValue | Space.c5.rawValue | Space.c6.rawValue | Space.d4.rawValue | Space.d6.rawValue | Space.e4.rawValue | Space.e5.rawValue | Space.e6.rawValue
        case .d6: return Space.c5.rawValue | Space.c6.rawValue | Space.c7.rawValue | Space.d5.rawValue | Space.d7.rawValue | Space.e5.rawValue | Space.e6.rawValue | Space.e7.rawValue
        case .d7: return Space.c6.rawValue | Space.c7.rawValue | Space.c8.rawValue | Space.d6.rawValue | Space.d8.rawValue | Space.e6.rawValue | Space.e7.rawValue | Space.e8.rawValue
        case .d8: return Space.c7.rawValue | Space.c8.rawValue | Space.d7.rawValue | Space.e7.rawValue | Space.e8.rawValue
            
        case .e1: return Space.d1.rawValue | Space.d2.rawValue | Space.e2.rawValue | Space.f1.rawValue | Space.f2.rawValue
        case .e2: return Space.d1.rawValue | Space.d2.rawValue | Space.d3.rawValue | Space.e1.rawValue | Space.e3.rawValue | Space.f1.rawValue | Space.f2.rawValue | Space.f3.rawValue
        case .e3: return Space.d2.rawValue | Space.d3.rawValue | Space.d4.rawValue | Space.e2.rawValue | Space.e4.rawValue | Space.f2.rawValue | Space.f3.rawValue | Space.f4.rawValue
        case .e4: return Space.d3.rawValue | Space.d4.rawValue | Space.d5.rawValue | Space.e3.rawValue | Space.e5.rawValue | Space.f3.rawValue | Space.f4.rawValue | Space.f5.rawValue
        case .e5: return Space.d4.rawValue | Space.d5.rawValue | Space.d6.rawValue | Space.e4.rawValue | Space.e6.rawValue | Space.f4.rawValue | Space.f5.rawValue | Space.f6.rawValue
        case .e6: return Space.d5.rawValue | Space.d6.rawValue | Space.d7.rawValue | Space.e5.rawValue | Space.e7.rawValue | Space.f5.rawValue | Space.f6.rawValue | Space.f7.rawValue
        case .e7: return Space.d6.rawValue | Space.d7.rawValue | Space.d8.rawValue | Space.e6.rawValue | Space.e8.rawValue | Space.f6.rawValue | Space.f7.rawValue | Space.f8.rawValue
        case .e8: return Space.d7.rawValue | Space.d8.rawValue | Space.e7.rawValue | Space.f7.rawValue | Space.f8.rawValue
            
        case .f1: return Space.e1.rawValue | Space.e2.rawValue | Space.f2.rawValue | Space.g1.rawValue | Space.g2.rawValue
        case .f2: return Space.e1.rawValue | Space.e2.rawValue | Space.e3.rawValue | Space.f1.rawValue | Space.f3.rawValue | Space.g1.rawValue | Space.g2.rawValue | Space.g3.rawValue
        case .f3: return Space.e2.rawValue | Space.e3.rawValue | Space.e4.rawValue | Space.f2.rawValue | Space.f4.rawValue | Space.g2.rawValue | Space.g3.rawValue | Space.g4.rawValue
        case .f4: return Space.e3.rawValue | Space.e4.rawValue | Space.e5.rawValue | Space.f3.rawValue | Space.f5.rawValue | Space.g3.rawValue | Space.g4.rawValue | Space.g5.rawValue
        case .f5: return Space.e4.rawValue | Space.e5.rawValue | Space.e6.rawValue | Space.f4.rawValue | Space.f6.rawValue | Space.g4.rawValue | Space.g5.rawValue | Space.g6.rawValue
        case .f6: return Space.e5.rawValue | Space.e6.rawValue | Space.e7.rawValue | Space.f5.rawValue | Space.f7.rawValue | Space.g5.rawValue | Space.g6.rawValue | Space.g7.rawValue
        case .f7: return Space.e6.rawValue | Space.e7.rawValue | Space.e8.rawValue | Space.f6.rawValue | Space.f8.rawValue | Space.g6.rawValue | Space.g7.rawValue | Space.g8.rawValue
        case .f8: return Space.e7.rawValue | Space.e8.rawValue | Space.f7.rawValue | Space.g7.rawValue | Space.g8.rawValue
            
        case .g1: return Space.f1.rawValue | Space.f2.rawValue | Space.g2.rawValue | Space.h1.rawValue | Space.h2.rawValue
        case .g2: return Space.f1.rawValue | Space.f2.rawValue | Space.f3.rawValue | Space.g1.rawValue | Space.g3.rawValue | Space.h1.rawValue | Space.h2.rawValue | Space.h3.rawValue
        case .g3: return Space.f2.rawValue | Space.f3.rawValue | Space.f4.rawValue | Space.g2.rawValue | Space.g4.rawValue | Space.h2.rawValue | Space.h3.rawValue | Space.h4.rawValue
        case .g4: return Space.f3.rawValue | Space.f4.rawValue | Space.f5.rawValue | Space.g3.rawValue | Space.g5.rawValue | Space.h3.rawValue | Space.h4.rawValue | Space.h5.rawValue
        case .g5: return Space.f4.rawValue | Space.f5.rawValue | Space.f6.rawValue | Space.g4.rawValue | Space.g6.rawValue | Space.h4.rawValue | Space.h5.rawValue | Space.h6.rawValue
        case .g6: return Space.f5.rawValue | Space.f6.rawValue | Space.f7.rawValue | Space.g5.rawValue | Space.g7.rawValue | Space.h5.rawValue | Space.h6.rawValue | Space.h7.rawValue
        case .g7: return Space.f6.rawValue | Space.f7.rawValue | Space.f8.rawValue | Space.g6.rawValue | Space.g8.rawValue | Space.h6.rawValue | Space.h7.rawValue | Space.h8.rawValue
        case .g8: return Space.f7.rawValue | Space.f8.rawValue | Space.g7.rawValue | Space.h7.rawValue | Space.h8.rawValue
            
        case .h1: return Space.h2.rawValue | Space.g1.rawValue | Space.g2.rawValue
        case .h2: return Space.h1.rawValue | Space.h3.rawValue | Space.g1.rawValue | Space.g2.rawValue | Space.g3.rawValue
        case .h3: return Space.h2.rawValue | Space.h4.rawValue | Space.g2.rawValue | Space.g3.rawValue | Space.g4.rawValue
        case .h4: return Space.h3.rawValue | Space.h5.rawValue | Space.g3.rawValue | Space.g4.rawValue | Space.g5.rawValue
        case .h5: return Space.h4.rawValue | Space.h6.rawValue | Space.g4.rawValue | Space.g5.rawValue | Space.g6.rawValue
        case .h6: return Space.h5.rawValue | Space.h7.rawValue | Space.g5.rawValue | Space.g6.rawValue | Space.g7.rawValue
        case .h7: return Space.h6.rawValue | Space.h8.rawValue | Space.g6.rawValue | Space.g7.rawValue | Space.g8.rawValue
        case .h8: return Space.h7.rawValue | Space.g7.rawValue | Space.g8.rawValue
        }
    }
    
    var adjacentSpacesOld: Set<Space> {
        switch self {
        case .a1: return [.a2,.b1,.b2]
        case .a2: return [.a1,.a3,.b1,.b2,.b3]
        case .a3: return [.a2,.a4,.b2,.b3,.b4]
        case .a4: return [.a3,.a5,.b3,.b4,.b5]
        case .a5: return [.a4,.a6,.b4,.b5,.b6]
        case .a6: return [.a5,.a7,.b5,.b6,.b7]
        case .a7: return [.a6,.a8,.b6,.b7,.b8]
        case .a8: return [.a7,.b7,.b8]
            
        case .b1: return [.a1,.a2,.b2,.c1,.c2]
        case .b2: return [.a1,.a2,.a3,.b1,.b3,.c1,.c2,.c3]
        case .b3: return [.a2,.a3,.a4,.b2,.b4,.c2,.c3,.c4]
        case .b4: return [.a3,.a4,.a5,.b3,.b5,.c3,.c4,.c5]
        case .b5: return [.a4,.a5,.a6,.b4,.b6,.c4,.c5,.c6]
        case .b6: return [.a5,.a6,.a7,.b5,.b7,.c5,.c6,.c7]
        case .b7: return [.a6,.a7,.a8,.b6,.b8,.c6,.c7,.c8]
        case .b8: return [.a7,.a8,.b7,.c7,.c8]
            
        case .c1: return [.b1,.b2,.c2,.d1,.d2]
        case .c2: return [.b1,.b2,.b3,.c1,.c3,.d1,.d2,.d3]
        case .c3: return [.b2,.b3,.b4,.c2,.c4,.d2,.d3,.d4]
        case .c4: return [.b3,.b4,.b5,.c3,.c5,.d3,.d4,.d5]
        case .c5: return [.b4,.b5,.b6,.c4,.c6,.d4,.d5,.d6]
        case .c6: return [.b5,.b6,.b7,.c5,.c7,.d5,.d6,.d7]
        case .c7: return [.b6,.b7,.b8,.c6,.c8,.d6,.d7,.d8]
        case .c8: return [.b7,.b8,.c7,.d7,.d8]
            
        case .d1: return [.c1,.c2,.d2,.e1,.e2]
        case .d2: return [.c1,.c2,.c3,.d1,.d3,.e1,.e2,.e3]
        case .d3: return [.c2,.c3,.c4,.d2,.d4,.e2,.e3,.e4]
        case .d4: return [.c3,.c4,.c5,.d3,.d5,.e3,.e4,.e5]
        case .d5: return [.c4,.c5,.c6,.d4,.d6,.e4,.e5,.e6]
        case .d6: return [.c5,.c6,.c7,.d5,.d7,.e5,.e6,.e7]
        case .d7: return [.c6,.c7,.c8,.d6,.d8,.e6,.e7,.e8]
        case .d8: return [.c7,.c8,.d7,.e7,.e8]
            
        case .e1: return [.d1,.d2,.e2,.f1,.f2]
        case .e2: return [.d1,.d2,.d3,.e1,.e3,.f1,.f2,.f3]
        case .e3: return [.d2,.d3,.d4,.e2,.e4,.f2,.f3,.f4]
        case .e4: return [.d3,.d4,.d5,.e3,.e5,.f3,.f4,.f5]
        case .e5: return [.d4,.d5,.d6,.e4,.e6,.f4,.f5,.f6]
        case .e6: return [.d5,.d6,.d7,.e5,.e7,.f5,.f6,.f7]
        case .e7: return [.d6,.d7,.d8,.e6,.e8,.f6,.f7,.f8]
        case .e8: return [.d7,.d8,.e7,.f7,.f8]
            
        case .f1: return [.e1,.e2,.f2,.g1,.g2]
        case .f2: return [.e1,.e2,.e3,.f1,.f3,.g1,.g2,.g3]
        case .f3: return [.e2,.e3,.e4,.f2,.f4,.g2,.g3,.g4]
        case .f4: return [.e3,.e4,.e5,.f3,.f5,.g3,.g4,.g5]
        case .f5: return [.e4,.e5,.e6,.f4,.f6,.g4,.g5,.g6]
        case .f6: return [.e5,.e6,.e7,.f5,.f7,.g5,.g6,.g7]
        case .f7: return [.e6,.e7,.e8,.f6,.f8,.g6,.g7,.g8]
        case .f8: return [.e7,.e8,.f7,.g7,.g8]
            
        case .g1: return [.f1,.f2,.g2,.h1,.h2]
        case .g2: return [.f1,.f2,.f3,.g1,.g3,.h1,.h2,.h3]
        case .g3: return [.f2,.f3,.f4,.g2,.g4,.h2,.h3,.h4]
        case .g4: return [.f3,.f4,.f5,.g3,.g5,.h3,.h4,.h5]
        case .g5: return [.f4,.f5,.f6,.g4,.g6,.h4,.h5,.h6]
        case .g6: return [.f5,.f6,.f7,.g5,.g7,.h5,.h6,.h7]
        case .g7: return [.f6,.f7,.f8,.g6,.g8,.h6,.h7,.h8]
        case .g8: return [.f7,.f8,.g7,.h7,.h8]
            
        case .h1: return [.h2,.g1,.g2]
        case .h2: return [.h1,.h3,.g1,.g2,.g3]
        case .h3: return [.h2,.h4,.g2,.g3,.g4]
        case .h4: return [.h3,.h5,.g3,.g4,.g5]
        case .h5: return [.h4,.h6,.g4,.g5,.g6]
        case .h6: return [.h5,.h7,.g5,.g6,.g7]
        case .h7: return [.h6,.h8,.g6,.g7,.g8]
        case .h8: return [.h7,.g7,.g8]
        }
    }

}

enum CastleMoves: String {
    case blackKingSide =  "k"
    case blackQueenSide = "q"
    case whiteKingSide =  "K"
    case whiteQueenSide = "Q"
    
    var king: Move {
        switch  self {
        case .blackKingSide:  return Move(from: .e8, to: .g8)
        case .blackQueenSide: return Move(from: .e8, to: .c8)
        case .whiteKingSide:  return Move(from: .e1, to: .g1)
        case .whiteQueenSide: return Move(from: .e1, to: .c1)
        }
    }
    
    var rook: Move {
        switch self {
        case .blackKingSide:  return Move(from: .h8, to: .f8)
        case .blackQueenSide: return Move(from: .a8, to: .d8)
        case .whiteKingSide:  return Move(from: .h1, to: .f1)
        case .whiteQueenSide: return Move(from: .a1, to: .d1)
        }
    }
}

enum Color: String {
    case black = "b"
    case white = "w"
    
    var description: String {
        switch self {
        case .black: return "black"
        case .white: return "white"
        }
    }
    
    var opposite: Color {
        switch self {
        case .black: return .white
        case .white: return .black
        }
    }
}

enum Piece: String {
    case blackPawn =   "p"
    case blackKnight = "n"
    case blackBishop = "b"
    case blackRook =   "r"
    case blackQueen =  "q"
    case blackKing =   "k"
    case whitePawn =   "P"
    case whiteKnight = "N"
    case whiteBishop = "B"
    case whiteRook =   "R"
    case whiteQueen =  "Q"
    case whiteKing =   "K"
    
    var description: String {
        switch self {
        case .blackPawn:   return "♟"
        case .blackKnight: return "♞"
        case .blackBishop: return "♝"
        case .blackRook:   return "♜"
        case .blackQueen:  return "♛"
        case .blackKing:   return "♚"
        case .whitePawn:   return "♙"
        case .whiteKnight: return "♘"
        case .whiteBishop: return "♗"
        case .whiteRook:   return "♖"
        case .whiteQueen:  return "♕"
        case .whiteKing:   return "♔"
        }
    }
    
    var color: Color {
        switch self {
        case .blackPawn, .blackKnight, .blackBishop, .blackRook, .blackQueen, .blackKing: return .black
        case .whitePawn, .whiteKnight, .whiteBishop, .whiteRook, .whiteQueen, .whiteKing: return .white
        }
    }
}
