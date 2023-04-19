//
//  StaticData.swift
//
//
//  Created by changgyo seo on 2023/04/13.
//

import Photos

class Photo {
    
    var current: [PHAsset] = [PHAsset]()
    
    // Singleton pattern
    init(howTime: Int) {
        
        let photoAuthorizationStatus = PHPhotoLibrary.authorizationStatus()
        if photoAuthorizationStatus == .authorized {
        
            let options = PHFetchOptions()
            options.fetchLimit = 30
            let fromDate = Calendar.current.date(byAdding: .year, value: howTime, to: Date())
            let toDate = Date()
            options.predicate = NSPredicate(format: "creationDate > %@ AND creationDate <= %@", fromDate! as CVarArg, toDate as CVarArg)
            options.sortDescriptors = [NSSortDescriptor(key: "creationDate", ascending: true)]
            
            let fetchResult = PHAsset.fetchAssets(with: .image, options: options)
            var result = [PHAsset]()
            fetchResult.enumerateObjects { (object, index, stop) in
                
                let dateformmater = DateFormatter()
                dateformmater.dateFormat = "yyyy MM dd"
                dateformmater.locale = Locale(identifier: "ko_KR")
                
                print(dateformmater.string(from: object.creationDate!))
                result.append(object)
            }
            
            self.current = result.sorted(by: { $0.creationDate! < $1.creationDate! })
            for i in self.current {
                print(i.creationDate)
            }
        }
        else if photoAuthorizationStatus == .notDetermined {
            PHPhotoLibrary.requestAuthorization { newStatus in
                if newStatus == .authorized {
                    // 권한이 부여되면 코드 작성
                }
            }
        }
    }
}
