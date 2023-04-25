# Perl Junk Code

# CSV column sorting

   ./csv-sort.pl < test.csv
   ./csv-sort.pl reverse-columns < test.csv

# Text encodings

    diff -u pangram-de.latin1 pangram-de.utf8
    diff -u pangram-de.utf8 <(./deal-with-encoding-latin12utf8.pl pangram-de.latin1)

- Pangram from https://www.designerinaction.de/design-wissen/pangramme/

