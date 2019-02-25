#!/usr/bin/python
# -*- coding: UTF-8 -*-
# Author: honghzh
# Automatically build source HTML files into website pages.
# Usage: run $ python build_doc.py 

import os
import sys
import re

project_source_dir = 'source'
project_docs_dir = 'docs'

def search(path, checker):
    files = os.listdir(path)
    return filter(checker, files)

def suffix_checker(*search_string):
    ends = search_string
    def checker(file_name):
        return True in map(file_name.endswith, ends)
    return checker

def create_doc(file_name, lines):
    name_without_ext = os.path.splitext(file_name)[0]
    page_path = os.path.join(project_docs_dir, name_without_ext)
    if not os.path.exists(page_path):
        os.makedirs(page_path)
    with open(os.path.join(page_path, 'index.html'), 'w', encoding='utf-8') as f:
        f.writelines(lines)
    return None

if __name__ == '__main__':
    # Change working dir to the path of **the R-Learning Project**.
    original_root = os.getcwd()
    os.chdir(os.path.join(sys.path[0], '..'))

    # Operate files.
    html_files = search(project_source_dir, suffix_checker('.html'))
    for html_file in html_files:
        with open(os.path.join(project_source_dir, html_file), 'r', encoding='utf-8') as f:
            lines = f.readlines()
            for idx, line in enumerate(lines):
                if line.strip().endswith(('</title>',)): # Windows CR/LF
                    head_str='<link ref="stylesheet" type="text/css" href="../asset/css/r_notebook.css">\n'
                    lines.insert(idx + 1, head_str)
                    break
            target_name = os.path.split(f.name)[1]
            print('[Creating doc] %s' % (target_name))
            create_doc(target_name, lines)
            print('[Successfully created doc] %s' % (target_name))
            
    # Recover working dir.
    os.chdir(original_root)