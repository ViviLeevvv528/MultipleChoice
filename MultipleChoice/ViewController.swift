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
    @IBOutlet weak var startButton: UIButton!
    
    //    設定取用data
        var psytests = Psytest.data
    //    宣告index儲存目前題數
        var index = 0
    //    宣告total儲存目前分數
        var total = 0

    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(psytests)
        cleanContent()
//        print(psytests[0])
//        print(psytests[0].question)
//        print(psytests[0].answer[0])
//        print(psytests[0].score[0])
 
    }
//    測驗的顯示動作
    func startTest(){
        startButton.isHidden = true
//        定義答案題數
        var i = 0
//        print(psytests.count)
    if index < psytests.count {
        questionLabel.text = psytests[index].question
//        print(psytests[index].answer[index])
        for val in psytests[index].answer{
            print(val)
            answerTables[i].setTitle(val, for: UIControl.State.normal)
            i = i + 1
        }
    }
    }

    func cleanContent(){
        questionLabel.text = ""
        for i in 0...6{
            answerTables[i].setTitle("", for: UIControl.State.normal)
        }
    }
    func showResult(){
        if total >= 60{
        resultLabel.text = "在別人眼中是一個以利益為先的人，你有虚榮之心，較自我中心，同時喜歡支配別人，雖然有人會羨慕及仰望你，但其實你的信賴度很低，真正相信你的人並不多。"
        }
        if total >= 51{
            resultLabel.text = "你在別人眼中是領導者，也是一個能在短時間內做出決定的人。你是一個很容易興奮，而且情緒起伏很大、十分衝動的人。另外，你勇敢、喜歡接受挑戰，只要有機會，你都會接受新嘗試，和你親近的人，會被你的熱情吸引。"
        }
        if total >= 41{
            resultLabel.text = "你身邊的人都認為你活潑、有魅力、有趣和開朗，無論去到哪裡，你也受到注目，但你很會看別人的眼色，所以不會變得驕傲自大。另外，你在別人眼中亦是一個多情和親切的人，在別人有困難時，第一時間都會想起你，因為你擁有樂於助人的形象。"
        }
        if total >= 31{
            resultLabel.text = "別人眼中的你，是一個賢明、慎重、小心、現實的人，而且十分聰明，有很高的能力和才能，為人謙虚。另外，你和別人交往時，不會以輕挑態度接近，而對認識的朋友十分真誠，希望別人亦能以相同的態度待你。"
        }
        if total >= 21{
            resultLabel.text = "在別人眼中，你是一個固執和非常小心的人。無論什麼事你也會慎重和小心，一旦遇上令你著迷的事，你會非常衝動地朝著目標前進。不過，因為做事實在太仔細，有時候會給人「太執著」、「太認真」的感覺，在適當時候記得要顧及別人的感受。"
        }
        else {
            resultLabel.text = "在別人眼中的你，是十分害羞、膽小、柔弱的人，你也是有「選擇困難」的人，任何事都要別人替你決定，而別人也盡量不想與你有牽連。此外，你的觀察力很高，經常發現到一些別人沒有發現的錯誤或問題，所以和你不熟的人會以為你很高智慧，但和你親近的人就知道這不是事實。"
        }
    }
    @IBAction func startBtn(_ sender: Any) {
        cleanContent()
        startTest()

    }

    @IBAction func answerBtns(_ sender: UIButton) {
        print(total)
        if index < psytests.count {
            if sender.tag <= psytests[index].score.count {
                total = total + Int(psytests[index].score[sender.tag - 1])!
                index = index + 1
                cleanContent()
                startTest()
                print(total)
                if index == 10{
                    showResult()
                }
            }
        }

    }
}
