import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';
import '../repositories/table_keys.dart';

enum PeopleToDisplayType { PESQUISADOR, MEMBRO, COLABORADOR }

class PeopleToDisplay {
  PeopleToDisplay(
    this.id,
    this.name,
    this.description,
    this.image,
    this.email,
    this.linkedin,
    this.lattes,
    this.orcId,
    this.researchGate,
    this.type,
  );

  String? id;
  late String name;
  late String description;
  dynamic image;
  String? email;
  String? linkedin;
  String? lattes;
  String? orcId;
  String? researchGate;
  late PeopleToDisplayType type;

  @override
  String toString() {
    return 'PeopleToDisplay{id: $id, name: $name, description: $description, image: $image, email: $email, linkedin: $linkedin, lattes: $lattes, orcId: $orcId, researchGate: $researchGate}';
  }

  PeopleToDisplay.fromParse(ParseObject parseObject) {
    id = parseObject.objectId;
    name = parseObject.get<String>(keyPeopleToDisplayName)!;
    description = parseObject.get<String>(keyPeopleToDisplayDescription)!;
    image = parseObject.get(keyPeopleToDisplayImage)..url;
    email = parseObject.get<String?>(keyPeopleToDisplayEmail);
    linkedin = parseObject.get<String>(keyPeopleToDisplayLinkedin);
    lattes = parseObject.get<String>(keyPeopleToDisplayLattes);
    orcId = parseObject.get<String>(keyPeopleToDisplayOrcId);
    researchGate = parseObject.get<String>(keyPeopleToDisplayResearchGate);
    type = PeopleToDisplayType.values[parseObject.get(keyPeopleToDisplayType)];
  }
}
