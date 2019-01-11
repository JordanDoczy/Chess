//
//  Enums.swift
//  Chess
//
//  Created by Jordan Doczy on 11/24/16.
//  Copyright © 2016 Jordan Doczy. All rights reserved.
//

import Foundation

enum File: Int, CaseIterable {
    case a = 1
    case b
    case c
    case d
    case e
    case f
    case g
    case h
    
    var description: String {
        switch self {
        case .a: return "a"
        case .b: return "b"
        case .c: return "c"
        case .d: return "d"
        case .e: return "e"
        case .f: return "f"
        case .g: return "g"
        case .h: return "h"
        }
    }
    
//    var spaces: Set<Space> {
//        switch self {
//        case .a: return [.a1,.a2,.a3,.a4,.a5,.a6,.a7,.a8]
//        case .b: return [.b1,.b2,.b3,.b4,.b5,.b6,.b7,.b8]
//        case .c: return [.c1,.c2,.c3,.c4,.c5,.c6,.c7,.c8]
//        case .d: return [.d1,.d2,.d3,.d4,.d5,.d6,.d7,.d8]
//        case .e: return [.e1,.e2,.e3,.e4,.e5,.e6,.e7,.e8]
//        case .f: return [.f1,.f2,.f3,.f4,.f5,.f6,.f7,.f8]
//        case .g: return [.g1,.g2,.g3,.g4,.g5,.g6,.g7,.g8]
//        case .h: return [.h1,.h2,.h3,.h4,.h5,.h6,.h7,.h8]
//        }
//    }
    
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

enum Rank: Int, CaseIterable {
    case _1 = 1
    case _2
    case _3
    case _4
    case _5
    case _6
    case _7
    case _8
    
