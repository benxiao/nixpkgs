{ lib
, buildPythonPackage
, fetchurl
, python3
, tree
, unzip
, zip
, patchelf
, stdenv
}:

buildPythonPackage rec {
  pname = "mediapipe";
  version = "0.8.11";
  format = "wheel";
  src = fetchurl {
    url = "https://files.pythonhosted.org/packages/75/b0/de86aaadb05eae01409eb1b5b8cc4b64bb0327a477b3dec8c67998755e14/mediapipe-0.8.11-cp310-cp310-manylinux_2_17_x86_64.manylinux2014_x86_64.whl";
    sha256 = "4a9622deabc54ebf259f5f958789c7e92a38d01938ae0dd01de017c4eb799580";
  };

  doCheck = false;


  preConfigure = ''
    ${unzip}/bin/unzip $NIX_BUILD_TOP/dist/*.whl

    substituteInPlace mediapipe-0.8.11.dist-info/METADATA \
    --replace "Requires-Dist: opencv-contrib-python" ""

    ${patchelf}/bin/patchelf --replace-needed libstdc++.so.6 ${stdenv.cc.cc.lib}/lib/libstdc++.so.6 mediapipe/python/_framework_bindings.cpython-310-x86_64-linux-gnu.so

    rm $NIX_BUILD_TOP/dist/mediapipe-0.8.11-cp310-cp310-manylinux_2_17_x86_64.manylinux2014_x86_64.whl     

    ${zip}/bin/zip -r $NIX_BUILD_TOP/dist/mediapipe-0.8.11-cp310-cp310-manylinux_2_17_x86_64.manylinux2014_x86_64.whl \
    mediapipe  mediapipe-0.8.11.dist-info  mediapipe.libs
  '';

  nativeBuildInputs = [ ];

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
