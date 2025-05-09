//
//  PomodoroPicker.swift
//  Univert
//
//  Created by Adrian Neshad on 2025-05-04.
//

import SwiftUI

struct PomodoroPicker<Content, Item: Hashable>: View where Content: View {
    @State private var persistentOffset: CGFloat = 0
    @State private var offset: CGFloat = 0
    @State private var previousSelection: Item?
    
    @Binding var selection: Item?
    
    let options: [Item]
    let itemWidth: CGFloat?
    let onChange: ((Item?) -> ())?
    
    let content: (Item) -> Content
    
    private let feedbackGenerator = UISelectionFeedbackGenerator()  // 🟢 Feedback generator
    
    func itemWidthOverride(_ geometry: GeometryProxy) -> CGFloat {
        return itemWidth ?? geometry.size.height * 0.15
    }
    
    init(selection: Binding<Item?>, options: [Item], width itemWidth: CGFloat? = nil, onChange: ((Item?) -> ())? = nil, @ViewBuilder _ content: @escaping (Item) -> Content) {
        _selection = selection
        self.options = options
        self.itemWidth = itemWidth
        self.onChange = onChange
        self.content = content
        
        feedbackGenerator.prepare()  // 🟢 Prepare feedback at init
    }
    
    var body: some View {
        GeometryReader { geometry in
            Picker(geometry)
        }
        .onAppear {
            feedbackGenerator.prepare()  // 🟢 Prepare again on appear
        }
        .onChange(of: selection) { onChange?($0) }
    }
    
    @ViewBuilder
    private func Picker(_ geometry: GeometryProxy) -> some View {
        VStack (spacing: 0) {
            Spacer()
                .frame(height: geometry.size.height / 2 - itemWidthOverride(geometry) / 2)
            
            ForEach (options, id: \.self) { option in
                GeometryReader { geo in
                    VStack (spacing: 0) {
                        let relativeY = geo.frame(in: .named("pomodoroPicker")).midY
                        let ratio: Double = (geometry.size.height / 2 - relativeY) / (geometry.size.height / 2)
                        let angle = Angle(degrees: Double(90) * ratio)
                        let scale = 1 - abs(ratio) <= 0 ? 0.001 : 1 - abs(ratio) / 1
                        Group {
                            if scale == 0.001 {
                                content(option)
                                    .hidden()
                            } else {
                                content(option)
                                    .scaleEffect(scale)
                            }
                        }
                        .position(x: geo.size.width / 2, y: geo.size.height / 2)
                        .rotation3DEffect(angle, axis: (x: 1, y: 0, z: 0)) // Vertikal lutning
                    }
                }
                .frame(height: itemWidthOverride(geometry))
                .onTapGesture { onTapped(option, geometry) }
            }
            
            Spacer()
                .frame(height: geometry.size.height / 2 - itemWidthOverride(geometry) / 2)
        }
        .contentShape(Rectangle())
        .offset(x: 0, y: persistentOffset + offset)
        .coordinateSpace(name: "pomodoroPicker")
        .gesture(
            DragGesture()
                .onChanged { onDragChanged($0, geometry) }
                .onEnded { onDragEnded($0, geometry) }
        )
    }
    
    private func onTapped(_ option: Item, _ geometry: GeometryProxy) {
        guard let index = options.firstIndex(of: option) else { return }
        
        withAnimation(.spring()) {
            self.persistentOffset = CGFloat(index) * itemWidthOverride(geometry) * -1
            self.offset = 0
        }
        
        selection = option
        
        // 🟢 Haptic feedback vid tap
        feedbackGenerator.selectionChanged()
        feedbackGenerator.prepare()
        
        previousSelection = option
    }
    
    private func onDragChanged(_ drag: DragGesture.Value, _ geometry: GeometryProxy) {
        let totalOffset = persistentOffset + drag.translation.height
        
        var newOffset: CGFloat!
        var calculatedIndex: Int!
        let length = CGFloat(options.count - 1) * itemWidthOverride(geometry)
        
        if totalOffset > 0 {
            let offsetToEdge = drag.translation.height - abs(totalOffset)
            newOffset = offsetToEdge + totalOffset / 2.5
            calculatedIndex = 0
        } else if totalOffset < -length {
            let offsetOffEdge = totalOffset + length
            let offsetToEdge = drag.translation.height - offsetOffEdge
            newOffset = offsetToEdge + offsetOffEdge / 2.5
            calculatedIndex = options.count - 1
        } else {
            newOffset = drag.translation.height
            calculatedIndex = Int(round(abs(totalOffset / itemWidthOverride(geometry))))
        }
        
        guard calculatedIndex >= 0 && calculatedIndex < options.count else {
            selection = nil
            return
        }
        
        withAnimation(.easeOut(duration: 0.15)) {
            self.offset = newOffset
        }
        
        selection = options[calculatedIndex]
        
        // 🟢 Haptic feedback vid ny selection under scroll
        if selection != previousSelection {
            feedbackGenerator.selectionChanged()
            feedbackGenerator.prepare()
            previousSelection = selection
        }
    }
    
    private func onDragEnded(_ drag: DragGesture.Value, _ geometry: GeometryProxy) {
        let totalOffset = persistentOffset + drag.translation.height
        
        var calculatedIndex: Int!
        let length = CGFloat(options.count - 1) * itemWidthOverride(geometry)
        
        if totalOffset > 0 {
            calculatedIndex = 0
        } else if totalOffset < -length {
            calculatedIndex = options.count - 1
        } else {
            calculatedIndex = Int(round(abs(totalOffset / itemWidthOverride(geometry))))
        }
        
        guard calculatedIndex >= 0 && calculatedIndex < options.count else {
            selection = nil
            return
        }
        
        withAnimation(.spring()) {
            self.persistentOffset = CGFloat(calculatedIndex) * itemWidthOverride(geometry) * -1
            self.offset = 0
        }
        
        selection = options[calculatedIndex]
        
        // 🟢 Haptic feedback på end? (frivilligt, kan tas bort)
        if selection != previousSelection {
            feedbackGenerator.selectionChanged()
            feedbackGenerator.prepare()
            previousSelection = selection
        }
    }
}
