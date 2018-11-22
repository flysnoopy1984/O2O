//
//  WebCore.swift
//  O2ODemo
//
//  Created by jackyPC on 2018/6/27.
//  Copyright © 2018年 jackyPC. All rights reserved.
//

import Foundation
import Alamofire

class WebCore
{

    public static let Url_Register = SysConfig.MainHost+"api/User/Register"
    public static let Url_Login = SysConfig.MainHost+"api/User/Login";  //?loginName=13482710060&pwd=123456
    public static let Url_ImageUpload = SysConfig.MainHost+"api/User/UpdateHeaderImage";
    public static let Url_SetNickName = SysConfig.MainHost+"api/User/SetNickName";
    public static let Url_PostUserToken = SysConfig.MainHost+"api/User/SetUserDeviceToken";
    
    public static let Url_Banner = SysConfig.MainHost+"api/banner/GetLatest";
    public static let Url_Task = SysConfig.MainHost+"api/Task/QueryTask";

    //SMS
    public static let Url_SMSSend = SysConfig.MainHost+"api/sms/GetMessage";
    public static let Url_SMSConfirm = SysConfig.MainHost+"api/sms/ConfirmVerification";
    
    //Web 修改密码
    public static let Url_PersonAccount_ModifyPwd = SysConfig.WebHost+"app/modifypwd";
    
    
    typealias SuccessUpload = (JSON) -> Void;
    typealias FailureUpload = (Error) -> Void;
    typealias AfterLoadEvent = (JSON) -> Void

    func EmptyAfterLoad(_ result:JSON){
        return;
    }
    
    func PostData(url:String,
                         parameters:Dictionary<String,AnyObject> = ["":"" as AnyObject],
                         afterEvent:@escaping AfterLoadEvent) ->Void
    {
        var result:JSON = JSON.null;
        
        Alamofire.request(url,method:.post,parameters:parameters)
            .validate()
            .responseJSON{ response in
                switch response.result
                {
                case .success:
                    if let value = response.value{
                        result = JSON(value);
                        afterEvent(result);
                    }
                case .failure:
                    print ("Post Data Error");
                    break
                    
                }
                
        }
      //  return result;
    }
    
    func DownloadFile(url:String,SavePath:String)->String{
        var result = "";
        //SysConfig.HeaderDirPath_FileName
        let destination : DownloadRequest.DownloadFileDestination = {_,_ in
            let docUrl = FileManager.default.urls(for:.documentDirectory, in:.userDomainMask)[0]
            
            let fileUrl = docUrl.appendingPathComponent(SavePath);
            
            return (fileUrl,[.removePreviousFile,.createIntermediateDirectories]);
        };
        
        Alamofire.download(url, to: destination).response{
            res in
            
          // var status =  res.response?.statusCode
            result = (res.destinationURL?.path)!;
           
        }
        return result;
    }
    
    func Upload(FileName:String,
                UploadImg:UIImage,
                SuccessUpload:@escaping SuccessUpload,
                FailureUpload:@escaping FailureUpload){
        
        let userPhone = UserData.GetPhone();
        let url = WebCore.Url_ImageUpload+"?UserPhone="+userPhone;
      //  let urlRequest = URLRequest(url: URL(string: url)!);
        
        let data  = UploadImg.jpegData(compressionQuality:0.5) //UIImageJPEGRepresentation(UploadImg,0.5);
        
        var result:JSON = JSON.null;
        
        Alamofire.upload(multipartFormData: { (formdata) in
            formdata.append(data!, withName: "imgData", fileName: FileName, mimeType: "image/jpg")
        },
                         
         to: url,
         encodingCompletion:{(encodingresult) in
            switch encodingresult
            {
            case .success(request: let upload, _, _):
                upload.responseJSON(completionHandler: { (res) in
//                    print("\(res)")
                    if let value = res.value{
                         result = JSON(value);
                         SuccessUpload(result);
                    }
                })
            case .failure(let error):
                
                FailureUpload(error);
            }
                            
        } )
        
    }
    
  
    
    
}
