{ lib
, buildPythonPackage
, fetchPypi
, fastprogress
, fastcore
, fastdownload
, torchvision-bin
, matplotlib
, pillow
, scikit-learn
, scipy
, spacy
, pandas
, requests
, pythonOlder
}:

buildPythonPackage rec {
  pname = "fastai";
  version = "2.7.10";
  disabled = pythonOlder "3.6";

  src = fetchPypi {
    inherit pname version;
    sha256 = "sha256-zO9qGFrjpjfvybzZ/qjki3X0VNDrrTtt9CbyL64gA50=";
  };

  propagatedBuildInputs = [
    fastprogress
    fastcore
    fastdownload
    torchvision-bin
    matplotlib
    pillow
    scikit-learn
    scipy
    spacy
    pandas
    requests
  ];

  # no real tests
  doCheck = false;
  pythonImportsCheck = [ "fastai" ];

  meta = with lib; {
    homepage = "https://github.com/fastai/fastai";
    description = "Simple and flexible progress bar for Jupyter Notebook and console";
    license = licenses.asl20;
    maintainers = with maintainers; [ rxiao ];
  };

}
