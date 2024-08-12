{
  buildPythonPackage,
  poetry-core,
  flask,
  flask-restful,
  ldap3,
  numpy,
  requests,
}:
buildPythonPackage {
  pname = "sal";
  version = "1.2.5";
  pyproject = true;
  src = ./.;
  build-system = [ poetry-core ];
  dependencies = [
    flask
    flask-restful
    ldap3
    numpy
    requests
  ];
}
