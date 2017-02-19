////
////  Enums.swift
////  Chess
////
////  Created by Jordan Doczy on 11/24/16.
////  Copyright © 2016 Jordan Doczy. All rights reserved.
////

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
    
    var color: Color {
        switch self {
        case .blackPawn, .blackKnight, .blackBishop, .blackRook, .blackQueen, .blackKing: return .black
        case .whitePawn, .whiteKnight, .whiteBishop, .whiteRook, .whiteQueen, .whiteKing: return .white
        }
    }
    
    var description: String {
        return rawValue
    }
    
    var symbol: String {
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
    
    var bishopMoves: UInt64 {
        return diagonals
    }
    
    var blackPawnMoves: UInt64 {
        switch self {
        case .a1: return 0
        case .a2: return 257
        case .a3: return 514
        case .a4: return 1028
        case .a5: return 2056
        case .a6: return 4112
        case .a7: return 8240
        case .a8: return 0
            
        case .b1: return 0
        case .b2: return 65793
        case .b3: return 131586
        case .b4: return 263172
        case .b5: return 526344
        case .b6: return 1052688
        case .b7: return 2109472
        case .b8: return 0
            
        case .c1: return 0
        case .c2: return 16843008
        case .c3: return 33686016
        case .c4: return 67372032
        case .c5: return 134744064
        case .c6: return 269488128
        case .c7: return 540024832
        case .c8: return 0
            
        case .d1: return 0
        case .d2: return 4311810048
        case .d3: return 8623620096
        case .d4: return 17247240192
        case .d5: return 34494480384
        case .d6: return 68988960768
        case .d7: return 138246356992
        case .d8: return 0
            
        case .e1: return 0
        case .e2: return 1103823372288
        case .e3: return 2207646744576
        case .e4: return 4415293489152
        case .e5: return 8830586978304
        case .e6: return 17661173956608
        case .e7: return 35391067389952
        case .e8: return 0
            
        case .f1: return 0
        case .f2: return 282578783305728
        case .f3: return 565157566611456
        case .f4: return 1130315133222912
        case .f5: return 2260630266445824
        case .f6: return 4521260532891648
        case .f7: return 9060113251827712
        case .f8: return 0
            
        case .g1: return 0
        case .g2: return 72340168526266368
        case .g3: return 144680337052532736
        case .g4: return 289360674105065472
        case .g5: return 578721348210130944
        case .g6: return 1157442696420261888
        case .g7: return 2319388992467894272
        case .g8: return 0
            
        case .h1: return 0
        case .h2: return 72339069014638592
        case .h3: return 144678138029277184
        case .h4: return 289356276058554368
        case .h5: return 578712552117108736
        case .h6: return 1157425104234217472
        case .h7: return 3467771713075281920
        case .h8: return 0
        }
    }
    
    var diagonals: UInt64 {
        switch self {
        case .a1: return 9241421688590303744
        case .a2: return 36099303471056128
        case .a3: return 141012904249856
        case .a4: return 550848566272
        case .a5: return 6480472064
        case .a6: return 1108177604608
        case .a7: return 283691315142656
        case .a8: return 72624976668147712
            
        case .b1: return 4620710844295151618
        case .b2: return 9241421688590368773
        case .b3: return 36099303487963146
        case .b4: return 141017232965652
        case .b5: return 1659000848424
        case .b6: return 283693466779728
        case .b7: return 72624976676520096
        case .b8: return 145249953336262720
            
        case .c1: return 2310355422147510788
        case .c2: return 4620710844311799048
        case .c3: return 9241421692918565393
        case .c4: return 36100411639206946
        case .c5: return 424704217196612
        case .c6: return 72625527495610504
        case .c7: return 145249955479592976
        case .c8: return 290499906664153120
            
        case .d1: return 1155177711057110024
        case .d2: return 2310355426409252880
        case .d3: return 4620711952330133792
        case .d4: return 9241705379636978241
        case .d5: return 108724279602332802
        case .d6: return 145390965166737412
        case .d7: return 290500455356698632
        case .d8: return 580999811184992272
            
        case .e1: return 577588851267340304
        case .e2: return 1155178802063085600
        case .e3: return 2310639079102947392
        case .e4: return 4693335752243822976
        case .e5: return 9386671504487645697
        case .e6: return 326598935265674242
        case .e7: return 581140276476643332
        case .e8: return 1161999073681608712
            
        case .f1: return 288793334762704928
        case .f2: return 577868148797087808
        case .f3: return 1227793891648880768
        case .f4: return 2455587783297826816
        case .f5: return 4911175566595588352
        case .f6: return 9822351133174399489
        case .f7: return 1197958188344280066
        case .f8: return 2323857683139004420
            
        case .g1: return 144117404414255168
        case .g2: return 360293502378066048
        case .g3: return 720587009051099136
        case .g4: return 1441174018118909952
        case .g5: return 2882348036221108224
        case .g6: return 5764696068147249408
        case .g7: return 11529391036782871041
        case .g8: return 4611756524879479810
            
        case .h1: return 567382630219904
        case .h2: return 1416240237150208
        case .h3: return 2833579985862656
        case .h4: return 5667164249915392
        case .h5: return 11334324221640704
        case .h6: return 22667548931719168
        case .h7: return 45053622886727936
        case .h8: return 18049651735527937
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
    
    var kingMoves: UInt64 {
        return adjacentSpaces
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
        case .c6: return 345879119952
        case .c7: return 687463207072
        case .c8: return 275414786112
            
        case .d1: return 2216203387392
        case .d2: return 5531918402816
        case .d3: return 11068131838464
        case .d4: return 22136263676928
        case .d5: return 44272527353856
        case .d6: return 88545054707712
        case .d7: return 175990581010432
        case .d8: return 70506185244672
            
        case .e1: return 567348067172352
        case .e2: return 1416171111120896
        case .e3: return 2833441750646784
        case .e4: return 5666883501293568
        case .e5: return 11333767002587136
        case .e6: return 22667534005174272
        case .e7: return 45053588738670592
        case .e8: return 18049583422636032
            
        case .f1: return 145241105196122112
        case .f2: return 362539804446949376
        case .f3: return 725361088165576704
        case .f4: return 1450722176331153408
        case .f5: return 2901444352662306816
        case .f6: return 5802888705324613632
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
    
    var queenMoves: UInt64 {
        switch self {
        case .a1: return 9313761861428380670
        case .a2: return 180779649147209725
        case .a3: return 289501704256556795
        case .a4: return 578721933553179895
        case .a5: return 1157442771889699055
        case .a6: return 2314886638996058335
        case .a7: return 4630054752952049855
        case .a8: return 9332167099941961855
            
        case .b1: return 4693051017133293059
        case .b2: return 9386102034266586375
        case .b3: return 325459994840333070
        case .b4: return 578862399937640220
        case .b5: return 1157444424410132280
        case .b6: return 2315169224285282160
        case .b7: return 4702396038313459680
        case .b8: return 9404792076610076608
            
        case .c1: return 2382695595002168069
        case .c2: return 4765391190004401930
        case .c3: return 9530782384287059477
        case .c4: return 614821794359483434
        case .c5: return 1157867469641037908
        case .c6: return 2387511058326581416
        case .c7: return 4775021017124823120
        case .c8: return 9550042029937901728
            
        case .d1: return 1227517888139822345
        case .d2: return 2455035776296487442
        case .d3: return 4910072647826412836
        case .d4: return 9820426766351346249
        case .d5: return 1266167048752878738
        case .d6: return 2460276499189639204
        case .d7: return 4920271519124312136
        case .d8: return 9840541934442029200
            
        case .e1: return 649930110732142865
        case .e2: return 1299860225776030242
        case .e3: return 2600000831312176196
        case .e4: return 5272058161445620104
        case .e5: return 10544115227674579473
        case .e6: return 2641485286422881314
        case .e7: return 5210911883574396996
        case .e8: return 10421541192660455560
            
        case .f1: return 361411684042608929
        case .f2: return 722824471891812930
        case .f3: return 1517426162373248132
        case .f4: return 3034571949281478664
        case .f5: return 6068863523097809168
        case .f6: return 12137446670713758241
        case .f7: return 5827868887957914690
        case .f8: return 11583398706901190788
            
        case .g1: return 287670746360127809
        case .g2: return 575624067208594050
        case .g3: return 1079472019650937860
        case .g4: return 2087167920257370120
        case .g5: return 4102559721436811280
        case .g6: return 8133343319517438240
        case .g7: return 16194909420462031425
        case .g8: return 13871017173176583298
            
        case .h1: return 18303478847064064385
        case .h2: return 18232552689433215490
        case .h3: return 18090419998706369540
        case .h4: return 17806153522019305480
        case .h5: return 17237620560088797200
        case .h6: return 16100553540994408480
        case .h7: return 13826139127340482880
        case .h8: return 9205534180971414145
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
    
    var rookMoves: UInt64 {
        switch self {
        case .a1: return 72340172838076926
        case .a2: return 144680345676153597
        case .a3: return 289360691352306939
        case .a4: return 578721382704613623
        case .a5: return 1157442765409226991
        case .a6: return 2314885530818453727
        case .a7: return 4629771061636907199
        case .a8: return 9259542123273814143
            
        case .b1: return 72340172838141441
        case .b2: return 144680345676217602
        case .b3: return 289360691352369924
        case .b4: return 578721382704674568
        case .b5: return 1157442765409283856
        case .b6: return 2314885530818502432
        case .b7: return 4629771061636939584
        case .b8: return 9259542123273813888
            
        case .c1: return 72340172854657281
        case .c2: return 144680345692602882
        case .c3: return 289360691368494084
        case .c4: return 578721382720276488
        case .c5: return 1157442765423841296
        case .c6: return 2314885530830970912
        case .c7: return 4629771061645230144
        case .c8: return 9259542123273748608
            
        case .d1: return 72340177082712321
        case .d2: return 144680349887234562
        case .d3: return 289360695496279044
        case .d4: return 578721386714368008
        case .d5: return 1157442769150545936
        case .d6: return 2314885534022901792
        case .d7: return 4629771063767613504
        case .d8: return 9259542123257036928
            
        case .e1: return 72341259464802561
        case .e2: return 144681423712944642
        case .e3: return 289361752209228804
        case .e4: return 578722409201797128
        case .e5: return 1157443723186933776
        case .e6: return 2314886351157207072
        case .e7: return 4629771607097753664
        case .e8: return 9259542118978846848
            
        case .f1: return 72618349279904001
        case .f2: return 144956323094725122
        case .f3: return 289632270724367364
        case .f4: return 578984165983651848
        case .f5: return 1157687956502220816
        case .f6: return 2315095537539358752
        case .f7: return 4629910699613634624
        case .f8: return 9259541023762186368
            
        case .g1: return 143553341945872641
        case .g2: return 215330564830528002
        case .g3: return 358885010599838724
        case .g4: return 645993902138460168
        case .g5: return 1220211685215703056
        case .g6: return 2368647251370188832
        case .g7: return 4665518383679160384
        case .g8: return 9259260648297103488
            
        case .h1: return 18302911464433844481
        case .h2: return 18231136449196065282
        case .h3: return 18087586418720506884
        case .h4: return 17800486357769390088
        case .h5: return 17226286235867156496
        case .h6: return 16077885992062689312
        case .h7: return 13781085504453754944
        case .h8: return 9187484529235886208
        }
    }
    
    var whitePawnMoves: UInt64 {
        switch self {
        case .a1: return 0
        case .a2: return 1036
        case .a3: return 2056
        case .a4: return 4112
        case .a5: return 8224
        case .a6: return 16448
        case .a7: return 32896
        case .a8: return 0
            
        case .b1: return 0
        case .b2: return 265220
        case .b3: return 526344
        case .b4: return 1052688
        case .b5: return 2105376
        case .b6: return 4210752
        case .b7: return 8421504
        case .b8: return 0
            
        case .c1: return 0
        case .c2: return 67896320
        case .c3: return 134744064
        case .c4: return 269488128
        case .c5: return 538976256
        case .c6: return 1077952512
        case .c7: return 2155905024
        case .c8: return 0
            
        case .d1: return 0
        case .d2: return 17381457920
        case .d3: return 34494480384
        case .d4: return 68988960768
        case .d5: return 137977921536
        case .d6: return 275955843072
        case .d7: return 551911686144
        case .d8: return 0
            
        case .e1: return 0
        case .e2: return 4449653227520
        case .e3: return 8830586978304
        case .e4: return 17661173956608
        case .e5: return 35322347913216
        case .e6: return 70644695826432
        case .e7: return 141289391652864
        case .e8: return 0
            
        case .f1: return 0
        case .f2: return 1139111226245120
        case .f3: return 2260630266445824
        case .f4: return 4521260532891648
        case .f5: return 9042521065783296
        case .f6: return 18085042131566592
        case .f7: return 36170084263133184
        case .f8: return 0
            
        case .g1: return 0
        case .g2: return 291612473918750720
        case .g3: return 578721348210130944
        case .g4: return 1157442696420261888
        case .g5: return 2314885392840523776
        case .g6: return 4629770785681047552
        case .g7: return 9259541571362095104
        case .g8: return 0
            
        case .h1: return 0
        case .h2: return 865817028361977856
        case .h3: return 578712552117108736
        case .h4: return 1157425104234217472
        case .h5: return 2314850208468434944
        case .h6: return 4629700416936869888
        case .h7: return 9259400833873739776
        case .h8: return 0
        }
    }
}
