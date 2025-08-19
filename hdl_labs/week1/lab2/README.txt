$ROOT
    |_    design/           // Directory that keeps lab2 design files
    |_    lint/             // Directory for running lint, it contains makefile for running spyglass flow(s)
    |_    scripts/          // Directory that keeps lab2 scripts
    |_    lab2.setup        // Setup file that needs to be sourced at the very beginning, setting the environment related to this lab2
    |_    README.txt        // This file

% gtar -zxvf lab2.tar.gz    // Untar the file at your local area
% cd lab2
% source lab2.setup         // Change $ROOT to your local area
% cd lint
% make <lint_flow>

To perform SpyGlass basic Design_Read check, use the following make command:
% make design_read

To perform SpyGlass Linting check, use the following make command:
% make linting

To perform both at once, use the following command:
% make both