    var description: String {
        return "\(rawValue)"
    }
    
//    var spaces: Set<Space> {
//        switch self {
//        case ._1: return [.a1,.b1,.c1,.d1,.e1,.f1,.g1,.h1]
//        case ._2: return [.a2,.b2,.c2,.d2,.e2,.f2,.g2,.h2]
//        case ._3: return [.a3,.b3,.c3,.d3,.e3,.f3,.g3,.h3]
//        case ._4: return [.a4,.b4,.c4,.d4,.e4,.f4,.g4,.h4]
//        case ._5: return [.a5,.b5,.c5,.d5,.e5,.f5,.g5,.h5]
//        case ._6: return [.a6,.b6,.c6,.d6,.e6,.f6,.g6,.h6]
//        case ._7: return [.a7,.b7,.c7,.d7,.e7,.f7,.g7,.h7]
//        case ._8: return [.a8,.b8,.c8,.d8,.e8,.f8,.g8,.h8]
//        }
//    }
    
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

enum Diagonal: CaseIterable {
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
    
//    var spaces: Set<Space> {
//        switch self {
//        case .a1h8: return [.a1,.b2,.c3,.d4,.e5,.f6,.g7,.h8]
//        case .b1h7: return [.b1,.c2,.d3,.e4,.f5,.g6,.h7]
//        case .b1a2: return [.b1,.a2]
//        case .b8a7: return [.b8,.a7]
//        case .b8h2: return [.b8,.c7,.d6,.e5,.f4,.g3,.h2]
//        case .c1h6: return [.c1,.d2,.e3,.f4,.g5,.h6]
//        case .c1a3: return [.c1,.b2,.a3]
//        case .c8a6: return [.c8,.b7,.a6]
//        case .c8h3: return [.c8,.d7,.e6,.f5,.g4,.h3]
//        case .d1h5: return [.d1,.e2,.f3,.g4,.h5]
//        case .d1a4: return [.d1,.c2,.b3,.a4]
//        case .d8a5: return [.d8,.c7,.b6,.a5]
//        case .d8h4: return [.d8,.e7,.f6,.g5,.h4]
//        case .e1h4: return [.e1,.f2,.g3,.h4]
//        case .e1a5: return [.e1,.d2,.c3,.b4,.a5]
//        case .e8a4: return [.e8,.d7,.c6,.b5,.a4]
//        case .e8h5: return [.e8,.f7,.g6,.h5]
//        case .f1h3: return [.f1,.g2,.h3]
//        case .f1a6: return [.f1,.e2,.d3,.c4,.b5,.a6]
//        case .f8a3: return [.f8,.e7,.d6,.c5,.b4,.a3]
//        case .f8h6: return [.f8,.g7,.h6]
//        case .g1h2: return [.g1,.h2]
//        case .g1a7: return [.g1,.f2,.e3,.d4,.c5,.b6,.a7]
//        case .g8a2: return [.g8,.f7,.e6,.d5,.c4,.b3,.a2]
//        case .g8h7: return [.g8,.h7]
//        case .h1a8: return [.h1,.g2,.f3,.e4,.d5,.c6,.b7,.a8]
//        }
//    }
}

enum Space: String, Equatable, CaseIterable {
    case a1 = "a1"
    case a2 = "a2"
    case a3 = "a3"
    case a4 = "a4"
    case a5 = "a5"
    case a6 = "a6"
    case a7 = "a7"
    case a8 = "a8"
    case b1 = "b1"
    case b2 = "b2"
    case b3 = "b3"
    case b4 = "b4"
    case b5 = "b5"
    case b6 = "b6"
    case b7 = "b7"
    case b8 = "b8"
    case c1 = "c1"
    case c2 = "c2"
    case c3 = "c3"
    case c4 = "c4"
    case c5 = "c5"
    case c6 = "c6"
    case c7 = "c7"
    case c8 = "c8"
    case d1 = "d1"
    case d2 = "d2"
    case d3 = "d3"
    case d4 = "d4"
    case d5 = "d5"
    case d6 = "d6"
    case d7 = "d7"
    case d8 = "d8"
    case e1 = "e1"
    case e2 = "e2"
    case e3 = "e3"
    case e4 = "e4"
    case e5 = "e5"
    case e6 = "e6"
    case e7 = "e7"
    case e8 = "e8"
    case f1 = "f1"
    case f2 = "f2"
    case f3 = "f3"
    case f4 = "f4"
    case f5 = "f5"
    case f6 = "f6"
    case f7 = "f7"
    case f8 = "f8"
    case g1 = "g1"
    case g2 = "g2"
    case g3 = "g3"
    case g4 = "g4"
    case g5 = "g5"
    case g6 = "g6"
    case g7 = "g7"
    case g8 = "g8"
    case h1 = "h1"
    case h2 = "h2"
    case h3 = "h3"
    case h4 = "h4"
    case h5 = "h5"
    case h6 = "h6"
    case h7 = "h7"
    case h8 = "h8"
    
