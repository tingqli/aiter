# Test-only shim: the current /sgl-workspace/pyhip checkout lacks pyhip.contrib,
# which aiter imports unconditionally. Any pyhip.contrib.* becomes a stub module
# whose attributes raise if called. Not used by the MoE experiments.
import importlib.abc, importlib.machinery, sys, types
try:
    import pyhip.contrib  # noqa: F401
except Exception:
    class _Stub(types.ModuleType):
        def __getattr__(self, name):
            if name.startswith("__"):
                raise AttributeError(name)
            def _missing(*a, **k):
                raise RuntimeError(f"{self.__name__}.{name} unavailable (shim)")
            return _missing

    class _Finder(importlib.abc.MetaPathFinder, importlib.abc.Loader):
        def find_spec(self, name, path, target=None):
            if name == "pyhip.contrib" or name.startswith("pyhip.contrib."):
                return importlib.machinery.ModuleSpec(name, self, is_package=True)
        def create_module(self, spec):
            m = _Stub(spec.name); m.__path__ = []; return m
        def exec_module(self, module):
            pass

    sys.meta_path.insert(0, _Finder())
