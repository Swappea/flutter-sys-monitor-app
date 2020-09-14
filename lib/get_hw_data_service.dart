import 'package:http/http.dart';
import 'dart:convert';

class HwData {
  double cpuLoad;
  double cpuTemp;
  double gpuLoad;
  double ramLoad;
  double gpuTemp;
  double gpuMemSize;
  double gpuMemLoad;

  double maxCpuLoad;
  double maxGpuLoad;
  double maxCpuTemp;
  double maxGpuTemp;
  double maxRamLoad;
  double maxGpuMem;

  String errorMessage;

  String pcName = 'Swapnesh';

  Future<void> getData() async {
    try {
      Response response = await get('http://192.168.1.12:8085/data.json');
      List data = jsonDecode(response.body)['Children'][0]['Children'];

      parseData(data);
    } catch (e) {
      print('caught error: $e');
      errorMessage = e.toString();
    }
  }

  parseData(List data) {
    setCpuData(data);
    setGpuData(data);
    setMemoryData(data);
  }

  setCpuData(List data) {
    List cpu = data[1]['Children'];
    int cpuLoadIndex = cpu.indexWhere((element) => element['Text'] == 'Load');
    int cpuTempIndex =
        cpu.indexWhere((element) => element['Text'] == 'Temperatures');
    List cpuLoadList = cpu[cpuLoadIndex]['Children'];
    List cpuTempList = cpu[cpuTempIndex]['Children'];
    int cpuLoadIndex1 =
        cpuLoadList.indexWhere((element) => element['Text'] == 'CPU Total');
    int cpuTempIndex1 =
        cpuTempList.indexWhere((element) => element['Text'] == 'CPU Package');
    cpuLoad = double.parse(cpuLoadList[cpuLoadIndex1]['Value'].split(" ")[0]);
    maxCpuLoad = double.parse(cpuLoadList[cpuLoadIndex1]['Max'].split(" ")[0]);
    cpuTemp = double.parse(cpuTempList[cpuTempIndex1]['Value'].split(" ")[0]);
    maxCpuTemp = double.parse(cpuTempList[cpuTempIndex1]['Max'].split(" ")[0]);
    // print('Cpu-load: $cpuLoad');
    // print('Cpu-temp: $cpuTemp');
    // print('maxCpuLoad: $maxCpuLoad');
  }

  setGpuData(List data) {
    List gpu = data[3]['Children'];
    int gpuLoadIndex = gpu.indexWhere((element) => element['Text'] == 'Load');
    int gpuTempIndex =
        gpu.indexWhere((element) => element['Text'] == 'Temperatures');
    int gpuMemIndex = gpu.indexWhere((element) => element['Text'] == 'Data');
    List gpuLoadList = gpu[gpuLoadIndex]['Children'];
    List gpuTempList = gpu[gpuTempIndex]['Children'];
    List gpuMemList = gpu[gpuLoadIndex]['Children'];
    List gpuMemList1 = gpu[gpuMemIndex]['Children'];
    int gpuLoadIndex1 =
        gpuLoadList.indexWhere((element) => element['Text'] == 'GPU Core');
    int gpuTempIndex1 =
        gpuTempList.indexWhere((element) => element['Text'] == 'GPU Core');
    int gpuMemIndex1 =
        gpuMemList.indexWhere((element) => element['Text'] == 'GPU Memory');
    int gpuMemIndex2 = gpuMemList1
        .indexWhere((element) => element['Text'] == 'GPU Memory Used');
    gpuLoad = double.parse(gpuLoadList[gpuLoadIndex1]['Value'].split(" ")[0]);
    maxGpuLoad = double.parse(gpuLoadList[gpuLoadIndex1]['Max'].split(" ")[0]);
    gpuTemp = double.parse(gpuTempList[gpuTempIndex1]['Value'].split(" ")[0]);
    maxGpuTemp = double.parse(gpuTempList[gpuTempIndex1]['Max'].split(" ")[0]);
    gpuMemLoad = double.parse(gpuLoadList[gpuMemIndex1]['Value'].split(" ")[0]);
    gpuMemSize = double.parse(gpuMemList1[gpuMemIndex2]['Value'].split(" ")[0]);
    maxGpuMem = double.parse(gpuMemList1[gpuMemIndex2]['Max'].split(" ")[0]);
    // print('Gpu-load: $gpuLoad');
    // print('Gpu-temp: $gpuTemp');
    // print('Gpu-mem: $gpuMemLoad');
    // print('Gpu-mem: $gpuMemSize');
    // print('maxGpuLoad: $maxGpuLoad');
    // print('maxGpuTemp: $maxGpuTemp');
    // print('maxGpuMem: $maxGpuMem');
  }

  setMemoryData(List data) {
    List ram = data[2]['Children'];
    int ramLoadIndex = ram.indexWhere((element) => element['Text'] == 'Load');
    List ramLoadList = ram[ramLoadIndex]['Children'];
    int ramLoadIndex1 =
        ramLoadList.indexWhere((element) => element['Text'] == 'Memory');
    ramLoad = double.parse(ramLoadList[ramLoadIndex1]['Value'].split(" ")[0]);
    maxRamLoad = double.parse(ramLoadList[ramLoadIndex1]['Max'].split(" ")[0]);
    // print('Ram-load: $ramLoad');
    // print('print: $maxRamLoad');
  }
}
