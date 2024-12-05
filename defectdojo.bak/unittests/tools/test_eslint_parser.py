from dojo.models import Test
from dojo.tools.eslint.parser import ESLintParser
from unittests.dojo_test_case import DojoTestCase


class TestESLintParser(DojoTestCase):
    def test_parse_file_has_two_findings(self):
        testfile = open("unittests/scans/eslint/scan.json", encoding="utf-8")
        parser = ESLintParser()
        findings = parser.get_findings(testfile, Test())
        testfile.close()
        self.assertEqual(2, len(findings))

    def test_parse_empty_file(self):
        testfile = open("unittests/scans/eslint/empty.json", encoding="utf-8")
        parser = ESLintParser()
        findings = parser.get_findings(testfile, Test())
        testfile.close()
        self.assertEqual(0, len(findings))

    def test_parse_file_with_no_finding(self):
        testfile = open("unittests/scans/eslint/no_finding.json", encoding="utf-8")
        parser = ESLintParser()
        findings = parser.get_findings(testfile, Test())
        testfile.close()
        self.assertEqual(0, len(findings))