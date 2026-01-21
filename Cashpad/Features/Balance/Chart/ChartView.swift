import SwiftUI
import Charts

struct ChartView: View {
    @ObservedObject var viewModel: ChartViewModel

    var body: some View {
        VStack(alignment: .leading, spacing: 24) {
            HStack(spacing: 12) {
                summaryCard(
                    title: "Income",
                    amount: viewModel.periodIncomeTotal,
                    isSelected: viewModel.selectedFlow == .income,
                    color: .green
                )
                .onTapGesture { viewModel.selectedFlow = .income }

                summaryCard(
                    title: "Expenses",
                    amount: viewModel.periodExpenseTotal,
                    isSelected: viewModel.selectedFlow == .expense,
                    color: .red
                )
                .onTapGesture { viewModel.selectedFlow = .expense }
            }
            
            Picker("Granularity", selection: $viewModel.selectedGranularity) {
                ForEach(Granularity.allCases) { g in
                    Text(g.rawValue).tag(g)
                }
            }
            .pickerStyle(.segmented)

            Text(viewModel.periodTitle)
                .font(.headline)
                .frame(maxWidth: .infinity)
                .contentShape(Rectangle())
                .gesture(
                    DragGesture(minimumDistance: 20)
                        .onEnded { value in
                            let threshold: CGFloat = 40
                            if value.translation.width <= -threshold {
                                withAnimation(.spring(response: 0.35, dampingFraction: 0.8)) { viewModel.shiftPeriod(1) }
                            } else if value.translation.width >= threshold {
                                withAnimation(.spring(response: 0.35, dampingFraction: 0.8)) { viewModel.shiftPeriod(-1) }
                            }
                        }
                )

            Chart {
                if viewModel.aggregated.isEmpty {
                    // Placeholder to keep axes visible when no data
                    let lower = viewModel.periodRange.lowerBound
                    let upper = viewModel.periodRange.upperBound
                    RuleMark(xStart: .value("Start", lower), xEnd: .value("End", upper))
                        .opacity(0.0)
                    RuleMark(y: .value("Zero", 0))
                        .opacity(0.0)
                } else {
                    ForEach(viewModel.aggregated, id: \.date) { bucket in
                        LineMark(
                            x: .value("Date", bucket.date),
                            y: .value("Amount", bucket.total)
                        )
                        .interpolationMethod(.catmullRom)
                        .symbol(Circle())
                        .foregroundStyle(viewModel.selectedFlow == .income ? Color.green : Color.red)
                        .lineStyle(StrokeStyle(lineWidth: 3, lineCap: .round, lineJoin: .round))
                    }
                    if let min = viewModel.aggregated.map({ $0.total }).min(), let max = viewModel.aggregated.map({ $0.total }).max() {
                        RuleMark(y: .value("Min", min))
                            .foregroundStyle(.secondary)
                            .lineStyle(.init(lineWidth: 1, dash: [4, 4]))
                        RuleMark(y: .value("Max", max))
                            .foregroundStyle(.secondary)
                            .lineStyle(.init(lineWidth: 1, dash: [4, 4]))
                    }
                }
            }
            // Axes & scales
            .chartXAxis {
                switch viewModel.selectedGranularity {
                case .day:
                    AxisMarks(values: .stride(by: .hour, count: 2)) { _ in
                        // Hide vertical grid lines by omitting AxisGridLine
                        AxisTick()
                        AxisValueLabel()
                    }
                case .week:
                    AxisMarks(values: .stride(by: .day, count: 1)) { _ in
                        AxisTick()
                        AxisValueLabel()
                    }
                case .year:
                    AxisMarks(values: .stride(by: .month, count: 1)) { _ in
                        AxisTick()
                        AxisValueLabel()
                    }
                }
            }
            .chartYAxis {
                AxisMarks(position: .leading)
            }
            .chartXScale(domain: viewModel.periodRange.lowerBound...viewModel.periodRange.upperBound)
            .chartYScale(domain: (viewModel.aggregated.map{ $0.total }.min() ?? 0)...(viewModel.aggregated.map{ $0.total }.max() ?? 1))
            .aspectRatio(1, contentMode: .fit)
            .contentShape(Rectangle())
            .gesture(
                DragGesture(minimumDistance: 20)
                    .onEnded { value in
                        let threshold: CGFloat = 40
                        let dx = value.translation.width
                        let dy = value.translation.height
                        // Only react to predominantly horizontal drags
                        guard abs(dx) > abs(dy) else { return }
                        if dx <= -threshold {
                            withAnimation(.spring(response: 0.35, dampingFraction: 0.8)) { viewModel.shiftPeriod(1) }
                        } else if dx >= threshold {
                            withAnimation(.spring(response: 0.35, dampingFraction: 0.8)) { viewModel.shiftPeriod(-1) }
                        }
                    }
            )
            .contentTransition(.numericText(value: Double(viewModel.filtered.count)))
            .onAppear {
                viewModel.selectedFlow = .income
            }
        }
        .padding()
        .background(Color("Background"))
    }
}

