//
//  PlaylistModel.swift
//  MusicApp
//
//  Created by Sang on 4/4/20.
//  Copyright © 2020 SangNX. All rights reserved.
//

import Foundation
import RealmSwift

@objcMembers class PlaylistModel: Object {
    enum Property: String {
        case id, name, items
    }
    
    dynamic var id = UUID().uuidString
    dynamic var name = ""
    dynamic var items = List<ItemPlayList>()

    override static func primaryKey() -> String? {
        return PlaylistModel.Property.id.rawValue
    }
    
    convenience init(_ name: String, item: ItemPlayList? = nil) {
        self.init()
        self.name = name
        if(item != nil) {
            self.items.append(item!)
        }
    }
}

extension PlaylistModel {
    static func add(name: String, item: ItemPlayList? = nil, in realm: Realm = try! Realm()) -> PlaylistModel {
        let playList = PlaylistModel(name, item: item)
        try! realm.write {
            realm.add(playList)
        }
        return playList
    }
    
    static func getItemWith(id: String, in realm: Realm = try! Realm()) -> PlaylistModel {
        let list = realm.objects(PlaylistModel.self)
        for value in list {
            if(value.id == id) {
                return value
            }
        }
        return PlaylistModel("")
    }
    
    static func getAll(in realm: Realm = try! Realm()) -> Results<PlaylistModel> {
        return realm.objects(PlaylistModel.self)
    }
    
    func editName(name: String) {
        guard let realm = realm else { return }
        try! realm.write {
            self.name = name
        }
    }
    
    func addItem(item: ItemPlayList) {
        guard let realm = realm else { return }
        try! realm.write {
            self.items.append(item)
        }
    }
    
    func removeItem(item: ItemPlayList) {
        guard let realm = realm else { return }
        try! realm.write {
            for (index, value) in self.items.enumerated() {
                if(value.id == item.id) {
                    items.remove(at: index)
                }
            }
        }
    }
    
    func delete() {
        guard let realm = realm else { return }
        try! realm.write {
            realm.delete(self)
        }
    }
    
}


@objcMembers class ItemPlayList: Object {

    dynamic var name: String = ""
    dynamic var id: String = ""
    dynamic var thumbnail: String = ""
    dynamic var channelTitle: String = ""
    
    convenience init(name: String, id: String, thumbnail: String, channelTitle: String) {
        self.init()
        self.name = name
        self.id = id
        self.thumbnail = thumbnail
        self.channelTitle = channelTitle
    }
}

extension ItemPlayList {
    
    static func getAll(in realm: Realm = try! Realm()) -> Results<ItemPlayList> {
        return realm.objects(ItemPlayList.self)
    }
    
    static func add(item: ItemPlayList, in realm: Realm = try! Realm()) -> ItemPlayList {
        let _item = Array(ItemPlayList.getAll()).filter { $0.id == item.id }
        if(_item.count == 0) {
            if(ItemPlayList.getAll().count >= 50) {
                ItemPlayList.getAll()[0].delete()
            }
            try! realm.write {
                realm.add(item)
            }
        }
        return item
    }
    
    func delete() {
        guard let realm = realm else { return }
        try! realm.write {
            realm.delete(self)
        }
    }
}
