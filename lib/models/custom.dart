import 'package:custom_pc/models/pc_parts.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class Custom {
  final PcParts? cpu;
  final PcParts? cpuCooler;
  final PcParts? memory;
  final PcParts? motherBoard;
  final PcParts? graphicsCard;
  final PcParts? ssd;
  final PcParts? pcCase;
  final PcParts? powerUnit;
  final PcParts? caseFan;

  Custom._(this.cpu, this.cpuCooler, this.memory, this.motherBoard, this.graphicsCard, this.ssd, this.pcCase, this.powerUnit, this.caseFan);

  static Custom create() {
    return Custom._(null, null, null, null, null, null, null, null, null);
  }

  Custom copyWith({PcParts? cpu, PcParts? cpuCooler, PcParts? memory, PcParts? motherBoard, PcParts? graphicsCard, PcParts? ssd, PcParts? pcCase, PcParts? powerUnit, PcParts? caseFan}) {
    return Custom._(cpu ?? this.cpu, cpuCooler ?? this.cpuCooler, memory ?? this.memory, motherBoard ?? this.motherBoard, graphicsCard ?? this.graphicsCard, ssd ?? this.ssd, pcCase ?? this.pcCase, powerUnit ?? this.powerUnit, caseFan ?? this.caseFan);
  }

  PcParts? get(PartsCategory category) {
    switch (category) {
      case PartsCategory.cpu:
        return cpu;
      case PartsCategory.cpuCooler:
        return cpuCooler;
      case PartsCategory.memory:
        return memory;
      case PartsCategory.motherBoard:
        return motherBoard;
      case PartsCategory.graphicsCard:
        return graphicsCard;
      case PartsCategory.ssd:
        return ssd;
      case PartsCategory.pcCase:
        return pcCase;
      case PartsCategory.powerUnit:
        return powerUnit;
      case PartsCategory.caseFan:
        return caseFan;
    }
  }
}

class CustomNotifier extends StateNotifier<Custom> {
  CustomNotifier(super.state);

  void setCpu(PcParts cpu) {
    state = state.copyWith(cpu: cpu);
  }

  void deleteCpu() {
    state = state.copyWith(cpu: null);
  }

  void setCpuCooler(PcParts cpuCooler) {
    state = state.copyWith(cpuCooler: cpuCooler);
  }

  void deleteCpuCooler() {
    state = state.copyWith(cpuCooler: null);
  }

  void setMemory(PcParts memory) {
    state = state.copyWith(memory: memory);
  }

  void deleteMemory() {
    state = state.copyWith(memory: null);
  }

  void setMotherBoard(PcParts motherBoard) {
    state = state.copyWith(motherBoard: motherBoard);
  }

  void deleteMotherBoard() {
    state = state.copyWith(motherBoard: null);
  }

  void setGraphicsCard(PcParts graphicsCard) {
    state = state.copyWith(graphicsCard: graphicsCard);
  }

  void deleteGraphicsCard() {
    state = state.copyWith(graphicsCard: null);
  }

  void setSsd(PcParts ssd) {
    state = state.copyWith(ssd: ssd);
  }

  void deleteSsd() {
    state = state.copyWith(ssd: null);
  }

  void setPcCase(PcParts pcCase) {
    state = state.copyWith(pcCase: pcCase);
  }

  void deletePcCase() {
    state = state.copyWith(pcCase: null);
  }

  void setPowerUnit(PcParts powerUnit) {
    state = state.copyWith(powerUnit: powerUnit);
  }

  void deletePowerUnit() {
    state = state.copyWith(powerUnit: null);
  }

  void setCaseFan(PcParts caseFan) {
    state = state.copyWith(caseFan: caseFan);
  }

  void deleteCaseFan() {
    state = state.copyWith(caseFan: null);
  }

  void reset() {
    state = Custom.create();
  }

  void setCustom(Custom custom) {
    state = custom;
  }
}

final customNotifierProvider = StateNotifierProvider<CustomNotifier, Custom>((ref) {
  return CustomNotifier(Custom.create());
});
