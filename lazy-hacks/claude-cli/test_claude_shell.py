import json
import os
from pathlib import Path
import subprocess
import tempfile
import unittest


SOURCE = Path(__file__).with_name('claude-shell.sh')


class ShellTests(unittest.TestCase):
    def setUp(self):
        self.temp = tempfile.TemporaryDirectory()
        self.addCleanup(self.temp.cleanup)
        self.root = Path(self.temp.name)
        for name in ('claude', 'agent-claude'):
            tool = self.root / name
            tool.write_text('#!/usr/bin/python3\nimport json,sys\nprint(json.dumps(sys.argv))\n')
            tool.chmod(0o755)

    def invoke(self, *args):
        return subprocess.run(
            ['bash', '--noprofile', '--norc', '-c', 'source "$1"; shift; "$@"',
             'bash', str(SOURCE), *args],
            env={**os.environ, 'PATH': f'{self.root}:/usr/bin:/bin'},
            capture_output=True, text=True,
        )

    def arguments(self, *args):
        result = self.invoke(*args)
        self.assertEqual(result.returncode, 0, result.stderr)
        return json.loads(result.stdout)

    def test_default_full_access_and_preserved_prompt(self):
        self.assertEqual(self.arguments('claude', 'two words')[1:],
                         ['--dangerously-skip-permissions', 'two words'])

    def test_resume_default(self):
        self.assertEqual(self.arguments('clauder', 'session-id')[1:],
                         ['--dangerously-skip-permissions', '--resume', 'session-id'])

    def test_explicit_permission_mode_wins(self):
        self.assertEqual(self.arguments('claude', '--permission-mode', 'plan')[1:],
                         ['--permission-mode', 'plan'])

    def test_maintenance_command_unchanged(self):
        self.assertEqual(self.arguments('claude', 'auth', 'status')[1:], ['auth', 'status'])

    def test_account_dispatch(self):
        result = self.arguments('clauder', '--account', 'personal', 'session-id')
        self.assertEqual(Path(result[0]).name, 'agent-claude')
        self.assertEqual(result[1:], ['--account', 'personal', '--dangerously-skip-permissions',
                                      '--resume', 'session-id'])

    def test_native_move_preserves_spaces(self):
        target = self.root / 'new folder'
        target.mkdir()
        self.assertEqual(self.arguments('claudemv', str(target))[1:],
                         ['--dangerously-skip-permissions', f'/cd {target}', '--continue'])

    def test_move_explicit_session_and_account(self):
        result = self.arguments('claudemv', '--account=lab', str(self.root), 'session-id')
        self.assertEqual(result[1:], ['--account=lab', '--dangerously-skip-permissions',
                                      f'/cd {self.root}', '--resume', 'session-id'])

    def test_missing_destination_rejected(self):
        self.assertNotEqual(self.invoke('claudemv', str(self.root / 'absent')).returncode, 0)

    def test_missing_account_rejected(self):
        self.assertEqual(self.invoke('clauder', '--account').returncode, 2)

    def test_help_and_shell_syntax(self):
        self.assertIn('Moves one session', self.invoke('claudemv', '--help').stdout)
        subprocess.run(['bash', '-n', str(SOURCE)], check=True)


if __name__ == '__main__':
    unittest.main()
