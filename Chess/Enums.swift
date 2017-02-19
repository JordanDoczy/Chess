////
////  Enums.swift
////  Chess
////
////  Created by Jordan Doczy on 11/24/16.
////  Copyright © 2016 Jordan Doczy. All rights reserved.
////

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
        case .a: return 255
        case .b: return 65280
        case .c: return 16711680
        case .d: return 4278190080
        case .e: return 1095216660480
        case .f: return 280375465082880
        case .g: return 71776119061217280
        case .h: return 18374686479671623680
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
    
    var spaces: UInt64 {
        switch self {
        case ._1: return 72340172838076673
        case ._2: return 144680345676153346
        case ._3: return 289360691352306692
        case ._4: return 578721382704613384
        case ._5: return 1157442765409226768
        case ._6: return 2314885530818453536
        case ._7: return 4629771061636907072
        case ._8: return 9259542123273814144
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

enum Diagonal: UInt64 {
    
    case a1h8 = 9241421688590303745
    case b1h7 = 4620710844295151872
    case b1a2 = 258
    case b8a7 = 32832
    case b8h2 = 145249953336295424
    case c1h6 = 2310355422147575808
    case c1a3 = 66052
    case c8a6 = 8405024
    case c8h3 = 290499906672525312
    case d1h5 = 1155177711073755136
    case d1a4 = 16909320
    case d8a5 = 2151686160
    case d8h4 = 580999813328273408
    case e1h4 = 577588855528488960
    case e1a5 = 4328785936
    case e8a4 = 550831656968
    case e8h5 = 1161999622361579520
    case f1h3 = 288794425616760832
    case f1a6 = 1108169199648
    case f8a3 = 141012904183812
    case f8h6 = 2323998145211531264
    case g1h2 = 144396663052566528
    case g1a7 = 283691315109952
    case g8a2 = 36099303471055874
    case g8h7 = 4647714815446351872
    case h1a8 = 72624976668147840
    
    var spaces: UInt64 {
        return rawValue
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
    
    var int: UInt64 {
        return rawValue
    }
    
    var diagonals: UInt64 {
        switch self {
        case .a1: return 9241421688590303745
        case .a2: return 36099303471056130
        case .a3: return 141012904249860
        case .a4: return 550848566280
        case .a5: return 6480472080
        case .a6: return 1108177604640
        case .a7: return 283691315142720
        case .a8: return 72624976668147840
            
        case .b1: return 4620710844295151874
        case .b2: return 9241421688590369285
        case .b3: return 36099303487964170
        case .b4: return 141017232967700
        case .b5: return 1659000852520
        case .b6: return 283693466787920
        case .b7: return 72624976676536480
        case .b8: return 145249953336295488
            
        case .c1: return 2310355422147576324
        case .c2: return 4620710844311930120
        case .c3: return 9241421692918827537
        case .c4: return 36100411639731234
        case .c5: return 424704218245188
        case .c6: return 72625527497707656
        case .c7: return 145249955483787280
        case .c8: return 290499906672541728
            
        case .d1: return 1155177711073887240
        case .d2: return 2310355426442807312
        case .d3: return 4620711952397242656
        case .d4: return 9241705379771195969
        case .d5: return 108724279870768258
        case .d6: return 145390965703608324
        case .d7: return 290500456430440456
        case .d8: return 580999813332475920
            
        case .e1: return 577588855562307600
        case .e2: return 1155178810653020192
        case .e3: return 2310639096282816576
        case .e4: return 4693335786603561344
        case .e5: return 9386671573207122433
        case .e6: return 326599072704627714
        case .e7: return 581140551354550276
        case .e8: return 1161999623437422600
            
        case .f1: return 288794434274332704
        case .f2: return 577870347820343360
        case .f3: return 1227798289695391872
        case .f4: return 2455596579390849024
        case .f5: return 4911193158781632768
        case .f6: return 9822386317546488321
        case .f7: return 1198028557088457730
        case .f8: return 2323998420627359748
            
        case .g1: return 144398879390965824
        case .g2: return 360856452331487360
        case .g3: return 721712908957941760
        case .g4: return 1443425817932595200
        case .g5: return 2886851635848478720
        case .g6: return 5773703267401990400
        case .g7: return 11547405435292353025
        case .g8: return 4647785321898443778
            
        case .h1: return 72624976668147840
        case .h2: return 145531428313006080
        case .h3: return 291063956137574400
        case .h4: return 582127916553338880
        case .h5: return 1164255828828487680
        case .h6: return 2328510558145413120
        case .h7: return 4656739641314115840
        case .h8: return 9241421688590303745
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
        case .a1: return 132096
        case .a2: return 329728
        case .a3: return 659712
        case .a4: return 1319424
        case .a5: return 2638848
        case .a6: return 5277696
        case .a7: return 10489856
        case .a8: return 4202496
            
        case .b1: return 33816580
        case .b2: return 84410376
        case .b3: return 168886289
        case .b4: return 337772578
        case .b5: return 675545156
        case .b6: return 1351090312
        case .b7: return 2685403152
        case .b8: return 1075839008
            
        case .c1: return 8657044482
        case .c2: return 21609056261
        case .c3: return 43234889994
        case .c4: return 86469779988
        case .c5: return 172939559976
        case .c6: return 414598596688
        case .c7: return 687463207072
        case .c8: return 275414786112
            
        case .d1: return 2216203387392
        case .d2: return 5531918402816
        case .d3: return 11068131838464
        case .d4: return 22136263676928
        case .d5: return 44272527353856
        case .d6: return 106137240752128
        case .d7: return 175990581010432
        case .d8: return 70506185244672
            
        case .e1: return 567348067172352
        case .e2: return 1416171111120896
        case .e3: return 2833441750646784
        case .e4: return 5666883501293568
        case .e5: return 11333767002587136
        case .e6: return 27171133632544768
        case .e7: return 45053588738670592
        case .e8: return 18049583422636032
            
        case .f1: return 145241105196122112
        case .f2: return 290763685385732096
        case .f3: return 725361088165576704
        case .f4: return 1450722176331153408
        case .f5: return 2901444352662306816
        case .f6: return 6955810209931460608
        case .f7: return 11533718717099671552
        case .f8: return 4620693356194824192
            
        case .g1: return 288234782788157440
        case .g2: return 576469569871282176
        case .g3: return 1224997833292120064
        case .g4: return 2449995666584240128
        case .g5: return 4899991333168480256
        case .g6: return 9799982666336960512
        case .g7: return 1152939783987658752
        case .g8: return 2305878468463689728
            
        case .h1: return 1128098930098176
        case .h2: return 2257297371824128
        case .h3: return 4796069720358912
        case .h4: return 9592139440717824
        case .h5: return 19184278881435648
        case .h6: return 38368557762871296
        case .h7: return 4679521487814656
        case .h8: return 9077567998918656
        }
    }
    
    var adjacentSpaces: UInt64 {
        switch self {
        case .a1: return 770
        case .a2: return 1797
        case .a3: return 3594
        case .a4: return 7188
        case .a5: return 14376
        case .a6: return 28752
        case .a7: return 57504
        case .a8: return 49216
            
        case .b1: return 197123
        case .b2: return 460039
        case .b3: return 920078
        case .b4: return 1840156
        case .b5: return 3680312
        case .b6: return 7360624
        case .b7: return 14721248
        case .b8: return 12599488
            
        case .c1: return 50463488
        case .c2: return 117769984
        case .c3: return 235539968
        case .c4: return 471079936
        case .c5: return 942159872
        case .c6: return 1884319744
        case .c7: return 3768639488
        case .c8: return 3225468928
            
        case .d1: return 12918652928
        case .d2: return 30149115904
        case .d3: return 60298231808
        case .d4: return 120596463616
        case .d5: return 241192927232
        case .d6: return 482385854464
        case .d7: return 964771708928
        case .d8: return 825720045568
            
        case .e1: return 3307175149568
        case .e2: return 7718173671424
        case .e3: return 15436347342848
        case .e4: return 30872694685696
        case .e5: return 61745389371392
        case .e6: return 123490778742784
        case .e7: return 246981557485568
        case .e8: return 211384331665408
            
        case .f1: return 846636838289408
        case .f2: return 1975852459884544
        case .f3: return 3951704919769088
        case .f4: return 7903409839538176
        case .f5: return 15806819679076352
        case .f6: return 31613639358152704
        case .f7: return 63227278716305408
        case .f8: return 54114388906344448
            
        case .g1: return 216739030602088448
        case .g2: return 505818229730443264
        case .g3: return 1011636459460886528
        case .g4: return 2023272918921773056
        case .g5: return 4046545837843546112
        case .g6: return 8093091675687092224
        case .g7: return 16186183351374184448
        case .g8: return 13853283560024178688
            
        case .h1: return 144959613005987840
        case .h2: return 362258295026614272
        case .h3: return 724516590053228544
        case .h4: return 1449033180106457088
        case .h5: return 2898066360212914176
        case .h6: return 5796132720425828352
        case .h7: return 11592265440851656704
        case .h8: return 4665729213955833856
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

extension Rank {
    var computedSpaces: UInt64{
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
}

extension File {
    var computedSpaces: UInt64 {
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
}

extension Diagonal {
    var computedSpaces: UInt64 {
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

extension Space {
    
    var computedAdjacentSpaces: UInt64 {
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
    
    var calculatedWhitePawnMoves: UInt64 {
        switch self {
        case .a1, .b1, .c1, .d1, .e1, .f1, .g1, .h1, .a8, .b8, .c8, .d8, .e8, .f8, .g8, .h8: return 0

        case .a2: return Space.a3.rawValue | Space.a4.rawValue                     | Space.b3.rawValue
        case .b2: return Space.b3.rawValue | Space.b4.rawValue | Space.a3.rawValue | Space.c3.rawValue
        case .c2: return Space.c3.rawValue | Space.c4.rawValue | Space.b3.rawValue | Space.d3.rawValue
        case .d2: return Space.d3.rawValue | Space.d4.rawValue | Space.c3.rawValue | Space.e3.rawValue
        case .e2: return Space.e3.rawValue | Space.e4.rawValue | Space.d3.rawValue | Space.f3.rawValue
        case .f2: return Space.f3.rawValue | Space.f4.rawValue | Space.e3.rawValue | Space.g3.rawValue
        case .g2: return Space.g3.rawValue | Space.g4.rawValue | Space.f3.rawValue | Space.h3.rawValue
        case .h2: return Space.h3.rawValue | Space.a4.rawValue | Space.g3.rawValue

        case .a3: return Space.a4.rawValue                     | Space.b4.rawValue
        case .b3: return Space.b4.rawValue | Space.a4.rawValue | Space.c4.rawValue
        case .c3: return Space.c4.rawValue | Space.b4.rawValue | Space.d4.rawValue
        case .d3: return Space.d4.rawValue | Space.c4.rawValue | Space.e4.rawValue
        case .e3: return Space.e4.rawValue | Space.d4.rawValue | Space.f4.rawValue
        case .f3: return Space.f4.rawValue | Space.e4.rawValue | Space.g4.rawValue
        case .g3: return Space.g4.rawValue | Space.f4.rawValue | Space.h4.rawValue
        case .h3: return Space.h4.rawValue | Space.g4.rawValue

        case .a4: return Space.a5.rawValue                     | Space.b5.rawValue
        case .b4: return Space.b5.rawValue | Space.a5.rawValue | Space.c5.rawValue
        case .c4: return Space.c5.rawValue | Space.b5.rawValue | Space.d5.rawValue
        case .d4: return Space.d5.rawValue | Space.c5.rawValue | Space.e5.rawValue
        case .e4: return Space.e5.rawValue | Space.d5.rawValue | Space.f5.rawValue
        case .f4: return Space.f5.rawValue | Space.e5.rawValue | Space.g5.rawValue
        case .g4: return Space.g5.rawValue | Space.f5.rawValue | Space.h5.rawValue
        case .h4: return Space.h5.rawValue | Space.g5.rawValue

        case .a5: return Space.a6.rawValue                     | Space.b6.rawValue
        case .b5: return Space.b6.rawValue | Space.a6.rawValue | Space.c6.rawValue
        case .c5: return Space.c6.rawValue | Space.b6.rawValue | Space.d6.rawValue
        case .d5: return Space.d6.rawValue | Space.c6.rawValue | Space.e6.rawValue
        case .e5: return Space.e6.rawValue | Space.d6.rawValue | Space.f6.rawValue
        case .f5: return Space.f6.rawValue | Space.e6.rawValue | Space.g6.rawValue
        case .g5: return Space.g6.rawValue | Space.f6.rawValue | Space.h6.rawValue
        case .h5: return Space.h6.rawValue | Space.g6.rawValue

        case .a6: return Space.a7.rawValue                     | Space.b7.rawValue
        case .b6: return Space.b7.rawValue | Space.a7.rawValue | Space.c7.rawValue
        case .c6: return Space.c7.rawValue | Space.b7.rawValue | Space.d7.rawValue
        case .d6: return Space.d7.rawValue | Space.c7.rawValue | Space.e7.rawValue
        case .e6: return Space.e7.rawValue | Space.d7.rawValue | Space.f7.rawValue
        case .f6: return Space.f7.rawValue | Space.e7.rawValue | Space.g7.rawValue
        case .g6: return Space.g7.rawValue | Space.f7.rawValue | Space.h7.rawValue
        case .h6: return Space.h7.rawValue | Space.g7.rawValue

        case .a7: return Space.a8.rawValue                     | Space.b8.rawValue
        case .b7: return Space.b8.rawValue | Space.a8.rawValue | Space.c8.rawValue
        case .c7: return Space.c8.rawValue | Space.b8.rawValue | Space.d8.rawValue
        case .d7: return Space.d8.rawValue | Space.c8.rawValue | Space.e8.rawValue
        case .e7: return Space.e8.rawValue | Space.d8.rawValue | Space.f8.rawValue
        case .f7: return Space.f8.rawValue | Space.e8.rawValue | Space.g8.rawValue
        case .g7: return Space.g8.rawValue | Space.f8.rawValue | Space.h8.rawValue
        case .h7: return Space.h8.rawValue | Space.g8.rawValue
        }
    }
    
    var calculatedBlackawnMoves: UInt64 {
        switch self {
        case .a1, .b1, .c1, .d1, .e1, .f1, .g1, .h1, .a8, .b8, .c8, .d8, .e8, .f8, .g8, .h8: return 0
            
        case .a2: return Space.a1.rawValue                     | Space.b1.rawValue
        case .b2: return Space.b1.rawValue | Space.a1.rawValue | Space.c1.rawValue
        case .c2: return Space.c1.rawValue | Space.b1.rawValue | Space.d1.rawValue
        case .d2: return Space.d1.rawValue | Space.c1.rawValue | Space.e1.rawValue
        case .e2: return Space.e1.rawValue | Space.d1.rawValue | Space.f1.rawValue
        case .f2: return Space.f1.rawValue | Space.e1.rawValue | Space.g1.rawValue
        case .g2: return Space.g1.rawValue | Space.f1.rawValue | Space.h1.rawValue
        case .h2: return Space.h1.rawValue | Space.g1.rawValue
            
        case .a3: return Space.a2.rawValue                     | Space.b2.rawValue
        case .b3: return Space.b2.rawValue | Space.a2.rawValue | Space.c2.rawValue
        case .c3: return Space.c2.rawValue | Space.b2.rawValue | Space.d2.rawValue
        case .d3: return Space.d2.rawValue | Space.c2.rawValue | Space.e2.rawValue
        case .e3: return Space.e2.rawValue | Space.d2.rawValue | Space.f2.rawValue
        case .f3: return Space.f2.rawValue | Space.e2.rawValue | Space.g2.rawValue
        case .g3: return Space.g2.rawValue | Space.f2.rawValue | Space.h2.rawValue
        case .h3: return Space.h2.rawValue | Space.g2.rawValue
            
        case .a4: return Space.a3.rawValue                     | Space.b3.rawValue
        case .b4: return Space.b3.rawValue | Space.a3.rawValue | Space.c3.rawValue
        case .c4: return Space.c3.rawValue | Space.b3.rawValue | Space.d3.rawValue
        case .d4: return Space.d3.rawValue | Space.c3.rawValue | Space.e3.rawValue
        case .e4: return Space.e3.rawValue | Space.d3.rawValue | Space.f3.rawValue
        case .f4: return Space.f3.rawValue | Space.e3.rawValue | Space.g3.rawValue
        case .g4: return Space.g3.rawValue | Space.f3.rawValue | Space.h3.rawValue
        case .h4: return Space.h3.rawValue | Space.g3.rawValue
            
        case .a5: return Space.a4.rawValue                     | Space.b4.rawValue
        case .b5: return Space.b4.rawValue | Space.a4.rawValue | Space.c4.rawValue
        case .c5: return Space.c4.rawValue | Space.b4.rawValue | Space.d4.rawValue
        case .d5: return Space.d4.rawValue | Space.c4.rawValue | Space.e4.rawValue
        case .e5: return Space.e4.rawValue | Space.d4.rawValue | Space.f4.rawValue
        case .f5: return Space.f4.rawValue | Space.e4.rawValue | Space.g4.rawValue
        case .g5: return Space.g4.rawValue | Space.f4.rawValue | Space.h4.rawValue
        case .h5: return Space.h4.rawValue | Space.g4.rawValue
            
        case .a6: return Space.a5.rawValue                     | Space.b5.rawValue
        case .b6: return Space.b5.rawValue | Space.a5.rawValue | Space.c5.rawValue
        case .c6: return Space.c5.rawValue | Space.b5.rawValue | Space.d5.rawValue
        case .d6: return Space.d5.rawValue | Space.c5.rawValue | Space.e5.rawValue
        case .e6: return Space.e5.rawValue | Space.d5.rawValue | Space.f5.rawValue
        case .f6: return Space.f5.rawValue | Space.e5.rawValue | Space.g5.rawValue
        case .g6: return Space.g5.rawValue | Space.f5.rawValue | Space.h5.rawValue
        case .h6: return Space.h5.rawValue | Space.g5.rawValue
            
        case .a7: return Space.a6.rawValue | Space.a5.rawValue                     | Space.b6.rawValue
        case .b7: return Space.b6.rawValue | Space.b5.rawValue | Space.a6.rawValue | Space.c6.rawValue
        case .c7: return Space.c6.rawValue | Space.c5.rawValue | Space.b6.rawValue | Space.d6.rawValue
        case .d7: return Space.d6.rawValue | Space.d5.rawValue | Space.c6.rawValue | Space.e6.rawValue
        case .e7: return Space.e6.rawValue | Space.e5.rawValue | Space.d6.rawValue | Space.f6.rawValue
        case .f7: return Space.f6.rawValue | Space.f5.rawValue | Space.e6.rawValue | Space.g6.rawValue
        case .g7: return Space.g6.rawValue | Space.g5.rawValue | Space.f6.rawValue | Space.h6.rawValue
        case .h7: return Space.h6.rawValue | Space.a5.rawValue | Space.g6.rawValue
        }
    }
}


















