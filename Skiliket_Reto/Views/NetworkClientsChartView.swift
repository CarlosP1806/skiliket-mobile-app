//
//  NetworkClientsChartView.swift
//  Skiliket_Reto
//
//  Created by Pedro Luis Pérez Collado on 14/10/24.
//

import SwiftUI
import Charts

struct NetworkClientsChartView: View {
    let networkHealthData: [NetworkHealthResponse] // Array of NetworkHealthResponse

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("% of Healthy Connected Clients")
                .font(.headline)
                .foregroundColor(.white)
                .padding(.leading, 16)
            
            HStack {
                // SwiftUI chart to display healthy client percentages over time
                Chart {
                    ForEach(networkHealthData.filterUniqueTimestamps().suffix(5), id: \.timestamp) { dataPoint in
                        LineMark(
                            // Format time to "MM:ss" for x-axis labels
                            x: .value("Time", formatTime(dataPoint.date ?? Date())),
                            y: .value("Clients", Double(dataPoint.clients.totalPercentage) ?? 0.0)
                        )
                        .foregroundStyle(.green)
                    }
                }
                .chartYAxis {
                    AxisMarks(position: .leading) {
                        AxisGridLine()
                            .foregroundStyle(Color.gray) // Color for the Y-axis grid lines
                        AxisTick()
                            .foregroundStyle(Color.white) // Color for the Y-axis ticks
                        AxisValueLabel()
                            .foregroundStyle(Color.white) // Color for the Y-axis labels
                    }
                }
                .chartXAxis {
                    AxisMarks(position: .bottom) {
                        AxisGridLine()
                            .foregroundStyle(Color.gray) // Color for the X-axis grid lines
                        AxisTick()
                            .foregroundStyle(Color.white) // Color for the X-axis ticks
                        AxisValueLabel()
                            .foregroundStyle(Color.white) // Color for the X-axis labels
                    }
                }
                .frame(height: 150)
                .padding()
                
                // Clients Health Level display
                VStack(spacing: 2) {
                    Text("Healthy Clients")
                        .font(.caption)
                        .foregroundColor(.white)
                    Text("\(networkHealthData.last?.clients.totalPercentage ?? "0")%")
                        .font(.title3)
                        .bold()
                        .foregroundColor(.white)
                }
                .padding(.top, 4)
            }
        }
        .padding(16)
        .background(Color.black)
        .cornerRadius(15)
        .overlay(
            RoundedRectangle(cornerRadius: 15)
                .stroke(Color.green, lineWidth: 2) // Blue border around the view
        )
        .shadow(radius: 5)
    }

    // Function to format Date into minutes and seconds only (MM:ss)
    func formatTime(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "mm:ss"
        return formatter.string(from: date)
    }
}

