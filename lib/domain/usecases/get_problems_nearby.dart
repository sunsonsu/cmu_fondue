import 'package:cmu_fondue/domain/entities/problem_entity.dart';
import 'package:cmu_fondue/domain/enum/problem_enums.dart';
// import 'package:cmu_fondue/domain/repositories/problem_repo.dart';

class GetProblemsNearbyUseCase {
  // final ProblemRepository repository;
  final List<ProblemEntity> _mockProblems = [
    ProblemEntity(
      id: '1',
      title: 'ถนนแตกหน้าหอสมุด',
      status: ProblemStatus.pending, // ยังไม่ได้แก้ไข
      type: ProblemType.road,
      imageUrl:
          'https://images.unsplash.com/photo-1625047509168-a7026f36de04?w=200&h=200&fit=crop',
      reportedAt: DateTime(2024, 1, 15), // 15/01/2567
      location: 'หน้าอาคารหอสมุด มช.',
      description:
          'ถนนมีรอยแตกขนาดใหญ่ ความยาวประมาณ 2 เมตร อาจเกิดอันตรายต่อการสัญจร',
    ),
    ProblemEntity(
      id: '2',
      title: 'ไฟฟ้าขัดข้อง',
      status: ProblemStatus.inProgress, // กำลังแก้ไข
      type: ProblemType.electricity,
      imageUrl:
          'https://images.unsplash.com/photo-1473341304170-971dccb5ac1e?w=200&h=200&fit=crop',
      reportedAt: DateTime(2024, 1, 18), // 18/01/2567
      location: 'อาคารวิศวกรรม ชั้น 3',
      description: 'ไฟส่องสว่างดับหมดทั้งชั้น ส่งผลกระทบต่อการเรียนการสอน',
    ),
    ProblemEntity(
      id: '3',
      title: 'ท่อน้ำแตก',
      status: ProblemStatus.pending, // ยังไม่ได้แก้ไข
      type: ProblemType.water, 
      imageUrl:
          'https://images.unsplash.com/photo-1532996122724-e3c354a0b15b?w=200&h=200&fit=crop',
      reportedAt: DateTime(2024, 1, 20), // 20/01/2567
      location: 'หลังอาคารวิทยาศาสตร์',
      description:
          'ท่อน้ำแตกทำให้น้ำไหลออกมาอย่างต่อเนื่อง อาจทำให้เกิดน้ำท่วมขัง',
    ),
    ProblemEntity(
      id: '4',
      title: 'ทางเท้าชำรุด',
      status: ProblemStatus.completed, // เสร็จสิ้น
      type: ProblemType.road,
      imageUrl:
          'https://images.unsplash.com/photo-1599481238640-191a4c52e5b2?w=200&h=200&fit=crop',
      reportedAt: DateTime(2024, 1, 10), // 10/01/2567
      location: 'ทางเข้าคณะพาณิชย์',
      description:
          'ทางเท้าแตกเป็นแผ่นสร้างความไม่สะดวกในการเดิน ได้รับการซ่อมแซมเรียบร้อยแล้ว',
    ),
    ProblemEntity(
      id: '5',
      title: 'ต้นไม้ล้ม',
      status: ProblemStatus.inProgress, // กำลังแก้ไข
      type: ProblemType.other,
      imageUrl:
          'https://images.unsplash.com/photo-1542601906990-b4d3fb778b09?w=200&h=200&fit=crop',
      reportedAt: DateTime(2024, 1, 22), // 22/01/2567
      location: 'สวนหย่อมหน้าคณะมนุษย์',
      description: 'ต้นไม้ใหญ่ล้มขวางทางเดิน จำเป็นต้องตัดและเคลื่อนย้ายออก',
    ),
    ProblemEntity(
      id: '6',
      title: 'ป้ายจราจรชำรุด',
      status: ProblemStatus.received, // รับเรื่องแล้ว
      type: ProblemType.other,
      imageUrl:
          'https://images.unsplash.com/photo-1449253984488-e5b74f37809f?w=200&h=200&fit=crop',
      reportedAt: DateTime(2024, 1, 19), // 19/01/2567
      location: 'สี่แยกหน้าประตู 1',
      description: 'ป้ายจราจรล้มเอียง ไม่สามารถมองเห็นสัญลักษณ์ได้ชัดเจน',
    ),
    ProblemEntity(
      id: '7',
      title: 'ถังขยะเต็ม',
      status: ProblemStatus.completed, // เสร็จสิ้น
      type: ProblemType.garbage, // ปรับจาก 'อื่นๆ' เป็น 'garbage'
      imageUrl:
          'https://images.unsplash.com/photo-1526951521990-620dc14c214b?w=200&h=200&fit=crop',
      reportedAt: DateTime(2024, 1, 12), // 12/01/2567
      location: 'ลานจอดรถ คณะศึกษาศาสตร์',
      description:
          'ถังขยะเต็มล้นจนขยะเกลื่อนพื้น ได้รับการเก็บและทำความสะอาดแล้ว',
    ),
    ProblemEntity(
      id: '8',
      title: 'รั้วชำรุด',
      status: ProblemStatus.inProgress, // กำลังแก้ไข
      type: ProblemType.other,
      imageUrl:
          'https://images.unsplash.com/photo-1558618666-fcd25c85cd64?w=200&h=200&fit=crop',
      reportedAt: DateTime(2024, 1, 21), // 21/01/2567
      location: 'ข้างสนามกีฬา',
      description: 'รั้วกั้นหักเสียหายยาวหลายเมตร อาจเกิดอันตรายแก่นักศึกษา',
    ),
    ProblemEntity(
      id: '9',
      title: 'ไฟถนนไม่ติด',
      status: ProblemStatus.pending, // ยังไม่ได้แก้ไข
      type: ProblemType.electricity,
      imageUrl:
          'https://images.unsplash.com/photo-1513475382585-d06e58bcb0e0?w=200&h=200&fit=crop',
      reportedAt: DateTime(2024, 1, 23), // 23/01/2567
      location: 'ถนนหลังหอพัก',
      description: 'ไฟถนนไม่ติดหลายจุดทำให้กลางคืนมืดมากเกินไป ไม่ปลอดภัย',
    ),
    ProblemEntity(
      id: '10',
      title: 'หลุมบนถนน',
      status: ProblemStatus.pending, // ยังไม่ได้แก้ไข
      type: ProblemType.road,
      imageUrl:
          'https://images.unsplash.com/photo-1581092918056-0c4c3acd3789?w=200&h=200&fit=crop',
      reportedAt: DateTime(2024, 1, 24), // 24/01/2567
      location: 'ถนนเข้าอาคารเรียนรวม',
      description: 'หลุมลึกเป็นอันตรายต่อรถจักรยานยนต์และรถยนต์ที่ผ่านไปมา',
    ),
  ];

  // GetProblemsNearbyUseCase(this.repository);
  GetProblemsNearbyUseCase();

  Future<List<ProblemEntity>> call() async {
    await Future.delayed(const Duration(milliseconds: 500)); // fake loading

    return _mockProblems;
  }
}
