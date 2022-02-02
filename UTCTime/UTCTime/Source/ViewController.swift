//
//  ViewController.swift
//  UTCTime
//
//  Created by 이지석 on 2022/02/02.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var dateTimeLbl: UILabel!    // 시간표시 Label
    
    @IBAction func onNowTapped(_ sender: UIButton) {
        dateTimeLbl.text = "로딩중.."
        viewModel.reload()
    }
    
    @IBAction func onYesterdayTapped(_ sender: UIButton) {
        viewModel.moveDay(day: -1)
    }
    
    @IBAction func onTomorrowTapped(_ sender: UIButton) {
        viewModel.moveDay(day: 1)
    }
    
    let viewModel = ViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel.onUpdated = { [weak self] in
            DispatchQueue.main.async {
                self?.dateTimeLbl?.text = self?.viewModel.dateTimeString
            }
        }
        
        viewModel.reload()
    }


}

