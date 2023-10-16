enum InstructionEnum {
  av,
  re,
  td,
  tg,
  lc,
  bc,
  ct,
  mt,
  ve,
  nettoie,
  origine,
  vt,
  fcc,
  fcb,
  fcap,
  cap,
  fpos,
  repete,
  pour,
  position;

  int get parameterCount {
    switch (this) {
      case av:
      case re:
      case td:
      case tg:
      case fcap:
        return 1;
      case fpos:
        return 2;
      case fcc:
      case fcb:
        return 3;
      case lc:
      case bc:
      case ct:
      case mt:
      case ve:
      case nettoie:
      case origine:
      case vt:
      case cap:
      case position:
        return 0;
      case repete:
        return -1;
      case pour:
        return -1;
      default:
        return 0;
    }
  }

  @override
  String toString() {
    switch (this) {
      case av:
        return 'AV';
      case re:
        return 'RE';
      case td:
        return 'TD';
      case tg:
        return 'TG';
      case lc:
        return 'LC';
      case bc:
        return 'BC';
      case ct:
        return 'CT';
      case mt:
        return 'MT';
      case ve:
        return 'VE';
      case nettoie:
        return 'NETTOIE';
      case origine:
        return 'ORIGINE';
      case vt:
        return 'VT';
      case fcc:
        return 'FCC';
      case fcb:
        return 'FCB';
      case fcap:
        return 'FCAP';
      case cap:
        return 'CAP';
      case fpos:
        return 'FPOS';
      case position:
        return 'POSITION';
      case repete:
        return 'REPETE';
      case pour:
        return 'POUR';
      default:
        return '';
    }
  }

  static InstructionEnum fromString(String instructionString) {
    final cleanString = instructionString.replaceAll(' ', '')..toLowerCase();
    switch (cleanString) {
      case 'av':
        return InstructionEnum.av;
      case 're':
        return InstructionEnum.re;
      case 'td':
        return InstructionEnum.td;
      case 'tg':
        return InstructionEnum.tg;
      case 'lc':
        return InstructionEnum.lc;
      case 'bc':
        return InstructionEnum.bc;
      case 'ct':
        return InstructionEnum.ct;
      case 'mt':
        return InstructionEnum.mt;
      case 've':
        return InstructionEnum.ve;
      case 'nettoie':
        return InstructionEnum.nettoie;
      case 'origine':
        return InstructionEnum.origine;
      case 'vt':
        return InstructionEnum.vt;
      case 'fcc':
        return InstructionEnum.fcc;
      case 'fcb':
        return InstructionEnum.fcb;
      case 'fcap':
        return InstructionEnum.fcap;
      case 'cap':
        return InstructionEnum.cap;
      case 'fpos':
        return InstructionEnum.fpos;
      case 'pos':
      case 'position':
        return InstructionEnum.position;
      case 'repete':
        return InstructionEnum.repete;
      case 'pour':
        return InstructionEnum.pour;
      default:
        throw Exception('String entered is not a valid instruction');
    }
  }
}
