// ignore_for_file: public_member_api_docs, sort_constructors_first
class OfficiatingCategory {
  final String id;
  final String ceremony;
  OfficiatingCategory({
    required this.id,
    required this.ceremony,
  });
  static List<OfficiatingCategory> categoryList = [
    OfficiatingCategory(id: '1', ceremony: 'Child naming and dedication'),
    OfficiatingCategory(id: '2', ceremony: 'Marriage ceremonies'),
    OfficiatingCategory(id: '3', ceremony: 'Funeral services'),
    OfficiatingCategory(
        id: '4', ceremony: 'Ordinance - Dedication of properties'),
    OfficiatingCategory(id: '5', ceremony: 'Ministerial accreditation'),
  ];
}
