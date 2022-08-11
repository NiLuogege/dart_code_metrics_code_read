import 'dart:io';

import 'package:dart_code_metrics/lint_analyzer.dart';

Future<void> main() async {
  // Get some folder you would like to analyze.
  const foldersToAnalyze = ['lib', 'test'];

  // Root folder path is used to resolve relative file paths.
  // const rootFolder = 'E:\\111work\\code\\code_work\\zhiyao\\zhiyao\\zhiyao';
  const rootFolder = 'C:\\Users\\niluogege\\Desktop\\dart-code-metrics-master\\dart-code-metrics-master';

  // First of all config has to be created for a checker.
  const config = LintConfig(
    excludePatterns: [
      'test/resources/**',
      'test/**',
      'lib/src/**',
      'lib/analyzer_plugin.dart',
      'lib/config.dart',
      'lib/lint_analyzer.dart',
      'lib/reporters.dart',
      'lib/unused_code_analyzer.dart',
      'lib/unused_files_analyzer.dart',
      'lib/unused_l10n_analyzer.dart',
    ],
    excludeForMetricsPatterns: ['test/**'],
    metrics: {
      'maximum-nesting-level': '5',
      'number-of-methods': '10',
    },
    excludeForRulesPatterns: ['test/**'],
    rules: {
      // 'no-empty-block': {},
      'double-literal-format': {},
      'newline-before-return': {'severity': 'info'},
    },
    antiPatterns: {'long-method': {}},
  );

  const analyzer = LintAnalyzer();

  final result = await analyzer.runCliAnalysis(foldersToAnalyze, rootFolder, config);

  // Now runner.results() contains some insights about analyzed code. Let's report it!
  // For a simple example we would report results to terminal

  // Now pass collected analysis reports from runner to reporter and that's it
  await analyzer.getReporter(name: 'console', output: stdout, reportFolder: '.')?.report(result);

  // There is also JsonReporter for making machine-readable reports
  // HtmlReporter produces fancy html-documents with bells and whistles
  // And CodeClimateReporter produces reports that are widely understood by various CI tools
  // If none of these fits your case you can always access raw analysis info via results() method of runner and process it any way you see fit
}

