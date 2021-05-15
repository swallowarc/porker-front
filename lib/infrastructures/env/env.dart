enum DeployTarget { Development, Production }

const _isProduction = bool.fromEnvironment('dart.vm.product');
const _backendURI = String.fromEnvironment("BACKEND_URI");

class Env {
  DeployTarget _deployTarget;
  String _porkerBackendURI;

  get deployTarget => _deployTarget;

  get porkerBackendURI => _porkerBackendURI;

  Env()
      : _deployTarget = _isProduction ? DeployTarget.Production : DeployTarget.Development,
        _porkerBackendURI = _backendURI;
}