    init(rank: Rank, file: File) {
        self = Space(rawValue: file.description + rank.description)!
    }
    
//    var index: Int {
//        return ((self.file.rawValue-1) * 8) + self.rank.rawValue - 1
//    }
//
//    var diagonals: Set<Diagonal> {
//        switch self {
//        case .a1: return [.a1h8]
//        case .a2: return [.g8a2, .b1a2]
//        case .a3: return [.f8a3, .c1a3]
//        case .a4: return [.e8a4, .d1a4]
//        case .a5: return [.d8a5, .e1a5]
//        case .a6: return [.c8a6, .f1a6]
//        case .a7: return [.b8a7, .g1a7]
//        case .a8: return [.h1a8]
//            
//        case .b1: return [.b1a2, .b1h7]
//        case .b2: return [.a1h8, .c1a3]
//        case .b3: return [.g8a2, .d1a4]
//        case .b4: return [.f8a3, .e1a5]
//        case .b5: return [.e8a4, .f1a6]
//        case .b6: return [.d8a5, .g1a7]
//        case .b7: return [.c8a6, .h1a8]
//        case .b8: return [.b8a7, .b8h2]
//            
//        case .c1: return [.c1a3, .c1h6]
//        case .c2: return [.d1a4, .b1h7]
//        case .c3: return [.e1a5, .a1h8]
//        case .c4: return [.g8a2, .f1a6]
//        case .c5: return [.f8a3, .g1a7]
//        case .c6: return [.e8a4, .h1a8]
//        case .c7: return [.d8a5, .b8h2]
//        case .c8: return [.c8a6, .c8h3]
//            
//        case .d1: return [.d1a4, .d1h5]
//        case .d2: return [.c1h6, .e1a5]
//        case .d3: return [.b1h7, .f1a6]
//        case .d4: return [.a1h8, .g1a7]
//        case .d5: return [.g8a2, .h1a8]
//        case .d6: return [.f8a3, .b8h2]
//        case .d7: return [.e8a4, .c8h3]
//        case .d8: return [.d8a5, .d8h4]
//            
//        case .e1: return [.e1a5, .e1h4]
//        case .e2: return [.d1h5, .f1a6]
//        case .e3: return [.c1h6, .g1a7]
//        case .e4: return [.b1h7, .h1a8]
//        case .e5: return [.a1h8, .b8h2]
//        case .e6: return [.g8a2, .c8h3]
//        case .e7: return [.f8a3, .d8h4]
//        case .e8: return [.e8a4, .e8h5]
//            
//        case .f1: return [.f1a6, .f1h3]
//        case .f2: return [.e1h4, .g1a7]
//        case .f3: return [.d1h5, .h1a8]
//        case .f4: return [.c1h6, .b8h2]
//        case .f5: return [.b1h7, .c8h3]
//        case .f6: return [.a1h8, .d8h4]
//        case .f7: return [.g8a2, .e8h5]
//        case .f8: return [.f8a3, .f8h6]
//            
//        case .g1: return [.g1a7, .g1h2]
//        case .g2: return [.f1h3, .h1a8]
//        case .g3: return [.e1h4, .b8h2]
//        case .g4: return [.d1h5, .c8h3]
//        case .g5: return [.c1h6, .d8h4]
//        case .g6: return [.b1h7, .e8h5]
//        case .g7: return [.a1h8, .f8h6]
//        case .g8: return [.g8a2, .g8h7]
//            
//        case .h1: return [.h1a8]
//        case .h2: return [.b8h2, .g1h2]
//        case .h3: return [.c8h3, .f1h3]
//        case .h4: return [.d8h4, .e1h4]
//        case .h5: return [.e8h5, .d1h5]
//        case .h6: return [.f8h6, .c1h6]
//        case .h7: return [.g8h7, .b1h7]
//        case .h8: return [.a1h8]
//        }
//    }
//    
//    var file: File {
//        switch self {
//        case .a1,.a2,.a3,.a4,.a5,.a6,.a7,.a8: return .a
//        case .b1,.b2,.b3,.b4,.b5,.b6,.b7,.b8: return .b
//        case .c1,.c2,.c3,.c4,.c5,.c6,.c7,.c8: return .c
//        case .d1,.d2,.d3,.d4,.d5,.d6,.d7,.d8: return .d
//        case .e1,.e2,.e3,.e4,.e5,.e6,.e7,.e8: return .e
//        case .f1,.f2,.f3,.f4,.f5,.f6,.f7,.f8: return .f
//        case .g1,.g2,.g3,.g4,.g5,.g6,.g7,.g8: return .g
//        case .h1,.h2,.h3,.h4,.h5,.h6,.h7,.h8: return .h
//        }
//    }
//    
//    var rank: Rank {
//        switch self {
//        case .a1,.b1,.c1,.d1,.e1,.f1,.g1,.h1: return ._1
//        case .a2,.b2,.c2,.d2,.e2,.f2,.g2,.h2: return ._2
//        case .a3,.b3,.c3,.d3,.e3,.f3,.g3,.h3: return ._3
//        case .a4,.b4,.c4,.d4,.e4,.f4,.g4,.h4: return ._4
//        case .a5,.b5,.c5,.d5,.e5,.f5,.g5,.h5: return ._5
//        case .a6,.b6,.c6,.d6,.e6,.f6,.g6,.h6: return ._6
//        case .a7,.b7,.c7,.d7,.e7,.f7,.g7,.h7: return ._7
//        case .a8,.b8,.c8,.d8,.e8,.f8,.g8,.h8: return ._8
//        }
//    }
//    
//    var knightMoves: Set<Space> {
//        switch self {
//        case .a1: return [.b3,.c2]
//        case .a2: return [.b4,.c1,.c3]
//        case .a3: return [.b5,.b1,.c4,.c2]
//        case .a4: return [.b6,.b2,.c5,.c3]
//        case .a5: return [.b7,.b3,.c6,.c4]
//        case .a6: return [.b8,.b4,.c7,.c5]
//        case .a7: return [.b5,.c8,.c6]
//        case .a8: return [.b6,.c7]
//            
//        case .b1: return [.a3,.c3,.d2]
//        case .b2: return [.a4,.c4,.d1,.d3]
//        case .b3: return [.a1,.a5,.c1,.c5,.d2,.d4]
//        case .b4: return [.a2,.a6,.c2,.c6,.d3,.d5]
//        case .b5: return [.a3,.a7,.c3,.c7,.d4,.d6]
//        case .b6: return [.a4,.a8,.c4,.c8,.d5,.d7]
//        case .b7: return [.a5,.c5,.d6,.d8]
//        case .b8: return [.a6,.c6,.d7]
//            
//        case .c1: return [.a2,.b3,.d3,.e2]
//        case .c2: return [.a1,.a3,.b4,.d4,.e1,.e3]
//        case .c3: return [.a2,.a4,.b1,.b5,.d1,.d5,.e2,.e4]
//        case .c4: return [.a3,.a5,.b2,.b6,.d2,.d6,.e3,.e5]
//        case .c5: return [.a4,.a6,.b3,.b7,.d3,.d7,.e4,.e6]
//        case .c6: return [.a5,.a7,.b4,.b8,.d4,.d8,.e6,.e7]
//        case .c7: return [.a6,.a8,.b5,.d5,.e6,.e8]
//        case .c8: return [.a7,.b6,.d6,.e7]
//            
//        case .d1: return [.b2,.c3,.e3,.f2]
//        case .d2: return [.b1,.b3,.c4,.e4,.f1,.f3]
//        case .d3: return [.b2,.b4,.c1,.c5,.e1,.e5,.f2,.f4]
//        case .d4: return [.b3,.b5,.c2,.c6,.e2,.e6,.f3,.f5]
//        case .d5: return [.b4,.b6,.c3,.c7,.e3,.e7,.f4,.f6]
//        case .d6: return [.b5,.b7,.c4,.c8,.e4,.e8,.f6,.f7]
//        case .d7: return [.b6,.b8,.c5,.e5,.f6,.f8]
//        case .d8: return [.b7,.c6,.e6,.f7]
//            
//        case .e1: return [.c2,.d3,.f3,.g2]
//        case .e2: return [.c1,.c3,.d4,.f4,.g1,.g3]
//        case .e3: return [.c2,.c4,.d1,.d5,.f1,.f5,.g2,.g4]
//        case .e4: return [.c3,.c5,.d2,.d6,.f2,.f6,.g3,.g5]
//        case .e5: return [.c4,.c6,.d3,.d7,.f3,.f7,.g4,.g6]
//        case .e6: return [.c5,.c7,.d4,.d8,.f4,.f8,.g6,.g7]
//        case .e7: return [.c6,.c8,.d5,.f5,.g6,.g8]
//        case .e8: return [.c7,.d6,.f6,.g7]
//            
//        case .f1: return [.d2,.e3,.g3,.h2]
//        case .f2: return [.d1,.d3,.e4,.g4,.g1,.h3]
//        case .f3: return [.d2,.d4,.e1,.e5,.g1,.g5,.h2,.h4]
//        case .f4: return [.d3,.d5,.e2,.e6,.g2,.g6,.h3,.h5]
//        case .f5: return [.d4,.d6,.e3,.e7,.g3,.g7,.h4,.h6]
//        case .f6: return [.d5,.d7,.e4,.e8,.g4,.g8,.h6,.h7]
//        case .f7: return [.d6,.d8,.e5,.g5,.h6,.h8]
//        case .f8: return [.d7,.e6,.g6,.h7]
//            
//        case .g1: return [.h3,.f3,.e2]
//        case .g2: return [.h4,.f4,.e1,.e3]
//        case .g3: return [.h1,.h5,.f1,.f5,.e2,.e4]
//        case .g4: return [.h2,.h6,.f2,.f6,.e3,.e5]
//        case .g5: return [.h3,.h7,.f3,.f7,.e4,.e6]
//        case .g6: return [.h4,.h8,.f4,.f8,.e5,.e7]
//        case .g7: return [.h5,.f5,.e6,.e8]
//        case .g8: return [.h6,.f6,.e7]
//            
//        case .h1: return [.g3,.f2]
//        case .h2: return [.g4,.f1,.f3]
//        case .h3: return [.g5,.g1,.f4,.f2]
//        case .h4: return [.g6,.g2,.f5,.f3]
//        case .h5: return [.g7,.g3,.f6,.f4]
//        case .h6: return [.g8,.g4,.f7,.f5]
//        case .h7: return [.g5,.f8,.f6]
//        case .h8: return [.g6,.f7]
//        }
//    }
//    
//    var adjacentSpaces: Set<Space> {
//        switch self {
//        case .a1: return [.a2,.b1,.b2]
//        case .a2: return [.a1,.a3,.b1,.b2,.b3]
//        case .a3: return [.a2,.a4,.b2,.b3,.b4]
//        case .a4: return [.a3,.a5,.b3,.b4,.b5]
//        case .a5: return [.a4,.a6,.b4,.b5,.b6]
//        case .a6: return [.a5,.a7,.b5,.b6,.b7]
//        case .a7: return [.a6,.a8,.b6,.b7,.b8]
//        case .a8: return [.a7,.b7,.b8]
//            
//        case .b1: return [.a1,.a2,.b2,.c1,.c2]
//        case .b2: return [.a1,.a2,.a3,.b1,.b3,.c1,.c2,.c3]
//        case .b3: return [.a2,.a3,.a4,.b2,.b4,.c2,.c3,.c4]
//        case .b4: return [.a3,.a4,.a5,.b3,.b5,.c3,.c4,.c5]
//        case .b5: return [.a4,.a5,.a6,.b4,.b6,.c4,.c5,.c6]
//        case .b6: return [.a5,.a6,.a7,.b5,.b7,.c5,.c6,.c7]
//        case .b7: return [.a6,.a7,.a8,.b6,.b8,.c6,.c7,.c8]
//        case .b8: return [.a7,.a8,.b7,.c7,.c8]
//            
//        case .c1: return [.b1,.b2,.c2,.d1,.d2]
//        case .c2: return [.b1,.b2,.b3,.c1,.c3,.d1,.d2,.d3]
//        case .c3: return [.b2,.b3,.b4,.c2,.c4,.d2,.d3,.d4]
//        case .c4: return [.b3,.b4,.b5,.c3,.c5,.d3,.d4,.d5]
//        case .c5: return [.b4,.b5,.b6,.c4,.c6,.d4,.d5,.d6]
//        case .c6: return [.b5,.b6,.b7,.c5,.c7,.d5,.d6,.d7]
//        case .c7: return [.b6,.b7,.b8,.c6,.c8,.d6,.d7,.d8]
//        case .c8: return [.b7,.b8,.c7,.d7,.d8]
//            
//        case .d1: return [.c1,.c2,.d2,.e1,.e2]
//        case .d2: return [.c1,.c2,.c3,.d1,.d3,.e1,.e2,.e3]
//        case .d3: return [.c2,.c3,.c4,.d2,.d4,.e2,.e3,.e4]
//        case .d4: return [.c3,.c4,.c5,.d3,.d5,.e3,.e4,.e5]
//        case .d5: return [.c4,.c5,.c6,.d4,.d6,.e4,.e5,.e6]
//        case .d6: return [.c5,.c6,.c7,.d5,.d7,.e5,.e6,.e7]
//        case .d7: return [.c6,.c7,.c8,.d6,.d8,.e6,.e7,.e8]
//        case .d8: return [.c7,.c8,.d7,.e7,.e8]
//            
//        case .e1: return [.d1,.d2,.e2,.f1,.f2]
//        case .e2: return [.d1,.d2,.d3,.e1,.e3,.f1,.f2,.f3]
//        case .e3: return [.d2,.d3,.d4,.e2,.e4,.f2,.f3,.f4]
//        case .e4: return [.d3,.d4,.d5,.e3,.e5,.f3,.f4,.f5]
//        case .e5: return [.d4,.d5,.d6,.e4,.e6,.f4,.f5,.f6]
//        case .e6: return [.d5,.d6,.d7,.e5,.e7,.f5,.f6,.f7]
//        case .e7: return [.d6,.d7,.d8,.e6,.e8,.f6,.f7,.f8]
//        case .e8: return [.d7,.d8,.e7,.f7,.f8]
//            
//        case .f1: return [.e1,.e2,.f2,.g1,.g2]
//        case .f2: return [.e1,.e2,.e3,.f1,.f3,.g1,.g2,.g3]
//        case .f3: return [.e2,.e3,.e4,.f2,.f4,.g2,.g3,.g4]
//        case .f4: return [.e3,.e4,.e5,.f3,.f5,.g3,.g4,.g5]
//        case .f5: return [.e4,.e5,.e6,.f4,.f6,.g4,.g5,.g6]
//        case .f6: return [.e5,.e6,.e7,.f5,.f7,.g5,.g6,.g7]
//        case .f7: return [.e6,.e7,.e8,.f6,.f8,.g6,.g7,.g8]
//        case .f8: return [.e7,.e8,.f7,.g7,.g8]
//            
//        case .g1: return [.f1,.f2,.g2,.h1,.h2]
//        case .g2: return [.f1,.f2,.f3,.g1,.g3,.h1,.h2,.h3]
//        case .g3: return [.f2,.f3,.f4,.g2,.g4,.h2,.h3,.h4]
//        case .g4: return [.f3,.f4,.f5,.g3,.g5,.h3,.h4,.h5]
//        case .g5: return [.f4,.f5,.f6,.g4,.g6,.h4,.h5,.h6]
//        case .g6: return [.f5,.f6,.f7,.g5,.g7,.h5,.h6,.h7]
//        case .g7: return [.f6,.f7,.f8,.g6,.g8,.h6,.h7,.h8]
//        case .g8: return [.f7,.f8,.g7,.h7,.h8]
//            
//        case .h1: return [.h2,.g1,.g2]
//        case .h2: return [.h1,.h3,.g1,.g2,.g3]
//        case .h3: return [.h2,.h4,.g2,.g3,.g4]
//        case .h4: return [.h3,.h5,.g3,.g4,.g5]
//        case .h5: return [.h4,.h6,.g4,.g5,.g6]
//        case .h6: return [.h5,.h7,.g5,.g6,.g7]
//        case .h7: return [.h6,.h8,.g6,.g7,.g8]
//        case .h8: return [.h7,.g7,.g8]
//        }
//    }
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
    
    var kingStep: Move {
        switch  self {
        case .blackKingSide:  return Move(from: .e8, to: .f8)
        case .blackQueenSide: return Move(from: .e8, to: .d8)
        case .whiteKingSide:  return Move(from: .e1, to: .f1)
        case .whiteQueenSide: return Move(from: .e1, to: .d1)
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
    
    init?(move: Move) {
        switch move.hashValue {
        case Move(from: .e8, to: .g8).hashValue: self = .blackKingSide
        case Move(from: .e8, to: .c8).hashValue: self = .blackQueenSide
        case Move(from: .e1, to: .g1).hashValue: self = .whiteKingSide
        case Move(from: .e1, to: .c1).hashValue: self = .whiteKingSide
        default: return nil
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
    
    var sign: Int {
        switch self {
        case .black: return -1
        case .white: return 1
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
    
    var value: Int {
        switch self {
        case .blackPawn, .whitePawn: return 1 * color.sign
        case .blackKnight, .whiteKnight, .blackBishop, .whiteBishop: return 3 * color.sign
        case .blackRook, .whiteRook: return 5 * color.sign
        case .blackQueen, .whiteQueen: return 9 * color.sign
        case .blackKing, .whiteKing: return 0 * color.sign
        }
    }
}
