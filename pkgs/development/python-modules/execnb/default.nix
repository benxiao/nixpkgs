{ lib
, buildPythonPackage
, fetchPypi
, fastcore
, traitlets
, ipython
, pythonOlder
}:

buildPythonPackage rec {
  pname = "execnb";
  version = "0.1.4";
  disabled = pythonOlder "3.6";

  src = fetchPypi {
    inherit pname version;
    sha256 = "sha256-y9gSvzJA8Fsh56HbA8SszlozsBBfTLfgWGDXm9uSBvA=";
  };

  propagatedBuildInputs = [ fastcore traitlets ipython ];

  # no real tests
  doCheck = false;
  pythonImportsCheck = [ "execnb" ];

  meta = with lib; {
    homepage = "https://github.com/fastai/execnb";
    description = "Simple and flexible progress bar for Jupyter Notebook and console";
    license = licenses.asl20;
    maintainers = with maintainers; [ ris ];
  };

}
