//
//  ViewController.swift
//  Chess
//
//  Created by Jordan Doczy on 11/12/16.
//  Copyright © 2016 Jordan Doczy. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func onRunTestPressed(_ sender: UIButton) {

        testSpeed()
        
//        let start = Date()
//        let fen = "rnbqk2r/pppp1ppp/5n2/8/1Q2P3/2N5/PPP2PPP/R1B1KBNR b KQkq - 0 6"
//        let board = Fen.createBoard(from: fen)!
//        let count = testRecursiveCall(board: board, remaingingCalls: 2)
//        let end = Date()
//        print(count, end.timeIntervalSince(start))
    }
    
    func testRecursiveCall(board: Board, remaingingCalls: Int) -> Int {
        let validMoves = board.getValidMoves()
        var count = validMoves.count
        
        guard remaingingCalls > 0 else {
            return count
        }
        
        for _ in validMoves {
            count += testRecursiveCall(board: board, remaingingCalls: remaingingCalls-1)
        }
        
        return count
    }
    
    func testSpeed() {
        let start = Date()
        let fen = "rnbqk2r/pppp1ppp/5n2/8/1Q2P3/2N5/PPP2PPP/R1B1KBNR b KQkq - 0 6"
        let board = Fen.createBoard(from: fen)!
        let iterations = 10000 // 10k

        var count = 0
        for _ in 0 ..< iterations {
            count += board.getValidMoves().count
        }
        
        
        let end = Date()
        print(count, end.timeIntervalSince(start))
    }
    
    func playGame() {
        let board = Fen.createBoard()
        var validMoves = board.getValidMoves()
        while validMoves.isEmpty == false {
            let start = Date()
            board.computerMove()
            let end = Date()
            print(end.timeIntervalSince(start))
            //board.printBoard()
            print("move:", board.fullMove, board.halfMove)
            validMoves = board.getValidMoves()
            
            guard board.fullMove < 2000 else {
                return
            }
        }
        
        print("isCheckmate?", board.isCheckmate())
        board.printBoard()
    }
}
