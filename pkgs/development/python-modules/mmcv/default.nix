{ lib
, buildPythonPackage
, fetchFromGitHub
, python3
, pythonOlder
, requests
, cudatoolkit
, torch-bin
, opencv4
, yapf
, packaging
, pillow
, addict
, ninja
, which
, torchvision-bin
}:

buildPythonPackage rec {
  pname = "mmcv";
  version = "1.7.0";
  format = "setuptools";

  disabled = pythonOlder "3.6";

  src = fetchFromGitHub {
    owner = "open-mmlab";
    repo = pname;
    rev = "v1.7.0";
    hash = "sha256-EVu6D6rTeebTKFCMNIbgQpvBS52TKk3vy2ReReJ9VQE=";
  };

  nativeBuildInputs = [
  cudatoolkit.lib cudatoolkit.out torch-bin cudatoolkit.cc ninja  torchvision-bin which
  ];

  propagatedBuildInputs = [
  torch-bin  opencv4 yapf packaging pillow addict
  ];

  # Project has no tests
  doCheck = false;
  # dontUnpack = true;

  pythonImportsCheck = [
    "mmcv"
  ];

  MMCV_WITH_OPS = 1;


  meta = with lib; {
    description = "Python bindings for nuki.io bridges";
    homepage = with licenses; [ gpl3Only ];
    maintainers = with maintainers; [ fab open-false];

  };

}