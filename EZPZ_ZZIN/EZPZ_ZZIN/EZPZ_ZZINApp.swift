//
//  EZPZ_ZZINApp.swift
//  EZPZ_ZZIN
//
//  Created by Yeni Hwang on 2022/04/11.
//

import SwiftUI

@main
struct EZPZ_ZZINApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            TabBarMainView()
            // 앱이 실행되면 TabBarMainView로 연결이 됩니다.
            
            // ContentView() //기본코드
            //      .environment(\.managedObjectContext, persistenceController.container.viewContext)        }
        }
    }
}