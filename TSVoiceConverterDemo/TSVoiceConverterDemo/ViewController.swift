//
//  ViewController.swift
//  TSVoiceConverterDemo
//
//  Created by Hilen on 3/29/16.
//  Copyright © 2016 Hilen. All rights reserved.
//

import UIKit
import TSVoiceConverter

let kAudioFileTypeWav = "wav"
let kAudioFileTypeAmr = "amr"
private let kAmrRecordFolder = "ChatAudioAmrRecord"   //存 amr 的文件目录名
private let kWavRecordFolder = "ChatAudioWavRecord"  //存 wav 的文件目录名

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let amrPath = NSBundle.mainBundle().pathForResource("hello", ofType: "amr")
        let wavPath = NSBundle.mainBundle().pathForResource("count", ofType: "wav")

        let amrTargetPath = AudioFolderManager.amrPathWithName("test_amr").path!
        let wavTargetPath = AudioFolderManager.wavPathWithName("test_wav").path!
        
        if TSVoiceConverter.convertAmrToWav(amrPath!, wavSavePath: wavTargetPath) {
            print("wav path: \(wavTargetPath)")
        } else {
            print("convertAmrToWav error")
        }
        
        if TSVoiceConverter.convertWavToAmr(wavPath!, amrSavePath: amrTargetPath) {
            print("amr path: \(amrTargetPath)")
        } else {
            print("convertWavToAmr error")
        }
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}


class AudioFolderManager {
    /**
     返回 amr 的完整路径
     
     - parameter fileName: 文件名字，不包含后缀
     
     - returns: 返回路径
     */
    class func amrPathWithName(fileName: String) -> NSURL {
        let filePath = self.amrFilesFolder.URLByAppendingPathComponent("\(fileName).\(kAudioFileTypeAmr)")
        return filePath
    }
    
    
    /**
     返回 wav 的完整路径
     
     - parameter fileName: 文件名字，不包含后缀
     
     - returns: 返回路径
     */
    class func wavPathWithName(fileName: String) -> NSURL {
        let filePath = self.wavFilesFolder.URLByAppendingPathComponent("\(fileName).\(kAudioFileTypeWav)")
        return filePath
    }
    
    /**
     创建录音的文件夹, amr 格式
     */
    private class var amrFilesFolder: NSURL {
        get { return self.createAudioFolder(kAmrRecordFolder)}
    }
    
    /**
     创建录音的文件夹, wav 格式
     */
    private class var wavFilesFolder: NSURL {
        get { return self.createAudioFolder(kWavRecordFolder)}
    }
    
    /**
     创建录音的文件夹
     */
    class private func createAudioFolder(folderName :String) -> NSURL {
        let documentsDirectory = NSFileManager.defaultManager().URLsForDirectory(.CachesDirectory, inDomains: .UserDomainMask)[0]
        let folder = documentsDirectory.URLByAppendingPathComponent(folderName)
        let fileManager = NSFileManager.defaultManager()
        if !fileManager.fileExistsAtPath(folder.absoluteString) {
            do {
                try fileManager.createDirectoryAtPath(folder.path!, withIntermediateDirectories: true, attributes: nil)
                return folder
            } catch let error as NSError {
                print("error:\(error)")
            }
        }
        return folder
    }
}

