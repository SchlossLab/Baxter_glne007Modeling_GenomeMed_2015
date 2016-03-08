#!/usr/local/bin/python

import sys
import re

tax_file = open(sys.argv[1],'r')
outfile = open(sys.argv[2],'w')
# sys.argv[3] is the minimum taxonomic level. 1=genus, 5=phylum.

outfile.write('\t'.join(['OTU','Classification','Label'+'\n']))

next(tax_file)
for line in tax_file:
	line=line.strip()
	line=line.split('\t')
	taxon=re.sub('\([0-9]+\)|"','',line[2])
	taxon=taxon.split(';')
	level = -1*int(sys.argv[3]) - 1 
	while level > -8:
		if not taxon[level] == 'unclassified':
			taxon = taxon[level]
			break
		else:
			level = level-1
	if level == -8:
		taxon = 'Unclassified'		
			
	otu = line[0]
	otu=re.sub('Otu0*','OTU',otu)
	label=[taxon,' (',otu,')']
	label=''.join(label)
	outfile.write('\t'.join([line[0],otu, taxon, label+'\n']))

tax_file.close()
