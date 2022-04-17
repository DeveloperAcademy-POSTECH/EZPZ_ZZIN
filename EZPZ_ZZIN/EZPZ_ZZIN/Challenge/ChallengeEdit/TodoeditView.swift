//
//  TodoeditView.swift
//  EZPZ_ZZIN
//
//  Created by 이주화 on 2022/04/14.
//

import SwiftUI

struct TodoeditView: View {
    
    @Environment(\.managedObjectContext) private var viewContext
    @Environment(\.presentationMode) var presentationMode
    
    @ObservedObject var todoEntity: TodoEntity
    @State var todoTitle: String = ""
    private var label: String
    private let mask: Int64
    @Binding var flag: Int
    
    @State var mondayCheck = false
    @State var tuesdayCheck = false
    @State var wednesdayCheck = false
    @State var thursdayCheck = false
    @State var fridayCheck = false
    @State var saturdayCheck = false
    @State var sundayCheck = false
    
    init(todoEntity: TodoEntity, label: String, mask: Int64, flag: Binding<Int>) {
        self.todoEntity = todoEntity
        self.label = label
        self.mask = mask
        self._flag = flag
    }
    
    private func bitmask() -> Int64 {
        var result: Int64 = 0
        if mondayCheck {
            result |= (1 << 0)
        }
        if tuesdayCheck {
            result |= (1 << 1)
        }
        if wednesdayCheck {
            result |= (1 << 2)
        }
        if thursdayCheck {
            result |= (1 << 3)
        }
        if fridayCheck {
            result |= (1 << 4)
        }
        if saturdayCheck {
            result |= (1 << 5)
        }
        if sundayCheck {
            result |= (1 << 6)
        }
        return result
    }
    
    private func saveTodoEntity() {
        todoEntity.label = todoTitle
        todoEntity.mask = bitmask()
        do {
            try viewContext.save()
        } catch {
            print(error)
        }
    }
    
