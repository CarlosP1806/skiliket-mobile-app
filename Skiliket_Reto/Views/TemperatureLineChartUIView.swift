//
//  TemperatureLineChartUIView.swift
//  Skiliket_Reto
//
//  Created by José Antonio Pacheco on 14/10/24.
//

import SwiftUI
import Charts

struct TemperatureLineChartUIView: View {
    var temperatureData: [Temperature]
    @State private var selectedReading: Temperature?
    
    var body: some View {
        VStack{
            Text("Temperature")
                .font(.title)
                .foregroundColor(.white)
                .padding()
            
            let filledTemperatureData = Array(fillDataWithDefaults(temperatureData).suffix(4))
            
            Chart {
                ForEach(temperatureData) { reading in
                    LineMark(
                        x: .value("Time", reading.timeStamp),
                        y: .value("Temperature", Double(reading.value) ?? 0.0)
                    )
                    .interpolationMethod(.catmullRom)
                    .foregroundStyle(reading.value < "50.0" ? Color.blue : Color.red)
                }
            }
            .chartYScale(domain: calculateYAxisRange(from: filledTemperatureData))
            .chartXAxisLabel("Date & time", position: .bottom)
            .chartYAxisLabel("Temperature °Celsius", position: .leading)
            .padding()
            .chartOverlay { proxy in
                GeometryReader { geo in
                    Rectangle().fill(Color.clear).contentShape(Rectangle())
                        .gesture(
                            DragGesture()
                                .onChanged { value in
                                    let location = value.location
                                    if let date: Date = proxy.value(atX: location.x),
                                       let closestReading = filledTemperatureData.min(by: {
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
                Text("Temperature: \(selectedReading.value) °C")
                    .font(.headline)
                Text("Date: \(selectedReading.timeStamp.formatted(date: .numeric, time: .shortened))")
                    .font(.subheadline)
                    .padding(.top, 4)
            }
        }
    }
    // Ensure there are always at least 5 data points
    func fillDataWithDefaults(_ data: [Temperature]) -> [Temperature] {
        var filledData = data
        
        // If there are fewer than 5 entries, add default placeholder data
        let defaultTemperature = Temperature(value: "0.0", timeStamp: Date().addingTimeInterval(-3600))
        while filledData.count < 4 {
            filledData.insert(defaultTemperature, at: 0)
        }
        
        return filledData
    }
    // Calculate the Y-axis range based on the data, with a buffer
    func calculateYAxisRange(from data: [Temperature]) -> ClosedRange<Double> {
        let minTemperature = data.map { Double($0.value) ?? 0.0 }.min() ?? 0.0
        let maxTemperature = data.map { Double($0.value) ?? 0.0 }.max() ?? 100.0
        let buffer = 10.0 // Add some buffer to the Y-axis range for clarity
        
        return (minTemperature - buffer)...(maxTemperature + buffer)
    }
}

#Preview {
    TemperatureLineChartUIView(temperatureData: [
        Temperature(value: "22.0", timeStamp: Date().addingTimeInterval(-3600)),
        Temperature(value: "23.5", timeStamp: Date().addingTimeInterval(-1800)),
        Temperature(value: "24.0", timeStamp: Date())
    ])
}
