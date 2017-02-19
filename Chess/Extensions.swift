//
//  Extensions.swift
//  Chess
//
//  Created by Jordan Doczy on 2/18/17.
//  Copyright © 2017 Jordan Doczy. All rights reserved.
//

import Foundation

extension File {
    var computedSpaces: UInt64 {
        switch self {
        case .a: return Space.a1.int | Space.a2.int | Space.a3.int | Space.a4.int | Space.a5.int | Space.a6.int | Space.a7.int | Space.a8.int
        case .b: return Space.b1.int | Space.b2.int | Space.b3.int | Space.b4.int | Space.b5.int | Space.b6.int | Space.b7.int | Space.b8.int
        case .c: return Space.c1.int | Space.c2.int | Space.c3.int | Space.c4.int | Space.c5.int | Space.c6.int | Space.c7.int | Space.c8.int
        case .d: return Space.d1.int | Space.d2.int | Space.d3.int | Space.d4.int | Space.d5.int | Space.d6.int | Space.d7.int | Space.d8.int
        case .e: return Space.e1.int | Space.e2.int | Space.e3.int | Space.e4.int | Space.e5.int | Space.e6.int | Space.e7.int | Space.e8.int
        case .f: return Space.f1.int | Space.f2.int | Space.f3.int | Space.f4.int | Space.f5.int | Space.f6.int | Space.f7.int | Space.f8.int
        case .g: return Space.g1.int | Space.g2.int | Space.g3.int | Space.g4.int | Space.g5.int | Space.g6.int | Space.g7.int | Space.g8.int
        case .h: return Space.h1.int | Space.h2.int | Space.h3.int | Space.h4.int | Space.h5.int | Space.h6.int | Space.h7.int | Space.h8.int
        }
    }
}

extension Rank {
    var computedSpaces: UInt64{
        switch self {
        case ._1: return Space.a1.int | Space.b1.int | Space.c1.int | Space.d1.int | Space.e1.int | Space.f1.int | Space.g1.int | Space.h1.int
        case ._2: return Space.a2.int | Space.b2.int | Space.c2.int | Space.d2.int | Space.e2.int | Space.f2.int | Space.g2.int | Space.h2.int
        case ._3: return Space.a3.int | Space.b3.int | Space.c3.int | Space.d3.int | Space.e3.int | Space.f3.int | Space.g3.int | Space.h3.int
        case ._4: return Space.a4.int | Space.b4.int | Space.c4.int | Space.d4.int | Space.e4.int | Space.f4.int | Space.g4.int | Space.h4.int
        case ._5: return Space.a5.int | Space.b5.int | Space.c5.int | Space.d5.int | Space.e5.int | Space.f5.int | Space.g5.int | Space.h5.int
        case ._6: return Space.a6.int | Space.b6.int | Space.c6.int | Space.d6.int | Space.e6.int | Space.f6.int | Space.g6.int | Space.h6.int
        case ._7: return Space.a7.int | Space.b7.int | Space.c7.int | Space.d7.int | Space.e7.int | Space.f7.int | Space.g7.int | Space.h7.int
        case ._8: return Space.a8.int | Space.b8.int | Space.c8.int | Space.d8.int | Space.e8.int | Space.f8.int | Space.g8.int | Space.h8.int
        }
    }
}



