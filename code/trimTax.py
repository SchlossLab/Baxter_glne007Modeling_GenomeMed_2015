#!/usr/local/bin/python3

import sys
import re

tax_file = open(sys.argv[1],'r')
outfile = open(sys.argv[2],'w')

print('\t'.join(['OTU','Classification','Label']), end='\n', file=outfile)

next(tax_file)
for line in tax_file:
	line=line.strip()
	line=line.split('\t')
	taxon=re.sub('\([0-9]+\)|"','',line[2])
	taxon=taxon.split(';')
	if not taxon[-2] == 'unclassified':
			taxon = taxon[-2]
	else:
		if not taxon[-3] == 'unclassified':
			taxon = taxon[-3]
		else:
			if not taxon[-4] == 'unclassified':
				taxon = taxon[-4]
			else:
				if not taxon[-5] == 'unclassified':
					taxon = taxon[-5]
				else:
					if not taxon[-6] == 'unclassified':
						taxon = taxon[-6]
					else:
						taxon = taxon[-7]
	otu = line[0]
	otu=re.sub('Otu0*','OTU',otu)
	label=[taxon,'(',otu,')']
	label=''.join(label)
	print('\t'.join([line[0],otu, taxon, label]), file=outfile, end='\n')

tax_file.close()
