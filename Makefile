#Generation and validation of CoNLL-U files
#If you want to use, first do:
#$ cd Scripts; git clone git@github.com:UniversalDependencies/tools.git
nohup-conllu:
	nohup time make conllu > ParlaMint-XX.conllu.log &
conllu:
	Scripts/parlamint2conllu.pl ParlaMint-BE ParlaMint-BE
	Scripts/parlamint2conllu.pl ParlaMint-BG ParlaMint-BG
	Scripts/parlamint2conllu.pl ParlaMint-CZ ParlaMint-CZ
	Scripts/parlamint2conllu.pl ParlaMint-DK ParlaMint-DK
	#Scripts/parlamint2conllu.pl ParlaMint-FR ParlaMint-FR
	#Scripts/parlamint2conllu.pl ParlaMint-GB ParlaMint-GB
	Scripts/parlamint2conllu.pl ParlaMint-HR ParlaMint-HR
	#Scripts/parlamint2conllu.pl ParlaMint-HU ParlaMint-HU
	Scripts/parlamint2conllu.pl ParlaMint-IS ParlaMint-IS
	#Scripts/parlamint2conllu.pl ParlaMint-IT ParlaMint-IT
	#Scripts/parlamint2conllu.pl ParlaMint-LT ParlaMint-LT
	Scripts/parlamint2conllu.pl ParlaMint-NL ParlaMint-NL
	Scripts/parlamint2conllu.pl ParlaMint-PL ParlaMint-PL
	#Scripts/parlamint2conllu.pl ParlaMint-RO ParlaMint-RO
	Scripts/parlamint2conllu.pl ParlaMint-SI ParlaMint-SI
	#Scripts/parlamint2conllu.pl ParlaMint-TR ParlaMint-TR

