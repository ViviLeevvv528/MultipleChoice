//
//  ViewController.swift
//  MultipleChoice
//
//  Created by Vivi Lee on 2021/1/9.
//

import UIKit
//匯入csv
import CodableCSV
//定義欄位
struct Psytest: Codable {
    let question: String
    let answer: [String]
    let score: [String]
//宣告使用多選項type定義欄位
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        question = try container.decode(String.self, forKey: .question)
        let answerString = try container.decode(String.self, forKey: .answer)
        answer = answerString.components(separatedBy: ",")
        let scoreString = try container.decode(String.self, forKey: .score)
        score = scoreString.components(separatedBy: ",")
        }

    }
//宣告使用csv產生的data array
extension Psytest {
    static var data: [Self] {
        var array = [Self]()
        if let data = NSDataAsset(name: "Psytests")?.data {
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
    
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet var answerTables: [UIButton]!
    @IBOutlet weak var resultLabel: UILabel!
    
    //    設定取用data
        var psytests = Psytest.data
    //    宣告index儲存目前題數
        var index = 0
//        var count = 1
        var quizs = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
 
    }
//    測驗的顯示動作
    func startTest(){
    if index < psytests.count - 1{
        index = index + 1
        questionLabel.text = psytests[index].question
        print(psytests[index].answer[index])
        for answer in psytests[index].answer{
            print(answer)
            answerTables.setTitle(answer, for: UIControl.State.normal)
        }
        
            
//    }
    }
    
    func cleanContent(){
        questionLabel.text = ""

    }
    
    @IBAction func startBtn(_ sender: Any) {
        cleanContent()
        startTest()
        
    }

    
    @IBAction func answerBtns(_ sender: UIButton) {
//        if sender.currentTitle == psytests[index].answer
    }
        
    
    @IBAction func resultBtn(_ sender: Any) {
        
    }
}

