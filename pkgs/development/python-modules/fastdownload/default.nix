{ lib
, buildPythonPackage
, fetchPypi
, fastprogress
, fastcore
, pythonOlder
}:

buildPythonPackage rec {
  pname = "fastdownload";
  version = "0.0.6";
  disabled = pythonOlder "3.6";

  src = fetchPypi {
    inherit pname version;
    sha256 = "sha256-1ayb0zx8rFKDgqlq/tVVLqDkh47T5jofHt53r8bWr30=";
  };

  propagatedBuildInputs = [ fastprogress fastcore ];

  # no real tests
  doCheck = false;
  pythonImportsCheck = [ "fastdownload" ];

  meta = with lib; {
    homepage = "https://github.com/fastai/fastdownload";
    description = "Simple and flexible progress bar for Jupyter Notebook and console";
    license = licenses.asl20;
    maintainers = with maintainers; [ rxiao ];
  };

}
