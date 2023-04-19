//
//  AirPlaneViewModel.swift
//  ReToday
//
//  Created by changgyo seo on 2023/04/13.
//

import Combine
import Photos
import UIKit

class AirPlaneViewModel: ObservableObject {
    
    var cancellableBag = Set<AnyCancellable>()
    
    // MARK: use only viewmodel
    @Published var didLoad: Void = ()
    @Published var currentPhotsIndex: Int = 0
    @Published var currentYear: Int = 2022
    
    // MARK: input
    @Published var tapAirPlane: Void = ()
    @Published var tapHeart: Bool = false
    @Published var addComment: Bool = false
    @Published var comment: String = ""
    @Published var emoticon: emoticon = .none
    @Published var isCloudShowing: Bool = false
    
    // MARK: ouput
    @Published var currentPhotos: [TodayPhoto] = [TodayPhoto]()
    @Published var currentPhoto: TodayPhoto = TodayPhoto(id: "",image: UIImage(), asset: PHAsset(), emoticon: .none)
    @Published var currentHeartPhotos: [TodayPhoto] = [TodayPhoto]()
    @Published var isWindowClose: Bool = true
    @Published var changeTheNewPicture: Void = ()
    @Published var cloudPhotos: [TodayPhoto] = [TodayPhoto]()
    @Published var tapEdit: Void = ()
    
    // MARK: both
    @Published var currentDate: Date = Date()
    @Published var isCommentShowing: Bool = false
    
    // MARK: init(observe everything)
    init(year: Int) {
        //_ = Photo.shard.current
        _ = Time.shared.current
        
        currentYear = year
        
        $tapHeart
            .eraseToAnyPublisher()
            .dropFirst()
            .filter { $0 }
            .flatMap { _ in
                return self.currentPhoto.asset.addHeart()
            }
            .receive(on: DispatchQueue.main)
            .sink { [weak self] _ in
                guard let self = self else { return }
                
                let index = self.currentPhotos.firstIndex(where: { $0.id == self.currentPhoto.id})!
                self.currentPhotos[index].hasHeart = true
                self.currentPhoto.hasHeart = true
            }
            .store(in: &cancellableBag)
        
        $addComment
            .eraseToAnyPublisher()
            .dropFirst()
            .filter { $0 }
            .sink { [weak self] _ in
                guard let self = self else { return }
                if self.comment != "" {
                    let index = self.currentPhotos.firstIndex(where: { $0.id == self.currentPhoto.id })!
                    self.currentPhotos[index].hasCommnet = self.comment
                    self.currentPhotos[index].emoticon = self.emoticon
                    self.comment = ""
                    self.emoticon = .none
                }
            }
            .store(in: &cancellableBag)
    
        $tapEdit
            .dropFirst()
            .eraseToAnyPublisher()
            .sink { [weak self] _ in
                guard let self = self else { return }
                self.comment = self.currentPhoto.hasCommnet
                self.currentPhoto.hasCommnet = ""
                
            }
            .store(in: &cancellableBag)
        
        
        $isCloudShowing
            .eraseToAnyPublisher()
            .dropFirst()
            .filter { $0 }
            .sink { [weak self] _ in
                guard let self = self else { return }
                
                self.isCommentShowing = false
                self.cloudPhotos = self.currentPhotos.filter { $0.hasHeart }
                self.isWindowClose = true
                if self.cloudPhotos.count == 0 {
                    var temp = [TodayPhoto]()
                    temp.append(TodayPhoto(id: "0", image: UIImage(named:"kakaka")!, asset: PHAsset()))
                    self.cloudPhotos = temp
                }
            }
            .store(in: &cancellableBag)
        
        $currentPhoto
            .eraseToAnyPublisher()
            .dropFirst()
            .dropFirst()
            .sink { [weak self] photo in
                guard let self = self else { return }
                
                print(photo.asset.creationDate)
                
                self.isWindowClose = false
                let index = self.currentPhotos.firstIndex(where: { $0.id == photo.id })!
                self.currentPhotsIndex = index
                self.comment = photo.hasCommnet
                self.emoticon = photo.emoticon
                self.tapHeart = photo.hasHeart
            }
            .store(in: &cancellableBag)
        
        $changeTheNewPicture
            .eraseToAnyPublisher()
            .dropFirst()
            .sink { [weak self] _ in
                guard let self = self else { return }
                self.isWindowClose = true
                self.isCommentShowing = false
                if self.currentPhotsIndex + 1 >= self.currentPhotos.count {
                    self.currentPhotsIndex = 0
                }
                else {
                    self.currentPhotsIndex += 1
                }
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 1.6) {
                    self.currentPhoto = self.currentPhotos[self.currentPhotsIndex]
                }
            }
            .store(in: &cancellableBag)
        
        $tapAirPlane
            .eraseToAnyPublisher()
            .dropFirst()
            .sink { [weak self] _ in
                guard let self = self else { return }
                
                self.currentPhotsIndex += 1
                self.currentPhoto = self.currentPhotos[self.currentPhotsIndex]
            }
            .store(in: &cancellableBag)
    }
    
    func appearYes(completion: @escaping ()->()) {
        let time = self.currentYear - 2023
        
        var todayPhotos = Photo(howTime: time).current.changeUIImages() { photos in
            
            self.isWindowClose = false
            self.currentPhotos = photos
            self.currentPhoto = self.currentPhotos.first ?? TodayPhoto(id: "", image: UIImage(), asset: PHAsset())
            completion()
        }
        
    }
}

