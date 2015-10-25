//
//  ViewController.swift
//  pub_chime
//
//  Created by Tecco on 2015/07/27.
//  Copyright (c) 2015年 Tecco's Project. All rights reserved.
//

import UIKit
import GoogleMobileAds
import AVFoundation

class ViewController: UIViewController, GADBannerViewDelegate {

    @IBOutlet weak var buttonStatus: UIButton!
    
    //自分で登録した個別のAd unit IDを入力
    let AdUnitID = "ca-app-pub-7287685278318574/5555449841"
    //実機でテストする場合はデバイスIDを入力（コンソールに表示される番号）
    //let TEST_DEVICE_ID = "#####################"
    //テスト用のフェイクの広告を表示させる時はtrue
    let AdMobTest:Bool = false
    //シミュレータでテストする時はtrue
    let SimulatorTest:Bool = false
    
    var audioPlayer: AVAudioPlayer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        //TODO: Admobの表示
        self.admob()
        
        let ud = NSUserDefaults.standardUserDefaults()
        let seValue : Int = ud.integerForKey("se")
        
        var initTitle = NSLocalizedString("dingdong", value: "", comment: "comment")
        
        if(seValue == 0){
            initTitle = NSLocalizedString("dingdong", value: "", comment: "comment")
        } else if(seValue == 1){
            initTitle = NSLocalizedString("bingo", value: "", comment: "comment")
        } else if(seValue == 2){
            initTitle = NSLocalizedString("ting", value: "", comment: "comment")
        }
        
        buttonStatus.setTitle(initTitle, forState: .Normal)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func buttonPush(sender: AnyObject) {
        let ud = NSUserDefaults.standardUserDefaults()
        let seValue : Int = ud.integerForKey("se")
        
        let sound_data = NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("chime" + String(seValue), ofType: "wav")!)
        
        audioPlayer = try! AVAudioPlayer(contentsOfURL: sound_data)
        audioPlayer.prepareToPlay()
        audioPlayer.play()
    }

    @IBAction func infoClick(sender: AnyObject) {
        let dialogTitle = NSLocalizedString("dialogTitle", value: "", comment: "comment")
        
        let notice1 = NSLocalizedString("notice1", value: "", comment: "comment")
        let notice2 = NSLocalizedString("notice2", value: "", comment: "comment")
        let notice3 = NSLocalizedString("notice3", value: "", comment: "comment")
        
        let alertController = UIAlertController(title: dialogTitle, message: "\n" + notice1 + "\n\n" + notice2 + "\n\n" + notice3, preferredStyle: .Alert)
        
        let otherAction = UIAlertAction(title: "OK", style: .Default) {
            action in NSLog("push OK")
        }
        
        // addActionした順に左から右にボタンが配置されます
        alertController.addAction(otherAction)
        
        presentViewController(alertController, animated: true, completion: nil)
        
        
    }
    
    @IBAction func actionButtonClick(sender: AnyObject) {
        
        let _menu = NSLocalizedString("menu", value: "", comment: "comment")
        let _share = NSLocalizedString("share", value: "", comment: "comment")
        let _cancel = NSLocalizedString("cancel", value: "", comment: "comment")
        let _change = NSLocalizedString("change", value: "", comment: "comment")
        
        //UIActionSheet
        let actionSheet:UIAlertController = UIAlertController(title: _menu,
            message: nil, //description
            preferredStyle: UIAlertControllerStyle.ActionSheet)
        
        //Cancel 一つだけしか指定できない
        let cancelAction:UIAlertAction = UIAlertAction(title: _cancel,
            style: UIAlertActionStyle.Cancel,
            handler:{
                (action:UIAlertAction!) -> Void in
                //println("Cancel")
        })
        
        //Share
        let otherAction1:UIAlertAction = UIAlertAction(title: _share,
            style: UIAlertActionStyle.Default,
            handler:{
                (action:UIAlertAction!) -> Void in
                
                let shareText = NSLocalizedString("appName", value: "", comment: "comment")
                let shareUrl = "http://tecc0.com/pub_chime_lp.html"
                let activityItems = [shareText, shareUrl]
                
                // 初期化処理
                let activityVC = UIActivityViewController(activityItems: activityItems, applicationActivities: nil)
                
                // 使用しないアクティビティタイプ
                let excludedActivityTypes = [
                    UIActivityTypeSaveToCameraRoll,
                    UIActivityTypePrint
                ]
                
                activityVC.excludedActivityTypes = excludedActivityTypes
                
                // UIActivityViewControllerを表示
                self.presentViewController(activityVC, animated: true, completion: nil)
                
        })
        
        //Change
        let otherAction2:UIAlertAction = UIAlertAction(title: _change,
            style: UIAlertActionStyle.Default,
            handler:{
                (action:UIAlertAction!) -> Void in
                
                let _pub = NSLocalizedString("pub", value: "", comment: "comment")
                let _restaurant = NSLocalizedString("restaurant", value: "", comment: "comment")
                let _bar = NSLocalizedString("bar", value: "", comment: "comment")
                
                let _dingdong = NSLocalizedString("dingdong", value: "", comment: "comment")
                let _bingo = NSLocalizedString("bingo", value: "", comment: "comment")
                let _ting = NSLocalizedString("ting", value: "", comment: "comment")
                
                let ud = NSUserDefaults.standardUserDefaults()
                
                let alertController = UIAlertController(title: _change, message: nil, preferredStyle: .Alert)
                
                let changeAction1 = UIAlertAction(title: _pub, style: .Default) {
                    action in NSLog("push OK")
                    ud.setObject(0, forKey: "se")
                    self.buttonStatus.setTitle(_dingdong, forState: .Normal)
                }
                let changeAction2 = UIAlertAction(title: _restaurant, style: .Default) {
                    action in NSLog("push OK")
                    ud.setObject(1, forKey: "se")
                    self.buttonStatus.setTitle(_bingo, forState: .Normal)
                }
                let changeAction3 = UIAlertAction(title: _bar, style: .Default) {
                    action in NSLog("push OK")
                    ud.setObject(2, forKey: "se")
                    self.buttonStatus.setTitle(_ting, forState: .Normal)
                }
                
                // addActionした順に左から右にボタンが配置されます
                alertController.addAction(changeAction1)
                alertController.addAction(changeAction2)
                alertController.addAction(changeAction3)
                
                
                self.presentViewController(alertController, animated: true, completion: nil)
                
        })
        
        // addActionした順に左から右にボタンが配置されます
        actionSheet.addAction(cancelAction)
        actionSheet.addAction(otherAction1)
        actionSheet.addAction(otherAction2)
        
        //表示。UIAlertControllerはUIViewControllerを継承している。
        presentViewController(actionSheet, animated: true, completion: nil)
    }
    
    //TODO: 普通にレイアウトで直接指定すれば良い(そのうち直す
    func admob(){
        var admobView: GADBannerView = GADBannerView()
        admobView = GADBannerView(adSize:kGADAdSizeBanner)
        admobView.frame.origin = CGPointMake(0, self.view.frame.size.height - admobView.frame.height)
        admobView.frame.size = CGSizeMake(self.view.frame.width, admobView.frame.height)
        admobView.adUnitID = AdUnitID
        admobView.delegate = self
        admobView.rootViewController = self
        
        let admobRequest:GADRequest = GADRequest()
        
        if AdMobTest {
            if SimulatorTest {
                admobRequest.testDevices = [kGADSimulatorID]
            }
            else {
                //admobRequest.testDevices = [TEST_DEVICE_ID]
            }
            
        }
        
        admobView.loadRequest(admobRequest)
        self.view.addSubview(admobView)
    }
    
}