extension Diagonal {
    var computedSpaces: UInt64 {
        switch self {
        case .a1h8: return Space.a1.int | Space.b2.int | Space.c3.int | Space.d4.int | Space.e5.int | Space.f6.int | Space.g7.int | Space.h8.int
        case .b1h7: return Space.b1.int | Space.c2.int | Space.d3.int | Space.e4.int | Space.f5.int | Space.g6.int | Space.h7.int
        case .b1a2: return Space.b1.int | Space.a2.int
        case .b8a7: return Space.b8.int | Space.a7.int
        case .b8h2: return Space.b8.int | Space.c7.int | Space.d6.int | Space.e5.int | Space.f4.int | Space.g3.int | Space.h2.int
        case .c1h6: return Space.c1.int | Space.d2.int | Space.e3.int | Space.f4.int | Space.g5.int | Space.h6.int
        case .c1a3: return Space.c1.int | Space.b2.int | Space.a3.int
        case .c8a6: return Space.c8.int | Space.b7.int | Space.a6.int
        case .c8h3: return Space.c8.int | Space.d7.int | Space.e6.int | Space.f5.int | Space.g4.int | Space.h3.int
        case .d1h5: return Space.d1.int | Space.e2.int | Space.f3.int | Space.g4.int | Space.h5.int
        case .d1a4: return Space.d1.int | Space.c2.int | Space.b3.int | Space.a4.int
        case .d8a5: return Space.d8.int | Space.c7.int | Space.b6.int | Space.a5.int
        case .d8h4: return Space.d8.int | Space.e7.int | Space.f6.int | Space.g5.int | Space.h4.int
        case .e1h4: return Space.e1.int | Space.f2.int | Space.g3.int | Space.h4.int
        case .e1a5: return Space.e1.int | Space.d2.int | Space.c3.int | Space.b4.int | Space.a5.int
        case .e8a4: return Space.e8.int | Space.d7.int | Space.c6.int | Space.b5.int | Space.a4.int
        case .e8h5: return Space.e8.int | Space.f7.int | Space.g6.int | Space.h5.int
        case .f1h3: return Space.f1.int | Space.g2.int | Space.h3.int
        case .f1a6: return Space.f1.int | Space.e2.int | Space.d3.int | Space.c4.int | Space.b5.int | Space.a6.int
        case .f8a3: return Space.f8.int | Space.e7.int | Space.d6.int | Space.c5.int | Space.b4.int | Space.a3.int
        case .f8h6: return Space.f8.int | Space.g7.int | Space.h6.int
        case .g1h2: return Space.g1.int | Space.h2.int
        case .g1a7: return Space.g1.int | Space.f2.int | Space.e3.int | Space.d4.int | Space.c5.int | Space.b6.int | Space.a7.int
        case .g8a2: return Space.g8.int | Space.f7.int | Space.e6.int | Space.d5.int | Space.c4.int | Space.b3.int | Space.a2.int
        case .g8h7: return Space.g8.int | Space.h7.int
        case .h1a8: return Space.h1.int | Space.g2.int | Space.f3.int | Space.e4.int | Space.d5.int | Space.c6.int | Space.b7.int | Space.a8.int
        }
    }
}

extension Space {
    
