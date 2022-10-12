{ lib
, buildPythonPackage
, fetchFromGitHub
, python3
, bazel_5
}:

buildPythonPackage rec {
  pname = "mediapipe";
  version = "v0.8.11";

  src = fetchFromGitHub {
    owner = "google";
    repo = pname;
    rev = "refs/tags/${version}";
    hash = "sha256-2lBDxTMTPU5pXcJMKA9jtFprizG9e6qB8g7HEeXZ8E8=";
  };

  doCheck = false;

  
  preConfigure = ''
    substituteInPlace requirements.txt \
      --replace "opencv-contrib-python" "" 
  '';

  nativeBuildInputs = [bazel_5];

  propagatedBuildInputs = with python3.pkgs;[
    opencv4
    numpy
    protobuf
    attrs
    absl-py
    matplotlib
  ];

  pythonImportsCheck = [ "mediapipe" ];

  meta = with lib; {
    description = "MediaPipe";
    homepage = "https://github.com/google/mediapipe";
    license = licenses.asl20;
    maintainers = with maintainers; [ ];
  };
}
