{ lib
, buildPythonPackage
, fetchPypi
, pythonOlder
, python3
}:

with python3.pkgs;buildPythonPackage rec {
  pname = "mtcnn";
  version = "0.1.1";
  disabled = pythonOlder "3.4";

  src = fetchPypi {
    inherit pname version;
    sha256 = "sha256-0JVydFhL5iy4PUoIkEH47jzzsYk+RfAe0zVvlKOBMCs=";
  };

  doCheck = false;

  
  preConfigure = ''
    substituteInPlace setup.py \
      --replace "opencv-python>=4.1.0" "" 
  '';

  propagatedBuildInputs = [
    keras
    opencv4
    tensorflow
  ];

  pythonImportsCheck = [ "mtcnn" ];

  meta = with lib; {
    description = "MTCNN";
    homepage = "https://github.com/ipazc/mtcnn";
    license = licenses.asl20;
    maintainers = with maintainers; [ ];
  };
}
