//
//  SmokeLineChartUIView.swift
//  Skiliket_Reto
//
//  Created by José Antonio Pacheco on 15/10/24.
//

import SwiftUI
import Charts

struct SmokeLineChartUIView: View {
    var smokeData: [Smoke]
    @State private var selectedReading: Smoke?
    
    var body: some View {
        VStack{
            Text("Smoke")
                .font(.title)
                .padding()
            
            Chart {
                ForEach(smokeData) { reading in
                    LineMark(
                        x: .value("Time", reading.timeStamp),
                        y: .value("Smoke", Double(reading.value) ?? 0.0)
                    )
                    .interpolationMethod(.catmullRom)
                }
            }
            .chartYScale(domain: 0...100)
            .chartXAxisLabel("Date&time", position: .bottom)
            .chartYAxisLabel("°Celsius", position: .leading)
            .padding()
            .chartOverlay { proxy in
                GeometryReader { geo in
                    Rectangle().fill(Color.clear).contentShape(Rectangle())
                        .gesture(
                            DragGesture()
                                .onChanged { value in
                                    let location = value.location
                                    if let date: Date = proxy.value(atX: location.x),
                                       let closestReading = smokeData.min(by: {
                                           abs($0.timeStamp.timeIntervalSince(date)) <
                                           abs($1.timeStamp.timeIntervalSince(date))
                                       }) {
                                        selectedReading = closestReading
                                    }
                                }
                        )
                }
            }
                        
            if let selectedReading = selectedReading {
                Text("Smoke: \(selectedReading.value) °C")
                    .font(.headline)
                Text("Date: \(selectedReading.timeStamp.formatted(date: .numeric, time: .shortened))")
                    .font(.subheadline)
                    .padding(.top, 4)
            }
        }
    }
}

#Preview {
    SmokeLineChartUIView(smokeData: [
        Smoke(value: "22.0", timeStamp: Date().addingTimeInterval(-3600)),
        Smoke(value: "23.5", timeStamp: Date().addingTimeInterval(-1800)),
        Smoke(value: "24.0", timeStamp: Date())
    ])
}
