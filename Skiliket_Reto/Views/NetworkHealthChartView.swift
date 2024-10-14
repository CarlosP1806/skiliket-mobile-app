//
//  NetworkHealthChartView.swift
//  Skiliket_Reto
//
//  Created by Pedro Luis Pérez Collado on 13/10/24.
//

import SwiftUI
import Charts

struct NetworkHealthChartView: View {
    let networkHealthData: [NetworkHealthResponse] // Array of NetworkHealthResponse

    var body: some View {
        VStack {
            Text("Percentage of Healthy Network Devices Over Time")
                .font(.headline)
                .foregroundColor(.white)
            
            HStack {
                // SwiftUI chart to display health percentages over time
                Chart {
                    ForEach(networkHealthData, id: \.timestamp) { dataPoint in
                        LineMark(
                            x: .value("Time", dataPoint.timestamp),
                            y: .value("Health", Double(dataPoint.networkDevices.totalPercentage) ?? 0.0)
                        )
                        .foregroundStyle(.green)
                    }
                }
                .chartYAxis {
                    AxisMarks(position: .leading) {
                        AxisGridLine()
                        AxisTick()
                        AxisValueLabel()
                    }
                }
                .frame(height: 150)
                .padding()
                
                // Health Level display
                VStack {
                    Text("Health Level")
                        .font(.subheadline)
                        .foregroundColor(.white)
                    Text("\(networkHealthData.last?.networkDevices.totalPercentage ?? "0")%")
                        .font(.largeTitle)
                        .bold()
                        .foregroundColor(.white)
                }
                .padding()
            }
        }
        .padding()
        .background(Color.blue)
        .cornerRadius(15)
        .shadow(radius: 5)
    }
}
