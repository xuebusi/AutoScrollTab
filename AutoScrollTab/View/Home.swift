//
//  Home.swift
//  AutoScrollTab
//
//  Created by shiyanjun on 2023/9/4.
//

import SwiftUI

struct Home: View {
    @State var activeTab: Tab = .men
    
    var body: some View {
        VStack {
            TabIndicator(activeTab: $activeTab)
            TabContent(activeTab: $activeTab)
            
            Spacer()
        }
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct TabContent: View {
    @Binding var activeTab: Tab
    
    var body: some View {
        TabView(selection: $activeTab) {
            ForEach(Tab.allCases, id: \.rawValue) {
                Image($0.rawValue)
                    .resizable()
                    .scaledToFill()
                    .tag($0)
            }
        }
        .tabViewStyle(.page(indexDisplayMode: .never))
    }
}

struct TabIndicator: View {
    @Binding var activeTab: Tab
    @State var offsetX: CGFloat = .zero
    
    var body: some View {
        GeometryReader {
            let rect = $0.frame(in: .global)
            let tabWidth = rect.width / 3
            
            HStack(spacing: 0) {
                ForEach(Tab.allCases, id: \.rawValue) { tab in
                    Text(tab.rawValue)
                        .font(.title2)
                        .foregroundColor(self.activeTab == tab ? .white : .gray)
                        .frame(width: tabWidth)
                        .onTapGesture {
                            withAnimation(.easeInOut(duration: 0.3)) {
                                self.activeTab = tab
                                self.offsetX = self.activeTab.offsetX(tabWidth)
                            }
                        }
                }
            }
            .offset(x: self.offsetX)
            .frame(width: CGFloat(Tab.allCases.count) * tabWidth)
            .frame(height: rect.height)
            .onAppear {
                self.offsetX = self.activeTab.offsetX(tabWidth)
            }
            .onChange(of: self.activeTab) { newTab in
                withAnimation(.default) {
                    self.offsetX = self.activeTab.offsetX(tabWidth)
                }
            }
        }
        .frame(height: 50)
    }
}
