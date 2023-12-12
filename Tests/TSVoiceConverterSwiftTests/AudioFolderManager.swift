//
//  File.swift
//  
//
//  Created by william on 2023/12/12.
//

import Foundation

let kAudioFileTypeWav = "wav"
let kAudioFileTypeAmr = "amr"
private let kAmrRecordFolder = "ChatAudioAmrRecord"
private let kWavRecordFolder = "ChatAudioWavRecord"

class AudioFolderManager {
    /**
     Get the AMR file's full path

     - parameter fileName: file name

     - returns: Full path
     */
    class func amrPathWithName(_ fileName: String) -> URL {
        let filePath = self.amrFilesFolder.appendingPathComponent("\(fileName).\(kAudioFileTypeAmr)")
        return filePath
    }

    /**
     Get the WAV file's full path

     - parameter fileName: file name

     - returns: Full path
     */
    class func wavPathWithName(_ fileName: String) -> URL {
        let filePath = self.wavFilesFolder.appendingPathComponent("\(fileName).\(kAudioFileTypeWav)")
        return filePath
    }

    /// Create AMR file record folder
    fileprivate class var amrFilesFolder: URL {
        get { return self.createAudioFolder(kAmrRecordFolder)}
    }

    /// Create WAV file record folder
    fileprivate class var wavFilesFolder: URL {
        get { return self.createAudioFolder(kWavRecordFolder)}
    }

    /// Create record folder
    class fileprivate func createAudioFolder(_ folderName :String) -> URL {
        let documentsDirectory = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask)[0]
        let folder = documentsDirectory.appendingPathComponent(folderName)
        let fileManager = FileManager.default
        if !fileManager.fileExists(atPath: folder.absoluteString) {
            do {
                try fileManager.createDirectory(atPath: folder.path, withIntermediateDirectories: true, attributes: nil)
                return folder
            } catch let error as NSError {
                print("error:\(error)")
            }
        }
        return folder
    }
}
