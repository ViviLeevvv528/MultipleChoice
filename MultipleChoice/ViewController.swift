//
//  ViewController.swift
//  MultipleChoice
//
//  Created by Vivi Lee on 2021/1/9.
//

import UIKit
import CodableCSV
struct Psytest: Codable {
    let question: String
    let answer: [String]
    let score: [String]
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        question = try container.decode(String.self, forKey: .question)
        let answerString = try container.decode(String.self, forKey: .answer)
        answer = answerString.components(separatedBy: ",")
        let scoreString = try container.decode(String.self, forKey: .score)
        score = scoreString.components(separatedBy: ",")
        }
        
    }
extension Psytest {
    static var data: [Self] {
        var array = [Self]()
        if let data = NSDataAsset(name: "psytests")?.data {
            let decoder = CSVDecoder {
                $0.headerStrategy = .firstLine
            }
            do {
                array = try decoder.decode([Self].self, from: data)
            } catch {
                print(error)
            }
        }
        return array
    }
}

class ViewController: UIViewController {
    var psytests = Psytest.data
    var index = 0
    var quizs = ""
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet var answerTables: [UIButton]!
    @IBOutlet weak var resultLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func startBtn(_ sender: Any) {
        questionLabel.text = psytests[0].question

    }
    
    @IBAction func answerBtns(_ sender: UIButton) {
    }
    
    @IBAction func resultBtn(_ sender: Any) {
    }
}

