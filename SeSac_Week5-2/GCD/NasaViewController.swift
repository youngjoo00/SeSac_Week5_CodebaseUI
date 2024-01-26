//
//  NasaViewController.swift
//  SeSac_Week5-2
//
//  Created by youngjoo on 1/25/24.
//

import UIKit

class NasaViewController: UIViewController {
    
    @IBOutlet var oneImageView: UIImageView!
    @IBOutlet var twoImageView: UIImageView!
    @IBOutlet var threeImageView: UIImageView!
    @IBOutlet var fourImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //serialSync()
        //serialAsync()
        //concurrentSync()
        concurrentAsync()
        
        print("1")
        DispatchQueue.main.async {
            // 이걸 이용해서 뷰를 그리는 것을 미뤄버린거였음
            print("2")
        }
        
        print("3")

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print(#function)
    }
    
    
    // 이 시점에 뷰의 프레임 사이즈가 정해짐
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        print(#function)
        
        present(SnapViewController(), animated: true)
    }
    
    
    @IBAction func didSyncBtnTapped(_ sender: UIButton) {
        print("start")
        syncDownloadImage(oneImageView, value: "one")
        syncDownloadImage(twoImageView, value: "two")
        syncDownloadImage(threeImageView, value: "three")
        syncDownloadImage(fourImageView, value: "four")
        print("end") // 동기, 순서대로 실행, 끝나는 지점 알 수 있음
    }
    
    func syncDownloadImage(_ imageView: UIImageView, value: String) {
        
        print("==1==\(value)")
        let url = Nasa.photo
        print("==2==\(value)")
        do {
            print("==3==\(value)")
            let data = try Data(contentsOf: url)
            print("==4==\(value)")
            // 메인쓰레드 혼자 너무 바빠서 이미지뷰를 모든 일이 끝나고 난 뒤 띄우게 된다..
            imageView.image = UIImage(data: data)
            print("==5==\(value)")
        } catch {
            print("error-1\(value)")
            imageView.image = UIImage(systemName: "star.fill")
            print("error-2\(value)")
        }
        print("==6==\(value)")
    }
    
    // Async, Sync
    // Concurrent(global), Serial(main)
    @IBAction func didAsyncBtnTapped(_ sender: UIButton) {
        print("Start")
        asyncDownloadImage(oneImageView, value: "one")
        asyncDownloadImage(twoImageView, value: "two")
        asyncDownloadImage(threeImageView, value: "three")
        asyncDownloadImage(fourImageView, value: "four")
        print("End")
    }
    
    // 일단, global을 만나면, 다른 알바생에게 작업을 보내고 나머지 실행!
    // 작업이 언제 끝나는 지 정확한 시점을 알기 어렵다!!
    // UI 관련된 작업은 항상 메인 쓰레드에서 진행해야 한다!!
    func asyncDownloadImage(_ imageView: UIImageView, value: String) {
        
        print("==1==\(value)", Thread.isMainThread)
        let url = Nasa.photo
        print("==2==\(value)", Thread.isMainThread)
        DispatchQueue.global().async {
            do {
                print("==3==\(value)", Thread.isMainThread)
                let data = try Data(contentsOf: url)
                DispatchQueue.main.async {
                    print("==main=>1==\(value)", Thread.isMainThread)
                    // 메인쓰레드 혼자 너무 바빠서 이미지뷰를 모든 일이 끝나고 난 뒤 띄우게 된다..
                    imageView.image = UIImage(data: data)
                    print("==main=>2==\(value)", Thread.isMainThread)
                    print("==4==\(value)")
                }
            } catch {
                print("error-1\(value)")
                imageView.image = UIImage(systemName: "star.fill")
                print("error-2\(value)")
            }
        }

        print("==5==\(value)")
    }
    
}

extension NasaViewController {
    // 일을 한번에 다 맡겼는데(serial) 그 일을 혼자 다 처리하는 것(sync)
    func serialSync() {
        print("Start", terminator: " ")
        
        for item in 1...100 {
            print(item, terminator: " ")
        }
        
        // 메인에게 일이 잔뜩 주어졌는데, main.sync 를 명시적으로 사용해서 일을 시키려는 순간,
        // 자기는 일이 언제 끝날지 몰라서 계속 일을 하고 있는데, 이 일이 또 주어졌다. -> 그럼 이 일을 해결하기 위해서는 순차적으로 해결해야 하는데,
        // 이 일을 하려면 다른 일이 다 끝나야하지만 끝나는게 언제인지 몰라서 무한정으로 대기하는 일이 발생함
        // 무한 대기 상태에 들어갈 수 있기 때문에, 교착 상태(DeadLock)이 발생 할 수 있음.
        //        DispatchQueue.main.sync {
        for item in 101...200 {
            print(item, terminator: " ")
        }
        //        }
        
        print("End")
    }
    
    func serialAsync() {
        // 1. sync로 일단 모든 일 진행 시작
        print("Start", terminator: " ")
        
        // async 작업이니까 큐로 보내버리고 다음 코드를 실행함
        // 근데 큐에서 보니까 이 일은 main 한테 시키기로 해서 다시 일을 받고 작업을 시작함
        // 4. 실행되는 시점이 가장 뒤로 미뤄짐
        DispatchQueue.main.async {
            for item in 1...100 {
                print(item, terminator: " ")
            }
        }
        
        // 2.
        for item in 101...200 {
            print(item, terminator: " ")
        }
        
        // 3.
        print("End")
    }
    
    func concurrentSync() {
        // 1. main이 sync 로 시작
        print("Start", terminator: " ")
        
        // 2. 이 일을 queue 가 global 에게 동시성있게 맡겼지만, sync 로 진행해야하는 일이기에 메인은 이 일이 끝날때까지 기다리고,
        // global 이 일을 진행해야하지만, 사실 그러면 메인이 일을 하나. global 이 일을 하나. 일의 진행시간은 똑같아짐
        // 애플은 일의 진행시간이 똑같아지면 그냥 메인쓰레드에게 모든 일을 맡겨버리도록 지정하여서 결론은 메인쓰레드가 모든 일을 다 진행하게 된다.
        // 그니까, 앞으로 global.sync 는 쓸 일이 거의 없을거다.
        DispatchQueue.global().sync {
            for item in 1...100 {
                print(item, terminator: " ")
            }
        }
        
        for item in 101...200 {
            print(item, terminator: " ")
        }
        
        print("End")
    }
    
    func concurrentAsync() {
        // 1. 메인이 sync 로 시작
        print("Start", terminator: " ")
        
        // 2. queue 에게 일을 맡기고 global 이 비동기로 일하도록 시킴
        DispatchQueue.global().async {
            for item in 1...100 {
                // 3. 이번엔 출력하는 일을 모두 queue 에게 다 보내버림
                // 4. queue 가 이제 모든 global 들에게 각각 일을 하도록 시킴 (일하는 녀석들이 몇명인지는 모름. 애플이 알아서지정해줌)
                DispatchQueue.global().async {
                    print(item, terminator: " ")
                }
            }
        }
        
        // 2. queue 가 main 은 동기로 일하도록 시킴
        for item in 101...200 {
            print(item, terminator: " ")
        }
        
        // 2. main과 global 이 동시에 일을 수행하고 있어서 출력이 동시에 개판으로 일어나지만,
        //    101~200 출력 코드는 sync 로 진행중이기에 숫자가 순차적으로 잘 나온다.
        
        // 3.
        print("End")
    }
}
