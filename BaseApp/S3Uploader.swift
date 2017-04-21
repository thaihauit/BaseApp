//
//  S3Uploader.swift
//  Grabit
//
//  Created by Wahyu Sumartha  on 1/9/15.
//  Copyright (c) 2015 BuzzElement. All rights reserved.
//
import Alamofire
import BoltsSwift

protocol S3UploaderDelegate {
    func onCallBack(totalBytesWritten: Int64, totalBytesExpectedToWrite: Int64)
}

class S3Uploader: NSObject {
    
    class func uploadFileToS3InBackground(_ data: Data, fileType: String, headers: [String: String]? = nil, delegate: S3UploaderDelegate? = nil) -> BoltsSwift.Task<Any> {
        let task = TaskCompletionSource<Any>()
        var path = ""
        var url = ""
        S3Uploader.getPresignedUrlInBackground(fileType).continueWithTask(continuation: { (t: BoltsSwift.Task<Any>) -> BoltsSwift.Task<Any> in
            if t.faulted {
                return t
            }
            let response = t.result as! ApiResponse
            let result = response.result as! Dictionary<String, AnyObject>
            path = result["path"] as! String
            url  = result["url"] as! String
            return S3Uploader.uploadWithPresignedUrlInBackground(data, fileType: fileType, presignedUrl: url, headers: headers, delegate: delegate)
        }).continueWith(continuation: { (t: BoltsSwift.Task<Any>) -> Any? in
            if t.faulted {
                task.set(error: t.error!)
            } else {
                task.set(result: path)
            }
            return nil
        })
        return task.task
    }
    
    class func uploadFileToS3CloudInBackground(_ data: Data, fileType: String, headers: [String: String]? = nil, delegate: S3UploaderDelegate? = nil) -> BoltsSwift.Task<Any> {
        let task = TaskCompletionSource<Any>()
        var path = ""
        var url = ""
        S3Uploader.getPresignedUrlInBackground(fileType).continueWithTask(continuation: { (t: BoltsSwift.Task<Any>) -> BoltsSwift.Task<Any> in
            if t.faulted {
                return t
            }
            let response = t.result as! ApiResponse
            let result = response.result as! Dictionary<String, AnyObject>
            path = result["path"] as! String
            url  = result["url"] as! String
            return S3Uploader.uploadWithPresignedUrlInBackground(data, fileType: fileType, presignedUrl: url, headers: headers, delegate: delegate)
        }).continueWith(continuation: { (t: BoltsSwift.Task<Any>) -> Any? in
            if t.faulted {
                task.set(error: t.error!)
            } else {
                task.set(result: path)
            }
            return nil
        })
        return task.task
    }
    
    class func getPresignedUrlInBackground(_ fileType: String) -> BoltsSwift.Task<Any> {
        return ImageRestApi.sharedInstance.getPreSignedURL(fileType: fileType)
    }
    
    class func uploadWithPresignedUrlInBackground(_ data: Data, fileType:String, presignedUrl: String, headers: [String: String]? = nil, delegate: S3UploaderDelegate? = nil) -> BoltsSwift.Task<Any> {
        let task = TaskCompletionSource<Any>()
        Alamofire.upload(data, to: URL(string: presignedUrl)!, method: HTTPMethod.put, headers: headers).uploadProgress { (progress: Progress) in
            DispatchQueue.main.async {
                delegate?.onCallBack(totalBytesWritten: progress.completedUnitCount, totalBytesExpectedToWrite: progress.totalUnitCount)
            }
            }.validate().response { (response: DefaultDataResponse) in
                if let error = response.error {
                    task.set(error: error)
                } else {
                    task.set(result: presignedUrl)
                }
        }
        return task.task
    }
}
