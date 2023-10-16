enum HomeDisplayEnum {
  console,
  script;

  @override
  String toString() {
    switch (this) {
      case console:
        return 'Console';

      case script:
        return 'Editeur de script';

      default:
        return '';
    }
  }
}