conllu-six:
	rm -f ParlaMint-SI/*.conllu
	ls ParlaMint-SI/*_*.ana.xml | $P --jobs 10 \
	'$s meta=../ParlaMint-SI/ParlaMint-SI.ana.xml -xsl:Scripts/parlamint2conllu.xsl {} > {.}.conllu'
	rename 's/\.ana\.conllu/.conllu/' ParlaMint-SI/*.ana.conllu
	python3 Scripts/tools/validate.py --lang sl --level 1 ParlaMint-SI/*.conllu
	python3 Scripts/tools/validate.py --lang sl --level 2 ParlaMint-SI/*.conllu
	python3 Scripts/tools/validate.py --lang sl --level 3 ParlaMint-SI/*.conllu

SI = ParlaMint-SI_2018-04-13-SDZ7-Izredna-59
test-conllu-si:
	$s meta=../ParlaMint-SI/ParlaMint-SI.ana.xml -xsl:Scripts/parlamint2conllu.xsl \
	ParlaMint-SI/${SI}.ana.xml > ParlaMint-SI/${SI}.conllu
	python3 Scripts/tools/validate.py --lang sl --level 1 ParlaMint-SI/${SI}.conllu
	python3 Scripts/tools/validate.py --lang sl --level 2 ParlaMint-SI/${SI}.conllu
	python3 Scripts/tools/validate.py --lang sl --level 3 ParlaMint-SI/${SI}.conllu

CZ = ParlaMint-CZ_2013-11-25-ps2013-001-01-001-001
test-conllu-cz:
	$s meta=../ParlaMint-CZ/ParlaMint-CZ.ana.xml -xsl:Scripts/parlamint2conllu.xsl \
	ParlaMint-CZ/${CZ}.ana.xml > ParlaMint-CZ/${CZ}.conllu
	python3 Scripts/tools/validate.py --lang cs --level 1 ParlaMint-CZ/${CZ}.conllu
	python3 Scripts/tools/validate.py --lang cs --level 2 ParlaMint-CZ/${CZ}.conllu
	python3 Scripts/tools/validate.py --lang cs --level 3 ParlaMint-CZ/${CZ}.conllu

DK = ParlaMint-DK_2018-11-22-20181-M24
test-conllu-dk:
	$s meta=../ParlaMint-DK/ParlaMint-DK.ana.xml -xsl:Scripts/parlamint2conllu.xsl \
	ParlaMint-DK/${DK}.ana.xml > ParlaMint-DK/${DK}.conllu
	python3 Scripts/tools/validate.py --lang dk --level 1 ParlaMint-DK/${DK}.conllu
	python3 Scripts/tools/validate.py --lang dk --level 2 ParlaMint-DK/${DK}.conllu
	python3 Scripts/tools/validate.py --lang dk --level 3 ParlaMint-DK/${DK}.conllu

BE = ParlaMint-BE_2015-06-10-54-commissie-ic189x
test-conllu-be:	test-conllu-be-nl test-conllu-be-fr
test-conllu-be-nl:
	$s seg-lang=nl meta=../ParlaMint-BE/ParlaMint-BE.ana.xml -xsl:Scripts/parlamint2conllu.xsl \
	ParlaMint-BE/${BE}.ana.xml > ParlaMint-BE/${BE}-nl.conllu
	python3 Scripts/tools/validate.py --lang nl --level 1 ParlaMint-BE/${BE}-nl.conllu
	-python3 Scripts/tools/validate.py --lang nl --level 2 ParlaMint-BE/${BE}-nl.conllu
test-conllu-be-fr:
	$s seg-lang=fr meta=../ParlaMint-BE/ParlaMint-BE.ana.xml -xsl:Scripts/parlamint2conllu.xsl \
	ParlaMint-BE/${BE}.ana.xml > ParlaMint-BE/${BE}-fr.conllu
	python3 Scripts/tools/validate.py --lang fr --level 1 ParlaMint-BE/${BE}-fr.conllu
	-python3 Scripts/tools/validate.py --lang fr --level 2 ParlaMint-BE/${BE}-fr.conllu

#Now that we have plain text, would be better to compute char counts from those!
chars-xml:
	rm -f ParlaMint-BG/chars-files-BG.tbl
	ls ParlaMint-BG/*_*.xml | grep -v '.ana.' | $P --jobs 10 \
	'Scripts/chars.pl {} >> ParlaMint-BG/chars-files-BG.tbl'
	Scripts/chars-summ.pl < ParlaMint-BG/chars-files-BG.tbl > ParlaMint-BG/chars-BG.tbl

	rm -f ParlaMint-CZ/chars-files-CZ.tbl
	ls ParlaMint-CZ/*_*.xml | grep -v '.ana.' | $P --jobs 10 \
	'Scripts/chars.pl {} >> ParlaMint-CZ/chars-files-CZ.tbl'
	Scripts/chars-summ.pl < ParlaMint-CZ/chars-files-CZ.tbl > ParlaMint-CZ/chars-CZ.tbl

	rm -f ParlaMint-HR/chars-files-HR.tbl
	ls ParlaMint-HR/*_*.xml | grep -v '.ana.' | $P --jobs 10 \
	'Scripts/chars.pl {} >> ParlaMint-HR/chars-files-HR.tbl'
	Scripts/chars-summ.pl < ParlaMint-HR/chars-files-HR.tbl > ParlaMint-HR/chars-HR.tbl

	rm -f ParlaMint-IS/chars-files-IS.tbl
	ls ParlaMint-IS/*_*.xml | grep -v '.ana.' | $P --jobs 10 \
	'Scripts/chars.pl {} >> ParlaMint-IS/chars-files-IS.tbl'
	Scripts/chars-summ.pl < ParlaMint-IS/chars-files-IS.tbl > ParlaMint-IS/chars-IS.tbl

	rm -f ParlaMint-PL/chars-files-PL.tbl
	ls ParlaMint-PL/*_*.xml | grep -v '.ana.' | $P --jobs 10 \
	'Scripts/chars.pl {} >> ParlaMint-PL/chars-files-PL.tbl'
	Scripts/chars-summ.pl < ParlaMint-PL/chars-files-PL.tbl > ParlaMint-PL/chars-PL.tbl

	rm -f ParlaMint-SI/chars-files-SI.tbl
	ls ParlaMint-SI/*_*.xml | grep -v '.ana.' | $P --jobs 10 \
	'Scripts/chars.pl {} >> ParlaMint-SI/chars-files-SI.tbl'
	Scripts/chars-summ.pl < ParlaMint-SI/chars-files-SI.tbl > ParlaMint-SI/chars-SI.tbl
texts:
	ls ParlaMint-BG/*_*.xml | grep -v '.ana.' | $P --jobs 10 \
	'$s -xsl:Scripts/parlamint-tei2text.xsl {} > ParlaMint-BG/{/.}.txt'
	ls ParlaMint-CZ/*_*.xml | grep -v '.ana.' | $P --jobs 10 \
	'$s -xsl:Scripts/parlamint-tei2text.xsl {} > ParlaMint-CZ/{/.}.txt'
	ls ParlaMint-HR/*_*.xml | grep -v '.ana.' | $P --jobs 10 \
	'$s -xsl:Scripts/parlamint-tei2text.xsl {} > ParlaMint-HR/{/.}.txt'
	ls ParlaMint-IS/*_*.xml | grep -v '.ana.' | $P --jobs 10 \
	'$s -xsl:Scripts/parlamint-tei2text.xsl {} > ParlaMint-IS/{/.}.txt'
	ls ParlaMint-PL/*_*.xml | grep -v '.ana.' | $P --jobs 10 \
	'$s -xsl:Scripts/parlamint-tei2text.xsl {} > ParlaMint-PL/{/.}.txt'
	ls ParlaMint-SI/*_*.xml | grep -v '.ana.' | $P --jobs 10 \
	'$s -xsl:Scripts/parlamint-tei2text.xsl {} > ParlaMint-SI/{/.}.txt'
verts:
	Scripts/parlamint-tei2vert.pl ParlaMint-BE/ParlaMint-BE.ana.xml ParlaMint-BE
	Scripts/parlamint-tei2vert.pl ParlaMint-BG/ParlaMint-BG.ana.xml ParlaMint-BG
	Scripts/parlamint-tei2vert.pl ParlaMint-CZ/ParlaMint-CZ.ana.xml ParlaMint-CZ
	Scripts/parlamint-tei2vert.pl ParlaMint-HR/ParlaMint-HR.ana.xml ParlaMint-HR
	Scripts/parlamint-tei2vert.pl ParlaMint-IS/ParlaMint-IS.ana.xml ParlaMint-IS
	Scripts/parlamint-tei2vert.pl ParlaMint-PL/ParlaMint-PL.ana.xml ParlaMint-PL
	Scripts/parlamint-tei2vert.pl ParlaMint-SI/ParlaMint-SI.ana.xml ParlaMint-SI

#Make ParlaMint corpus root
root:
	$s -xsl:Scripts/parlamint2root.xsl Scripts/ParlaMint-template.xml > ParlaMint.xml

#Make HTML, not yet operative
H = /project/corpora/Parla/ParlaMint/ParlaMint/
htm:	val-all
	Scripts/Stylesheets/bin/teitohtml --profiledir=$H --profile=profile \
	docs/ParlaMint-summary.xml docs/index.html

test-val:
	$s -xsl:Scripts/validate-parlamint.xsl ParlaMint-BE/ParlaMint-BE.ana.xml
	$s -xsl:Scripts/validate-parlamint.xsl ParlaMint-BE/ParlaMint-BE_2015-06-10-54-commissie-ic189x.ana.xml
# Validate and derived format for 1 language
LANG = LV
PREF = /project/corpora/Parla/ParlaMint/ParlaMint
all-lang:	all-lang-tei all-lang-ana
all-lang-tei:	val-pc-lang val-lang text-lang chars-lang
all-lang-ana:	vert-lang vertana-lang conllu-lang
chars-lang:
	rm -f ParlaMint-${LANG}/chars-files-${LANG}.txt
	rm -f ParlaMint-${LANG}/*.tmp
	nice find ParlaMint-${LANG}/ -name '*.txt' | \
	$P --jobs 20 'cut -f2 {} > {.}.tmp'
	nice find ParlaMint-${LANG}/ -name '*.tmp' | \
	$P --jobs 20 'Scripts/chars.pl {} >> ParlaMint-${LANG}/chars-files-${LANG}.tbl'
	Scripts/chars-summ.pl < ParlaMint-${LANG}/chars-files-${LANG}.tbl \
	> ParlaMint-${LANG}/chars-${LANG}.tbl
	rm -f ParlaMint-${LANG}/*.tmp
text-lang:
	ls ParlaMint-${LANG}/*_*.xml | grep -v '.ana.' | $P --jobs 10 \
	'$s -xsl:Scripts/parlamint-tei2text.xsl {} > ParlaMint-${LANG}/{/.}.txt'
conllu-lang:
	Scripts/parlamint2conllu.pl ParlaMint-${LANG} ParlaMint-${LANG}

vertana-lang:
	Scripts/parlamint-tei2vert.pl ParlaMint-${LANG}/ParlaMint-${LANG}.ana.xml ParlaMint-${LANG}
vert-lang:
	Scripts/parlamint-tei2vert.pl ParlaMint-${LANG}/ParlaMint-${LANG}.xml ParlaMint-${LANG}
val-lang:
	Scripts/validate-parlamint.pl Schema 'ParlaMint-${LANG}'
val-pc-lang:
	ls ParlaMint-${LANG}/ParlaMint-${LANG}.xml | xargs ${pc} 
	ls ParlaMint-${LANG}/ParlaMint-${LANG}.ana.xml | xargs ${pc}

# Validation for all corpora
# Parla-CLARIN validation
nohup:
	nohup time make all > nohup.val &
all:	val-all

# ParlaMint validation
val-all:
	Scripts/validate-parlamint.pl Schema 'ParlaMint-*'

# ParlaMint validation with Jing only
val-jing:
	ls ParlaMint-*/ParlaMint-*.xml | grep -v '.ana.' | grep -v '_' | xargs ${pc}
	ls ParlaMint-*/ParlaMint-*.xml | grep    '.ana.' | grep -v '_' | xargs ${pc}
	ls ParlaMint-*/ParlaMint-*.xml | grep -v '.ana.' | grep -v '_' | xargs ${vrt}
	ls ParlaMint-*/ParlaMint-*.xml | grep -v '.ana.' | grep    '_' | xargs ${vct}
	ls ParlaMint-*/ParlaMint-*.xml | grep    '.ana.' | grep -v '_' | xargs ${vra}
	ls ParlaMint-*/ParlaMint-*.xml | grep    '.ana.' | grep    '_' | xargs ${vca}
clean:
	rm -f ParlaMint-*/*.xml

################################################
s = java -jar /usr/share/java/saxon.jar
P = parallel --gnu --halt 2
j = java -jar /usr/share/java/jing.jar 
pc = -I % $s -xi -xsl:Scripts/copy.xsl % | $j Schema/parla-clarin.rng
vrt = $j Schema/ParlaMint-teiCorpus.rng 	# Corpus root / text
vct = $j Schema/ParlaMint-TEI.rng		# Corpus component / text
vra = $j Schema/ParlaMint-teiCorpus.ana.rng	# Corpus root / analysed
vca = $j Schema/ParlaMint-TEI.ana.rng		# Corpus component / analysed
