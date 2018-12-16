# coding=utf-8
"""
Ingest data from the command-line.
"""
from __future__ import absolute_import

import logging
from xml.etree import ElementTree
from pathlib import Path
import click

# image boundary imports


# IMAGE BOUNDARY CODE



def prepare_list(path):
    root = ElementTree.parse(str(path)).getroot()

    entries = root.findall('./{http://www.w3.org/2005/Atom}entry')
    granules = []
    for entry in entries:
        granules.append([entry.findall('./{http://www.w3.org/2005/Atom}title')[0].text, entry.findall('./{http://www.w3.org/2005/Atom}link')[0].attrib["href"]])
    return granules


@click.command(
    help="Converts a sentinel hub atom query result into a batch for indexins all entries. "
         "eg. python shub_list.py <input>.xml --output <outfile>.bat")
@click.argument('datasets',
                type=click.Path(exists=True, readable=True, writable=True),
                nargs=-1)
@click.option('--output', help="Write a list of titles and urls into this file",
              type=click.Path(exists=False, writable=True))
def main(datasets, output):
    logging.basicConfig(format='%(asctime)s %(levelname)s %(message)s', level=logging.INFO)

    for dataset in datasets:
        path = Path(dataset)

        if path.suffix != '.xml':
            raise RuntimeError('want xml')

        logging.info("Processing %s", path)

        granules = prepare_list(path)

        if granules:
            logging.info("Writing %s dataset(s) into %s", len(granules), output)
            with open(output, 'w') as stream:
                for gran in granules:
                    stream.write("call s2_l2a "+gran[0]+" \""+gran[1]+"\"\r\n")
        else:
            logging.info("No datasets discovered. Bye!")


if __name__ == "__main__":
    main()
