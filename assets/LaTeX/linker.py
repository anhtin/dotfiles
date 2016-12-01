#!/usr/bin/env python3
import sys
import os
import argparse

# Global variables
path = os.path.dirname(__file__)
default = {
    'author': 'Anon',
    'lang': 'english',
    'type': 'report',
    'pkg': '',
    'template': 'main',
}

def main(args):
    # Information
    description = "Generate PDF-document with predefined settings."
    doctypes = ('report', 'article')
    templates = os.listdir(os.path.join(path, 'templates'))
    if len(templates) == 0:
        return "No templates found."
        raise FileNotFoundError("No templates found.")

    # Parse arguments
    parser = argparse.ArgumentParser(description=description)
    parser.add_argument('name', type=str, help='name of document file')
    parser.add_argument('title', type=str, help='title of document')
    parser.add_argument('--author', type=str, help='author of document')
    parser.add_argument('--lang', type=str, help='language used in document')
    parser.add_argument('--load', type=str, default='default',
                        help='file to load settings from')
    parser.add_argument('--packages', type=str, nargs='+',
                        help='extra packages to use in LaTeX document')
    parser.add_argument('--template', type=str, choices=templates,
                        help='type of document')
    parser.add_argument('--type', type=str, choices=doctypes,
                        help='type of document')
    args = parser.parse_args()

    # Link document to template using arguments as configuration
    try:
        return linkdocument(args)
    except FileNotFoundError as e:
        print(e, file=sys.stderr)
        raise e


def linkdocument(conf):
    # Make sure document exists
    if not os.path.exists(conf.name):
        raise FileNotFoundError("No such file: " + conf.name)

    # Load configuration from file
    configpath = os.path.join(path, 'configs', conf.load)
    if os.path.exists(configpath):
        with open(configpath, 'r') as f:
            for line in f.readlines():
                key, val = line.split()
                default[key] = val.strip('\n')
    elif conf.load != 'default':
        raise FileNotFoundError("No such setting file: " + conf.load)

    # Override configuration from file
    templatefile = default['template'] if conf.template is None else conf.template
    pkgs = default['pkg'] if conf.packages is None else conf.packages

    info = {
        '__NAME__': os.path.abspath(conf.name),
        '__TITLE__': conf.title,
        '__AUTHOR__': default['author'] if conf.author is None else conf.author,
        '__LANG__': default['lang'] if conf.lang is None else conf.lang,
        '__TYPE__': default['type'] if conf.type is None else conf.type,
        '__PKG__': '\n'.join('\\usepackage\{{}\}'.format(pkg) for pkg in pkgs),
    }

    # Load template
    templatepath = os.path.join(path, 'templates', templatefile)
    if os.path.exists(templatepath):
        with open(templatepath, 'r') as f:
            template = f.read()
    else:
        raise FileNotFoundError("No such template file: " + conf.load)

    # Fill settings into template
    for key, val in info.items():
        template = template.replace(key, val)

    return template


if __name__ == '__main__':
    try:
        print(main(sys.argv[1:]))
    except FileNotFoundError:
        exit(1)
