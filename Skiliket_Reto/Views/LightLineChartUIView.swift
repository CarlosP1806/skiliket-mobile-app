//
//  LightBarChartUIView.swift
//  Skiliket_Reto
//
//  Created by José Antonio Pacheco on 15/10/24.
//

import SwiftUI
import Charts

struct LightChartUIView: View {
    var lightData: [Light]
    
    var body: some View {
        VStack {
            Spacer().frame(height: 30)
            Text("Light Presence")
                .font(.title3)
                .foregroundColor(.white)
                .frame(maxWidth: .infinity, alignment: .center)
            Spacer()
            
            ZStack {
                GeometryReader { geometry in
                    VStack(spacing: 0) {
                        let width = geometry.size.width * 0.8
                        let heightGreen = CGFloat(geometry.size.height) * 0.50
                        let heightRed = CGFloat(geometry.size.height) * 0.50
                        
                        // Background color areas for Low (Red) and High (Green) presence of light
                        Color.green
                            .frame(width: width, height: heightGreen)
                            .cornerRadius(10, corners: [.topLeft])
                            .offset(x: geometry.size.width * 0.2)
                        
                        Color.red
                            .frame(width: width, height: heightRed)
                            .cornerRadius(10, corners: [.bottomLeft])
                            .offset(x: geometry.size.width * 0.2)
                    }
                }
                
                // Overlay for line chart
                .overlay(
                    Chart {
                        ForEach(lightData) { data in
                            LineMark(
                                x: .value("Time", data.timeStamp),
                                y: .value("Light", (Double(data.value) == 1.0) ? 0.75 : 0.25)
                            )
                            .foregroundStyle(.white)
                            .lineStyle(StrokeStyle(lineWidth: 2, dash: [5, 5]))
                        }
                        
                        // Define rules at 0.25 (Low presence) and 0.75 (High presence)
                        RuleMark(y: .value("Low Presence", 0.25))
                            .lineStyle(StrokeStyle(lineWidth: 1, dash: [5]))
                            .foregroundStyle(.red)
                        
                        RuleMark(y: .value("High Presence", 0.75))
                            .lineStyle(StrokeStyle(lineWidth: 1, dash: [5]))
                            .foregroundStyle(.green)
                    }
                    .chartYScale(domain: 0...1)
                    .chartYAxis {
                        AxisMarks(position: .leading) { value in
                            if let yValue = value.as(Double.self) {
                                if yValue == 0.75 {
                                    AxisValueLabel { Text("High Light") }
                                        .foregroundStyle(.white)
                                        .offset(y: 4)
                                } else if yValue == 0.25 {
                                    AxisValueLabel { Text("Low Light") }
                                        .foregroundStyle(.white)
                                }
                            }
                        }
                    }
                    .chartXAxis {
                        AxisMarks(position: .bottom) { AxisValueLabel().foregroundStyle(.white) }
                    }
                    .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(Color.green, lineWidth: 1)
                            .padding(.top, -10)
                    )
                )
            }
            .padding()
            .frame(maxHeight: 300)
            
            Spacer().frame(height: 20)
            
            VStack {
                Text("Current Light Presence")
                    .font(.headline)
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity, alignment: .center)
                HStack {
                    Image(systemName: "lightbulb.fill")
                        .resizable()
                        .frame(width: 50, height: 40)
                        .foregroundColor(.yellow)
                        .padding(.trailing, 20)
                    Text(lightData.last?.value == "1" ? "High" : "Low")
                        .font(.largeTitle)
                        .bold()
                        .foregroundColor(.white)
                }
                .frame(maxWidth: .infinity, alignment: .center)
            }
            .padding()
            .padding(.bottom, 250)
        }
        .background(Color.black)
    }
}

#Preview {
    LightChartUIView(lightData: [
        Light(value: "0", timeStamp: Date().addingTimeInterval(-3600 * 4)),
        Light(value: "1", timeStamp: Date().addingTimeInterval(-3600 * 3)),
        Light(value: "0", timeStamp: Date().addingTimeInterval(-3600 * 2)),
        Light(value: "1", timeStamp: Date().addingTimeInterval(-3600)),
        Light(value: "0", timeStamp: Date())
    ])
}
