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
        VStack(alignment: .leading, spacing: 12) {
            Text("% of Healthy Network Devices")
                .font(.headline)
                .foregroundColor(.white)
                .padding(.leading, 16)
            
            HStack {
                // SwiftUI chart to display health percentages over time
                Chart {
                    ForEach(networkHealthData.filterUniqueTimestamps().suffix(5), id: \.timestamp) { dataPoint in
                        LineMark(
                            // Format time to "MM:ss" for x-axis labels
                            x: .value("Time", formatTime(dataPoint.date ?? Date())),
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
                VStack(spacing: 2) {
                    Text("Health Level")
                        .font(.caption)
                        .foregroundColor(.white)
                    Text("\(networkHealthData.last?.networkDevices.totalPercentage ?? "0")%")
                        .font(.title3)
                        .bold()
                        .foregroundColor(.white)
                }
                .padding(.top, 4)
            }
        }
        .padding(16)
        .background(Color.blue)
        .cornerRadius(15)
        .shadow(radius: 5)
    }

    // Function to format Date into minutes and seconds only (MM:ss)
    func formatTime(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "mm:ss"
        return formatter.string(from: date)
    }
}

