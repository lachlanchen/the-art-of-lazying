import contextlib
import importlib.util
import io
from pathlib import Path
import subprocess
import tempfile
import unittest
from unittest.mock import patch


spec = importlib.util.spec_from_file_location(
    "download", Path(__file__).with_name("xcode-component-download.py"))
download = importlib.util.module_from_spec(spec)
spec.loader.exec_module(download)


class DownloadTests(unittest.TestCase):
    def invoke(self, outcome):
        with tempfile.TemporaryDirectory() as home:
            output = io.StringIO()
            with patch.object(download.Path, "home", return_value=Path(home)), \
                    patch.object(download.sys, "argv", ["test", "-downloadPlatform", "iOS"]), \
                    patch.dict(download.os.environ, {"XCODE_DOWNLOAD_TIMEOUT": "17"}), \
                    patch.object(download.subprocess, "run", side_effect=outcome) as run, \
                    contextlib.redirect_stdout(output):
                code = download.main()
            self.assertEqual(run.call_args.kwargs["timeout"], 17)
            log, = (Path(home) / "Library/Logs/DeveloperSetup").glob("component-*.log")
            self.assertEqual(log.stat().st_mode & 0o777, 0o600)
            return code, output.getvalue()

    def test_success_and_deduplicated_progress(self):
        def result(command, **kwargs):
            kwargs["stdout"].write(b"Working\rWorking\rComplete\n")
            return subprocess.CompletedProcess(command, 0)
        code, output = self.invoke(result)
        self.assertEqual(code, 0)
        self.assertEqual(output.count("Working"), 1)
        self.assertIn("Complete", output)

    def test_failure_preserves_exit_status(self):
        code, _ = self.invoke(lambda command, **kw: subprocess.CompletedProcess(command, 7))
        self.assertEqual(code, 7)

    def test_timeout(self):
        code, output = self.invoke(subprocess.TimeoutExpired("xcodebuild", 17))
        self.assertEqual(code, 124)
        self.assertIn("timed out", output)

    def test_interrupt(self):
        code, _ = self.invoke(KeyboardInterrupt())
        self.assertEqual(code, 130)

    def test_reject_non_download(self):
        with patch.object(download.sys, "argv", ["test", "-license"]):
            with self.assertRaises(SystemExit):
                download.main()

    def test_reject_nonpositive_timeout(self):
        with patch.object(download.sys, "argv", ["test", "-downloadPlatform", "iOS"]), \
                patch.dict(download.os.environ, {"XCODE_DOWNLOAD_TIMEOUT": "0"}):
            with self.assertRaises(SystemExit):
                download.main()


if __name__ == "__main__":
    unittest.main()
