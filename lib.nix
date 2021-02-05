{
  # TODO: probably a lib function for this somewhere...
  getOrDefault = attribute: defaultValue: attrSet:
    if
      (builtins.hasAttr attribute attrSet)
    then
      (builtins.getAttr attribute attrSet)
    else defaultValue;
}