    var computedAdjacentSpaces: UInt64 {
        switch self {
        case .a1: return Space.a2.int | Space.b1.int | Space.b2.int
        case .a2: return Space.a1.int | Space.a3.int | Space.b1.int | Space.b2.int | Space.b3.int
        case .a3: return Space.a2.int | Space.a4.int | Space.b2.int | Space.b3.int | Space.b4.int
        case .a4: return Space.a3.int | Space.a5.int | Space.b3.int | Space.b4.int | Space.b5.int
        case .a5: return Space.a4.int | Space.a6.int | Space.b4.int | Space.b5.int | Space.b6.int
        case .a6: return Space.a5.int | Space.a7.int | Space.b5.int | Space.b6.int | Space.b7.int
        case .a7: return Space.a6.int | Space.a8.int | Space.b6.int | Space.b7.int | Space.b8.int
        case .a8: return Space.a7.int | Space.b7.int | Space.b8.int
            
        case .b1: return Space.a1.int | Space.a2.int | Space.b2.int | Space.c1.int | Space.c2.int
        case .b2: return Space.a1.int | Space.a2.int | Space.a3.int | Space.b1.int | Space.b3.int | Space.c1.int | Space.c2.int | Space.c3.int
        case .b3: return Space.a2.int | Space.a3.int | Space.a4.int | Space.b2.int | Space.b4.int | Space.c2.int | Space.c3.int | Space.c4.int
        case .b4: return Space.a3.int | Space.a4.int | Space.a5.int | Space.b3.int | Space.b5.int | Space.c3.int | Space.c4.int | Space.c5.int
        case .b5: return Space.a4.int | Space.a5.int | Space.a6.int | Space.b4.int | Space.b6.int | Space.c4.int | Space.c5.int | Space.c6.int
        case .b6: return Space.a5.int | Space.a6.int | Space.a7.int | Space.b5.int | Space.b7.int | Space.c5.int | Space.c6.int | Space.c7.int
        case .b7: return Space.a6.int | Space.a7.int | Space.a8.int | Space.b6.int | Space.b8.int | Space.c6.int | Space.c7.int | Space.c8.int
        case .b8: return Space.a7.int | Space.a8.int | Space.b7.int | Space.c7.int | Space.c8.int
            
        case .c1: return Space.b1.int | Space.b2.int | Space.c2.int | Space.d1.int | Space.d2.int
        case .c2: return Space.b1.int | Space.b2.int | Space.b3.int | Space.c1.int | Space.c3.int | Space.d1.int | Space.d2.int | Space.d3.int
        case .c3: return Space.b2.int | Space.b3.int | Space.b4.int | Space.c2.int | Space.c4.int | Space.d2.int | Space.d3.int | Space.d4.int
        case .c4: return Space.b3.int | Space.b4.int | Space.b5.int | Space.c3.int | Space.c5.int | Space.d3.int | Space.d4.int | Space.d5.int
        case .c5: return Space.b4.int | Space.b5.int | Space.b6.int | Space.c4.int | Space.c6.int | Space.d4.int | Space.d5.int | Space.d6.int
        case .c6: return Space.b5.int | Space.b6.int | Space.b7.int | Space.c5.int | Space.c7.int | Space.d5.int | Space.d6.int | Space.d7.int
        case .c7: return Space.b6.int | Space.b7.int | Space.b8.int | Space.c6.int | Space.c8.int | Space.d6.int | Space.d7.int | Space.d8.int
        case .c8: return Space.b7.int | Space.b8.int | Space.c7.int | Space.d7.int | Space.d8.int
            
        case .d1: return Space.c1.int | Space.c2.int | Space.d2.int | Space.e1.int | Space.e2.int
        case .d2: return Space.c1.int | Space.c2.int | Space.c3.int | Space.d1.int | Space.d3.int | Space.e1.int | Space.e2.int | Space.e3.int
        case .d3: return Space.c2.int | Space.c3.int | Space.c4.int | Space.d2.int | Space.d4.int | Space.e2.int | Space.e3.int | Space.e4.int
        case .d4: return Space.c3.int | Space.c4.int | Space.c5.int | Space.d3.int | Space.d5.int | Space.e3.int | Space.e4.int | Space.e5.int
        case .d5: return Space.c4.int | Space.c5.int | Space.c6.int | Space.d4.int | Space.d6.int | Space.e4.int | Space.e5.int | Space.e6.int
        case .d6: return Space.c5.int | Space.c6.int | Space.c7.int | Space.d5.int | Space.d7.int | Space.e5.int | Space.e6.int | Space.e7.int
        case .d7: return Space.c6.int | Space.c7.int | Space.c8.int | Space.d6.int | Space.d8.int | Space.e6.int | Space.e7.int | Space.e8.int
        case .d8: return Space.c7.int | Space.c8.int | Space.d7.int | Space.e7.int | Space.e8.int
            
        case .e1: return Space.d1.int | Space.d2.int | Space.e2.int | Space.f1.int | Space.f2.int
        case .e2: return Space.d1.int | Space.d2.int | Space.d3.int | Space.e1.int | Space.e3.int | Space.f1.int | Space.f2.int | Space.f3.int
        case .e3: return Space.d2.int | Space.d3.int | Space.d4.int | Space.e2.int | Space.e4.int | Space.f2.int | Space.f3.int | Space.f4.int
        case .e4: return Space.d3.int | Space.d4.int | Space.d5.int | Space.e3.int | Space.e5.int | Space.f3.int | Space.f4.int | Space.f5.int
        case .e5: return Space.d4.int | Space.d5.int | Space.d6.int | Space.e4.int | Space.e6.int | Space.f4.int | Space.f5.int | Space.f6.int
        case .e6: return Space.d5.int | Space.d6.int | Space.d7.int | Space.e5.int | Space.e7.int | Space.f5.int | Space.f6.int | Space.f7.int
        case .e7: return Space.d6.int | Space.d7.int | Space.d8.int | Space.e6.int | Space.e8.int | Space.f6.int | Space.f7.int | Space.f8.int
        case .e8: return Space.d7.int | Space.d8.int | Space.e7.int | Space.f7.int | Space.f8.int
            
        case .f1: return Space.e1.int | Space.e2.int | Space.f2.int | Space.g1.int | Space.g2.int
        case .f2: return Space.e1.int | Space.e2.int | Space.e3.int | Space.f1.int | Space.f3.int | Space.g1.int | Space.g2.int | Space.g3.int
        case .f3: return Space.e2.int | Space.e3.int | Space.e4.int | Space.f2.int | Space.f4.int | Space.g2.int | Space.g3.int | Space.g4.int
        case .f4: return Space.e3.int | Space.e4.int | Space.e5.int | Space.f3.int | Space.f5.int | Space.g3.int | Space.g4.int | Space.g5.int
        case .f5: return Space.e4.int | Space.e5.int | Space.e6.int | Space.f4.int | Space.f6.int | Space.g4.int | Space.g5.int | Space.g6.int
        case .f6: return Space.e5.int | Space.e6.int | Space.e7.int | Space.f5.int | Space.f7.int | Space.g5.int | Space.g6.int | Space.g7.int
        case .f7: return Space.e6.int | Space.e7.int | Space.e8.int | Space.f6.int | Space.f8.int | Space.g6.int | Space.g7.int | Space.g8.int
        case .f8: return Space.e7.int | Space.e8.int | Space.f7.int | Space.g7.int | Space.g8.int
            
        case .g1: return Space.f1.int | Space.f2.int | Space.g2.int | Space.h1.int | Space.h2.int
        case .g2: return Space.f1.int | Space.f2.int | Space.f3.int | Space.g1.int | Space.g3.int | Space.h1.int | Space.h2.int | Space.h3.int
        case .g3: return Space.f2.int | Space.f3.int | Space.f4.int | Space.g2.int | Space.g4.int | Space.h2.int | Space.h3.int | Space.h4.int
        case .g4: return Space.f3.int | Space.f4.int | Space.f5.int | Space.g3.int | Space.g5.int | Space.h3.int | Space.h4.int | Space.h5.int
        case .g5: return Space.f4.int | Space.f5.int | Space.f6.int | Space.g4.int | Space.g6.int | Space.h4.int | Space.h5.int | Space.h6.int
        case .g6: return Space.f5.int | Space.f6.int | Space.f7.int | Space.g5.int | Space.g7.int | Space.h5.int | Space.h6.int | Space.h7.int
        case .g7: return Space.f6.int | Space.f7.int | Space.f8.int | Space.g6.int | Space.g8.int | Space.h6.int | Space.h7.int | Space.h8.int
        case .g8: return Space.f7.int | Space.f8.int | Space.g7.int | Space.h7.int | Space.h8.int
            
        case .h1: return Space.h2.int | Space.g1.int | Space.g2.int
        case .h2: return Space.h1.int | Space.h3.int | Space.g1.int | Space.g2.int | Space.g3.int
        case .h3: return Space.h2.int | Space.h4.int | Space.g2.int | Space.g3.int | Space.g4.int
        case .h4: return Space.h3.int | Space.h5.int | Space.g3.int | Space.g4.int | Space.g5.int
        case .h5: return Space.h4.int | Space.h6.int | Space.g4.int | Space.g5.int | Space.g6.int
        case .h6: return Space.h5.int | Space.h7.int | Space.g5.int | Space.g6.int | Space.g7.int
        case .h7: return Space.h6.int | Space.h8.int | Space.g6.int | Space.g7.int | Space.g8.int
        case .h8: return Space.h7.int | Space.g7.int | Space.g8.int
        }
    }
    
    
    var computedDiagonals: UInt64 {
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
    
    var computedKnightMoves: UInt64 {
        switch self {
        case .a1: return Space.b3.int | Space.c2.int
        case .a2: return Space.b4.int | Space.c1.int | Space.c3.int
        case .a3: return Space.b5.int | Space.b1.int | Space.c4.int | Space.c2.int
        case .a4: return Space.b6.int | Space.b2.int | Space.c5.int | Space.c3.int
        case .a5: return Space.b7.int | Space.b3.int | Space.c6.int | Space.c4.int
        case .a6: return Space.b8.int | Space.b4.int | Space.c7.int | Space.c5.int
        case .a7: return Space.b5.int | Space.c8.int | Space.c6.int
        case .a8: return Space.b6.int | Space.c7.int
            
        case .b1: return Space.a3.int | Space.c3.int | Space.d2.int
        case .b2: return Space.a4.int | Space.c4.int | Space.d1.int | Space.d3.int
        case .b3: return Space.a1.int | Space.a5.int | Space.c1.int | Space.c5.int | Space.d2.int | Space.d4.int
        case .b4: return Space.a2.int | Space.a6.int | Space.c2.int | Space.c6.int | Space.d3.int | Space.d5.int
        case .b5: return Space.a3.int | Space.a7.int | Space.c3.int | Space.c7.int | Space.d4.int | Space.d6.int
        case .b6: return Space.a4.int | Space.a8.int | Space.c4.int | Space.c8.int | Space.d5.int | Space.d7.int
        case .b7: return Space.a5.int | Space.c5.int | Space.d6.int | Space.d8.int
        case .b8: return Space.a6.int | Space.c6.int | Space.d7.int
            
        case .c1: return Space.a2.int | Space.b3.int | Space.d3.int | Space.e2.int
        case .c2: return Space.a1.int | Space.a3.int | Space.b4.int | Space.d4.int | Space.e1.int | Space.e3.int
        case .c3: return Space.a2.int | Space.a4.int | Space.b1.int | Space.b5.int | Space.d1.int | Space.d5.int | Space.e2.int | Space.e4.int
        case .c4: return Space.a3.int | Space.a5.int | Space.b2.int | Space.b6.int | Space.d2.int | Space.d6.int | Space.e3.int | Space.e5.int
        case .c5: return Space.a4.int | Space.a6.int | Space.b3.int | Space.b7.int | Space.d3.int | Space.d7.int | Space.e4.int | Space.e6.int
        case .c6: return Space.a5.int | Space.a7.int | Space.b4.int | Space.b8.int | Space.d4.int | Space.d8.int | Space.e6.int | Space.e7.int
        case .c7: return Space.a6.int | Space.a8.int | Space.b5.int | Space.d5.int | Space.e6.int | Space.e8.int
        case .c8: return Space.a7.int | Space.b6.int | Space.d6.int | Space.e7.int
            
        case .d1: return Space.b2.int | Space.c3.int | Space.e3.int | Space.f2.int
        case .d2: return Space.b1.int | Space.b3.int | Space.c4.int | Space.e4.int | Space.f1.int | Space.f3.int
        case .d3: return Space.b2.int | Space.b4.int | Space.c1.int | Space.c5.int | Space.e1.int | Space.e5.int | Space.f2.int | Space.f4.int
        case .d4: return Space.b3.int | Space.b5.int | Space.c2.int | Space.c6.int | Space.e2.int | Space.e6.int | Space.f3.int | Space.f5.int
        case .d5: return Space.b4.int | Space.b6.int | Space.c3.int | Space.c7.int | Space.e3.int | Space.e7.int | Space.f4.int | Space.f6.int
        case .d6: return Space.b5.int | Space.b7.int | Space.c4.int | Space.c8.int | Space.e4.int | Space.e8.int | Space.f6.int | Space.f7.int
        case .d7: return Space.b6.int | Space.b8.int | Space.c5.int | Space.e5.int | Space.f6.int | Space.f8.int
        case .d8: return Space.b7.int | Space.c6.int | Space.e6.int | Space.f7.int
            
        case .e1: return Space.c2.int | Space.d3.int | Space.f3.int | Space.g2.int
        case .e2: return Space.c1.int | Space.c3.int | Space.d4.int | Space.f4.int | Space.g1.int | Space.g3.int
        case .e3: return Space.c2.int | Space.c4.int | Space.d1.int | Space.d5.int | Space.f1.int | Space.f5.int | Space.g2.int | Space.g4.int
        case .e4: return Space.c3.int | Space.c5.int | Space.d2.int | Space.d6.int | Space.f2.int | Space.f6.int | Space.g3.int | Space.g5.int
        case .e5: return Space.c4.int | Space.c6.int | Space.d3.int | Space.d7.int | Space.f3.int | Space.f7.int | Space.g4.int | Space.g6.int
        case .e6: return Space.c5.int | Space.c7.int | Space.d4.int | Space.d8.int | Space.f4.int | Space.f8.int | Space.g6.int | Space.g7.int
        case .e7: return Space.c6.int | Space.c8.int | Space.d5.int | Space.f5.int | Space.g6.int | Space.g8.int
        case .e8: return Space.c7.int | Space.d6.int | Space.f6.int | Space.g7.int
            
        case .f1: return Space.d2.int | Space.e3.int | Space.g3.int | Space.h2.int
        case .f2: return Space.d1.int | Space.d3.int | Space.e4.int | Space.g4.int | Space.g1.int | Space.h3.int
        case .f3: return Space.d2.int | Space.d4.int | Space.e1.int | Space.e5.int | Space.g1.int | Space.g5.int | Space.h2.int | Space.h4.int
        case .f4: return Space.d3.int | Space.d5.int | Space.e2.int | Space.e6.int | Space.g2.int | Space.g6.int | Space.h3.int | Space.h5.int
        case .f5: return Space.d4.int | Space.d6.int | Space.e3.int | Space.e7.int | Space.g3.int | Space.g7.int | Space.h4.int | Space.h6.int
        case .f6: return Space.d5.int | Space.d7.int | Space.e4.int | Space.e8.int | Space.g4.int | Space.g8.int | Space.h6.int | Space.h7.int
        case .f7: return Space.d6.int | Space.d8.int | Space.e5.int | Space.g5.int | Space.h6.int | Space.h8.int
        case .f8: return Space.d7.int | Space.e6.int | Space.g6.int | Space.h7.int
            
        case .g1: return Space.h3.int | Space.f3.int | Space.e2.int
        case .g2: return Space.h4.int | Space.f4.int | Space.e1.int | Space.e3.int
        case .g3: return Space.h1.int | Space.h5.int | Space.f1.int | Space.f5.int | Space.e2.int | Space.e4.int
        case .g4: return Space.h2.int | Space.h6.int | Space.f2.int | Space.f6.int | Space.e3.int | Space.e5.int
        case .g5: return Space.h3.int | Space.h7.int | Space.f3.int | Space.f7.int | Space.e4.int | Space.e6.int
        case .g6: return Space.h4.int | Space.h8.int | Space.f4.int | Space.f8.int | Space.e5.int | Space.e7.int
        case .g7: return Space.h5.int | Space.f5.int | Space.e6.int | Space.e8.int
        case .g8: return Space.h6.int | Space.f6.int | Space.e7.int
            
        case .h1: return Space.g3.int | Space.f2.int
        case .h2: return Space.g4.int | Space.f1.int | Space.f3.int
        case .h3: return Space.g5.int | Space.g1.int | Space.f4.int | Space.f2.int
        case .h4: return Space.g6.int | Space.g2.int | Space.f5.int | Space.f3.int
        case .h5: return Space.g7.int | Space.g3.int | Space.f6.int | Space.f4.int
        case .h6: return Space.g8.int | Space.g4.int | Space.f7.int | Space.f5.int
        case .h7: return Space.g5.int | Space.f8.int | Space.f6.int
        case .h8: return Space.g6.int | Space.f7.int
        }
    }
    
    var computedWhitePawnMoves: UInt64 {
        switch self {
        case .a1, .b1, .c1, .d1, .e1, .f1, .g1, .h1, .a8, .b8, .c8, .d8, .e8, .f8, .g8, .h8: return 0
            
        case .a2: return Space.a3.int | Space.a4.int                     | Space.b3.int
        case .b2: return Space.b3.int | Space.b4.int | Space.a3.int | Space.c3.int
        case .c2: return Space.c3.int | Space.c4.int | Space.b3.int | Space.d3.int
        case .d2: return Space.d3.int | Space.d4.int | Space.c3.int | Space.e3.int
        case .e2: return Space.e3.int | Space.e4.int | Space.d3.int | Space.f3.int
        case .f2: return Space.f3.int | Space.f4.int | Space.e3.int | Space.g3.int
        case .g2: return Space.g3.int | Space.g4.int | Space.f3.int | Space.h3.int
        case .h2: return Space.h3.int | Space.a4.int | Space.g3.int
            
        case .a3: return Space.a4.int                     | Space.b4.int
        case .b3: return Space.b4.int | Space.a4.int | Space.c4.int
        case .c3: return Space.c4.int | Space.b4.int | Space.d4.int
        case .d3: return Space.d4.int | Space.c4.int | Space.e4.int
        case .e3: return Space.e4.int | Space.d4.int | Space.f4.int
        case .f3: return Space.f4.int | Space.e4.int | Space.g4.int
        case .g3: return Space.g4.int | Space.f4.int | Space.h4.int
        case .h3: return Space.h4.int | Space.g4.int
            
        case .a4: return Space.a5.int                     | Space.b5.int
        case .b4: return Space.b5.int | Space.a5.int | Space.c5.int
        case .c4: return Space.c5.int | Space.b5.int | Space.d5.int
        case .d4: return Space.d5.int | Space.c5.int | Space.e5.int
        case .e4: return Space.e5.int | Space.d5.int | Space.f5.int
        case .f4: return Space.f5.int | Space.e5.int | Space.g5.int
        case .g4: return Space.g5.int | Space.f5.int | Space.h5.int
        case .h4: return Space.h5.int | Space.g5.int
            
        case .a5: return Space.a6.int                     | Space.b6.int
        case .b5: return Space.b6.int | Space.a6.int | Space.c6.int
        case .c5: return Space.c6.int | Space.b6.int | Space.d6.int
        case .d5: return Space.d6.int | Space.c6.int | Space.e6.int
        case .e5: return Space.e6.int | Space.d6.int | Space.f6.int
        case .f5: return Space.f6.int | Space.e6.int | Space.g6.int
        case .g5: return Space.g6.int | Space.f6.int | Space.h6.int
        case .h5: return Space.h6.int | Space.g6.int
            
        case .a6: return Space.a7.int                     | Space.b7.int
        case .b6: return Space.b7.int | Space.a7.int | Space.c7.int
        case .c6: return Space.c7.int | Space.b7.int | Space.d7.int
        case .d6: return Space.d7.int | Space.c7.int | Space.e7.int
        case .e6: return Space.e7.int | Space.d7.int | Space.f7.int
        case .f6: return Space.f7.int | Space.e7.int | Space.g7.int
        case .g6: return Space.g7.int | Space.f7.int | Space.h7.int
        case .h6: return Space.h7.int | Space.g7.int
            
        case .a7: return Space.a8.int                     | Space.b8.int
        case .b7: return Space.b8.int | Space.a8.int | Space.c8.int
        case .c7: return Space.c8.int | Space.b8.int | Space.d8.int
        case .d7: return Space.d8.int | Space.c8.int | Space.e8.int
        case .e7: return Space.e8.int  | Space.d8.int  | Space.f8.int
        case .f7: return Space.f8.int  | Space.e8.int  | Space.g8.int
        case .g7: return Space.g8.int  | Space.f8.int  | Space.h8.int
        case .h7: return Space.h8.int  | Space.g8.int
        }
    }
    
    var computedBlackPawnMoves: UInt64 {
        switch self {
        case .a1, .b1, .c1, .d1, .e1, .f1, .g1, .h1, .a8, .b8, .c8, .d8, .e8, .f8, .g8, .h8: return 0
            
        case .a2: return Space.a1.int                      | Space.b1.int
        case .b2: return Space.b1.int  | Space.a1.int  | Space.c1.int
        case .c2: return Space.c1.int  | Space.b1.int  | Space.d1.int
        case .d2: return Space.d1.int  | Space.c1.int  | Space.e1.int
        case .e2: return Space.e1.int  | Space.d1.int  | Space.f1.int
        case .f2: return Space.f1.int  | Space.e1.int  | Space.g1.int
        case .g2: return Space.g1.int  | Space.f1.int  | Space.h1.int
        case .h2: return Space.h1.int  | Space.g1.int
            
        case .a3: return Space.a2.int                      | Space.b2.int
        case .b3: return Space.b2.int  | Space.a2.int  | Space.c2.int
        case .c3: return Space.c2.int  | Space.b2.int  | Space.d2.int
        case .d3: return Space.d2.int  | Space.c2.int  | Space.e2.int
        case .e3: return Space.e2.int  | Space.d2.int  | Space.f2.int
        case .f3: return Space.f2.int  | Space.e2.int  | Space.g2.int
        case .g3: return Space.g2.int  | Space.f2.int  | Space.h2.int
        case .h3: return Space.h2.int  | Space.g2.int
            
        case .a4: return Space.a3.int                      | Space.b3.int
        case .b4: return Space.b3.int  | Space.a3.int  | Space.c3.int
        case .c4: return Space.c3.int  | Space.b3.int  | Space.d3.int
        case .d4: return Space.d3.int  | Space.c3.int  | Space.e3.int
        case .e4: return Space.e3.int  | Space.d3.int  | Space.f3.int
        case .f4: return Space.f3.int  | Space.e3.int  | Space.g3.int
        case .g4: return Space.g3.int  | Space.f3.int  | Space.h3.int
        case .h4: return Space.h3.int  | Space.g3.int
            
        case .a5: return Space.a4.int                      | Space.b4.int
        case .b5: return Space.b4.int  | Space.a4.int  | Space.c4.int
        case .c5: return Space.c4.int  | Space.b4.int  | Space.d4.int
        case .d5: return Space.d4.int  | Space.c4.int  | Space.e4.int
        case .e5: return Space.e4.int  | Space.d4.int  | Space.f4.int
        case .f5: return Space.f4.int  | Space.e4.int  | Space.g4.int
        case .g5: return Space.g4.int  | Space.f4.int  | Space.h4.int
        case .h5: return Space.h4.int  | Space.g4.int
            
        case .a6: return Space.a5.int                      | Space.b5.int
        case .b6: return Space.b5.int  | Space.a5.int  | Space.c5.int
        case .c6: return Space.c5.int  | Space.b5.int  | Space.d5.int
        case .d6: return Space.d5.int  | Space.c5.int  | Space.e5.int
        case .e6: return Space.e5.int  | Space.d5.int  | Space.f5.int
        case .f6: return Space.f5.int  | Space.e5.int  | Space.g5.int
        case .g6: return Space.g5.int  | Space.f5.int  | Space.h5.int
        case .h6: return Space.h5.int  | Space.g5.int
            
        case .a7: return Space.a6.int  | Space.a5.int                      | Space.b6.int
        case .b7: return Space.b6.int  | Space.b5.int  | Space.a6.int  | Space.c6.int
        case .c7: return Space.c6.int  | Space.c5.int  | Space.b6.int  | Space.d6.int
        case .d7: return Space.d6.int  | Space.d5.int  | Space.c6.int  | Space.e6.int
        case .e7: return Space.e6.int  | Space.e5.int  | Space.d6.int  | Space.f6.int
        case .f7: return Space.f6.int  | Space.f5.int  | Space.e6.int  | Space.g6.int
        case .g7: return Space.g6.int  | Space.g5.int  | Space.f6.int  | Space.h6.int
        case .h7: return Space.h6.int  | Space.a5.int  | Space.g6.int
        }
    }
    
    var computedRookMoves: UInt64 {
        return self.rank.computedSpaces | self.file.computedSpaces
    }
    
    var computedQueenMoves: UInt64 {
        return computedRookMoves | computedDiagonals
    }
}

//func printSpace(space: Space) {
//    let name = String(describing: space)
//    print("case .\(name): return \(space.computedRookMoves)")
//}
//
//let a = [Space.a1, .a2, .a3, .a4, .a5, .a6, .a7, .a8]
//let b = [Space.b1, .b2, .b3, .b4, .b5, .b6, .b7, .b8]
//let c = [Space.c1, .c2, .c3, .c4, .c5, .c6, .c7, .c8]
//let d = [Space.d1, .d2, .d3, .d4, .d5, .d6, .d7, .d8]
//let e = [Space.e1, .e2, .e3, .e4, .e5, .e6, .e7, .e8]
//let f = [Space.f1, .f2, .f3, .f4, .f5, .f6, .f7, .f8]
//let g = [Space.g1, .g2, .g3, .g4, .g5, .g6, .g7, .g8]
//let h = [Space.h1, .h2, .h3, .h4, .h5, .h6, .h7, .h8]
//
//print ("swift self {")
//a.forEach { printSpace(space: $0) }
//b.forEach { printSpace(space: $0) }
//c.forEach { printSpace(space: $0) }
//d.forEach { printSpace(space: $0) }
//e.forEach { printSpace(space: $0) }
//f.forEach { printSpace(space: $0) }
//g.forEach { printSpace(space: $0) }
//h.forEach { printSpace(space: $0) }
//print ("}")
