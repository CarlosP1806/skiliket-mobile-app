//
//  SoundLineChartUIView.swift
//  Skiliket_Reto
//
//  Created by José Antonio Pacheco on 15/10/24.
//

import SwiftUI
import Charts

// Extensión para redondear esquinas específicas
extension View {
    func cornerRadius(_ radius: CGFloat, corners: UIRectCorner) -> some View {
        clipShape(RoundedCorner(radius: radius, corners: corners))
    }
}

struct RoundedCorner: Shape {
    var radius: CGFloat = .infinity
    var corners: UIRectCorner = .allCorners

    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(
            roundedRect: rect,
            byRoundingCorners: corners,
            cornerRadii: CGSize(width: radius, height: radius)
        )
        return Path(path.cgPath)
    }
}

struct SoundLineChartUIView: View {
    var soundData: [Sound]
    
    var body: some View {
        VStack {
            Spacer().frame(height: 30)
            Text("Noise Measurements")
                .font(.title3)
                .foregroundColor(.white)
                .frame(maxWidth: .infinity, alignment: .center)
            Spacer()
            
            ZStack {
                GeometryReader { geometry in
                    VStack(spacing: 0) {
                        let width = geometry.size.width * 0.8
                        let heightRed = CGFloat(geometry.size.height) * 0.305
                        let heightYellow = CGFloat(geometry.size.height) * 0.305
                        let heightGreen = CGFloat(geometry.size.height) * 0.30
                        
                        Color.red
                            .frame(width: width, height: heightRed)
                            .cornerRadius(10, corners: [.topLeft])
                            .offset(x: geometry.size.width * 0.2)
                        
                        Color.yellow
                            .frame(width: width, height: heightYellow)
                            .offset(x: geometry.size.width * 0.2)
                        
                        Color.green
                            .frame(width: width, height: heightGreen)
                            .cornerRadius(10, corners: [.bottomLeft])
                            .offset(x: geometry.size.width * 0.2)
                    }
                }
                
                .overlay(
                    Chart {
                        ForEach(soundData) { data in
                            LineMark(
                                x: .value("Time", data.timeStamp),
                                y: .value("Sound", Double(data.value) ?? 0.0)
                            )
                            .foregroundStyle(.white)
                        }
                        
                        RuleMark(y: .value("Low Level", 50))
                            .lineStyle(StrokeStyle(lineWidth: 1, dash: [5]))
                            .foregroundStyle(.green)
                        
                        RuleMark(y: .value("Moderate Level", 100))
                            .lineStyle(StrokeStyle(lineWidth: 1, dash: [5]))
                            .foregroundStyle(.yellow)
                        
                        RuleMark(y: .value("High Level", 150))
                            .lineStyle(StrokeStyle(lineWidth: 1, dash: [5]))
                            .foregroundStyle(.red)
                    }
                    .chartYScale(domain: 0...150)
                    .chartYAxis {
                        AxisMarks(position: .leading) { value in
                            if let yValue = value.as(Double.self) {
                                if yValue == 150 {
                                    AxisValueLabel { Text("150 dB") }
                                        .foregroundStyle(.white)
                                        .offset(y: 4)
                                } else if yValue == 50 || yValue == 100 {
                                    AxisValueLabel { Text("\(Int(yValue)) dB") }
                                        .foregroundStyle(.white)
                                } else {
                                    AxisValueLabel().foregroundStyle(.white)
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
                Text("Current Noise Measurement")
                    .font(.headline)
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity, alignment: .center)
                HStack {
                    Image(systemName: "speaker.wave.2.fill")
                        .resizable()
                        .frame(width: 50, height: 40)
                        .foregroundColor(.green)
                        .padding(.trailing, 20)
                    Text("\(soundData.last?.value ?? "0") dB")
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
    SoundLineChartUIView(soundData: [
        Sound(value: "50", timeStamp: Date().addingTimeInterval(-3600 * 4)),
        Sound(value: "100", timeStamp: Date().addingTimeInterval(-3600 * 3)),
        Sound(value: "120", timeStamp: Date().addingTimeInterval(-3600 * 2)),
        Sound(value: "80", timeStamp: Date().addingTimeInterval(-3600)),
        Sound(value: "150", timeStamp: Date())
    ])
}