    var body: some View {
        ZStack {
            Color("ezpzBlack")
                .edgesIgnoringSafeArea(.all)
            VStack{
                HStack {
                    Button {
                        presentationMode.wrappedValue.dismiss()
                    } label: {
                        Image(systemName: "xmark")
                            .font(.custom("SpoqaHanSansNeo-Bold",size: 17))
                            .padding(.leading, 17.0)
                            .padding(.top, 20.0)
                            .foregroundColor(ColorManage.ezpzLightgrey)
                    }
                    Spacer()
                    Button {
                        saveTodoEntity()
                        flag ^= 1
                        presentationMode.wrappedValue.dismiss()
                    } label: {
                        Image(systemName: "checkmark")
                            .font(.custom("SpoqaHanSansNeo-Bold",size: 17))
                            .padding(.trailing, 17.0)
                            .padding(.top, 20.0)
                            .foregroundColor(ColorManage.ezpzLightgrey)
                    }
                }
                .padding(.bottom, 20)
                HStack{
                    Text("To do")
                        .font(.custom("SpoqaHanSansNeo-Bold",size: 17))
                        .foregroundColor(ColorManage.ezpzLightgrey)
                        .padding(.leading, 17)
                    Spacer()
                }
                .padding(.bottom, 8)
                
                TextField("Create a To do.", text: $todoTitle)
                    .font(.custom("SpoqaHanSansNeo-Regular",size: 17))
                    .foregroundColor(ColorManage.ezpzLightgrey)
                    .padding(.leading, 17)
                    .onAppear {
                        todoTitle = label
                    }
                
                Divider()
                    .padding([.leading, .trailing], 17)
                    .padding(.bottom, 25)
                ZStack{
                    RoundedRectangle(cornerRadius: 10.0)
                        .fill(ColorManage.ezpzDeepgrey)
                        .frame(width: 356, height: 107)
                    VStack{
                        Group{
                            HStack{
                                Text("Notice")
                                    .font(.custom("SpoqaHanSansNeo-Bold",size: 24))
                                    .foregroundColor(ColorManage.ezpzPink)
                                    .padding(.leading, 34)
                                Spacer()
                            }.padding(.bottom, 3)
                            HStack{
                                Text("Not a repetitive a To do")
                                    .font(.custom("SpoqaHanSansNeo-Bold",size: 17))
                                    .foregroundColor(ColorManage.ezpzLightgrey)
                                    .padding(.leading, 34)
                                Spacer()
                            }
                            HStack{
                                Text("Let them unselected.")
                                    .font(.custom("SpoqaHanSansNeo-Bold",size: 17))
                                    .foregroundColor(ColorManage.ezpzLightgrey)
                                    .padding(.leading, 34)
                                Spacer()
                            }
                        }
                    }
                }.padding(.bottom, 40)
                Group{
                    HStack{
                        Text("Schedule")
                            .font(.custom("SpoqaHanSansNeo-Bold",size: 17))
                            .foregroundColor(ColorManage.ezpzLightgrey)
                            .padding(.leading, 17)
                        Spacer()
                    }.padding(.bottom, 0.1)
                    HStack{
                        Text("Select the days of the week to repeat")
                            .font(.custom("SpoqaHanSansNeo-Bold",size: 17))
                            .foregroundColor(ColorManage.ezpzLightgrey)
                            .padding(.leading, 17)
                        Spacer()
                    }.padding(.bottom, 5)
                }
                HStack{
                    
                    Button(action: {
                        mondayCheck.toggle()
                    }) {
                        ZStack{
                            if mondayCheck {
                                RoundedRectangle(cornerRadius: 10.0)
                                    .fill(Color.black)
                                    .frame(width: 44, height: 62)
                            }else {
                                RoundedRectangle(cornerRadius: 10.0)
                                    .fill(ColorManage.ezpzDeepgrey)
                                    .frame(width: 44, height: 62)
                            }
                            VStack{
                                if mondayCheck {
                                    Text("Mon")
                                        .font(.custom("SpoqaHanSansNeo-Bold",size: 13))
                                        .foregroundColor(ColorManage.ezpzLime)
                                }else {
                                    Text("Mon")
                                        .font(.custom("SpoqaHanSansNeo-Bold",size: 13))
                                        .foregroundColor(ColorManage.ezpzDisable)
                                    
                                }
                            }
                        }
                        .onAppear {
                            if (self.mask & (1 << 0)) != 0 {
                                mondayCheck = true
                            }
                        }
                    }
                    Button(action: {
                        tuesdayCheck.toggle()
                    }) {
                        ZStack{
                            if tuesdayCheck {
                                RoundedRectangle(cornerRadius: 10.0)
                                    .fill(Color.black)
                                    .frame(width: 44, height: 62)
                            }else {
                                RoundedRectangle(cornerRadius: 10.0)
                                    .fill(ColorManage.ezpzDeepgrey)
                                    .frame(width: 44, height: 62)
                            }
                            VStack{
                                if tuesdayCheck {
                                    Text("Tue")
                                        .font(.custom("SpoqaHanSansNeo-Bold",size: 13))
                                        .foregroundColor(ColorManage.ezpzLime)
                                }else {
                                    Text("Tue")
                                        .font(.custom("SpoqaHanSansNeo-Bold",size: 13))
                                        .foregroundColor(ColorManage.ezpzDisable)
                                    
                                }
                            }
                        }
                        .onAppear {
                            if (self.mask & (1 << 1)) != 0 {
                                tuesdayCheck = true
                            }
                        }
                    }
                    Button(action: {
                        wednesdayCheck.toggle()
                    }) {
                        ZStack{
                            if wednesdayCheck {
                                RoundedRectangle(cornerRadius: 10.0)
                                    .fill(Color.black)
                                    .frame(width: 44, height: 62)
                            }else {
                                RoundedRectangle(cornerRadius: 10.0)
                                    .fill(ColorManage.ezpzDeepgrey)
                                    .frame(width: 44, height: 62)
                            }
                            VStack{
                                if wednesdayCheck {
                                    Text("Wed")
                                        .font(.custom("SpoqaHanSansNeo-Bold",size: 13))
                                        .foregroundColor(ColorManage.ezpzLime)
                                }else {
                                    Text("Wed")
                                        .font(.custom("SpoqaHanSansNeo-Bold",size: 13))
                                        .foregroundColor(ColorManage.ezpzDisable)
                                    
                                }
                            }
                        }
                        .onAppear {
                            if (self.mask & (1 << 2)) != 0 {
                                wednesdayCheck = true
                            }
                        }
                    }
                    Button(action: {
                        thursdayCheck.toggle()
                    }) {
                        ZStack{
                            if thursdayCheck {
                                RoundedRectangle(cornerRadius: 10.0)
                                    .fill(Color.black)
                                    .frame(width: 44, height: 62)
                            }else {
                                RoundedRectangle(cornerRadius: 10.0)
                                    .fill(ColorManage.ezpzDeepgrey)
                                    .frame(width: 44, height: 62)
                            }
                            VStack{
                                if thursdayCheck {
                                    Text("Thu")
                                        .font(.custom("SpoqaHanSansNeo-Bold",size: 13))
                                        .foregroundColor(ColorManage.ezpzLime)
                                }else {
                                    Text("Thu")
                                        .font(.custom("SpoqaHanSansNeo-Bold",size: 13))
                                        .foregroundColor(ColorManage.ezpzDisable)
                                    
                                }
                            }
                        }
                        .onAppear {
                            if (self.mask & (1 << 3)) != 0 {
                                thursdayCheck = true
                            }
                        }
                    }
                    Button(action: {
                        fridayCheck.toggle()
                    }) {
                        ZStack{
                            if fridayCheck {
                                RoundedRectangle(cornerRadius: 10.0)
                                    .fill(Color.black)
                                    .frame(width: 44, height: 62)
                            }else {
                                RoundedRectangle(cornerRadius: 10.0)
                                    .fill(ColorManage.ezpzDeepgrey)
                                    .frame(width: 44, height: 62)
                            }
                            VStack{
                                if fridayCheck {
                                    Text("Fri")
                                        .font(.custom("SpoqaHanSansNeo-Bold",size: 13))
                                        .foregroundColor(ColorManage.ezpzLime)
                                }else {
                                    Text("Fri")
                                        .font(.custom("SpoqaHanSansNeo-Bold",size: 13))
                                        .foregroundColor(ColorManage.ezpzDisable)
                                    
                                }
                            }
                        }
                        .onAppear {
                            if (self.mask & (1 << 4)) != 0 {
                                fridayCheck = true
                            }
                        }
                    }
                    Button(action: {
                        saturdayCheck.toggle()
                    }) {
                        ZStack{
                            if saturdayCheck {
                                RoundedRectangle(cornerRadius: 10.0)
                                    .fill(Color.black)
                                    .frame(width: 44, height: 62)
                            }else {
                                RoundedRectangle(cornerRadius: 10.0)
                                    .fill(ColorManage.ezpzDeepgrey)
                                    .frame(width: 44, height: 62)
                            }
                            VStack{
                                if saturdayCheck {
                                    Text("Sat")
                                        .font(.custom("SpoqaHanSansNeo-Bold",size: 13))
                                        .foregroundColor(ColorManage.ezpzLime)
                                }else {
                                    Text("Sat")
                                        .font(.custom("SpoqaHanSansNeo-Bold",size: 13))
                                        .foregroundColor(ColorManage.ezpzDisable)
                                    
                                }
                            }
                        }
                        .onAppear {
                            if (self.mask & (1 << 5)) != 0 {
                                saturdayCheck = true
                            }
                        }
                    }
                    Button(action: {
                        sundayCheck.toggle()
                    }) {
                        ZStack{
                            if sundayCheck {
                                RoundedRectangle(cornerRadius: 10.0)
                                    .fill(Color.black)
                                    .frame(width: 44, height: 62)
                            }else {
                                RoundedRectangle(cornerRadius: 10.0)
                                    .fill(ColorManage.ezpzDeepgrey)
                                    .frame(width: 44, height: 62)
                            }
                            VStack{
                                if sundayCheck {
                                    Text("Sun")
                                        .font(.custom("SpoqaHanSansNeo-Bold",size: 13))
                                        .foregroundColor(ColorManage.ezpzLime)
                                }else {
                                    Text("Sun")
                                        .font(.custom("SpoqaHanSansNeo-Bold",size: 13))
                                        .foregroundColor(ColorManage.ezpzDisable)
                                    
                                }
                            }
                        }
                        .onAppear {
                            if (self.mask & (1 << 6)) != 0 {
                                sundayCheck = true
                            }
                        }
                    }
                    
                    
                }
                Spacer()
                
            }
        }
    }
}
